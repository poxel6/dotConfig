local handlers = require 'vim.lsp.handlers'

local env = {
	HOME = vim.uv.os_homedir(),
	XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
}

local function get_cache_dir()
	return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. '/.cache'
end

local function get_jdtls_cache_dir()
	return get_cache_dir() .. '/jdtls'
end

local function get_jdtls_config_dir()
	return get_jdtls_cache_dir() .. '/config'
end

local function get_jdtls_workspace_dir()
	return get_jdtls_cache_dir() .. '/workspace'
end

local function fix_zero_version(workspace_edit)
	if workspace_edit and workspace_edit.documentChanges then
		for _, change in pairs(workspace_edit.documentChanges) do
			local text_document = change.textDocument
			if text_document and text_document.version and text_document.version == 0 then
				text_document.version = nil
			end
		end
	end
	return workspace_edit
end

local function on_textdocument_codeaction(err, actions, ctx)
	for _, action in ipairs(actions) do
		if action.command == 'java.apply.workspaceEdit' then                                             -- 'action' is Command in java format
			action.edit = fix_zero_version(action.edit or action.arguments[1])
		elseif type(action.command) == 'table' and action.command.command == 'java.apply.workspaceEdit' then -- 'action' is CodeAction in java format
			action.edit = fix_zero_version(action.edit or action.command.arguments[1])
		end
	end

	handlers[ctx.method](err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
	handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_definition(err, workspace_edit, ctx)
	handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
	handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

---@type vim.lsp.Config
return {
	cmd = {
		'jdtls',
		'-configuration',
		get_jdtls_config_dir(),
		'-data',
		get_jdtls_workspace_dir(),
		-- add jvm args
	},
	filetypes = { 'java' },
	root_markers = {
		-- Multi-module projects
		'.git',
		'build.gradle',
		'build.gradle.kts',
		-- Single-module projects
		'build.xml',       -- Ant
		'pom.xml',         -- Maven
		'settings.gradle', -- Gradle
		'settings.gradle.kts', -- Gradle
	},
	init_options = {
		workspace = get_jdtls_workspace_dir(),
		jvm_args = {},
		os_config = nil,
	},
	handlers = {
		-- Due to an invalid protocol implementation in the jdtls we have to conform these to be spec compliant.
		['textDocument/codeAction'] = on_textdocument_codeaction,
		['textDocument/rename'] = on_textdocument_rename,
		['textDocument/definition'] = on_definition,
		['workspace/applyEdit'] = on_workspace_applyedit,
		-- ['language/status'] = vim.schedule_wrap(on_language_status),
	},
}

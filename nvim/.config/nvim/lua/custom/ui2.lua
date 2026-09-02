require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "cmd",
			empty = "cmd",
			bufwrite = "cmd",
			confirm = "cmd",
			emsg = "pager",
			echo = "cmd",
			echomsg = "cmd",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "cmd",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "cmd",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "cmd",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.5,
			timeout = 3000,
		},
		pager = {
			height = 0.5,
		},
	},
})



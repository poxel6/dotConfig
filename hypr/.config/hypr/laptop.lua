---@return string
local hostname = function()
	local file = io.open("/etc/hostname")
	assert(file)
	local name = file:read("*l")
	file:close()
	return name
end

return (hostname() == "tucksoes")


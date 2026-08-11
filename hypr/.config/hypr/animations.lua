hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("myBezier", {
	type = "bezier",
	points = {
		{ 0.05, 0.90 },
		{ 0.10, 1.05 },
	},
})

hl.curve("ease-io-sine", {
	type = "bezier",
	points = {
		{ 0.455, 0.03 },
		{ 0.515, 0.955 },
	},
})

hl.curve("qubic-bezier", {
	type = "bezier",
	points = {
		{ 0.755, 0.05 },
		{ 0.855, 0.06 },
	},
})

hl.curve("ease-in-back", {
	type = "bezier",
	points = {
		{ 0.6, -0.28 },
		{ 0.735, 0.045 },
	},
})

-- Smooth, snappy curve for group/window switching
hl.curve("group-switch", {
	type = "bezier",
	points = {
		{ 0.22, 1.00 },
		{ 0.36, 1.00 },
	},
})

-- Slight overshoot for newly grouped windows
hl.curve("group-in", {
	type = "bezier",
	points = {
		{ 0.16, 1.00 },
		{ 0.30, 1.08 },
	},
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4,
	bezier = "qubic-bezier",
	style = "gnomed",
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4,
	bezier = "ease-in-back",
	style = "slide",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 4,
	bezier = "ease-io-sine",
	style = "popin 30%",
})

-- Smooth movement when switching between grouped windows
hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 3,
	bezier = "group-switch",
})

-- Tiny fade when changing the active window in a group
hl.animation({
	leaf = "fadeSwitch",
	enabled = true,
	speed = 2,
	bezier = "group-switch",
})

-- Slightly softer fade for newly appearing/grouped windows
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 3,
	bezier = "group-in",
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 1,
	bezier = "default",
})

hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 1,
	bezier = "default",
})

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 7,
	bezier = "default",
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1,
	bezier = "ease-io-sine",
	style = "slidefade 50%",
})

hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 2,
	bezier = "ease-io-sine",
	style = "slidefadevert 100%",
})

-- hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

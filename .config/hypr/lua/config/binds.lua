-- These binds register globally AND inside hyprvim's keymaps: a submap shadows
-- global binds, so this is what keeps the SUPER leads live in vim mode.
local smw = require("lua/plugins/split-monitor-workspaces")

smw.setup({
	workspace_count = 10,
})

local mod = "SUPER"
local terminal = "kitty"

local binds = {
	{ "Return",      hl.dsp.exec_cmd(terminal) },
	{ "Q",           hl.dsp.window.close() },
	{ "SHIFT + Q",   hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'") },
	{ "Space",       hl.dsp.window.float({ action = "toggle" }) },
	{ "W",           hl.dsp.exec_cmd("firefox") },
	{ "V",           hl.dsp.exec_cmd(terminal .. " -e nvim") },
	{ "F",           hl.dsp.exec_cmd(terminal .. " -e ranger") },
	{ "D",           hl.dsp.exec_cmd("hyprlauncher") },
	{ "G",           hl.dsp.exec_cmd("~/.cargo/bin/waycolor") },
	{ "C",           hl.dsp.exec_cmd("galculator") },
	{ "P",           hl.dsp.layout("togglesplit") },
	{ "O",           hl.dsp.window.move({ monitor = "+1" }) },
	{ "SHIFT + O",   hl.dsp.window.move({ monitor = "+1" }) },
	{ "H",           hl.dsp.focus({ direction = "left" }) },
	{ "L",           hl.dsp.focus({ direction = "right" }) },
	{ "K",           hl.dsp.focus({ direction = "up" }) },
	{ "J",           hl.dsp.focus({ direction = "down" }) },
	{ "SHIFT + H",   hl.dsp.window.move({ direction = "left" }) },
	{ "SHIFT + L",   hl.dsp.window.move({ direction = "right" }) },
	{ "SHIFT + K",   hl.dsp.window.move({ direction = "up" }) },
	{ "SHIFT + J",   hl.dsp.window.move({ direction = "down" }) },
	{ "CONTROL + H", hl.dsp.window.resize({ x = -25, y = 0, relative = true }) },
	{ "CONTROL + L", hl.dsp.window.resize({ x = 25, y = 0, relative = true }) },
	{ "CONTROL + K", hl.dsp.window.resize({ x = 0, y = -25, relative = true }) },
	{ "CONTROL + J", hl.dsp.window.resize({ x = 0, y = 25, relative = true }) },
	{ "SHIFT + G",   smw.grab_rogue_windows() },
	{ "T",           hl.dsp.workspace.toggle_special("magic") },
	{ "SHIFT + T",   hl.dsp.window.move({ workspace = "special:magic" }) },
}

for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then n = "0" end
	binds[#binds + 1] = { n, smw.workspace(n) }
	binds[#binds + 1] = { "SHIFT + " .. n, smw.move_to_workspace_silent(n) }
end

for _, b in ipairs(binds) do
	b[1] = mod .. " + " .. b[1]
end

for _, b in ipairs(binds) do
	hl.bind(b[1], b[2])
end

hl.bind(mod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mod .. " + mouse_up", smw.cycle_workspaces("prev"))
-- mouse 272/273 = LMB/RMB drag/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


return binds

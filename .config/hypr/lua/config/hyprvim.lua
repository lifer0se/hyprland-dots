local binds = require("lua/config/binds")

-- The NORMAL submap sets catchall="stay", so any key hyprvim doesn't bind (F1-F10
-- included) is swallowed and never reaches the focused app. Register F1-F10 as
-- explicit passes so function keys still behave normally in vim mode. `pass`
-- re-injects the original key to the active window (what hyprvim uses for Tab/Return).
local fn_keys = {}
for i = 1, 10 do
	fn_keys[#fn_keys + 1] = { "F" .. i, hl.dsp.pass({ window = "active" }) }
end

local function with_fn(keys)
	local merged = {}
	for _, k in ipairs(keys) do merged[#merged + 1] = k end
	for _, f in ipairs(fn_keys) do merged[#merged + 1] = f end
	return merged
end

local fn_binds = with_fn(binds)

require("lua/plugins/hyprvim").setup({
	keys = { activate = "ESCAPE" },
	applications = { terminal = "hyprvim-term" },
	-- pause self-update: upstream releases would overwrite the local HUD render fix
	-- which-key HUD skips sticky modes (NORMAL/VISUAL/INSERT); the bar chip shows the mode
	keymaps = {
		NORMAL     = fn_binds,
		VISUAL     = fn_binds,
		["V-LINE"] = fn_binds,
		INSERT     = binds,
	},
	updates = { channel = "off" },
})

-- Terminal passthrough: focused terminal suspends hyprvim so keys reach the app;
-- refocus restores prior submap. Keystroke-free (is_terminal() excludes hyprvim-term).
local vim_suspended = false
local current_submap = ""

hl.on("window.active", function()
	local Window = require("hyprvim.hypr.window")
	local Submap = require("hyprvim.lib.submap")
	local vim    = require("hyprvim.vim")

	if Window.is_terminal() then
		if not vim_suspended and Submap.current ~= "reset" then
			current_submap = Submap.current
			vim_suspended = true
			vim.count.clear()
			require("hyprvim.whichkey").close()
			vim.find.deactivate()
			require("hyprvim.vim.exit")()
		end
	elseif vim_suspended then
		vim_suspended = false
		Submap.enter(current_submap)
	end
end)

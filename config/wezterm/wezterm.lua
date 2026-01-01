-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local font = "Hack Nerd Font Mono"

-- This will hold the configuration.
local config = wezterm.config_builder()
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	font = "Hack NF"
	--- Set Pwsh as the default on Windows
	config.default_prog = { "powershell.exe", "-NoLogo" }
end

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		-- tabline_b = { "workspace" },
		tabline_b = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd",    padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_x = { "datetime", "battery" },
		-- tabline_y = { "domain" },
	},
	extensions = {},
})

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

-- or, changing the font size and color scheme.
config.font_size = 12
config.font = wezterm.font(font)

config.color_scheme = "nord"

-- config.window_frame = {
-- The font used in the tab bar.
-- Roboto Bold is the default; this font is bundled
-- with wezterm.
-- Whatever font is selected here, it will have the
-- main font setting appended to it to pick up any
-- fallback fonts you may have used there.
-- font = wezterm.font({ family = "Roboto", weight = "Bold" }),

-- The size of the font in the tab bar.
-- Default to 10.0 on Windows but 12.0 on other systems
-- font_size = 12.0,

-- The overall background color of the tab bar when
-- the window is focused
-- active_titlebar_bg = "none",

-- The overall background color of the tab bar when
-- the window is not focused
-- inactive_titlebar_bg = "none",
-- }

-- config.colors = {
-- tab_bar = {
-- 	-- background = config.colors.
-- 	-- The color of the inactive tab bar edge/divider
-- 	inactive_tab_edge = "#0a0",
-- 	active_tab = {
-- 		bg_color = "#0a0",
-- 		fg_color = "#fff",
-- 		italic = true,
-- 	},
-- 	inactive_tab = {
-- 		bg_color = "rgba(50% 50% 50% 50%)",
-- 		fg_color = "#fff",
-- 	},
-- 	new_tab = {
-- 		bg_color = "rgba(50% 50% 50% 100%)",
-- 		fg_color = "#fff",
-- 	},
-- },
-- }

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.audible_bell = "Disabled"

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	-- split
	{ key = "h", mods = "LEADER", action = act.SplitHorizontal },
	{ key = "v", mods = "LEADER", action = act.SplitVertical },

	-- jump between panes
	{ key = "h", mods = "CTRL",   action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL",   action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL",   action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL",   action = act.ActivatePaneDirection("Down") },
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{ key = "l", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- CTRL+Space, followed by 'r' will put us in resize-pane
	-- mode until we cancel that mode.
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
}

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "h",      action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l",      action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k",      action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j",      action = act.AdjustPaneSize({ "Down", 1 }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	activate_tab = {
		{ key = "1",      action = act.ActivateTab(0) },
		{ key = "2",      action = act.ActivateTab(1) },
		{ key = "3",      action = act.ActivateTab(2) },
		{ key = "4",      action = act.ActivateTab(3) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- Finally, return the configuration to wezterm:
return config

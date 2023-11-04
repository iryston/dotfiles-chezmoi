local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local function scheme_for_appearance(appearance)
	local scheme = {}
	if appearance:find("Dark") then
		scheme.name = "BlulocoDark"
		scheme.background = "#202324"
		scheme.cursor_fg = "#202324"
		return scheme
	else
		scheme.name = "BlulocoLight"
		scheme.background = "#f9f9f9"
		scheme.cursor_fg = "#ffffff"
		return scheme
	end
end

return {
	check_for_updates = false,

	-- Smart tab bar [distraction-free mode]
	hide_tab_bar_if_only_one_tab = true,

	-- Color scheme
	-- https://wezfurlong.org/wezterm/config/appearance.html
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())["name"],

	colors = {
		background = scheme_for_appearance(wezterm.gui.get_appearance())["background"],
		cursor_fg = scheme_for_appearance(wezterm.gui.get_appearance())["cursor_fg"],
	},

	window_background_opacity = 0.9,
	underline_position = "-4pt",

	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font_with_fallback({
		"SFMono Nerd Font Mono",
		"SFMono-Regular",
		"SF Mono",
		"JetBrains Mono",
		"JetBrainsMonoNL Nerd Font Mono",
		"Noto Color Emoji",
	}),
	-- font = wezterm.font('JetBrainsMonoNL Nerd Font Mono'),
	font_size = 16.0,

	-- Disable ligatures
	-- https://wezfurlong.org/wezterm/config/font-shaping.html
	--harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

	line_height = 1.3,

	--default_cursor_style = 'BlinkingBar',
	cursor_blink_rate = 500,
	force_reverse_video_cursor = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	mouse_bindings = {
		-- Change the default click behavior so that it only selects
		-- text and doesn't open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("PrimarySelection"),
		},

		-- and make CTRL-Click open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},

		-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.Nop,
		},
	},

	wezterm.on("gui-startup", function(cmd)
		local tab, pane, window = mux.spawn_window(cmd or {})
		window:gui_window():maximize()
	end),

	-- native_macos_fullscreen_mode = true,

	keys = {
		{ key = "F9", mods = "ALT", action = wezterm.action.ShowTabNavigator },
		{
			key = "R",
			mods = "SHIFT|CTRL|ALT",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	},
}

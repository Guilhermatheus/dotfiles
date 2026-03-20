pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification library
local gmath = require("gears.math")

if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
	title = "Oops, there were errors during startup!",
	text = awesome.startup_errors })
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = tostring(err) })
		in_error = false
	end)
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")


for _, preset in pairs(naughty.config.presets) do
	preset.position = "bottom_right"
end


local terminal = os.getenv("TERMINAL")
local browser = os.getenv("BROWSER")

local modkey = "Mod4"


awful.layout.layouts = {
	awful.layout.suit.max,
	awful.layout.suit.tile,
}


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({ }, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal(
				"request::activate",
				"tasklist",
				{raise = true}
			)
		end
	end),
	awful.button({ }, 3, function() awful.menu.client_list() end),
	awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
	awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s)
	end
end

	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "󰬺", "󰬻", "󰬼", "󰬽", "󰬾" }, s, awful.layout.layouts[1])

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	-- s.mylayoutbox = awful.widget.layoutbox(s)
	-- s.mylayoutbox:buttons(gears.table.join(
	-- 	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	-- 	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	-- 	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	-- 	awful.button({ }, 5, function () awful.layout.inc(-1) end)
	-- ))

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "bottom", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.taglist {
				screen  = s,
				filter  = awful.widget.taglist.filter.all,
				buttons = taglist_buttons
			},
			wibox.widget.systray(),
			wibox.widget{text = ' ', widget = wibox.widget.textbox},
			awful.widget.prompt(),
		}, -- Left widgets
		awful.widget.tasklist {
			screen  = s,
			filter  = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons
		}, -- Middle widgets
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.watch('sensors', 1, function(widget, stdout)
				for line in stdout:gmatch("[^\r\n]+") do
					if line:match("Tctl") then
						widget:set_text('  '..string.sub(line, 16, 17)..'°C | ')
						return
					end
				end
			end),
			wibox.widget.textclock('󰃭 %a %b %d |  %H:%M '),
			-- s.mylayoutbox,
		}, -- Right widgets
	}
	end
)


local function move_to_adjacent(direction)
	local client = client.focus
	if not client then return end

	local tags = client.screen.tags
	local idx = client.screen.selected_tag.index

	client:move_to_tag(tags[gmath.cycle(#tags, idx + direction)])

	if direction == 1 then awful.tag.viewnext()
	elseif direction == -1 then awful.tag.viewprev() end
end

root.keys(gears.table.join(

	awful.key({ modkey, "Control" }, "Left",  awful.tag.viewprev,
	{description = "view previous", group = "tag"}),
	awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext,
	{description = "view next", group = "tag"}),
	awful.key({ modkey, "Control", "Shift"}, "Left", function() move_to_adjacent(-1) end,
	{description = "move to previous", group = "tag"}),
	awful.key({ modkey, "Control", "Shift"}, "Right", function() move_to_adjacent(1) end,
	{description = "move to previous", group = "tag"}),

	awful.key({ modkey }, "Right", function() awful.client.focus.byidx(1) end,
	{description = "focus next by index", group = "client"}),
	awful.key({ modkey }, "Left", function() awful.client.focus.byidx(-1) end,
	{description = "focus previous by index", group = "client"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "Right", function () awful.client.swap.byidx(1) end,
	{description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift" }, "Left", function () awful.client.swap.byidx(-1) end,
	{description = "swap with previous client by index", group = "client"}),


	-- Standard program
	awful.key({ modkey }, "z", function() awful.spawn("pcmanfm") end,
	{description = "open file manager", group = "launcher"}),
	awful.key({ modkey }, "x", function() awful.spawn(browser) end,
	{description = "open browser", group = "launcher"}),
	awful.key({ modkey }, "c", function() awful.spawn(terminal) end,
	{description = "open a terminal", group = "launcher"}),

	awful.key({ modkey }, "r", awesome.restart,
	{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey }, "l", awesome.quit,
	{description = "quit awesome", group = "awesome"}),

	awful.key({ modkey }, "space", function () awful.layout.inc(1) end,
	{description = "select next", group = "layout"}),

	awful.key({ modkey, "Control" }, "n",
	function ()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal(
				"request::activate", "key.unminimize", {raise = true}
			)
		end
	end,
	{description = "restore minimized", group = "client"}),

	awful.key({ modkey }, "Return", function() awful.util.spawn('rofi -show drun') end,
	{description = "show rofi", group = "launcher"}),

	awful.key({ modkey }, ".", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/dmoji-menu.sh") end,
	{description = "show emoji menu", group = "launcher"}),

	-- Volume keys
	awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/volume-control.sh raise") end,
	{description = "raise volume", group = "system"}),
	awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/volume-control.sh lower") end,
	{description = "lower audio", group = "system"}),
	awful.key({}, "XF86AudioMute", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/volume-control.sh mute") end,
	{description = "toggle audio", group = "system"}),

	-- Print screen keys
	awful.key({ modkey }, "Print", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/print-screen.sh whole") end,
	{description = "print whole screen", group = "system"}),
	awful.key({ modkey, "Shift" }, "Print", function() awful.util.spawn(gears.filesystem.get_configuration_dir().."/print-screen.sh selection") end,
	{description = "print screen selection", group = "system"})
))

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f",
	function (c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end,
	{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey }, "q", function(c) c:kill() end,
	{description = "close", group = "client"}),
	awful.key({ modkey }, "v",  awful.client.floating.toggle,
	{description = "toggle floating", group = "client"})
)


local clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({ modkey }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end)
)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus = awful.client.focus.filter,
	raise = true,
	keys = clientkeys,
	buttons = clientbuttons,
	screen = awful.screen.preferred,
	placement = awful.placement.no_overlap+awful.placement.no_offscreen
}
	},

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			"Wpa_gui",
			"veromix",
			"xtightvncviewer"},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester",  -- xev.
			},
			role = {
				"AlarmWindow",  -- Thunderbird's calendar.
				"ConfigManager",  -- Thunderbird's about:config.
				"pop-up",	   -- e.g. Google Chrome's (detached) Developer Tools.
			}
		}, properties = { floating = true }},


-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

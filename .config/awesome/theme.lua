---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
--local config_path = gfs.get_configuration_dir()

local theme = {}

theme.font          = "sans bold 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- Get pywal's colors
do
    local wal = io.open(os.getenv("HOME").."/.cache/wal/colors.json", "r")
    if not wal then return end

    for line in wal:read('a*'):gmatch("[^\r\n]+") do
        if line:match("background") then
            theme.bg_normal = string.sub(line, 24, 30)
        elseif line:match("foreground") then
            theme.fg_normal = string.sub(line, 24, 30)
        elseif line:match("color4") then
            theme.bg_focus = string.sub(line, 20, 26)
            break
        end
    end
end

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.notification_icon_size = 100

-- Variables set for theming the menu:
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Random wallpaper following date
--math.randomseed(os.date("%Y%m%d"))
--local wallpapers = {}
--do
--    local wallpaper_path = io.popen('find "'..config_path..'wallpaper/"')
--    for file in wallpaper_path:lines() do
--        table.insert(wallpapers, file)
--    end
--end
--theme.wallpaper = wallpapers[math.random(#wallpapers)]
theme.wallpaper = "~/.local/share/bg"

-- You can use your own layout icons like this:
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

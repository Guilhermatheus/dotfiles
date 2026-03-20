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


-- Get pywal's colors
do
    local wal = io.open(os.getenv("HOME").."/.cache/wal/colors.json", "r")
    if not wal then return end

    for line in wal:read('a*'):gmatch("[^\r\n]+") do
        if line:match("background") then
            theme.bg_normal = string.sub(line, 24, 30)
        elseif line:match("color1") then
            theme.bg_urgent = string.sub(line, 20, 26)
        elseif line:match("color3") then
            theme.fg_minimize = string.sub(line, 20, 26)
        elseif line:match("color4") then
            theme.bg_focus = string.sub(line, 20, 26)
            break
        end
    end
end


theme.bg_normal     = theme.bg_normal     or "#222222"
theme.bg_focus      = theme.bg_focus      or "#535d6c"
theme.bg_urgent     = theme.bg_urgent     or "#ff0000"
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.bg_focus
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.fg_minimize   or "#ffffff"

theme.useless_gap   = theme.useless_gap   or dpi(0)
theme.border_width  = theme.border_width  or dpi(0)
theme.border_normal = theme.border_normal or "#000000"
theme.border_focus  = theme.border_focus  or "#535d6c"
theme.border_marked = theme.border_marked or "#91231c"


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

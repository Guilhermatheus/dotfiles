from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os, random, subprocess


mod = "mod4"
terminal = "alacritty"

u = "up"
d = "down"
l = "left"
r = "right"


keys = [
    Key([mod], l, lazy.layout.left()),
    Key([mod], r, lazy.layout.right()),
    Key([mod], u, lazy.layout.down()),
    Key([mod], d, lazy.layout.up()),

    Key([mod, "shift"], l, lazy.layout.shuffle_left()),
    Key([mod, "shift"], r, lazy.layout.shuffle_right()),
    Key([mod, "shift"], u, lazy.layout.shuffle_down()),
    Key([mod, "shift"], d, lazy.layout.shuffle_up()),

    Key([mod, "control"], l, lazy.layout.grow_left()),
    Key([mod, "control"], r, lazy.layout.grow_right()),
    Key([mod, "control"], u, lazy.layout.grow_down()),
    Key([mod, "control"], d, lazy.layout.grow_up()),
    Key([mod], "n", lazy.layout.normalize()),

    # Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    # Key([mod], "Return", lazy.spawn(terminal)),

    # Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "space", lazy.window.toggle_floating()),
    Key([mod], "r", lazy.reload_config()),
    Key([mod], "l", lazy.shutdown()),
    Key([mod], "Return", lazy.spawn("rofi -show drun")),
    Key([mod], "period", lazy.spawn(os.path.expanduser("~/.config/bin/dmoji.sh"))),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True))
        ]
    )

layouts = [
    layout.Columns(
        margin=16,
        border_width=1,
        border_focus="#00c000",
        border_normal="#ffffff",
        border_on_single=True
        )
]

widget_defaults = dict(
    font="terminus",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

backgrounds_path = os.path.expanduser("~/.config/backgrounds/")

screens = [
    Screen(
        wallpaper=backgrounds_path + random.choice(os.listdir(backgrounds_path)),
        wallpaper_mode="fill",
        bottom=bar.Bar(
            [
                widget.GroupBox(highlight_method="text", this_current_screen_border=random.choice(['#00c000', '#ffff00', '#ff0000', '#003cff', '#42fcff', '#d535d9'])),
                widget.Prompt(),
                widget.WindowName(),
                widget.Notify(),
                widget.Systray(), # NB Systray is incompatible with Wayland, consider using widget.StatusNotifier() instead
                widget.ThermalSensor(update_interval=1.0),
                widget.Clock(format="%d/%m/%Y, %H:%M", update_interval=60.0),
            ],
            20,
            border_width=[1, 0, 0, 0],
            border_color=["#00c000", "000000", "000000", "000000"]
        ),
    ),
]


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24


wmname = "LG3D"

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
#from libqtile.log_utils import logger # For debugging
import os, random


mod = 'mod4'
terminal = os.getenv('TERMINAL', '')
browser = os.getenv('BROWSER', '')


# Switch between even and odd groups
@lazy.function
def go_to_sidegroup(qtile) -> None:
	current_index = qtile.groups.index(qtile.current_group)
	if current_index % 2:
		qtile.groups[current_index - 1].toscreen()
	else: qtile.groups[current_index + 1].toscreen()

# Switch window between main and offhand groups
@lazy.function
def move_to_sidegroup(qtile) -> None:
	current_index = qtile.groups.index(qtile.current_group)
	if current_index % 2:
		qtile.current_window.togroup(
				qtile.current_group.name[:-1],
				switch_group=True
				)
	else:
		qtile.current_window.togroup(
				qtile.current_group.name+'•',
				switch_group=True
				)


u, d, l, r = 'up', 'down', 'left', 'right'

keys = [
		Key([mod], 'tab', go_to_sidegroup()),
		Key([mod, 'shift'], 'tab', move_to_sidegroup()),

		Key([mod], u, lazy.layout.up()),
		Key([mod], d, lazy.layout.down()),
		Key([mod], l, lazy.layout.left()),
		Key([mod], r, lazy.layout.right()),

		Key([mod, 'shift'], u, lazy.layout.shuffle_up()),
		Key([mod, 'shift'], d, lazy.layout.shuffle_down()),
		Key([mod, 'shift'], l, lazy.layout.shuffle_left()),
		Key([mod, 'shift'], r, lazy.layout.shuffle_right()),

		Key([mod, 'control'], u, lazy.layout.grow_up()),
		Key([mod, 'control'], d, lazy.layout.grow_down()),
		Key([mod, 'control'], l, lazy.layout.grow_left()),
		Key([mod, 'control'], r, lazy.layout.grow_right()),
		# Key([mod], 'n', lazy.layout.normalize()),

		# Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),

		Key([mod], 'q', lazy.window.kill()),
		Key([mod], 'f', lazy.window.toggle_fullscreen()),
		Key([mod], 'space', lazy.window.toggle_floating()),
		Key([mod], 'r', lazy.reload_config()),
		Key([mod], 'l', lazy.shutdown()),

		Key([mod], 'Return', lazy.spawn('rofi -show drun')),
		Key([mod], 'period', lazy.spawn(os.path.expanduser('~/.config/bin/dmoji.sh'))),

		Key([mod], 'z', lazy.spawn('pcmanfm')),
		Key([mod], 'x', lazy.spawn(browser)),
		Key([mod], 'c', lazy.spawn(terminal)),
		Key([mod, 'shift'], 'escape', lazy.spawn(terminal + ' -e btop')),
		Key([], 'XF86AudioRaiseVolume', lazy.spawn(os.path.expanduser('~/.config/bin/volume-control.sh')+' raise')),
		Key([], 'XF86AudioLowerVolume', lazy.spawn(os.path.expanduser('~/.config/bin/volume-control.sh')+' lower')),
		Key([], 'XF86AudioMute', lazy.spawn(os.path.expanduser('~/.config/bin/volume-control.sh')+' mute'))
		]


groups = []


for i in range(1, 5):
	i = str(i)

	groups.extend(
			[
				Group(name = i, label = i),
				Group(name = i+'•', label = '•')
				]
			)

	keys.extend(
			[
				Key([mod], i, lazy.group[i].toscreen()),
				Key([mod, 'shift'], i, lazy.window.togroup(i, switch_group=True))
				]
			)


layouts = [
		layout.MonadTall(
			margin=16,
			border_width=2,
			border_focus='#00c000',
			border_normal='#ffffff',
			border_on_single=True
			)
		]

widget_defaults = dict(
		font='terminus',
		foreground='#ff7f27',
		fontsize=12,
		padding=3,
		)
extension_defaults = widget_defaults.copy()

backgrounds_path = os.path.expanduser('~/.config/backgrounds/')

screens = [
		Screen(
			wallpaper=backgrounds_path + random.choice(os.listdir(backgrounds_path)),
			wallpaper_mode='fill',
			bottom=bar.Bar(
				[
					widget.GroupBox(
						highlight_method='text',
						this_current_screen_border='#00c000',
						padding=-1
						),
					widget.TextBox('|', padding=-2, fontsize=39),
					widget.Prompt(),
					widget.WindowName(),
					widget.Notify(),
					widget.Systray(),
					widget.TextBox('|', padding=-2, fontsize=39),
					widget.ThermalSensor(
						format='{temp:.0f}{unit}',
						tag_sensor='Tctl'
						),
					widget.TextBox('|', padding=-2, fontsize=39),
					widget.Clock(format='%d/%m/%Y, %H:%M', update_interval=60.0),
					],
				20,
				border_width=[2, 0, 0, 0],
				border_color=['ff7f27', '000000', '000000', '000000']
				),
			),
		]


mouse = [
		Drag(
			[mod],
			'Button1',
			lazy.window.set_position_floating(),
			start=lazy.window.get_position()
			),
		Drag(
			[mod],
			'Button3',
			lazy.window.set_size_floating(),
			start=lazy.window.get_size()),
		Click([mod], 'Button2', lazy.window.bring_to_front())
		]


floating_layout = layout.Floating(
		float_rules=[
			# Run the utility of `xprop` to see the wm class and name of an X client.
			*layout.Floating.default_float_rules,
			Match(wm_class='confirmreset'),	# gitk
			Match(wm_class='makebranch'),	# gitk
			Match(wm_class='maketag'),	# gitk
			Match(wm_class='ssh-askpass'),	# ssh-askpass
			Match(title='branchdialog'),	# gitk
			Match(title='pinentry'),	# GPG key password entry
			]
		)

dgroups_key_binder = None
dgroups_app_rules = []

follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = False

wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = 'LG3D'

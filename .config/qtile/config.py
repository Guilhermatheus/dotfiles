from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
#from libqtile.log_utils import logger # For debugging
import os, random
from datetime import datetime

mod = 'mod4'
terminal = os.getenv('TERMINAL', '')
browser = os.getenv('BROWSER', '')
task_man = terminal + ' -e btop'

# Go to closest group following direction
@lazy.function
def go_to_group(qtile, direction) -> None:
	if qtile.current_group is None: return
	
	index = qtile.groups.index(qtile.current_group)
	index = (index + direction) % len(qtile.groups)
	
	qtile.groups[index].toscreen()

# Move window and go to closest group following direction
@lazy.window.function
def move_to_group(window, direction) -> None:
	if window.qtile.current_group is None: return
	
	index = window.qtile.groups.index(window.group)
	index = (index + direction) % len(window.qtile.groups)
	
	window.cmd_togroup(window.qtile.groups[index].name, switch_group=True)


u, d, l, r = 'up', 'down', 'left', 'right'
dir_path = os.path.dirname(os.path.realpath(__file__))

keys = [

	Key([mod], u, lazy.layout.up()),
	Key([mod], d, lazy.layout.down()),
	Key([mod], l, lazy.layout.left()),
	Key([mod], r, lazy.layout.right()),

	Key([mod, 'shift'], u, lazy.layout.shuffle_up()),
	Key([mod, 'shift'], d, lazy.layout.shuffle_down()),
	Key([mod, 'shift'], l, lazy.layout.shuffle_left()),
	Key([mod, 'shift'], r, lazy.layout.shuffle_right()),

	Key([mod, 'control'], r, go_to_group(direction=1)),
	Key([mod, 'control'], l, go_to_group(direction=-1)),
	Key([mod, 'control'], u, move_to_group(direction=1)),
	Key([mod, 'control'], d, move_to_group(direction=-1)),

	#Key([mod, 'control'], u, lazy.layout.grow_up()),
	#Key([mod, 'control'], d, lazy.layout.grow_down()),
	#Key([mod, 'control'], l, lazy.layout.grow_left()),
	#Key([mod, 'control'], r, lazy.layout.grow_right()),

	# Key([mod], 'n', lazy.layout.normalize()),

	# Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),

	Key([mod], 'q', lazy.window.kill()),
	Key([mod], 'f', lazy.window.toggle_fullscreen()),
	Key([mod], 'space', lazy.window.toggle_floating()),
	Key([mod], 'r', lazy.reload_config()),
	Key([mod], 'l', lazy.shutdown()),

	Key([mod], 'Return', lazy.spawn('rofi -show drun')),
	Key([mod], 'Print', lazy.spawn(dir_path+'/print-screen.sh'+' whole')),
	Key([mod, 'control'], 'Print', lazy.spawn(dir_path+'/print-screen.sh'+' selection')),
	Key([mod], 'period', lazy.spawn(dir_path+'/dmoji-menu.sh')),

	Key([mod], 'z', lazy.spawn('pcmanfm')),
	Key([mod], 'x', lazy.spawn(browser)),
	Key([mod], 'c', lazy.spawn(terminal)),
	Key([mod, 'shift'], 'escape', lazy.spawn(task_man)),
	Key([], 'XF86AudioRaiseVolume', lazy.spawn(dir_path+'/volume-control.sh'+' raise')),
	Key([], 'XF86AudioLowerVolume', lazy.spawn(dir_path+'/volume-control.sh'+' lower')),
	Key([], 'XF86AudioMute', lazy.spawn(dir_path+'/volume-control.sh'+' mute'))
]


groups = []


for i in range(1, 6):
	i = str(i)

	groups.extend(
		[
			Group(name = i, label = i),
		]
	)

	keys.extend(
		[
			Key([mod], i, lazy.group[i].toscreen()),
			Key([mod, 'shift'], i, lazy.window.togroup(i, switch_group=True))
		]
	)

primary_color='#087408'
secondary_color='#084108'
background_color='#080808'


layouts = [
	layout.MonadTall(
		margin=16,
		border_width=2,
		border_focus=primary_color,
		border_normal=secondary_color,
		border_on_single=True
	)
]

widget_defaults = dict(
	font='terminus',
	fontshadow=background_color,
	foreground='#ffffff',
	background=secondary_color,
	fontsize=12,
	padding=3,
)
extension_defaults = widget_defaults.copy()


random.seed(datetime.today().strftime('%d%m%Y'))
try:
		wallpaper_path = dir_path + "/wallpaper/"
		wallpaper_path = wallpaper_path + random.choice(os.listdir(wallpaper_path))
except: wallpaper_path = ""

screens = [
	Screen(
		wallpaper=wallpaper_path,
		wallpaper_mode='fill',
		bottom=bar.Bar(
			[

				widget.GroupBox(
					background=primary_color,
					highlight_method='block',
					inactive=primary_color,
					padding=0,
					rounded=False,
					this_current_screen_border=secondary_color
				),

				widget.TextBox(
					fontsize=40,
					fontshadow=None,
					foreground=primary_color,
					padding=-1,
					text='\u25e3'
				),
				
				widget.Systray(),
				
				widget.Spacer(length=10),
				widget.TextBox(
					background=background_color,
					fontsize=40,
					fontshadow=None,
					foreground=secondary_color,
					text='\u25e3',
					padding=-1
				),

				
				widget.TaskList(
					background=background_color,
					border=background_color,
					highlight_method='block',
					margin=0,
					max_title_width=125,
					padding=4,
					rounded=False,
					title_width_method='uniform'
				),
				
				widget.TextBox(
					background=background_color,
					fontsize=40,
					fontshadow=None,
					foreground=secondary_color,
					text='\u25e2',
					padding=-1
				),
				widget.Spacer(length=10),
				
				widget.Notify(background=secondary_color),
				
				widget.TextBox(
					fontsize=40,
					fontshadow=None,
					foreground=primary_color,
					text='\u25e2',
					padding=-1
				),

				widget.ThermalSensor(
					background=primary_color,
					format='🌡️ {temp:.0f}{unit}',
					tag_sensor='Tctl',
					mouse_callbacks={'Button1': lazy.spawn(task_man)}
				),
				
				widget.Spacer(length=5, background=primary_color),

				widget.Clock(
					background=primary_color,
					format='⌛ %H:%M',
					update_interval=60.0
				),

			],
			size=20,
			border_width=[2,0,2,0],
			border_color=secondary_color
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
	border_width=2,
	border_focus=primary_color,
	border_normal=secondary_color,
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

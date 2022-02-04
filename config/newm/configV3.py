from __future__ import annotations
import logging
import os
from typing import Callable, Any
from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner, PaCtl

from pywm import PYWM_MOD_LOGO


logger = logging.getLogger(__name__)


def on_startup():
    init_service = (
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "systemctl --user import-environment \
        DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        "hash dbus-update-activation-environment 2>/dev/null && \
        dbus-update-activation-environment --systemd \
        DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        "wl-paste -t text --watch clipman store",
        "wlsunset -l 16.0867 -L -93.7561 -t 2500 -T 6000",
        "thunar --daemon",
        "waybar",
        "nm-applet --indicator",
        "/home/crag/Git/dotfiles/etc/dnscrypt-proxy/get_blocklist",
    )

    for service in init_service:
        service = f"{service} &"
        os.system(service)


def on_reconfigure():
    gnome_schema = 'org.gnome.desktop.interface'
    # gnome_peripheral = 'org.gnome.desktop.peripherals'
    wm_service_extra_config = (
        f"gsettings set {gnome_schema} gtk-theme 'Sweet-Dark-v40'",
        f"gsettings set {gnome_schema} icon-theme 'candy-icons'",
        f"gsettings set {gnome_schema} cursor-theme 'Sweet-cursors'",
        f"gsettings set {gnome_schema} cursor-size 35",
        f"gsettings set {gnome_schema} font-name 'Lucida MAC 15'",
        "gsettings set org.gnome.desktop.wm.preferences button-layout :",
        f"gsettings set {gnome_peripheral}.keyboard repeat-interval 30",
        f"gsettings set {gnome_peripheral}.keyboard delay 500",
        f"gsettings set {gnome_peripheral}.mouse natural-scroll false",
        f"gsettings set {gnome_peripheral}.mouse speed 0.0",
        f"gsettings set {gnome_peripheral}.mouse accel-profile 'default'",
    )

    for config in wm_service_extra_config:
        config = f"{config} &"
        os.system(config)


corner_radius = 0

outputs = [
    {'name': 'eDP-1', 'scale': 0.6},
    # {'name': 'DP-2', 'scale': 0.6, 'pos_x': 0, 'pos_y': 0},
    # {'name': 'DP-2', 'scale': 0.6},
]

pywm = {
    # 'renderer_mode': 'passthrough',
    'xkb_model': "PLACEHOLDER_xkb_model",
    'xkb_layout': "es",
    'xkb_options': "caps:swapescape",
    'encourage_csd': False,
    'enable_xwayland': True,
    'natural_scroll': True,
    # 'texture_shaders': 'basic',
    'focus_follows_mouse': True,
    'xcursor_theme': 'Sweet-cursors',
    'xcursor_size': 24,
    # 'contstrain_popups_to_toplevel': True
}


def should_float(view):
    size = (700, 700)
    position = (0.5, 0.35)
    float_apps = [
        "pavucontrol", "blueman-manager"
    ]
    if view.app_id in float_apps:
        return True, size, position
    if view.app_id == "catapult":
        return True, None, (0.5, 0.1)
    if view.title is not None and view.title.strip() == "Firefox — Sharing Indicator":
        return True, (100, 40), (0.5, 0.1)
    return None


view = {
    'padding': 6,
    'fullscreen_padding': 0,
    'send_fullscreen': False,
    'should_float': should_float,
    'floating_min_size': False,
    'debug_scaling': True,
    'border_ws_switch': 100
}

swipe_zoom = {
    'grid_m': 1,
    'grid_ovr': 0.02,
}

mod = PYWM_MOD_LOGO
background = {
    'path': os.environ["HOME"] + "/.cache/wallpaper.jpg",
    'time_scale': 0.125,
    'anim': True,
}

anim_time = .25
blend_time = 0.5
term = 'kitty'
power_times = [1000, 1000, 2000]

wob_runner = WobRunner("wob -a top -M 100")
backlight_manager = BacklightManager(anim_time=1., bar_display=wob_runner)
# Config for keyboard light
# kbdlight_manager = BacklightManager(
#     args="--device='*::kbd_backlight'",
#     anim_time=1.,
#     bar_display=wob_runner)


def synchronous_update() -> None:
    backlight_manager.update()
#     kbdlight_manager.update()


pactl = PaCtl(0, wob_runner)


def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    menu = '~/.config/rofi/bin/launcher_misc'
    clipboard = '~/.config/rofi/bin/clipboard'
    favorites = '~/.config/rofi/bin/apps'
    powermenu = '~/.config/rofi/bin/menu_powermenu'
    bookmarks = '~/.config/rofi/bin/bookmarks'
    passman = '~/.config/rofi/bin/passman'

    return [
        ("M-h", lambda: layout.move(-1, 0)),
        ("M-j", lambda: layout.move(0, 1)),
        ("M-k", lambda: layout.move(0, -1)),
        ("M-l", lambda: layout.move(1, 0)),
        ("M-t", lambda: layout.move_in_stack(1)),

        ("M-H", lambda: layout.move_focused_view(-1, 0)),
        ("M-J", lambda: layout.move_focused_view(0, 1)),
        ("M-K", lambda: layout.move_focused_view(0, -1)),
        ("M-L", lambda: layout.move_focused_view(1, 0)),

        ("M-C-h", lambda: layout.resize_focused_view(-1, 0)),
        ("M-C-j", lambda: layout.resize_focused_view(0, 1)),
        ("M-C-k", lambda: layout.resize_focused_view(0, -1)),
        ("M-C-l", lambda: layout.resize_focused_view(1, 0)),

        ("M-W", lambda: layout.change_focused_view_workspace()),
        ("M-v", lambda: layout.toggle_focused_view_floating()),
        ("M-w", lambda: layout.move_workspace()),
        ("A-Tab", lambda: layout.move_next_view(active_workspace=False)),

        ("M-u", lambda: layout.basic_scale(1)),
        ("M-n", lambda: layout.basic_scale(-1)),

        ("M-f", lambda: layout.toggle_fullscreen()),
        ("M-p", lambda: layout.ensure_locked(dim=True)),

        ("M-P", lambda: layout.terminate()),
        ("M-e", lambda: layout.close_view()),

        ("M-R", lambda: layout.update_config()),
        # ("ModPress", lambda: layout.toggle_overview()),
        ("ModPress", lambda: layout.toggle_overview(only_active_workspace=True)),

        ("M-z", lambda: layout.swallow_focused_view()),

        ("M-Return", lambda: os.system(f"{term} &")),

        ("C-q", lambda: os.system(f"{powermenu} &")),
        ("M-m", lambda: os.system("playerctl previous")),
        ("M-i", lambda: os.system("playerctl next")),
        ("M-ñ", lambda: os.system("playerctl play-pause &")),
        ("M-c", lambda: os.system(f'{clipboard} &')),
        ("M-b", lambda: os.system(f'{bookmarks} &')),
        ("A-l", lambda: os.system(f'{passman} &')),
        ("XF86AudioMicMute", lambda: os.system("amixer set Capture toggle")),
        ("XF86MonBrightnessUp", lambda:
            backlight_manager.set(backlight_manager.get() + 0.05)),
        ("XF86MonBrightnessDown", lambda:
            backlight_manager.set(backlight_manager.get() - 0.05)),
        # ("XF86KbdBrightnessUp", lambda: kbdlight_manager.set(kbdlight_manager.get() + 0.1)),
        # ("XF86KbdBrightnessDown", lambda: kbdlight_manager.set(kbdlight_manager.get() - 0.1)),
        ("XF86AudioRaiseVolume", lambda: pactl.volume_adj(5)),
        ("XF86AudioLowerVolume", lambda: pactl.volume_adj(-5)),
        ("XF86AudioMute", lambda: pactl.mute()),

        ("XF86Display", lambda: os.system("toggle_wcam uvcvideo &")),
        ("XF86Tools", lambda: os.system("kitty nvim \
                                        ~/.config/newm/config.py &")),
        ("XF86Search", lambda: os.system("catapult --show &")),
        ("Menu", lambda: os.system("catapult --show &")),
        ("XF86Explorer", lambda: os.system(f"{menu} &")),
        ("Pause", lambda: os.system(f"{menu} &")),
        ("XF86LaunchA", lambda: os.system(f"{favorites} &")),
        ("Print", lambda: os.system('grim ~/screen-"$(date +%s)".png &')),
        ("M-Print", lambda: os.system('grim -g "$(slurp)" ~/screen-"$(date\
            +%s)".png &')),
    ]


bar = {'enabled': False}

gestures = {
    'lp_freq': 120.,
    'lp_inertia': 0.4,
    'pyevdev': {"enabled": True},
}

swipe = {'gesture_factor': 3}

panels = {
    'lock': {
        'cmd': f'{term} newm-panel-basic lock',
        'w': 0.7,
        'h': 0.7,
        'corner_radius': 50,
    },
}

grid = {
    'throw_ps': [2, 10]
}

energy = {
    'idle_times': [60, 180],
    'idle_callback': backlight_manager.callback
}

focus = {
    # 'color': '#A29DFF11',  # change color
    # 'distance': 0,
    # 'width': 0,
    # 'animate_on_change': false,
    # 'anim_time': 0
    'enabled': False
}

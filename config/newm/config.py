from __future__ import annotations
import os
import pwd
import time
import psutil
from typing import Callable, Any
from subprocess import check_output
from newm.layout import Layout
from newm import (
    SysBackendEndpoint_alsa,
    SysBackendEndpoint_sysfs
)
from pywm import (
    PYWM_MOD_LOGO,
)

OUTPUT_MANAGER = True
outputs = [
    {'name': 'eDP-1', 'scale': 0.7},
    # {'name': 'eDP-1', 'pos_x': 1833, 'pos_y': 0, 'scale': 0.7},
    # {'name': 'DP-2', 'pos_x': 0, 'pos_y': 0, 'scale': 0.7},
]

pywm = {
    'xkb_layout': "es",
    'xkb_options': "caps:swapescape",

    'encourage_csd': False,
    'debug_f1': True,

    'enable_output_manager': OUTPUT_MANAGER,
    'enable_xwayland': True,
    'xcursor_theme': "Sweet-cursors",
    'xcursor_size': 12,
    'focus_follows_mouse': True,
    'contstrain_popups_to_toplevel': True,
}


def should_float(view):
    size = (700, 700)
    position = (0.5, 0.35)
    if view.app_id == "pavucontrol":
        return True, size, position
    if view.app_id == "blueman-manager":
        return True, size, position
    if view.app_id == "catapult":
        return True, (700, 700), (0.5, 0.1)
    return None


view = {
    'xwayland_handle_scale_clientside': not OUTPUT_MANAGER,
    'padding': 6,
    'fullscreen_padding': 0,
    'send_fullscreen': False,
    'should_float': should_float
}

swipe_zoom = {
    'grid_m': 1,
    'grid_ovr': 0.02,
}

mod = PYWM_MOD_LOGO
wallpaper = os.environ["HOME"] + "/.cache/wallpaper.jpg"
corner_radius = 0
blend_time = 0.5
power_times = [300, 900, 1800]
term = 'kitty'


def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    menu = '~/.config/rofi/bin/launcher_misc'
    clipboard = '~/.config/rofi/bin/clipboard'
    favorites = '~/.config/rofi/bin/apps'
    powermenu = '~/.config/rofi/bin/menu_powermenu'
    bookmarks = '~/.config/rofi/bin/bookmarks'
    return [
        ("M-h", lambda: layout.move(-1, 0)),
        ("M-j", lambda: layout.move(0, 1)),
        ("M-k", lambda: layout.move(0, -1)),
        ("M-l", lambda: layout.move(1, 0)),
        ("M-u", lambda: layout.basic_scale(1)),
        ("M-n", lambda: layout.basic_scale(-1)),
        ("M-t", lambda: layout.move_in_stack(1)),

        ("M-H", lambda: layout.move_focused_view(-1, 0)),
        ("M-J", lambda: layout.move_focused_view(0, 1)),
        ("M-K", lambda: layout.move_focused_view(0, -1)),
        ("M-L", lambda: layout.move_focused_view(1, 0)),

        ("M-C-h", lambda: layout.resize_focused_view(-1, 0)),
        ("M-C-j", lambda: layout.resize_focused_view(0, 1)),
        ("M-C-k", lambda: layout.resize_focused_view(0, -1)),
        ("M-C-l", lambda: layout.resize_focused_view(1, 0)),

        ("M-Return", lambda: os.system(f"{term} &")),
        ("M-e", lambda: layout.close_view()),

        ("M-p", lambda: layout.ensure_locked(dim=True)),
        ("M-P", lambda: layout.terminate()),
        ("M-C", lambda: layout.update_config()),

        ("M-f", lambda: layout.toggle_fullscreen()),

        ("ModPress", lambda: layout.toggle_overview()),

        ("M-q", lambda: os.system(f"{powermenu} &")),
        ("M-m", lambda: os.system("playerctl previous")),
        ("M-i", lambda: os.system("playerctl next")),
        ("M-ñ", lambda: os.system("playerctl play-pause")),
        ("M-c", lambda: os.system(f'{clipboard} &')),
        ("M-b", lambda: os.system(f'{bookmarks} &')),
        ("XF86AudioRaiseVolume", lambda: os.system("amixer -q \
            set Master 5%+")),
        ("XF86AudioLowerVolume", lambda: os.system("amixer -q \
            set Master 5%-")),
        ("XF86AudioMute", lambda: os.system("amixer set Master toggle")),
        ("XF86AudioMicMute", lambda: os.system("amixer set Capture toggle")),
        ("XF86MonBrightnessDown", lambda: os.system("brightnessctl \
            specific 3-")),
        ("XF86MonBrightnessUp", lambda: os.system("brightnessctl \
            specific +3")),
        ("XF86Display", lambda: os.system("toggle_wcam uvcvideo &")),
        ("XF86Tools", lambda: os.system("kitty vim \
                                        ~/.config/newm/config.py &")),
        ("XF86Search", lambda: os.system("catapult --show &")),
        ("Menu", lambda: os.system("catapult --show &")),
        ("XF86Explorer", lambda: os.system(f"{menu} &")),
        ("Scroll_lock", lambda: os.system(f"{menu} &")),
        ("XF86LaunchA", lambda: os.system(f"{favorites} &")),
        ("Print", lambda: os.system('grim ~/screen-"$(date +%s)".png &')),
        ("M-Print", lambda: os.system('grim -g "$(slurp)" ~/screen-"$(date\
            +%s)".png &')),
    ]


def on_startup():
    gnome_schema = 'org.gnome.desktop.interface'
    init_service = (
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY",
        "hash dbus-update-activation-environment 2>/dev/null && \
            dbus-update-activation-environment --systemd DISPLAY \
            WAYLAND_DISPLAY",
        f"gsettings set {gnome_schema} gtk-theme 'Sweet-mars'",
        f"gsettings set {gnome_schema} icon-theme 'candy-icons'",
        f"gsettings set {gnome_schema} cursor-theme 'Sweet-cursors'",
        f"gsettings set {gnome_schema} font-name 'Lucida MAC 11'",
        "gsettings set org.gnome.desktop.wm.preferences button-layout :",
        "wl-paste -t text --watch clipman store",
        "wlsunset -l 16.0867 -L -93.7561 -t 2500 -T 6000",
        "thunar --daemon",
        "/home/crag/Git/dotfiles/etc/dnscrypt-proxy"
    )

    for service in init_service:
        service = f"{service} &"
        os.system(service)


sys_backend_endpoints = [
    SysBackendEndpoint_sysfs(
        "backlight",
        "/sys/class/backlight/intel_backlight/brightness",
        "/sys/class/backlight/intel_backlight/max_brightness"),
    SysBackendEndpoint_sysfs(
        "kbdlight",
        "/sys/class/leds/smc::kbd_backlight/brightness",
        "/sys/class/leds/smc::kbd_backlight/max_brightness"),
    SysBackendEndpoint_alsa(
        "volume")
]

panels = {
    'launcher': {
        'cmd': f'{term} newm-panel-basic launcher'
    },
}

ssid = "nmcli -t -f active,ssid dev wifi | egrep '^sí'\
    | cut -d\\: -f2"

brightness = "brightnessctl i | grep 'Current' | cut -d\\( -f2"

volume = "awk -F\"[][]\" '/Left:/ { print $2 }' <(amixer sget Master)"


def get_nw():
    ifdevice = "wlan0"
    ip = ""
    try:
        ip = psutil.net_if_addrs()[ifdevice][0].address
    except Exception:
        ip = "-/-"
    ssid_string = check_output(ssid, shell=True).decode("utf-8")
    return f"  {ifdevice}: {ssid_string[:-1]} / {ip}"


bar = {
    'font': 'JetBrainsMono Nerd Font',
    'font_size': 15,
    'height': 20,
    'top_texts': lambda: [
        pwd.getpwuid(os.getuid())[0],
        f" {psutil.cpu_percent(interval=1)}",
        f" {psutil.virtual_memory().percent}%",
        f"/ {psutil.disk_usage('/').percent}%\
            /home {psutil.disk_usage('/home').percent}%"
    ],
    'bottom_texts': lambda: [
        # f'{psutil.sensors_battery().percent} \
        # {"↑" if psutil.sensors_battery().power_plugged else "↓"}',
        f' {check_output(brightness, shell=True).decode("utf-8")[:-2]}',
        f'墳 {check_output(volume, shell=True).decode("utf-8")[:-1]}',
        get_nw(),
        f' {time.strftime("%c")}'
    ]
}

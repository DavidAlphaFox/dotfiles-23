from __future__ import annotations

import logging
import os
from random import randrange
from typing import Any, Callable

from gi.repository import Notify
from newm.helper import BacklightManager, PaCtl, WobRunner
from newm.layout import Layout

logger = logging.getLogger(__name__)


def notify(msg: str, app_name: str, image="system-config-services"):
    Notify.init(app_name)
    n = Notify.Notification.new(app_name, msg, image)
    n.show()


def execute(procs: tuple[str], start="", end=" &"):
    for proc in procs:
        proc = f"{start}{proc}{end}"
        os.system(proc)


def set_value(keyval, file):
    var, val = keyval.split("=")
    return f"sed -i 's/^{var}\=.*/{var}={val}/' {file}"


def on_startup():
    # "hash dbus-update-activation-environment 2>/dev/null && \
    # dbus-update-activation-environment --systemd --all",

    INIT_SERVICE = (
        "systemctl --user import-environment \
        DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        "dbus-update-activation-environment --all",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "wl-paste -t text -n --watch clipman store",
        "wlsunset -l 16.0867 -L -93.7561 -t 2500 -T 6000",
        "nm-applet --indicator",
        "easyeffects --gapplication-service",
        "/home/crag/Git/dotfiles/etc/dnscrypt-proxy/get_blocklist",
        "fnott",
    )
    execute(INIT_SERVICE)


def on_reconfigure():
    gnome_schema = "org.gnome.desktop.interface"
    gnome_peripheral = "org.gnome.desktop.peripherals"
    gnome_preferences = "org.gnome.desktop.wm.preferences"
    easyeffects = "com.github.wwmm.easyeffects"
    theme = "Dracula-slim"
    icons = "candy-icons"
    cursor = "Sweet-cursors"
    font = "Lucida MAC 12"
    gtk2 = "~/.gtkrc-2.0"
    gtk3 = "~/.config/gtk-3.0/settings.ini"

    GSETTINGS = (
        f"gsettings set {gnome_preferences} button-layout :",
        f"gsettings set {gnome_preferences} theme {theme}",
        f"gsettings set {gnome_schema} gtk-theme {theme}",
        f"gsettings set {gnome_schema} icon-theme {icons}",
        f"gsettings set {gnome_schema} cursor-theme {cursor}",
        f"gsettings set {gnome_schema} cursor-size 30",
        f"gsettings set {gnome_schema} font-name '{font}'",
        f"gsettings set {gnome_peripheral}.keyboard repeat-interval 30",
        f"gsettings set {gnome_peripheral}.keyboard delay 250",
        f"gsettings set {gnome_peripheral}.mouse natural-scroll true",
        f"gsettings set {gnome_peripheral}.mouse speed 0.0",
        f"gsettings set {gnome_peripheral}.mouse accel-profile 'default'",
        f"gsettings {easyeffects} process-all-inputs true",
        f"gsettings {easyeffects} process-all-outputs true",
    )

    def options_gtk(file, c=""):
        CONFIG_GTK = (
            set_value(f"gtk-theme-name={c}{theme}{c}", file),
            set_value(f"gtk-icon-theme-name={c}{icons}{c}", file),
            set_value(f"gtk-font-name={c}{font}{c}", file),
            set_value(f"gtk-cursor-theme-name={c}{cursor}{c}", file),
        )
        execute(CONFIG_GTK)

    options_gtk(gtk3)
    options_gtk(gtk2, '"')
    execute(GSETTINGS)
    notify("newm reload", "Reload")


corner_radius = 0

outputs = [
    {"name": "eDP-1", "scale": 0.7},
    {"name": "DP-2", "scale": 0.7, "pos_x": 0, "pos_y": 0},
]

pywm = {
    "xkb_model": "PLACEHOLDER_xkb_model",
    "xkb_layout": "es",
    # "xkb_options": "caps:swapescape",
    "focus_follows_mouse": True,
    "xcursor_theme": "Sweet-cursors",
    "xcursor_size": 40,
    "encourage_csd": False,
    "enable_xwayland": True,
    "natural_scroll": True,
    "texture_shaders": "basic",
    # 'renderer_mode': 'indirect',
    # 'contstrain_popups_to_toplevel': True
}


def rules(view):
    common_rules = {"float": True, "float_size": (750, 750), "float_pos": (0.5, 0.35)}
    float_app_ids = (
        "pavucontrol",
        "blueman-manager",
        "com.github.gi_lom.dialect",
        "Pinentry-gtk-2",
    )
    float_titles = ("Exportar la imagen",)
    blur_apps = ("kitty", "rofi", "waybar", "Alacritty")
    app_rule = None
    if view.app_id in float_app_ids or view.title in float_titles:
        app_rule = common_rules
    if view.app_id in blur_apps:
        app_rule = {"blur": {"radius": 5, "passes": 6}}
    if view.app_id == "catapult":
        app_rule = {"float": True, "float_pos": (0.5, 0.1)}
    if view.role == "jetbrains-rider":
        app_rule = {"float": False}
    # os.system(
    #     f"echo '{view.app_id}, {view.title}, {view.role}' >> /home/crag/.config/newm/apps"
    # )
    return app_rule


view = {
    "padding": 6,
    "fullscreen_padding": 0,
    "send_fullscreen": False,
    "rules": rules,
    "floating_min_size": False,
    "debug_scaling": True,
    "border_ws_switch": 100,
    "ssd": {"enabled": False},
}

swipe_zoom = {
    "grid_m": 1,
    "grid_ovr": 0.02,
}

mod = "L"  # o "A", "C", "1", "2", "3"
super = mod + "-"
altgr = "3-"
ctrl = "C-"
alt = "A-"
background = {
    "path": os.environ["HOME"] + f"/Imágenes/space/space{randrange(1, 6)}.jpg",
    # "path": os.environ["HOME"]
    # + f"/Imágenes/wallpaperCicle/waves/{randrange(1, 3)}.png",
    # "path": os.environ["HOME"] + "/Imágenes/wallpaperCicle/cat-sound.png",
    "time_scale": 0.125,
    "anim": True,
}

anim_time = 0.25
blend_time = 0.5
power_times = [1000, 1000, 2000]

wob_runner = WobRunner("wob -a top -M 100")
backlight_manager = BacklightManager(anim_time=1.0, bar_display=wob_runner)
# Config for keyboard light
# kbdlight_manager = BacklightManager(
#     args="--device='*::kbd_backlight'",
#     anim_time=1.,
#     bar_display=wob_runner)


def synchronous_update() -> None:
    #     kbdlight_manager.update()
    backlight_manager.update()


pactl = PaCtl(0, wob_runner)
term = "kitty"


def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    menu = "~/.config/rofi/bin/launcher_misc"
    clipboard = "~/.config/rofi/bin/clipboard"
    favorites = "~/.config/rofi/bin/apps"
    powermenu = "~/.config/rofi/bin/menu_powermenu"
    bookmarks = "~/.config/rofi/bin/bookmarks"
    passman = "~/.config/rofi/bin/passman"
    wifi = "~/.config/rofi/bin/wifi"

    return [
        (super + "h", lambda: layout.move(-1, 0)),
        (super + "j", lambda: layout.move(0, 1)),
        (super + "k", lambda: layout.move(0, -1)),
        (super + "l", lambda: layout.move(1, 0)),
        (super + "t", lambda: layout.move_in_stack(3)),
        (super + alt + "h", lambda: layout.move_focused_view(-1, 0)),
        (super + alt + "j", lambda: layout.move_focused_view(0, 1)),
        (super + alt + "k", lambda: layout.move_focused_view(0, -1)),
        (super + alt + "l", lambda: layout.move_focused_view(1, 0)),
        (super + ctrl + "h", lambda: layout.resize_focused_view(-1, 0)),
        (super + ctrl + "j", lambda: layout.resize_focused_view(0, 1)),
        (super + ctrl + "k", lambda: layout.resize_focused_view(0, -1)),
        (super + ctrl + "l", lambda: layout.resize_focused_view(1, 0)),
        (altgr + "w", layout.change_focused_view_workspace),
        (altgr + "v", layout.toggle_focused_view_floating),
        ("Henkan_Mode", layout.move_workspace),
        (alt + "Tab", layout.move_next_view),
        (super + "u", lambda: layout.basic_scale(1)),
        (super + "n", lambda: layout.basic_scale(-1)),
        (super + "f", layout.toggle_fullscreen),
        (super + "p", lambda: layout.ensure_locked(dim=True)),
        (super + "P", layout.terminate),
        ("XF86Close", layout.close_view),
        ("XF86Reload", layout.update_config),
        (super, lambda: layout.toggle_overview(only_active_workspace=True)),
        (altgr + "z", layout.swallow_focused_view),
        ("XF86AudioPrev", lambda: os.system("playerctl previous")),
        ("XF86AudioNext", lambda: os.system("playerctl next")),
        ("XF86AudioPlay", lambda: os.system("playerctl play-pause &")),
        (super + "Return", lambda: os.system(f"{term} &")),
        (altgr + "e", lambda: os.system(f"{powermenu} &")),
        ("XF86Copy", lambda: os.system(f"{clipboard} &")),
        ("XF86Favorites", lambda: os.system(f"{bookmarks} &")),
        ("XF86Open", lambda: os.system(f"{passman} &")),
        ("XF86AudioMicMute", lambda: os.system("amixer set Capture toggle")),
        (
            "XF86MonBrightnessUp",
            lambda: backlight_manager.set(backlight_manager.get() + 0.05),
        ),
        (
            "XF86MonBrightnessDown",
            lambda: backlight_manager.set(backlight_manager.get() - 0.05),
        ),
        # (
        # "XF86KbdBrightnessUp",
        # lambda: kbdlight_manager.set(kbdlight_manager.get() + 0.1)),
        # (
        # "XF86KbdBrightnessDown",
        # lambda: kbdlight_manager.set(kbdlight_manager.get() - 0.1)),
        ("XF86AudioRaiseVolume", lambda: pactl.volume_adj(5)),
        ("XF86AudioLowerVolume", lambda: pactl.volume_adj(-5)),
        ("XF86AudioMute", pactl.mute),
        ("XF86Display", lambda: os.system("toggle_wcam uvcvideo &")),
        (
            "XF86Tools",
            lambda: os.system("kitty nvim ~/.config/newm/config.py &"),
        ),
        ("XF86Search", lambda: os.system("catapult --show &")),
        ("XF86Explorer", lambda: os.system(f"{menu} &")),
        ("XF86LaunchA", lambda: os.system(f"{favorites} &")),
        ("Print", lambda: os.system('grim ~/screen-"$(date +%s)".png &')),
        (
            super + "Print",
            lambda: os.system('grim -g "$(slurp)" ~/screen-"$(date +%s)".png &'),
        ),
        ("XF86Go", lambda: os.system(f"{wifi} &")),
        (
            "XF86Mail",
            lambda: os.system(
                "electron-mail --enable-features=UseOzonePlatform --ozone-platform=wayland &"
            ),
        ),
        ("XF86Bluetooth", lambda: os.system("blueman-manager &")),
        ("XF86AudioPreset", lambda: os.system("pavucontrol &")),
        ("XF86WWW", lambda: os.system("firefox &")),
        ("XF86Documents", lambda: os.system("thunar &")),
    ]


gestures = {
    "lp_freq": 120.0,
    "lp_inertia": 0.4,
    # 'pyevdev': {"enabled": True},
}

swipe = {"gesture_factor": 3}

panels = {
    "lock": {
        "cmd": f"{term} newm-panel-basic lock",
        "w": 0.7,
        "h": 0.7,
        "corner_radius": 50,
    },
    "bar": {
        "cmd": "waybar",
        "visible_normal": False,
        "visible_fullscreen": False,
    },
}

grid = {"throw_ps": [2, 10]}

energy = {"idle_times": [60, 180], "idle_callback": backlight_manager.callback}

focus = {
    # "color": "#fb5c8e",  # change color
    # # 'distance': 0,
    # "width": 2,
    # "animate_on_change": True,
    # "anim_time": 0.25
    "enabled": False
}

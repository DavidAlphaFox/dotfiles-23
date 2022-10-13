from __future__ import annotations

import logging
import os

from newm.helper import BacklightManager, PaCtl, WobRunner
from newm.layout import Layout

logger = logging.getLogger(__name__)


def notify(title: str, msg: str, icon="system-settings"):
    os.system(f"notify-send -i '{icon}' -a '{title}' '{msg}'")


def execute_iter(commands: tuple[str, ...]):
    for command in commands:
        os.system(f"{command} &")


def set_value(keyval, file):
    var, val = keyval.split("=")
    return f"sed -i 's/^{var}\\=.*/{var}={val}/' {file}"


def on_startup():
    # "hash dbus-update-activation-environment 2>/dev/null && \
    # "dbus-update-activation-environment --systemd \
    # DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    # "systemctl --user import-environment \
    #     DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    # "/home/crag/Git/dotfiles/etc/dnscrypt-proxy/get_blocklist",

    INIT_SERVICE = (
        # "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots",
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "wlsunset -l 16.0867 -L -93.7561 -t 2500 -T 6000",
        "nm-applet --indicator",
        "fnott",
        # "powerprofilesctl set performance",
        os.path.expanduser("~/.scripts/battery-status.sh"),
        "wl-paste --watch cliphist store",
        "catapult",
    )
    execute_iter(INIT_SERVICE)


def on_reconfigure():
    gnome_schema = "org.gnome.desktop.interface"
    gnome_peripheral = "org.gnome.desktop.peripherals"
    gnome_preferences = "org.gnome.desktop.wm.preferences"
    # easyeffects = "com.github.wwmm.easyeffects"
    theme = "Catppuccin-Mocha-Lavender"
    icons = "candy-icons"
    cursor = "Catppuccin-Mocha-Lavender-Cursors"
    font = "Lucida MAC 10"
    gtk2 = "~/.gtkrc-2.0"

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
        # f"gsettings {easyeffects} process-all-inputs true",
        # f"gsettings {easyeffects} process-all-outputs true",
    )

    def options_gtk(file, c=""):
        CONFIG_GTK = (
            set_value(f"gtk-theme-name={c}{theme}{c}", file),
            set_value(f"gtk-icon-theme-name={c}{icons}{c}", file),
            set_value(f"gtk-font-name={c}{font}{c}", file),
            set_value(f"gtk-cursor-theme-name={c}{cursor}{c}", file),
        )
        execute_iter(CONFIG_GTK)

    # options_gtk(gtk3)
    options_gtk(gtk2, '"')
    execute_iter(GSETTINGS)
    notify("Reload", "update config success")


outputs = [
    {"name": "eDP-2", "pos_x": 0, "pos_y": 0, "scale": 1.0},  # 2560/1600 },
    # {"name": "DP-2", "scale": 0.7},
]


mod = "L"  # o "A", "C", "1", "2", "3"

background = {
    "path": os.path.expanduser("~/Imágenes/wallpaperCicle/3.png"),
    # "path": os.path.expanduser("~/Imágenes/wallpaperCicle/17.jpg"),
    # "path": os.path.expanduser("~/Imágenes/wallpaperCicle/20.jpg"),
    # "path": os.path.expanduser("~/Imágenes/software/linuxfu.jpg"),
    "time_scale": 0.125,
    "anim": True,
}

corner_radius = 0

pywm = {
    "enable_xwayland": False,
    # "xkb_model": "PLACEHOLDER_xkb_model",
    "xkb_layout": "latam",
    # "xkb_layout": "es",
    # "xkb_options": "caps:swapescape",
    "xcursor_theme": "Catppuccin-Mocha-Lavender-Cursors",
    "xcursor_size": 30,
    "contstrain_popups_to_toplevel": True,
    "encourage_csd": False,
    "renderer_mode": "pywm",
}


def rules(view):
    common_rules = {
        # "opacity": 0.8,
        "float": True,
        "float_size": (750, 750),
        "float_pos": (0.5, 0.35),
    }
    float_app_ids = (
        "pavucontrol",
        "blueman-manager",
    )
    float_titles = ("Dialect",)
    blur_apps = ("kitty", "rofi", "Alacritty")
    app_rule = None
    os.system(
        f"echo '{view.app_id}, {view.title}, {view.role}, {view.up_state.is_floating}' >> ~/.config/newm/apps"
    )
    # Set float common rules
    if view.app_id == "catapult":
        app_rule = {"float": True, "float_pos": (0.5, 0.1)}
    # elif view.title is not None and "compartir indicador" in view.title.lower():
    #     return {"float": True, "float_size": (30, 20)}
    elif view.up_state.is_floating:
        app_rule = common_rules
    elif view.app_id in float_app_ids or view.title in float_titles:
        app_rule = common_rules
    elif view.app_id in blur_apps:
        app_rule = {"blur": {"radius": 5, "passes": 6}}
    return app_rule


view = {
    "padding": 10,
    "fullscreen_padding": 0,
    "send_fullscreen": False,
    "sticky_fullscreen": True,
    "accept_fullscreen": False,
    "rules": rules,
    "floating_min_size": False,
    "debug_scaling": False,
    "ssd": {"enabled": False},
}

focus = {
    "color": "#cba6f7",  # change color
    "distance": 4.5,
    "width": 4.5,
    "animate_on_change": True,
    "anim_time": 0.3
    # "enabled": False
}

swipe_zoom = {
    "grid_m": 1,
    "grid_ovr": 0.02,
}

anim_time = 0.25
blend_time = 0.5

wob_option = {
    "border": 2,
    "anchor": "top",
    "margin": 100,
    "border-color": "#94E2D5FF",
    "background-color": "#1E1E2EFF",
    "bar-color": "#A6E3A1FF",
    "overflow-border-color": "#EBA0ACFF",
    "overflow-background-color": "#1E1E2EFF",
    "overflow-bar-color": "#F38BA8FF",
}
wob_args = " ".join((f"--{k} {v}" for (k, v) in wob_option.items()))
wob_runner = WobRunner(f"wob {wob_args}")

backlight_manager = BacklightManager(anim_time=1.0, bar_display=wob_runner)
# # Config for keyboard light
# kbdlight_manager = BacklightManager(
#     args="--device='*::kbd_backlight'", anim_time=1.0, bar_display=wob_runner
# )


def synchronous_update() -> None:
    # kbdlight_manager.update()
    backlight_manager.update()


pactl = PaCtl(0, wob_runner)
term = "kitty"


def goto_view(layout: Layout, index: int):
    if index == 0:
        return
    workspace = layout.get_active_workspace()
    views = layout.tiles(workspace)
    num_w = len(views)
    if index > num_w:
        return
    layout.focus_view(views[index - 1])


def hook_prev_next_view(layout: Layout, fun, steps):
    workspace = layout.get_active_workspace()
    views = layout.tiles(workspace)
    current_view = layout.find_focused_view()
    if not current_view:
        return
    index = views.index(current_view) + steps
    fun(index, views)


def next_view(layout, steps=1):
    def inner_next_view(index, views):
        num_w = len(views)
        if index == num_w:
            index = 0
        layout.focus_view(views[index])

    hook_prev_next_view(layout, inner_next_view, steps)


def prev_view(layout: Layout, steps=1):
    def inner_prev_view(index, views):
        layout.focus_view(views[index])

    hook_prev_next_view(layout, inner_prev_view, -(steps))


def key_bindings(layout: Layout):
    super = mod + "-"
    altgr = "3-"
    ctrl = "C-"
    alt = "A-"
    rofi = "~/.config/rofi/scripts"

    return (
        (alt + "S-Tab", lambda: prev_view(layout)),
        (ctrl + "1", lambda: goto_view(layout, 1)),
        (ctrl + "2", lambda: goto_view(layout, 2)),
        (ctrl + "3", lambda: goto_view(layout, 3)),
        (ctrl + "4", lambda: goto_view(layout, 4)),
        (ctrl + "5", lambda: goto_view(layout, 5)),
        (ctrl + "6", lambda: goto_view(layout, 6)),
        (ctrl + "7", lambda: goto_view(layout, 7)),
        (ctrl + "8", lambda: goto_view(layout, 8)),
        (ctrl + "9", lambda: goto_view(layout, 9)),
        (ctrl + "0", lambda: goto_view(layout, 10)),
        (super + "h", lambda: layout.move(-1, 0)),
        (super + "j", lambda: layout.move(0, 1)),
        (super + "k", lambda: layout.move(0, -1)),
        (super + "l", lambda: layout.move(1, 0)),
        (super + "u", lambda: layout.move(-1, -1)),
        (super + "m", lambda: layout.move(1, 1)),
        (super + "i", lambda: layout.move(1, -1)),
        (super + "n", lambda: layout.move(-1, 1)),
        (super + "t", lambda: layout.move_in_stack(4)),
        (super + ctrl + "h", lambda: layout.move_focused_view(-1, 0)),
        (super + ctrl + "j", lambda: layout.move_focused_view(0, 1)),
        (super + ctrl + "k", lambda: layout.move_focused_view(0, -1)),
        (super + ctrl + "l", lambda: layout.move_focused_view(1, 0)),
        (super + alt + "h", lambda: layout.resize_focused_view(-1, 0)),
        (super + alt + "j", lambda: layout.resize_focused_view(0, 1)),
        (super + alt + "k", lambda: layout.resize_focused_view(0, -1)),
        (super + alt + "l", lambda: layout.resize_focused_view(1, 0)),
        # (altgr + "w", layout.change_focused_view_workspace),
        (altgr + "v", layout.toggle_focused_view_floating),
        # ("Henkan_Mode", layout.move_workspace),
        (alt + "Tab", layout.move_next_view),
        (super + "comma", lambda: layout.basic_scale(1)),
        (super + "period", lambda: layout.basic_scale(-1)),
        (super + "f", layout.toggle_fullscreen),
        (super + "p", lambda: layout.ensure_locked(dim=True)),
        (super + "P", layout.terminate),
        ("XF86Close", layout.close_focused_view),
        ("XF86Reload", layout.update_config),
        (super, lambda: layout.toggle_overview(only_active_workspace=True)),
        (altgr + "z", layout.swallow_focused_view),
        ("XF86AudioPrev", lambda: os.system("playerctl previous")),
        ("XF86AudioNext", lambda: os.system("playerctl next")),
        ("XF86AudioPlay", lambda: os.system("playerctl play-pause &")),
        (super + "Return", lambda: os.system(f"{term} &")),
        (altgr + "e", lambda: os.system(f"{rofi}/powermenu &")),
        ("XF86Copy", lambda: os.system(f"{rofi}/clipboard &")),
        ("XF86Favorites", lambda: os.system(f"{rofi}/bookmarks &")),
        ("XF86Open", lambda: os.system(f"{rofi}/passman &")),
        ("XF86AudioMicMute", lambda: os.system("amixer set Capture toggle")),
        (
            "XF86MonBrightnessUp",
            lambda: backlight_manager.set(backlight_manager.get() + 0.03),
        ),
        (
            "XF86MonBrightnessDown",
            lambda: backlight_manager.set(backlight_manager.get() - 0.03),
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
        # ("XF86Display", lambda: os.system("toggle_wcam uvcvideo &")),
        (
            "XF86Tools",
            lambda: os.system("kitty nvim ~/.config/newm/config.py &"),
        ),
        ("XF86Search", lambda: os.system("catapult &")),
        ("XF86Explorer", lambda: os.system(f"{rofi}/launcher &")),
        # ("XF86LaunchA", lambda: os.system(f"{rofi}/apps &")),
        ("Print", lambda: os.system("shotman output &")),
        (
            super + "Print",
            lambda: os.system("shotman region &"),
        ),
        ("XF86Go", lambda: os.system(f"{rofi}/wifi &")),
        (
            "XF86Mail",
            lambda: os.system(
                "electron-mail --enable-features=UseOzonePlatform --ozone-platform=wayland &"
            ),
        ),
        ("XF86Bluetooth", lambda: os.system("blueman-manager &")),
        ("XF86AudioPreset", lambda: os.system("pavucontrol &")),
        ("XF86WWW", lambda: os.system("firefox &")),
        ("XF86Documents", lambda: os.system("kitty ranger &")),
    )


gestures = {
    "lp_freq": 120.0,
    "lp_inertia": 0.4,
    # "pyevdev": {"enabled": True},
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
energy = {"idle_times": [300, 600, 1500], "idle_callback": backlight_manager.callback}

import os

from newm.layout import Callable, Layout
from newm.view import View

altgr = "3-"
ctrl = "C-"
alt = "A-"
copy_paste = "~/.scripts/super_copy_paste.sh"
rofi = "~/.config/rofi/scripts"


class KeyBindings:
    def __init__(self, layout: Layout, term: str, mod: str) -> None:
        self.layout = layout
        self.term = term
        self.super = mod + "-"

    def __super_clipboard(self, key: str = "v"):
        view = self.layout.find_focused_view()
        mode = " term" if view is not None and view.app_id == self.term else ""
        os.system(f"{copy_paste} {key}{mode} &")

    def __goto_view(self, index: int):
        if index == 0:
            return
        workspace = self.layout.get_active_workspace()
        views = self.layout.tiles(workspace)
        num_w = len(views)
        if index > num_w:
            return
        self.layout.focus_view(views[index - 1])

    def __hook_prev_next_view(self, fun: Callable[[int, list[View]], None], steps: int):
        workspace = self.layout.get_active_workspace()
        views = self.layout.tiles(workspace)
        current_view = self.layout.find_focused_view()
        if (not current_view) or (current_view not in views):
            return
        index = views.index(current_view) + steps
        fun(index, views)

    def __next_view(self, steps=1):
        def inner_next_view(index: int, views: list[View]):
            num_w = len(views)
            if index == num_w:
                index = 0
            self.layout.focus_view(views[index])

        self.__hook_prev_next_view(inner_next_view, steps)

    def __prev_view(self, steps=1):
        def inner_prev_view(index: int, views: list[View]):
            self.layout.focus_view(views[index])

        self.__hook_prev_next_view(inner_prev_view, -(steps))

    def get(self):
        return (
            (alt + "S-Tab", self.__prev_view),
            (ctrl + "1", lambda: self.__goto_view(1)),
            (ctrl + "2", lambda: self.__goto_view(2)),
            (ctrl + "3", lambda: self.__goto_view(3)),
            (ctrl + "4", lambda: self.__goto_view(4)),
            (ctrl + "5", lambda: self.__goto_view(5)),
            (ctrl + "6", lambda: self.__goto_view(6)),
            (ctrl + "7", lambda: self.__goto_view(7)),
            (ctrl + "8", lambda: self.__goto_view(8)),
            (ctrl + "9", lambda: self.__goto_view(9)),
            (ctrl + "0", lambda: self.__goto_view(10)),
            (self.super + "h", lambda: self.layout.move(-1, 0)),
            (self.super + "j", lambda: self.layout.move(0, 1)),
            (self.super + "k", lambda: self.layout.move(0, -1)),
            (self.super + "l", lambda: self.layout.move(1, 0)),
            (self.super + "u", lambda: self.layout.move(-1, -1)),
            (self.super + "m", lambda: self.layout.move(1, 1)),
            (self.super + "i", lambda: self.layout.move(1, -1)),
            (self.super + "n", lambda: self.layout.move(-1, 1)),
            (self.super + "t", lambda: self.layout.move_in_stack(4)),
            (
                self.super + ctrl + "h",
                lambda: self.layout.move_focused_view(-1, 0),
            ),
            (self.super + ctrl + "j", lambda: self.layout.move_focused_view(0, 1)),
            (
                self.super + ctrl + "k",
                lambda: self.layout.move_focused_view(0, -1),
            ),
            (self.super + ctrl + "l", lambda: self.layout.move_focused_view(1, 0)),
            (
                self.super + alt + "h",
                lambda: self.layout.resize_focused_view(-1, 0),
            ),
            (
                self.super + alt + "j",
                lambda: self.layout.resize_focused_view(0, 1),
            ),
            (
                self.super + alt + "k",
                lambda: self.layout.resize_focused_view(0, -1),
            ),
            (
                self.super + alt + "l",
                lambda: self.layout.resize_focused_view(1, 0),
            ),
            # (altgr + "w", self.layout.change_focused_view_workspace),
            (altgr + "v", self.layout.toggle_focused_view_floating),
            # ("Henkan_Mode", self.layout.move_workspace),
            (alt + "Tab", self.layout.move_next_view),
            (self.super + "comma", lambda: self.layout.basic_scale(1)),
            (self.super + "period", lambda: self.layout.basic_scale(-1)),
            (self.super + "f", self.layout.toggle_fullscreen),
            (self.super + "p", lambda: self.layout.ensure_locked(dim=True)),
            (self.super + "P", self.layout.terminate),
            ("XF86Close", self.layout.close_focused_view),
            ("XF86Reload", self.layout.update_config),
            (
                self.super,
                lambda: self.layout.toggle_overview(only_active_workspace=True),
            ),
            (altgr + "z", self.layout.swallow_focused_view),
            ("XF86AudioPrev", lambda: os.system("playerctl previous")),
            ("XF86AudioNext", lambda: os.system("playerctl next")),
            ("XF86AudioPlay", lambda: os.system("playerctl play-pause &")),
            (self.super + "Return", lambda: os.system(f"{self.term} &")),
            (altgr + "e", lambda: os.system(f"{rofi}/powermenu &")),
            ("XF86Paste", self.__super_clipboard),
            ("XF86Copy", lambda: self.__super_clipboard("c")),
            ("XF86Open", lambda: os.system(f"{rofi}/clipboard &")),
            ("XF86Favorites", lambda: os.system(f"{rofi}/bookmarks &")),
            # ("XF86Open", lambda: os.system(f"{self.rofi}/passman &")),
            ("XF86AudioMicMute", lambda: os.system("volumectl -m toggle-mute &")),
            (
                "XF86MonBrightnessUp",
                lambda: os.system("lightctl +2% &"),
            ),
            (
                "XF86MonBrightnessDown",
                lambda: os.system("lightctl -2% &"),
            ),
            # (
            # "XF86KbdBrightnessUp",
            # lambda: kbdlight_manager.set(kbdlight_manager.get() + 0.1)),
            # (
            # "XF86KbdBrightnessDown",
            # lambda: kbdlight_manager.set(kbdlight_manager.get() - 0.1)),
            ("XF86AudioRaiseVolume", lambda: os.system("volumectl -u up &")),
            ("XF86AudioLowerVolume", lambda: os.system("volumectl -u down &")),
            ("XF86AudioMute", lambda: os.system("volumectl toggle-mute &")),
            (
                "XF86Tools",
                lambda: os.system("kitty nvim ~/.config/newm/config.py &"),
            ),
            ("XF86Search", lambda: os.system("catapult &")),
            ("XF86Explorer", lambda: os.system(f"{rofi}/launcher &")),
            # ("XF86LaunchA", lambda: os.system(f"{self.rofi}/apps &")),
            ("Print", lambda: os.system("shotman output &")),
            (
                self.super + "Print",
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

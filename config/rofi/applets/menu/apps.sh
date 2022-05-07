#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

style="$($HOME/.config/rofi/applets/menu/style.sh)"

dir="$HOME/.config/rofi/applets/menu/configs/$style"
rofi_command="rofi -theme $dir/apps.rasi"

# Links
files=""
editor=""
browser=""
music=""
settings=""

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
$files)
	if [[ -f /usr/bin/thunar ]]; then
		thunar &
	else
		msg "No suitable file manager found!"
	fi
	;;
$editor)
	if [[ -f /usr/bin/nvim ]]; then
		lorien &
	else
		msg "No suitable text editor found!"
	fi
	;;
$browser)
	if [[ -f /usr/bin/librewolf ]]; then
		librewolf &
	elif [[ -f /usr/bin/firefox ]]; then
		firefox &
	elif [[ -f /usr/bin/chromium ]]; then
		chromium &
	elif [[ -f /usr/bin/midori ]]; then
		midori &
	else
		msg "No suitable web browser found!"
	fi
	;;
$music)
	if [[ -f /usr/bin/termusic ]]; then
		kitty termusic &
	else
		msg "No suitable music player found!"
	fi
	;;
$settings)
	if [[ -f /usr/bin/start-newm ]]; then
		kitty nvim ~/.config/newm/config.py
	else
		msg "No suitable settings manager found!"
	fi
	;;
esac

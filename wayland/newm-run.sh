#!/bin/sh

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export XDG_CURRENT_DESKTOP=wlroots
export XDG_CURRENT_SESSION=wlroots
source /usr/local/bin/wayland_enablement.sh

sleep 1;

start-newm

#!/bin/bash
killall gnome-keyring-daemon
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"

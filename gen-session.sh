#!/usr/bin/env bash
### Generate .chrome-remote-desktop-session file (for use with virtual desktop mode)
cat <<EOF > ~/.chrome-remote-desktop-session
export \$(dbus-launch)
export GNOME_SHELL_SESSION_MODE=$GNOME_SHELL_SESSION_MODE 
export XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP
export XDG_DATA_DIRS=$XDG_DATA_DIRS
export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS
exec $(which gnome-session)
EOF
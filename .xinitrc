xmodmap $HOME/.Xmodmap
nm-applet &
gnome-autosetting-daemon &
gnome-power-manager &
touchcruiser-indicator &
setxkbmap jp -model jp106 &
gnome-sound-properties &
stalonetray -i 1 --geometry 6x1-0-0 -bg white &
exec xmonad

setxkbmap fr ;
sxhkd &
xrdb .config/x11/Xresources &
numlockx &
xcompmgr &
unclutter -idle 3 &
dunst &
mpd &
xwallpaper --zoom ~/.config/wallpaper/horizon.jpg &
! pidof -s pulseaudio >/dev/null 2>&1 && setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1 &
dwmblocks &
exec dwm

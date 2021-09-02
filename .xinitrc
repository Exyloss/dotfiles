setxkbmap fr ;
exec sxhkd &
exec xrdb .config/x11/Xresources &
exec numlockx &
exec xcompmgr &
exec unclutter &
exec dunst &
exec mpd &
exec xwallpaper --zoom ~/.config/wallpaper/horizon.jpg &
! pidof -s pulseaudio >/dev/null 2>&1 && setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1 &
exec dwmblocks &
exec dwm

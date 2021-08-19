exec setxkbmap fr &
exec slstatus &
exec xrdb .config/x11/Xresources &
exec numlockx &
exec xcompmgr &
exec dunst &
exec mpd &
exec unclutter &
exec xwallpaper --zoom ~/.config/wallpaper/horizon.jpg &
! pidof -s pulseaudio >/dev/null 2>&1 && setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1 &
exec sxhkd-temp &
exec dwm 

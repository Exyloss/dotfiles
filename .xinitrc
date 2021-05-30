exec slstatus &
exec xrdb .config/.Xresources &
exec setxkbmap fr &
exec numlockx &
exec xcompmgr &
exec dunst &
exec xwallpaper --zoom ~/.config/wallpaper/horizon.jpg &
! pidof -s pulseaudio >/dev/null 2>&1 && setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1 &
exec dwm 

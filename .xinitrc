setxkbmap fr ;
sxhkd &
xrdb .config/x11/Xresources &
numlockx &
picom --experimental-backends &
unclutter -idle 3 &
dunst &
mpd &
playerctl &
mpDris2 &
transmission-daemon &
xwallpaper --zoom ~/.config/wallpaper/horizon.jpg &
exec dwmblocks &
kwalletd5 &
/usr/lib/kdeconnectd &
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
exec dwm

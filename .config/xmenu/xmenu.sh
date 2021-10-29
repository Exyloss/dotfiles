#!/bin/sh

xmenu <<EOF | sh &
Applications
	IMG:./icons/web.png		Librewolf	    librewolf
	IMG:./icons/gimp.png	Image editor	gimp
Terminal (alacritty)	alacritty

Éteindre			poweroff
Redémarrer		reboot
Verrouiller		slock
EOF

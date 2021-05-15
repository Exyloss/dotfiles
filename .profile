#
# ~/.zshenv
#

export READER="zathura"
export EDITOR="vim"
export TRUEBROWSER="firefox"
export TERMINAL="st"

[[ -f ~/.zshrc ]] && . ~/.zshrc

#start graphical server if dwm not already running
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep -x dwm || exec startx
fi

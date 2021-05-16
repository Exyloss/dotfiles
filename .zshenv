#
# ~/.zshenv
#

export LANG=fr_FR.UTF-8
export ZDOTDIR=$HOME/.config/zsh
export READER="zathura"
export EDITOR="vim"
export TRUEBROWSER="brave"
export TERMINAL="st"
export LESSHISTFILE=-

[ -f ~/.config/zsh/.zshrc ] && . ~/.config/zsh/.zshrc

#start graphical server if dwm not already running
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x dwm || exec startx
fi

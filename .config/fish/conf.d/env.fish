set -gx PATH "$PATH:$(find ~/.local/bin -type d -printf %p:)"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CURRENT_DESKTOP "sway"
set -gx TERM "xterm-256color"
set -gx LC_MESSAGES "fr_FR.UTF-8"
set -gx LANG "fr_FR.UTF-8"
set -gx XINITRC "$XDG_CONFIG_HOME"/X11/xinitrc
set -gx SUDO_ASKPASS "$HOME/.local/bin/dpass"
set -gx JAVA_HOME "/usr/lib/jvm/java-18-openjdk"
set -gx ANDROID_SDK_ROOT "$HOME/Android/Sdk"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle
set -gx ANDROID_HOME "$XDG_DATA_HOME"/android
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -gx ZDOTDIR $HOME/.config/zsh
set -gx CABAL_CONFIG "$XDG_CONFIG_HOME"/cabal/config
set -gx CABAL_DIR "$XDG_CACHE_HOME"/cabal
set -gx READER "zathura"
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx BROWSER "librewolf"
set -gx TERMINAL "alacritty"
set -gx LESSHISTFILE -
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --height 40%"
set -gx FZF_DEFAULT_COMMAND 'rg --hidden -l ""'
set -gx QT_QPA_PLATFORMTHEME "gtk2"	# Have QT use gtk2 theme.
set -gx MOZ_USE_XINPUT2 "1"		# Mozilla smooth scrolling/touchpads.
set -gx AWT_TOOLKIT "MToolkit wmname LG3D"	#May have to install wmname
set -gx _JAVA_AWT_WM_NONREPARENTING 1	# Fix for Java applications in dwm
set -gx PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/python"
set -gx PYTHONUSERBASE "$XDG_DATA_HOME/python"
set -gx SQLITE_HISTORY $XDG_DATA_HOME/sqlite_history
set -gx ERRFILE "$XDG_CACHE_HOME/X11/xsession-errors"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -gx STATUSBAR "i3blocks" # Comment if using dwm+X11
set -gx WINEPREFIX "$XDG_DATA_HOME/wine"
set -gx LF_ICONS "di=📁:fi=📃:tw=🤝:ow=📂:ln=⛓:or=❌:ex=🎯:*.txt=✍:*.mom=✍:*.me=✍:*.ms=✍:*.png=🖼:*.webp=🖼:*.ico=🖼:*.jpg=📸:*.jpe=📸:*.jpeg=📸:*.gif=🖼:*.svg=🗺:*.tif=🖼:*.tiff=🖼:*.xcf=🖌:*.html=🌎:*.xml=📰:*.gpg=🔒:*.css=🎨:*.pdf=📚:*.djvu=📚:*.epub=📚:*.csv=📓:*.xlsx=📓:*.tex=📜:*.md=📘:*.r=📊:*.R=📊:*.rmd=📊:*.Rmd=📊:*.m=📊:*.mp3=🎵:*.opus=🎵:*.ogg=🎵:*.m4a=🎵:*.flac=🎼:*.wav=🎼:*.mkv=🎥:*.mp4=🎥:*.webm=🎥:*.mpeg=🎥:*.avi=🎥:*.mov=🎥:*.mpg=🎥:*.wmv=🎥:*.m4b=🎥:*.flv=🎥:*.zip=📦:*.rar=📦:*.7z=📦:*.tar.gz=📦:*.z64=🎮:*.v64=🎮:*.n64=🎮:*.gba=🎮:*.nes=🎮:*.gdi=🎮:*.1=ℹ:*.nfo=ℹ:*.info=ℹ:*.log=📙:*.iso=📀:*.img=📀:*.bib=🎓:*.ged=👪:*.part=💔:*.torrent=🔽:*.jar=♨:*.java=♨"

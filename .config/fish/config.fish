set -U fish_greeting
fish_vi_key_bindings
#set -U fish_cursor_default block

# Start Sway at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sway
    end
end

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item
bind / expand-abbr

starship init fish | source
mcfly init fish | source
zoxide init fish | source

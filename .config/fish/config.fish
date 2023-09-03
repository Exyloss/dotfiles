set -U fish_greeting
fish_vi_key_bindings
#set -U fish_cursor_default block

# Start Sway at login
if status is-login
    if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        exec sway
    end
end

function last_history_item
    echo $history[1]
end

function last_file_item
    echo $history[1] | awk '{print $NF}'
end

function toast
    echo "test" >&3
end

abbr -a !! --position anywhere --function last_history_item
abbr -a !f --position anywhere --function last_file_item

mcfly init fish | source
zoxide init fish | source

abbr --erase za
abbr --add cd --position command z

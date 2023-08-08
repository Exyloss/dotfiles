set -U fish_greeting
set -U fish_cursor_default line
fish_vi_key_bindings

# Start Sway at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sway
    end
end

starship init fish | source
mcfly init fish | source
zoxide init fish | source

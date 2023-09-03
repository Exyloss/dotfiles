function lfcd
    set cachedir "$HOME/.cache/lf"
    lf -last-dir-path "$cachedir/path"
    cd (cat "$cachedir/path")
end

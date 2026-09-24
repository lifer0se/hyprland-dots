function ranger
    set -l tmp (command mktemp)
    command ranger --choosedir="$tmp" $argv
    if test -f "$tmp"
        set -l target (command cat "$tmp")
        if test -n "$target"
            cd "$target"
        end
    end
    command rm -f "$tmp"
end
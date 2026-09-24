if status is-interactive
# Commands to run in interactive sessions can go here
end

set -U fish_key_bindings fish_vi_key_bindings

abbr r "ranger"
abbr v "nvim"
abbr l "eza --icons"
abbr ls "eza --icons"
abbr ll "eza -la --icons"
abbr g "git"
abbr gs "git status"
abbr ga "git add"
abbr gr "git restore --staged"
abbr gc "git commit -m"
abbr gp "git push"
abbr gd "git --git-dir=$HOME/.dots --work-tree=$HOME"
abbr gds "git --git-dir=$HOME/.dots --work-tree=$HOME status"
abbr gda "git --git-dir=$HOME/.dots --work-tree=$HOME add"
abbr gdr "git --git-dir=$HOME/.dots --work-tree=$HOME restore --staged"
abbr gdc "git --git-dir=$HOME/.dots --work-tree=$HOME commit -m"
abbr gdp "git --git-dir=$HOME/.dots --work-tree=$HOME push"

# Autologin boot: launch Hyprland on tty1 login (no display manager)
if test -z "$DISPLAY" && test "$XDG_VTNR" = "1"
    exec start-hyprland
end

# hyprland-dots

Hyprland configuration managed as a [bare git repository](https://developer.atlassian.com/cloud/bitbucket/advanced-setup/clone-a-repository-workspace-standard/).

- **Repo**: `~/.hyprcfg/` (bare), work-tree = `$HOME`, alias `hyprdots`
- **Tracks**: `~/.config/hypr`, `~/.config/hyprvim`
- **Submodule**: [`lifer0se/quickbar`](https://github.com/lifer0se/quickbar) → `~/.config/quickshell` (Quickshell bar)

## Setup on a new machine

```sh
# Clone as a bare repo, set the work-tree to $HOME
git clone --bare https://github.com/lifer0se/hyprland-dots.git "$HOME/.hyprcfg"
printf 'alias hyprdots="/usr/bin/git --git-dir=$HOME/.hyprcfg --work-tree=$HOME"\n' >> ~/.bashrc
source ~/.bashrc

# Check the config out into place, ignoring tracked-over files
hyprdots checkout
hyprdots config status.showUntrackedFiles no

# Pull the Quickshell bar submodule
hyprdots submodule update --init
```

## Update

```sh
hyprdots status
hyprdots add .config/hypr .config/hyprvim
hyprdots commit -m "..."
hyprdots push
```

Notes:

- `lua/plugins/` is excluded — the `split-monitor-workspaces` plugin is installed
  separately (its own upstream repo).
- Config is Lua-driven (`hyprland.lua` sources `lua/config/*.lua`).
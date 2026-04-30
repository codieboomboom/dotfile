# Dotfiles

Dotfiles stores my configuration for tools and development environment

## What's inside

| File | Symlinked to | Purpose |
|------|--------------|---------|
| `.vimrc` | `~/.config/vim/vimrc` | Vim configuration |
| `.tmux.conf` | `~/.tmux.conf` | Tmux configuration |

## Prerequisites

- `git`
- `vim` 8.2+ (required for `~/.config/vim/vimrc` to be picked up automatically)
- `tmux`

## Setup on a new machine

### 1. Clone the repo into local machine

```bash
git clone git@github.com:codieboomboom/dotfile.git ~/.dotfiles
```

### 2. Back up any existing configs (optional but recommended)

```bash
[ -e ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
[ -e ~/.config/vim/vimrc ] && mv ~/.config/vim/vimrc ~/.config/vim/vimrc.backup
[ -e ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
```

### 3. Make sure the parent directory exists

`~/.config/vim/` doesn't exist by default on macOS, so create it first:

```bash
mkdir -p ~/.config/vim
```

### 4. Create the symlinks

```bash
ln -s ~/.dotfiles/.vimrc      ~/.config/vim/vimrc
ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
```

### 5. Verify

```bash
ls -l ~/.config/vim/vimrc ~/.tmux.conf
```

You should see arrows (`->`) pointing back into `~/.dotfiles/`.

## Updating

Pull the latest changes — the symlinks will pick up new content automatically:

```bash
cd ~/.dotfiles && git pull
```

To reload without restarting:

```bash
# tmux
tmux source-file ~/.tmux.conf

# vim — inside vim
:source $MYVIMRC
```

## Notes

- The `~/.config/vim/vimrc` location is vim's XDG-compliant config path (vim 8.2+). If you're on an older vim, symlink to `~/.vimrc` instead:
  ```bash
  ln -s ~/.dotfiles/.vimrc ~/.vimrc
  ```
- Symlinks point at the repo, so editing the linked file edits the repo file directly. Commit changes from `~/.dotfiles` as usual.

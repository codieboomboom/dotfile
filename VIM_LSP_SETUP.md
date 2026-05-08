# Vim + ALE setup for multi-language LSP

A clean, scalable vim configuration using ALE for LSP features (completion, go-to-definition, hover, diagnostics) across multiple languages. Per-language config lives in `~/.vim/ftplugin/<lang>.vim`, so adding or removing a language is just adding or deleting one file.

## Prerequisites: pipx

Install **pipx** so global CLI tools live in isolated envs without polluting any project env (especially conda envs):

```bash
# macOS
brew install pipx

# Ubuntu/Debian
sudo apt install pipx

# Fallback (anywhere with Python)
python3 -m pip install --user pipx
```

Add pipx's bin dir to PATH and reload your shell:

```bash
pipx ensurepath
```

Verify with `pipx --version`.

**Why pipx, not pip?** `pip` is for libraries you `import`. `pipx` is for command-line tools (linters, formatters, language servers): each gets its own isolated env, so their dependencies can never conflict with each other or with your projects.

## Install language tools

For Python:

```bash
pipx install 'python-lsp-server[all]'
pipx install ruff
```

This puts `pylsp` and `ruff` on your `PATH` globally — they work regardless of which conda env is active. Add `black`, `isort`, etc. the same way if needed.

## Install ALE

If you don't have a plugin manager yet, install [vim-plug](https://github.com/junegunn/vim-plug):

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Add ALE to `~/.vimrc` (full vimrc below) and run `:PlugInstall` inside vim.

## File layout

```
~/.vim/
└── ftplugin/
    ├── python.vim           # Python-specific
    ├── rust.vim             # Rust-specific
    └── ...                  # one file per language

~/.vimrc                     # global settings only
```

Vim auto-sources `~/.vim/ftplugin/<filetype>.vim` whenever you open a buffer of that filetype, so per-language config only loads when needed. Make sure `.vimrc` has `filetype plugin indent on` (it's in the template below) — that's what tells vim to use `ftplugin/`.

## `~/.vimrc`

Global only — plugin loading, ALE behavior shared by every language, and universal keybindings.

```vim
" --- Plugins ---
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
call plug#end()

filetype plugin indent on
syntax on

" --- Global ALE behavior ---
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc

" Universal fixers across all filetypes
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" --- Diagnostics display ---
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" --- LSP keybindings (mean the same thing in every language) ---
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)
nmap <silent> K  <Plug>(ale_hover)
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)
```

## `~/.vim/ftplugin/python.vim`

Everything Python-specific. Note `b:` (buffer-local) instead of `g:` (global) for per-buffer settings — much cleaner than maintaining one big global dictionary keyed by filetype.

```vim
" Linters & fixers for Python only
let b:ale_linters = ['pylsp', 'ruff']
let b:ale_fixers  = ['ruff', 'ruff_format']

" Point pylsp's jedi at the active conda env
" $CONDA_PREFIX is set by `conda activate`; baked in at vim startup,
" so the rule is: one vim session per env.
let s:py = !empty($CONDA_PREFIX) ? $CONDA_PREFIX . '/bin/python' : 'python'
let g:ale_python_pylsp_config = {
\   'pylsp': {
\     'plugins': {
\       'jedi':        {'environment': s:py},
\       'pycodestyle': {'enabled': v:false},
\       'pyflakes':    {'enabled': v:false},
\       'mccabe':      {'enabled': v:false}
\     }
\   }
\}

" Python-specific editor settings
setlocal expandtab shiftwidth=4 softtabstop=4
setlocal colorcolumn=88
```

The pylsp config disables pylsp's built-in linters because ruff replaces them all (and is faster). The pylsp config has to stay `g:` because that's how ALE wires LSP server config — fine, since it only matters when pylsp is actually running.

## Adding a new language

Create `~/.vim/ftplugin/<lang>.vim`. Example for Rust:

```vim
let b:ale_linters = ['analyzer']    " rust-analyzer
let b:ale_fixers  = ['rustfmt']
setlocal expandtab shiftwidth=4 softtabstop=4
```

Done. Nothing else changes. Remove a language by deleting the file.

## Daily workflow (Python)

```bash
conda activate myproject
cd ~/code/myproject
vim main.py
```

Inside vim:

- Type code → completion popups appear
- `gd` on a symbol → jump to definition
- `gr` → list references
- `K` → docstring/signature popup
- `[d` / `]d` → jump between diagnostics
- `:w` → ruff auto-fixes and formats

Run `:ALEInfo` once on a Python file to confirm pylsp and ruff both started cleanly.

If you switch projects, quit vim, activate the other env, relaunch.

## Discovering more options

1. **`:help ale-options`** — global ALE settings.
2. **`:help ale-python`** — Python-specific subpages: `:help ale-python-pylsp`, `:help ale-python-ruff`, etc. Each lists every variable, defaults, and what it controls.
3. **`:ALEInfo`** on an open file — shows what ALE actually picked: enabled linters, found executables, exact commands. Your debugging tool.

For pylsp's plugin-level settings (the nested dict under `g:ale_python_pylsp_config`), see [pylsp's CONFIGURATION.md](https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md). Anything you'd put in a pylsp config file goes inside that dict.

For ruff lint rules: `ruff linter` lists every rule. Configure via `pyproject.toml` or `ruff.toml` in your project root.

## Troubleshooting

| Symptom | Cause / Fix |
|---|---|
| `pylsp not found` in `:ALEInfo` | pipx's bin dir isn't on `PATH`. Run `pipx ensurepath`, open a new terminal. |
| Completion knows nothing about numpy/pandas/etc. | Vim was launched without activating the conda env. Quit, `conda activate`, relaunch. |
| Too many warnings from pylsp | Make sure pycodestyle/pyflakes/mccabe are disabled in `ftplugin/python.vim` (ruff replaces them). |
| Ruff doesn't fix on save | `:ALEInfo` should list ruff under "Available Fixers". If not, `which ruff` from the shell — pipx may not be on `PATH` for the vim process. |

## Rule of thumb

- **`.vimrc`**: plugin manager. Settings shared across every language. Anything that has to be `g:`.
- **`ftplugin/<lang>.vim`**: linters, fixers, indent rules, column width, language-specific keybindings. Anything that should only exist for that filetype.

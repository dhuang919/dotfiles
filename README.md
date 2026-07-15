# Components

- `core`  - cross-platform, every host (nvim, tmux, shared git body, shared jj body)
- `gui`   - macOS desktop only (zsh, wezterm, hammerspoon, karabiner, mac jj identity)
- `work`  - macOS work identity (git identity + proxy, gh, .custom, CLAUDE.md stub)
- `personal` - macOS personal identity (git identity)
- `spaces` - remote Linux (bash, linux git/jj identity, CLAUDE.md stub)

# Install per environment

- work mac: `stow -R core gui work`
- personal mac: `stow -R core gui personal`
- remote linux: `stow -R core spaces`

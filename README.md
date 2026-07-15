# dotfiles

Managed with GNU stow. Each top-level directory is a stow package; composing
packages gives per-environment setups.

## Packages

- `core`     - every host (nvim, tmux, shared git body, shared jj body, CLAUDE.md content)
- `macos`    - macOS desktop (zsh, wezterm, hammerspoon, karabiner, mac jj identity)
- `work`     - macOS work identity (git identity + proxy, gh, .custom, CLAUDE.md stub)
- `personal` - macOS personal identity (git identity)
- `spaces`   - remote Linux (bash, linux git/jj identity, CLAUDE.md stub)

## Install

Requires GNU stow. From `~/dotfiles`, preview with `-n` first, then apply:

- work mac:      `stow --no-folding -R core macos work`
- personal mac:  `stow --no-folding -R core macos personal`
- remote linux:  `stow --no-folding -R core spaces`

`--no-folding` is required: without it stow collapses a directory owned by one
package into a single symlink, which would link whole state dirs (`~/.config/jj`,
`~/.claude`) back into this repo and let apps write runtime state (jj `repos/`,
claude `history.jsonl`/sessions) into the working tree. With it, stow makes real
dirs and symlinks only leaf files.

## Layering (why identity is split out)

- git: `core/.config/git/shared` is the common body; each profile `.gitconfig`
  pulls it in via `[include]`, then adds identity and host specifics.
- jj:  `core/.config/jj/conf.d/00-common.toml` is shared; each profile adds
  `10-identity.toml`. Files in `conf.d/` merge in lexicographic order.
- CLAUDE.md: content lives in `core/.claude/work-memory.md`; work hosts import it
  from a one-line `~/.claude/CLAUDE.md` stub.

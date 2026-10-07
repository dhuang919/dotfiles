# dotfiles

Managed with GNU stow. Each top-level directory is a stow package; composing
packages gives per-environment setups.

## Packages

- `core`     - every host (nvim, tmux, shared git body, shared jj body, agent instructions)
- `macos`    - macOS desktop (zsh, wezterm, hammerspoon, karabiner, mac jj identity)
- `work`     - macOS work identity (git identity + proxy, gh, .custom, CLAUDE.md and codex AGENTS.md links)
- `personal` - macOS personal identity (git identity)
- `spaces`   - remote Linux (bash, linux git/jj identity)
- `spaces-workarea` - remote Linux agent config dirs under `/workarea` (CLAUDE.md and codex AGENTS.md links)

## Install

Requires GNU stow. From `~/dotfiles`, preview with `-n` first, then apply:

- work mac:      `stow --no-folding -R core macos work`
- personal mac:  `stow --no-folding -R core macos personal`
- remote linux:  `stow --no-folding -R core spaces`, then
  `stow --no-folding -t /workarea -R spaces-workarea`

On spaces, `CLAUDE_CONFIG_DIR` is `/workarea/.claude_config` and `CODEX_HOME` is
`/workarea/.codex_config`, but `$HOME` is `/root`. A stow package has one target
directory, so the agent links live in a separate package that targets `/workarea`.

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
- agent instructions: content lives in `core/.config/agents/AGENTS.md`, written
  tool-neutral. Each profile that wants it adds a relative symlink at the path its
  agent reads (`.claude/CLAUDE.md`, `.codex/AGENTS.md`, or the `/workarea`
  equivalents in `spaces-workarea`), pointing at
  `../../core/.config/agents/AGENTS.md`. Symlinks rather than `@` import stubs, so
  no agent needs to support imports. To add an agent, add one more symlink.

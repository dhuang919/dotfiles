# Default editors for CLI and GUI contexts
export EDITOR='nvim'
export VISUAL='nvim'

# Required for GPG signing (e.g., git commits) to prompt for passphrase correctly
export GPG_TTY=$(tty)

# Show timestamps in shell history (format: DD/MM/YY HH:MM:SS)
export HISTTIMEFORMAT="%d/%m/%y %T "

# Prevent Python from creating .pyc bytecode cache files
export PYTHONDONTWRITEBYTECODE=1

# Homebrew paths - cache prefix to avoid repeated calls
BREW_DIR=$(brew --prefix)

# Install Go binaries to Homebrew's bin directory for consistent PATH access
export GOBIN="${BREW_DIR}/bin"

# Use nvim as the pager for man pages (enables syntax highlighting, search, etc.)
export MANPAGER='nvim +Man!'

# Colorized man pages using LESS_TERMCAP escape sequences
# These work when viewing man pages through less (fallback if MANPAGER isn't used)
export MANROFFOPT='-c'                                           # Force color output from groff
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)                # Begin blinking (green)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)                # Begin bold (cyan) - headings
export LESS_TERMCAP_me=$(tput sgr0)                              # End mode
export LESS_TERMCAP_mh=$(tput dim)                               # Begin dim
export LESS_TERMCAP_mr=$(tput rev)                               # Begin reverse video
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                   # End standout mode
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)  # Begin standout (yellow on blue) - search highlights
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                   # End underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)     # Begin underline (white) - keywords

# PATH additions - use pattern matching to avoid duplicates when re-sourcing
[[ $PATH != *$GOPATH/bin* ]] && PATH="${PATH}:${GOPATH}/bin"    # Go binaries installed via 'go install'
[[ $PATH != *$GOROOT/bin* ]] && PATH="${PATH}:${GOROOT}/bin"    # Go toolchain binaries
[[ $PATH != */opt/homebrew/opt/bde-format@18/bin* ]] && PATH="${PATH}:/opt/homebrew/opt/bde-format@18/bin"  # BDE code formatter
[[ $PATH != */opt/homebrew/opt/node@22/bin* ]] && PATH="${PATH}:/opt/homebrew/opt/node@22/bin"  # Node.js v22 (keg-only, not linked)
export PATH

# Fix tmux-resurrect when the 'last' symlink points to a corrupted session file.
# Relinks 'last' to the second most recent session backup so tmux can restore.
function ftmr {
  local -r tmr_dir=~/.local/share/tmux/resurrect
  local -r top5=$(find "$tmr_dir" -name "*.txt" -type f | awk -F '/' '{print $NF}' | sort -rn | head -n 5)
  local -r second_most_recent=$(echo "$top5" | sed -n '2p')
  rm "${tmr_dir}/last"
  ln -sf "${tmr_dir}/${second_most_recent}" "${tmr_dir}/last"
}

# Search across multiple git repos in the current directory.
# Useful for monorepo-style project layouts where each subdirectory is its own repo.
# Usage: ggrep <pattern> [git-grep-options]
function ggrep {
  for d in $(find . -type d -depth 1); do
    git -C "$d" status &>/dev/null
    if [[ $? -eq 0 ]]; then
      git --no-pager -C "$d" grep "$@" &>/dev/null
      if [[ $? -eq 0 ]]; then
        echo "######################"
        echo "# ${d:2}"
        echo "######################"
        git --no-pager -C "$d" grep -C 3 -n --break --heading "$@"
        echo ""
      fi
    fi
  done
}

# Convert image format and resize to 30% (for reducing file size before sharing).
# Usage: fmt_img source.heic destination.jpg
function fmt_img {
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Source/destination images required" >&2
    return 1
  fi
  magick "$1" "$2"
  magick "$2" -resize 30% "$2"
}

# Batch convert all HEIC files in ~/Downloads to another format (default: jpg).
# Also resizes to 30%. Useful for iPhone photos that need to be shared.
# Usage: fmtheics [extension]
function fmtheics {
  local -r ext="${1:-jpg}"
  local fn
  local nfn
  local new
  for old in $(find ~/Downloads -type file -iname '*.heic'); do
    fn="$(basename "$old")"
    new=$(echo "$old" | sed -E "s/\.heic$/\.$ext/I")
    nfn="$(basename "$new")"
    magick "$old" "$new"
    magick "$new" -resize 30% "$new"
    echo "$fn -> $nfn"
  done
}

# Helper: find the most recent .md file in a directory (by filename sort)
function _get_last_md {
  find "${1}" -name "*.md" -type f | awk -F '/' '{print $NF}' | sort -rn | head -n 1
}

# Create today's scratch/todo markdown file, carrying over uncompleted tasks from previous day.
# Files are organized by year/month in ~/dev/notes/scratch/
# Preserves front matter and incomplete todo items ([ ] or [>]) from the last file.
function todo {
  local -r scratch="${HOME}/dev/notes/scratch"
  local -r year=$(date +%Y)
  local -r month=$(date +%m)
  local -r today=$(date +%d_%a | tr '[:upper:]' '[:lower:]')
  local -r today_path="${scratch}/${year}/${month}/${today}.md"
  local prev_md
  local prev_dir

  if [[ -f "${today_path}" ]]; then
    echo "${today_path} already exists" >&2
    return 0
  fi

  # Make sure the current year month dir exists
  mkdir -p "${scratch}/${year}/${month}"

  # Get the most recent md before today
  prev_md=$(_get_last_md "${scratch}/${year}/${month}")
  if [[ -z "${prev_md}" ]]; then
    # Make sure we get the last md if it's been longer than a month since the last
    while [[ -z "${prev_md}" ]]; do
      # Keep decrementing by a month, going back to prev years if needed
      prev_dir=$(date -v-1m +%Y/%m)
      prev_md=$(_get_last_md "${scratch}/${prev_dir}")
    done
  else
    prev_dir="${year}/${month}"
  fi

  local -r prev_path="${scratch}/${prev_dir}/${prev_md}"

  # Carry over front matter
  local meta="$(awk '
    NR==1 && $0 ~ /^---[ \t]*$/ {in_meta=1; print; next}
    in_meta { print; if ($0 ~ /^---[ \t]*$/) exit }
  ' "${prev_path}")"

  # Carry over todos, keeping h2s and unchecked/in-progress items
  local todo_block="$(awk '
  BEGIN { in_todo=0; printed_any_section=0 }
    # Enter Todo section
    /^# +Todo[ \t]*$/ { in_todo=1; next }
    # Leave Todo section on the next top-level header (e.g., "# Notes" or any "# ...")
    in_todo && /^# +/ { in_todo=0 }
    !in_todo { next }

    # Inside Todo:
    # H2 headings: ensure a blank line before each H2 except the first we print
    /^## +/ {
      if (printed_any_section) print "";
      print $0;
      printed_any_section=1;
      next
    }

    # Unchecked or in-progress tasks (including nested ones):
    /^[ \t]*- \[[ >]\]/ { print $0 }
  ' "${prev_path}")"

  # Write the new file
  {
    if [[ -n "${meta}" ]]; then
      printf "%s\n" "${meta}"
    fi

    printf "# Todo\n\n"
    if [[ -n "${todo_block}" ]]; then
      printf "%s\n" "${todo_block}"
    fi

    printf "\n# Notes\n"
  } > "${today_path}"

  return 0
}

# Reconnect Bluetooth Magic Trackpad by unpairing and re-pairing.
# Fixes intermittent connection issues without going to System Preferences.
# Requires: blueutil (brew install blueutil)
function tp {
  if ! type blueutil &> /dev/null; then
    echo "blueutil not installed" >&2
    return 1
  elif [[ $(blueutil -p) -eq 0 ]]; then
    echo "Bluetooth is off. Toggling..." >&2
    blueutil -p toggle
  fi
  local trackpad="a0-78-17-e3-31-79"
  local tries=0
  local retries=3
  echo "Unpairing..."
  blueutil --unpair "$trackpad"
  echo "Connecting..."
  while [ $(blueutil --is-connected "$trackpad") -eq 0 ]; do
    if [[ "$tries" -eq "$retries" ]]; then
      echo "stopping after $retries retries" >&2
      return 1
    fi
    blueutil --connect "$trackpad"
    (( tries++ ))
  done
}

# "Work work" - open all apps needed to start the workday
function ww {
  open -a /System/Applications/Calendar.app
  open -a /System/Applications/Messages.app
  open -a /Applications/Google\ Chrome.app "https://bba.bloomberg.com"
  open -a /Applications/Docker.app
  open -a /Applications/Spotify.app
  open -a /Applications/Slack.app
  # Parallels VM (commented out - no longer using)
  # if [[ -x "$(which prlctl)" ]]; then
  #   prlctl start c1f2e698-0d26-4dd3-85a7-03bdb9b7cc1a
  #   open /Applications/Parallels\ Desktop.app
  # fi
}

# Nuclear option for Docker cleanup - removes ALL containers, images, volumes, and caches.
# Useful when Docker Desktop is eating too much disk space.
function clean_docker {
  echo "Deleting containers..."
  for cid in $(docker ps -a | tail -n +2 | awk '{print $1}'); do
    docker rm -f $cid
    echo "  > $cid"
  done

  echo "\nPruning images..."
  docker image prune -af

  echo "\nPruning volumes..."
  docker volume prune -af

  echo "\nPruning builder cache..."
  docker builder prune -f

  echo "\nPruning networks..."
  docker network prune -f

  echo "\nPrinting disk usage..."
  docker system df
}

# Create directory and cd into it in one command (like mkdir + cd combined)
function take {
  mkdir -p $@ && cd ${@:$#}
}

# ============================================================================
# ZSH Completion Settings
# ============================================================================

# Cache completions for faster load times
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Show . and .. in completion menus
zstyle ':completion:*' special-dirs true

# Use bash's git completion script (more comprehensive than zsh's built-in)
zstyle ':completion:*:*:git:*' script ~/.zsh/completion/git-completion.bash

# Add custom completions to function path
fpath=(~/.zsh/completion $fpath)
type brew &>/dev/null && fpath+=${BREW_DIR}/share/zsh/site-functions

# Initialize completion system (-i ignores insecure directories)
autoload -Uz compinit && compinit -i
autoload bashcompinit && bashcompinit   # Enable bash completion compatibility
zmodload -i zsh/complist                 # Load completion list module for menu selection

# Jujutsu (jj) version control completions
if command -v jj >/dev/null 2>&1; then
  source <(jj util completion zsh)
fi

# Ctrl+X opens current command line in $EDITOR for complex edits
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# cd into directories just by typing the directory name (no cd required)
setopt autocd

# ============================================================================
# External Configuration Sources
# ============================================================================

# Machine-specific overrides (work credentials, local paths, etc.)
[ -f ~/.custom ] && source ~/.custom 2>& /dev/null

# WezTerm shell integration (enables features like clickable links, cwd tracking)
[ -f ~/.config/wezterm/wezterm.sh ] && source ~/.config/wezterm/wezterm.sh

# ============================================================================
# Tool Initializations (fzf, starship, zoxide)
# ============================================================================

# fzf: fuzzy finder for files, history, etc. (Ctrl+R for history, Ctrl+T for files)
type fzf &>/dev/null && source <(fzf --zsh)

# Custom prompt configuration (username, directory, git status)
[ -f ~/.prompt.sh ] && source ~/.prompt.sh

# zoxide: smarter cd that learns your most-used directories (use 'z' instead of 'cd')
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
else
  echo "zoxide not found. installing..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# ============================================================================
# Aliases
# ============================================================================

# Enable zsh's built-in help system (like bash's 'help' command)
[ alias run-help &>/dev/null ] && unalias run-help
autoload run-help
alias help=run-help

# Homebrew maintenance - update, upgrade all packages, remove old versions
alias bubu="brew update && brew upgrade && brew cleanup"

# Short aliases for frequently used commands
alias g="git"
alias gd="gh dash"               # Github dashboard TUI
alias j="jj"                     # Jujutsu version control
alias jp="jj tug && jj gp"       # jj update the closest branch and push it - *depends on jj aliases*
alias ll="ls -lAh --color=auto"  # Long listing with hidden files
alias mng="todo && vt && vim"    # "Morning" routine: create todo, cd to notes, open vim
alias tm="tmux"
alias vim="nvim"
alias vt="cd ~/dev/notes"        # Jump to notes directory

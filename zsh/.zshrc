export EDITOR='nvim'
export VISUAL='nvim'
export GPG_TTY=$(tty)
export HISTTIMEFORMAT="%d/%m/%y %T "
export PYTHONDONTWRITEBYTECODE=1

BREW_DIR=$(brew --prefix)
export GOBIN="${BREW_DIR}/bin"

# use nvim for man pages
export MANPAGER='nvim +Man!'

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)

[[ $PATH != *$GOPATH/bin* ]] && PATH="${PATH}:${GOPATH}/bin"
[[ $PATH != *$GOROOT/bin* ]] && PATH="${PATH}:${GOROOT}/bin"
[[ $PATH != */opt/homebrew/opt/bde-format@18/bin* ]] && PATH="${PATH}:/opt/homebrew/opt/bde-format@18/bin"
[[ $PATH != */opt/homebrew/opt/node@22/bin* ]] && PATH="${PATH}:/opt/homebrew/opt/node@22/bin"
export PATH

function ftmr {
  # Fix tmux-resurrect
  local -r tmr_dir=~/.local/share/tmux/resurrect
  local -r top5=$(find "$tmr_dir" -name "*.txt" -type f | awk -F '/' '{print $NF}' | sort -rn | head -n 5)
  # echo "$top5"
  local -r second_most_recent=$(echo "$top5" | sed -n '2p')
  rm "${tmr_dir}/last"
  # echo "$second_most_recent"
  ln -sf "${tmr_dir}/${second_most_recent}" "${tmr_dir}/last"
}

function ggrep {
  # Git grep all directories in the current directory
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

function fmt_img {
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Source/destination images required" >&2
    return 1
  fi
  magick "$1" "$2"
  magick "$2" -resize 30% "$2"
}

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

function _get_last_md {
  find "${1}" -name "*.md" -type f | awk -F '/' '{print $NF}' | sort -rn | head -n 1
}

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

function ww {
  open -a /System/Applications/Calendar.app
  open -a /System/Applications/Messages.app
  open -a /Applications/Google\ Chrome.app "https://bba.bloomberg.com"
  open -a /Applications/Docker.app
  open -a /Applications/Spotify.app
  open -a /Applications/Slack.app
  # if [[ -x "$(which prlctl)" ]]; then
  #   prlctl start c1f2e698-0d26-4dd3-85a7-03bdb9b7cc1a
  #   open /Applications/Parallels\ Desktop.app
  # fi
}

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

function take {
  mkdir -p $@ && cd ${@:$#}
}

# zsh settings
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:git:*' script ~/.zsh/completion/git-completion.bash

fpath=(~/.zsh/completion $fpath)
type brew &>/dev/null && fpath+=${BREW_DIR}/share/zsh/site-functions

autoload -Uz compinit && compinit -i
autoload bashcompinit && bashcompinit
zmodload -i zsh/complist

if command -v jj >/dev/null 2>&1; then
  source <(jj util completion zsh)
fi

# Shortcut to edit using vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

setopt autocd

## enable `help`
[ alias run-help &>/dev/null ] && unalias run-help
autoload run-help
alias help=run-help

[ -f ~/.custom ] && source ~/.custom 2>& /dev/null
[ -f ~/.config/wezterm/wezterm.sh ] && source ~/.config/wezterm/wezterm.sh

alias bubu="brew update && brew upgrade && brew cleanup"
alias vt="cd ~/dev/notes"
alias ll="ls -lAh"
alias vim="nvim"
alias szsh="source ~/.zshrc"
alias g="git"
alias gd="gh dash"
alias mng="todo && vt && vim"

type fzf &>/dev/null && source <(fzf --zsh)

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  echo "starship not found. installing..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

type starship_zle-keymap-select >/dev/null || \
  {
    echo "starship_zle bug. loading starship..."
    eval "$(starship init zsh)"
  }

if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
else
  echo "zoxide not found. installing..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

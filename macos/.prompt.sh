# Zsh prompt configuration

# --- Colors (ANSI codes) ---
COLOR_TIME="90"        # gray (bright black)
COLOR_USER="34"        # blue
COLOR_ROOT="31"        # red
COLOR_DIR="37"         # white
COLOR_GIT="33"         # yellow

# --- Git Info ---
parse_git() {
  git rev-parse --git-dir &>/dev/null || return
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  local dirty=""
  git diff --quiet 2>/dev/null || dirty="*"
  if [ -n "$branch" ]; then
    echo " ($branch$dirty)"
  elif [ -n "$dirty" ]; then
    echo " $dirty"
  fi
}

# --- Prompt ---
setopt prompt_subst

_pc_time=$'%{\e['"${COLOR_TIME}"$'m%}'
_pc_user=$'%{\e['"${COLOR_USER}"$'m%}'
_pc_root=$'%{\e['"${COLOR_ROOT}"$'m%}'
_pc_dir=$'%{\e['"${COLOR_DIR}"$'m%}'
_pc_git=$'%{\e['"${COLOR_GIT}"$'m%}'
_pc_reset=$'%{\e[0m%}'

# Build the base prompt (everything before the prompt char)
_prompt_base=''
_prompt_base+="${_pc_time}"'[%D{%H:%M:%S}]'"${_pc_reset}"' '          # time (HH:MM:SS)
_prompt_base+='%(#.'"${_pc_root}"'.'"${_pc_user}"')%n'"${_pc_reset}"  # user
_prompt_base+=':'"${_pc_dir}"'%~'"${_pc_reset}"                       # directory
_prompt_base+="${_pc_git}"'$(parse_git)'"${_pc_reset}"                # git status

# Vi mode indicator: update prompt char color based on insert vs normal mode.
# zle-keymap-select fires on every mode switch; zle-line-init resets on new prompt.
# $KEYMAP is 'vicmd' in normal mode, 'viins' or 'main' in insert mode.
function _set_vi_prompt {
  case $KEYMAP in
    vicmd)      PROMPT="${_prompt_base} %F{red}:%(?..)%f " ;;  # normal mode: red :
    viins|main) PROMPT="${_prompt_base} %(?.%F{green}.%F{red})%(#.#.\$)%f " ;;  # insert mode: green/red $
  esac
  zle && zle reset-prompt
}
zle -N zle-keymap-select _set_vi_prompt
zle -N zle-line-init _set_vi_prompt

# Set initial prompt (insert mode is the default)
PROMPT="${_prompt_base} %(?.%F{green}.%F{red})%(#.#.\$)%f "

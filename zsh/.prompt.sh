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

PROMPT=''
PROMPT+="${_pc_time}"'[%*]'"${_pc_reset}"' '                    # time (HH:MM:SS)
PROMPT+='%(#.'"${_pc_root}"'.'"${_pc_user}"')%n'"${_pc_reset}"  # user
PROMPT+=':'"${_pc_dir}"'%~'"${_pc_reset}"                       # directory
PROMPT+="${_pc_git}"'$(parse_git)'"${_pc_reset}"                # git status
PROMPT+=' %(?.%F{green}.%F{red})%(#.#.$)%f '                    # prompt char

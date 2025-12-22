# Prompt configuration - source from .bashrc and .zshrc

# --- Colors (ANSI codes) ---
COLOR_TIME="90"        # gray (bright black)
COLOR_USER="34"        # blue
COLOR_ROOT="31"        # red
COLOR_DIR="37"         # white
COLOR_GIT="33"         # yellow
COLOR_SUCCESS="32"     # green
COLOR_ERROR="31"       # red

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
if [ -n "$ZSH_VERSION" ]; then
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
else
  __prompt_cmd() {
    local exit_code=$?
    local user_color=$COLOR_USER
    [ "$EUID" -eq 0 ] && user_color=$COLOR_ROOT
    local char_color=$COLOR_SUCCESS
    [ $exit_code -ne 0 ] && char_color=$COLOR_ERROR
    PS1=''
    PS1+="\[\e[${COLOR_TIME}m\][\t]\[\e[0m\] "         # time
    PS1+="\[\e[${user_color}m\]\u\[\e[0m\]"            # user
    PS1+=":\[\e[${COLOR_DIR}m\]\w\[\e[0m\]"            # directory
    PS1+="\[\e[${COLOR_GIT}m\]\$(parse_git)\[\e[0m\]"  # git status
    PS1+=" \[\e[${char_color}m\]\$\[\e[0m\] "          # prompt char
  }
  PROMPT_COMMAND=__prompt_cmd
fi

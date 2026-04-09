# Bash prompt configuration

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

# --- Vi mode indicator ---
# Readline's show-mode-in-prompt inserts a mode string before PS1.
# vi-cmd-mode-string / vi-ins-mode-string customize what's shown.
# The \1...\1 wrapping tells readline these are non-printing (like \[...\] in PS1).
bind 'set show-mode-in-prompt on'
bind 'set vi-cmd-mode-string "\1\e[31m\2[N]\1\e[0m\2 "'
bind 'set vi-ins-mode-string "\1\e[32m\2[I]\1\e[0m\2 "'

# --- Prompt ---
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

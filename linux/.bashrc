export EDITOR=nvim
export VISUAL=nvim
export COLORTERM=truecolor
export TERM=xterm-256color
export LC_ALL=en_US.UTF-8

[[ $PATH != */bb/bin* ]] && PATH="${PATH}:/bb/bin"
[[ $PATH != */opt/bb/bin* ]] && PATH="${PATH}:/opt/bb/bin"
[[ $PATH != *${HOME}/.cargo/bin* ]] && PATH="${PATH}:${HOME}/.cargo/bin"
[[ $PATH != *${HOME}/.local/bin* ]] && PATH="${PATH}:${HOME}/.local/bin"
export PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Setup custom prompt
[ -f ~/.prompt.sh ] && source ~/.prompt.sh

function clean_docker {
  echo "Deleting containers..."
  for cid in $(docker ps -a | tail -n +2 | awk '{print $1}'); do
    docker rm -f "$cid"
    echo "  > $cid"
  done
  printf "\nPruning images..."
  docker image prune -af
  printf "\nPruning volumes..."
  docker volume prune -af
  printf "\nPruning builder cache..."
  docker builder prune -f
  docker system df
}

function take {
  mkdir -p "$@" && cd "${@:$#}"
}

function tglpxy {
  local PIPDIR=/root/.pip
  local NPMRCDIR=/opt/bb/etc
  local pipconf="${PIPDIR}/pip.conf"
  local npmrc="${NPMRCDIR}/npmrc"

  if [ -f "${pipconf}" ]; then
    echo "Renaming ${PIPDIR}/pip.conf to ${PIPDIR}/_pip.conf"
    mv $PIPDIR/{,_}pip.conf
  else
    echo "Renaming ${PIPDIR}/_pip.conf to ${PIPDIR}/pip.conf"
    mv $PIPDIR/{_,}pip.conf
  fi

  if [ -f "$npmrc" ]; then
    echo "Renaming ${NPMRCDIR}/npmrc to ${NPMRCDIR}/_npmrc"
    mv $NPMRCDIR/{,_}npmrc
  else
    echo "Renaming ${NPMRCDIR}/_npmrc to ${NPMRCDIR}/npmrc"
    mv $NPMRCDIR/{_,}npmrc
  fi
}

function install_cc {
  # Hack for spaces over ssh
  echo "Installing claude code"

  # https://bbgithub.dev.bloomberg.com/devx-ai-tooling/cc-setup?tab=readme-ov-file#spaces-web-ide--spaces-ssh
  curl https://seedling.s3.dev.bcs.bloomberg.com/latest/seedling-install.sh | sh

  function disable_bracketed_paste {
    printf '\033[?2004l';
  }

  disable_bracketed_paste && export NEXUS_CLAUDE_CODE_TOKEN=$(seedling auth get-token --quiet --simple --auth-mode bsso --token-type archer:mlp)

  curl -fsSL "https://cc-setup.s3.dev.bcs.bloomberg.com/cc-setup.sh" -o ./cc-setup.sh && chmod +x ./cc-setup.sh && echo "Y" | ./cc-setup.sh
}

function setup_cc {
  claude plugin marketplace add git@bbgithub.dev.bloomberg.com:devx-ai-tooling/claude-skills.git
  claude plugin install bloomberg-engineering-skills
}

# Init zoxide at the end otherwise it complains
eval "$(zoxide init bash)"

alias dpxy="http_proxy=http://devproxy.bloomberg.com:82 https_proxy=http://devproxy.bloomberg.com:82"
alias epxy="http_proxy=http://proxy.bloomberg.com:81 https_proxy=http://proxy.bloomberg.com:81"
alias ll="ls -lAh --color=auto"
alias vim="nvim"
alias g="git"
alias j="jj"
alias jp="jj tug && jj gp"       # jj update the closest branch and push it - *depends on jj aliases*

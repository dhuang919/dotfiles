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

# Vi keybindings for line editing
set -o vi
bind 'set keyseq-timeout 10'  # 10ms delay for key sequences — makes Esc near-instant

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Setup custom prompt
[[ -f ~/.prompt.sh ]] && source ~/.prompt.sh

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

function setup_cc {
  claude plugin marketplace add git@bbgithub.dev.bloomberg.com:devx-ai-tooling/claude-skills.git
  claude plugin install bloomberg-engineering-skills
}

function setup_chef {
  docker pull artprod.dev.bloomberg.com/chef-workstation:latest
  docker run artprod.dev.bloomberg.com/chef-workstation cat /usr/bin/aliases/devxspace-general-chef.sh > /usr/bin/chef
  chmod +x /usr/bin/chef
  docker run artprod.dev.bloomberg.com/chef-workstation cat /usr/bin/aliases/devxspace-general-kitchen.sh > /usr/bin/kitchen
  chmod +x /usr/bin/kitchen
  docker run artprod.dev.bloomberg.com/chef-workstation cat /usr/bin/aliases/devxspace-general-knife.sh > /usr/bin/knife
  chmod +x /usr/bin/knife
  docker run artprod.dev.bloomberg.com/chef-workstation cat /usr/bin/aliases/devxspace-general-irb.sh > /usr/bin/irb
  chmod +x /usr/bin/irb
}

# Init zoxide at the end otherwise it complains
eval "$(zoxide init bash)"

alias claude='get-claude-code-auth-token --skip-checks --warmup >/dev/null; /opt/bb/bin/claude'
alias dpxy="http_proxy=http://devproxy.bloomberg.com:82 https_proxy=http://devproxy.bloomberg.com:82"
alias epxy="http_proxy=http://proxy.bloomberg.com:81 https_proxy=http://proxy.bloomberg.com:81"
alias g="git"
alias j="jj"
alias jp="jj tug && jj gp"       # jj update the closest branch and push it - *depends on jj aliases*
alias ll="ls -lAh --color=auto"
alias tm="tmux"
alias vim="nvim"

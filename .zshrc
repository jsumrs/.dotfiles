if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/Users/june/.local/bin/mise activate zsh)"
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

eval "$(zoxide init zsh)"
alias df="df -h"
alias rm="rm -i"
alias ll='ls -alF'
Alias la='ls -A'
alias l='ls -CF'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY
autoload -Uz compinit && compinit

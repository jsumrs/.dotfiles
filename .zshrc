
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac
  # 
  eval "$(/Users/june/.local/bin/mise activate zsh)"
  alias ls='ls -G'
else
  # Linux
  # 
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  source ~/powerlevel10k/powerlevel10k.zsh-theme

  alias ls='ls --color=auto'

  # Added by swiftly
  . "/home/jn/.local/share/swiftly/env.sh"
  export PATH="$HOME/.local/share/swiftly/bin:$PATH"
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"
alias df="df -h"
alias rm="rm -i"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY
autoload -Uz compinit && compinit


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


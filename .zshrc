
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac
  echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
  eval "$(/Users/june/.local/bin/mise activate zsh)"
  alias ls='ls -G'
else
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  # Linux
  alias ls='ls --color=auto'
    
  # Added by swiftly
  . "/home/jn/.local/share/swiftly/env.sh"
  export PATH="$HOME/.local/share/swiftly/bin:$PATH"
fi

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
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

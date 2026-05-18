# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

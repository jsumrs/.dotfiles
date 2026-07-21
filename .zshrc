
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac
  # 
  alias ls='ls -G'
else
  # Linux
  # 
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

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
alias st="swift test"

sr() {
  swift run && open Output/$(ls -At1 ./Output | head -n 1)
}

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

source ~/powerlevel10k/powerlevel10k.zsh-theme


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/june/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP binary.
export PATH="/Users/june/Library/Application Support/Herd/bin/":$PATH

# Disable .NET tools (extension in VSCode) telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Enable .dotnet tools 
export PATH="$PATH:/Users/june/.dotnet/tools"

# Asciidoc Live Preview
# Usage: adoc-preview <file.adoc>
adoc-preview() {
  emulate -L zsh
  setopt local_options no_nomatch

  if [[ -z "$1" ]]; then
    print -u2 "usage: adoc-preview <file.adoc>"
    return 1
  fi

  # Resolve to an absolute path portably.
  # zsh's :A modifier does this without needing GNU readlink.
  local src="${1:A}"
  if [[ ! -f "$src" ]]; then
    print -u2 "adoc-preview: no such file: $1"
    return 1
  fi

  local outdir base out server_pid
  outdir=$(mktemp -d)
  base="${${src:t}:r}"          # :t = tail (basename), :r = strip extension
  out="$outdir/$base.html"

  local -a asciidoctor_args
  asciidoctor_args=(-a source-highlighter=highlight.js)

  # Initial build so the page exists before the server opens it.
  asciidoctor "${asciidoctor_args[@]}" "$src" -o "$out"

  # Start the live-reload server in the background.
  npx live-server "$outdir" --open="$base.html" &
  server_pid=$!

  # Tear down server and temp dir on any exit path.
  _adoc_preview_cleanup() {
    kill "$server_pid" 2>/dev/null
    rm -rf "$outdir"
  }
  trap '_adoc_preview_cleanup; return' INT TERM

  # Rebuild on every write. entr blocks until interrupted.
  # /_ is the changed file.
  print -r -- "$src" | entr asciidoctor "${asciidoctor_args[@]}" /_ -o "$out"

  # Cleanup if entr exits on its own (e.g. file removed).
  _adoc_preview_cleanup
  unfunction _adoc_preview_cleanup 2>/dev/null
}

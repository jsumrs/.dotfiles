# ~/.zshrc, shared by the Mac and WSL. Per-OS parts are inside [[ $OSTYPE == darwin* ]] checks.
# Tools that may be missing on one machine are guarded, so startup never errors.
# Old combined version: ~/.dotfiles/.zshrc.bak

# ---- Mac: Powerlevel10k instant prompt. Must stay near the top, before anything that prints. ----
if [[ $OSTYPE == darwin* && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- PATH ----
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"   # tools from `dotnet tool install -g`
if [[ $OSTYPE == darwin* ]]; then
  export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"
  export PATH="$HOME/Library/Application Support/Herd/bin/:$PATH"
  export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
else
  export PATH="$PATH:/snap/bin"
fi

# ---- .NET ----
# Mac: the official installer lives in /usr/local/share/dotnet.
# WSL: no DOTNET_ROOT needed; the apt install registers itself in /etc/dotnet/install_location.
[[ $OSTYPE == darwin* ]] && export DOTNET_ROOT=/usr/local/share/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# ---- Aliases ----
if [[ $OSTYPE == darwin* ]]; then
  alias ls='ls -G'
  alias st='swift test'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias df='df -h'
alias rm='rm -i'

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY

# ---- Completion ----
# ~/.zsh/completions holds generated completion files. _dotnet comes from
# `dotnet completions script zsh`; regenerate it after upgrading the .NET SDK.
# fpath must be set before compinit runs, or the files aren't found.
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                        # arrow-key menu on Tab
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive matching

# ---- Tools (skipped where not installed) ----
command -v fzf >/dev/null && source <(fzf --zsh)             # Ctrl-R history search, Ctrl-T file picker
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# ---- Prompt ----
if [[ $OSTYPE == darwin* ]]; then
  # Powerlevel10k. To customize, run `p10k configure` or edit ~/.p10k.zsh.
  [[ -r ~/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/powerlevel10k/powerlevel10k.zsh-theme
  [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
else
  PROMPT='%1~ ❯ '   # "airflow-sim ❯ " (%1~ = current folder name, ~ for home)
fi

# ---- Mac-only functions ----
if [[ $OSTYPE == darwin* ]]; then
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
fi

# ---- Plugins (Mac: brew install, WSL: apt install zsh-autosuggestions zsh-syntax-highlighting) ----
# Guarded so the shell starts cleanly where they aren't installed.
# Syntax highlighting must be sourced last: it wraps the key bindings that exist when it loads.
if [[ $OSTYPE == darwin* ]]; then _zsh_plugins=/opt/homebrew/share; else _zsh_plugins=/usr/share; fi
[[ -r $_zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
    source $_zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r $_zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
    source $_zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unset _zsh_plugins

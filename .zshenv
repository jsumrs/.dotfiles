export ZDOTDIR="$HOME/.config/zsh"

# ~/.zshenv, shared by the Mac and WSL. Everything here is Linux/WSL-only.
if [[ $OSTYPE == linux* ]]; then
  # Ubuntu's /etc/zsh/zshrc runs compinit before ~/.zshrc does. ~/.zshrc runs it itself (after adding
  # ~/.zsh/completions to fpath), and two runs with different fpaths rebuild the cache on every start.
  skip_global_compinit=1

  # WSL adds ~27 Windows folders (/mnt/c/...) to PATH. Reading them is slow (~0.6 s whenever zsh
  # builds its command list) and they only duplicate Linux tools. Drop them all, then keep only
  # C:\Windows (explorer.exe) and System32 (clip.exe). Windows programs still need the .exe suffix.
  path=(${path:#/mnt/*} /mnt/c/Windows /mnt/c/Windows/System32)
fi

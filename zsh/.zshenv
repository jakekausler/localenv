# ZSH
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$ZDOTDIR/.oh-my-zsh"
export HYPHEN_INSENSITIVE="true"
export ENABLE_CORRECTION="true"
export FPATH="$HOME/.config/eza/completions/zsh:$FPATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Browser
#export BROWSER="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c start"
export BROWSER=wslview

# NVM
export NVM_DIR="$HOME/.nvm"

# Path
export PATH=$HOME/.local/bin:/snap/bin:$HOME/.config/chatgpt-cli/:"$PATH"

# TMP
export TMPDIR="/tmp"

# NPTools
export NPTOOLS_DISABLE_METRICS=true

# Secrets
source "$HOME/.secrets.zsh"

# batdiff
export BATDIFF_USE_DELTA=true
. "$HOME/.cargo/env"

# ChatGPT CLI
export OPENAI_CONFIG_HOME="$HOME/.config/chatgpt-cli"
export OPENAI_DATA_HOME="$OPENAI_CONFIG_HOME/history"

# Autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"

# LevelDB
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export PATH="$PATH:/home/jakekausler/bin"

# Reuse the keychain-managed ssh-agent in non-interactive shells (never prompts)
[ -f "$HOME/.keychain/$(hostname)-sh" ] && . "$HOME/.keychain/$(hostname)-sh"

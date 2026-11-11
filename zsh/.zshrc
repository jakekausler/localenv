# Source Files
source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/.functions.sh
source $ZDOTDIR/.aliases.sh

# Completions
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

source $ZSH/custom/plugins/fzf-tab/fzf-tab.plugin.zsh

# Plugins
plugins=(
	zsh-syntax-highlighting
	zsh-autosuggestions
	zsh-auto-venv
	zsh-completions
	zsh-fzf-history-search
)

# Tmux: auto-attach to the shared "default" session (interactive terminal logins only).
# After a reboot, tmux-persistence restores the saved layout first (one login restores, concurrent
# logins wait on its lock, then attach to the same session without detaching other clients).
if [[ -o interactive && -z $TMUX && ( -n $SSH_TTY || -t 0 ) ]]; then
    if [[ -r $HOME/.local/lib/tmux-persistence/restore-before-attach.zsh ]]; then
        source "$HOME/.local/lib/tmux-persistence/restore-before-attach.zsh"
        tmux_persist_attach
    else
        tmux attach -t default || tmux new -s default
    fi
fi

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SSH
eval $(ssh-agent) &> /dev/null

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# Zoxide - Smart navigation
eval "$(zoxide init zsh)"

# Navi Widget
eval "$(navi widget zsh)"

# The Fuck
eval $(thefuck --alias)

# FZF Tab Configurations
source $ZDOTDIR/fzf-tab.zsh

# Widgets
source $ZDOTDIR/widgets.zsh

# ZSH Syntax Highlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/home/jakekausler/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/jakekausler/.bun/_bun" ] && source "/home/jakekausler/.bun/_bun"

# SSH agent via keychain: prompts for the GitHub key passphrase once per boot (interactive logins only)
command -v keychain >/dev/null && eval "$(keychain --eval --quiet id_ed25519_github)"

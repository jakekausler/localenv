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

# Tmux
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
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

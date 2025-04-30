# Replace lf with lfcd function
alias lf=lfcd

# Python
alias python=python3
alias pip=pip3

# Reload zsh config files
alias reload="source $ZDOTDIR/.zshenv && source $ZDOTDIR/.zshrc && tmux source-file $HOME/.config/tmux/.tmux.conf"

# git aliases
alias ga="git add ."
alias gc="git commit -m"
alias gps="git push"
alias gp="git pull"
alias gs="git status"
alias gac="ga && gc"
alias gco="git checkout"

# grep
alias grep='grep --color=auto'

# cd
alias cd..="cd .."
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias .1="cd ../"
alias .2="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias ,5="cd ../../../../../"

# mkdir
alias mkdir="mkdir -pv"

# netstat
alias ports="netstat -tulanp"

# updates
alias update="sudo apt-get update && sudo apt-get upgrade"
alias get="sudo apt-get install"

# disk usage
alias df="df -h"
alias du="du -ch"

# NVim
alias vim=nvim

# ls
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
# alias ls="ls --color=auto"
# alias ll="ls -la"
# alias l.="ls -d .*"
alias ls='eza --color=always --group-directories-first --icons=always'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons=always'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons=always'
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons=always'
alias lS='eza -1 --color=always --group-directories-first --icons=always'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons=always'
alias l.="eza -a | grep -E '^\.'"

# Replace cat with bat
alias cat=bat

# Format help messages with bat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Replace ripgrep with batgrep
alias rg=batgrep

# Replace man with batman
alias man=batman

# LazyDocker
alias lzd="lazydocker"

# The Fuck
alias f="thefuck"

# Apropos
alias apr="apropos"

# Copilot
alias cps="gh copilot suggest"
alias cpe="gh copilot explain"

# Btop
alias top="btop"

# Docker
alias dc="docker compose"

# Directory stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Zoxide
alias cd='z'
alias cdl='builtin cd'  # fallback for literal paths

# Tmuxinator
alias tmx="tmuxinator"
alias tmxl="tmuxinator list"
alias tmxn="tmuxinator new"
alias tmxo="tmuxinator open"
alias tmxe="tmuxinator edit"
alias tmxd="tmuxinator delete"

# Vim-like exit
alias ":q"="exit"


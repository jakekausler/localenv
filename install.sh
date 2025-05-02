#!/usr/bin/env zsh

# Used for boostrapping Ubuntu x86. Other OSes might not work

# Ask for sudo at the beginning
if sudo -v; then
  # Keep-alive: update existing sudo time stamp until script finishes
  while true; do
    sudo -n true
    sleep 600
    kill -0 "$$" || exit
  done 2>/dev/null &
else
  echo "❌ Failed to obtain sudo privileges."
  exit 1
fi

# Ensure the .config directory exists
mkdir -p "$HOME/.config"
export CONFIG_DIR="$HOME/.config"
export SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Now you can run sudo commands safely without further prompts
echo "✅ Sudo access granted."

# Set up links
ln -sf "$SCRIPT_PATH/starship.toml" "$CONFIG_DIR/starship.toml"
rm -rf "$CONFIG_DIR/bash"
ln -sf "$SCRIPT_PATH/bash" "$CONFIG_DIR/bash"
rm -rf "$CONFIG_DIR/bat"
ln -sf "$SCRIPT_PATH/bat" "$CONFIG_DIR/bat"
rm -rf "$CONFIG_DIR/btop"
ln -sf "$SCRIPT_PATH/btop" "$CONFIG_DIR/btop"
rm -rf "$CONFIG_DIR/delta"
ln -sf "$SCRIPT_PATH/delta" "$CONFIG_DIR/delta"
rm -rf "$CONFIG_DIR/eza"
ln -sf "$SCRIPT_PATH/eza" "$CONFIG_DIR/eza"
rm -rf "$CONFIG_DIR/glow"
ln -sf "$SCRIPT_PATH/glow" "$CONFIG_DIR/glow"
rm -rf "$CONFIG_DIR/lazygit"
ln -sf "$SCRIPT_PATH/lazygit" "$CONFIG_DIR/lazygit"
rm -rf "$CONFIG_DIR/lf"
ln -sf "$SCRIPT_PATH/lf" "$CONFIG_DIR/lf"
rm -rf "$CONFIG_DIR/mods"
ln -sf "$SCRIPT_PATH/mods" "$CONFIG_DIR/mods"
rm -rf "$CONFIG_DIR/nvim"
ln -sf "$SCRIPT_PATH/nvim" "$CONFIG_DIR/nvim"
rm -rf "$CONFIG_DIR/tealdeer"
ln -sf "$SCRIPT_PATH/tealdeer" "$CONFIG_DIR/tealdeer"
rm -rf "$CONFIG_DIR/thefuck"
ln -sf "$SCRIPT_PATH/thefuck" "$CONFIG_DIR/thefuck"
rm -rf "$CONFIG_DIR/tmux"
ln -sf "$SCRIPT_PATH/tmux" "$CONFIG_DIR/tmux"
rm -rf "$CONFIG_DIR/zsh"
ln -sf "$SCRIPT_PATH/zsh" "$CONFIG_DIR/zsh"
ln -sf "$CONFIG_DIR/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$CONFIG_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$CONFIG_DIR/.gitconfig" "$HOME/.gitconfig"
sudo ln -sf "$CONFIG_DIR/bat/bat-extras/src/batdiff.sh" "$HOME/.local/bin/batdiff"
sudo ln -sf "$CONFIG_DIR/bat/bat-extras/src/batgrep.sh" "$HOME/.local/bin/batgrep"
sudo ln -sf "$CONFIG_DIR/bat/bat-extras/src/batman.sh" "$HOME/.local/bin/batman"

# Add env variables
ask_for_variable() {
  local var_name=$1
  local prompt=$2
  local secrets_file="$HOME/.secrets.sh"

  if [[ -n "$BASH_VERSION" ]]; then
    read -p "$prompt: " input
  else
    printf "%s: " "$prompt"
    read input
  fi

  if [[ -z "$input" ]]; then
    # Don't save anything if the input is empty
    echo "No input provided for $var_name. Skipping..."
    return
  fi

  # Ensure the secrets file exists
  mkdir -p "$secrets_file"
  touch "$secrets_file"

  # Check if the variable is already defined
  if grep -q "^export $var_name=" "$secrets_file"; then
    # Replace the line
    sed -i "s|^export $var_name=.*|export $var_name=\"$input\"|" "$secrets_file"
    echo "Updated existing variable $var_name."
  else
    # Append new line
    echo "export $var_name=\"$input\"" >> "$secrets_file"
    echo "Added new variable $var_name."
  fi
}
ask_for_variable OPENAI_API_KEY "Enter your OpenAI API key (blank to skip)"
ask_for_variable GITLAB_ACCESS_TOKEN "Enter your GitLab access token (blank to skip)"
ask_for_variable GITHUB_ACCESS_TOKEN "Enter your GitHub access token (blank to skip)"

# Source zsh variables
source $HOME/.zshenv

# Update apt
sudo apt update

install_missing() {
  local binary=$1
  local name=$2
  shift 2
  local install_cmd="$@"

  echo "installing $name..."

  if ! command -v "$binary" &> /dev/null; then
    eval "$install_cmd"
    echo "$name installed"
  else
    echo "$name already installed"
  fi
}

# rust
install_missing cargo rust "curl https://sh.rustup.rs -sSf | sh"

# tmux
install_missing tmux tmux "sudo apt -y install tmux"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# fzf
install_missing "fzf" "fzf" "brew install fzf"

# zsh
install_missing zsh zsh "sudo apt install -y zsh"

# Neovim
echo "installing neovim..."
install_missing nvim neovim "
  wget -O /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  tar -xzf /tmp/nvim.tar.gz
  sudo mv /tmp/nvim/bin/nvim /bin/nvim
  rm -rf /tmp/nvim.tar.gz /tmp/nvim
"

# Tealdeer
install_missing tldr tealdeer "brew install tealdeer"
echo "downloading tealdeer completions..."
tldr --update
mkdir -p "$ZSH/custom/completions"
wget -O "$ZSH/custom/completions/_tealdeer" "https://raw.githubusercontent.com/tealdeer-rs/tealdeer/refs/heads/main/completion/zsh_tealdeer"
echo "done downloading completions"

# ripgrep
install_missing rg ripgrep "brew install ripgrep"

# delta
install_missing delta delta "brew install git-delta"

# bat
install_missing bat bat "
  wget -O /tmp/bat.tar.gz https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-unknown-linux-gnu.tar.gz
  tar -xzf /tmp/bat.tar.gz -C /tmp/
  sudo mv /tmp/bat*/bat /usr/bin/bat
  rm -rf /tmp/bat.tar.gz /tmp/bat*
"
wget -O $CONFIG_DIR/bat/syntaxes/cmd-help.sublime-syntax https://raw.githubusercontent.com/victor-gp/cmd-help-sublime-syntax/refs/heads/main/syntaxes/cmd-help.sublime-syntax
bat cache --build

# eva
install_missing eza eza "cargo install eza"

# sd
install_missing sd sd "cargo install sd"

# mycli
install_missing mycli mycli "pip install -U mycli"

# simplehttp
install_missing simplehttp simplehttp "go install github.com/snwfdhmp/simplehttp@latest"

# lazygit
install_missing lazygit  lazygit "brew install jesseduffield/lazygit/lazygit"

# lazydocker
install_missing lazydocker lazydocker "brew install jesseduffield/lazydocker/lazydocker"

# navi
install_missing navi navi "brew install navi"

# grex
install_missing grex grex "brew install grex"

# glow
install_missing glow glow "brew install glow"

# thefuck
install_missing fuck thefuck "brew install thefuck"
mkdir -p $CONFIG_DIR/thefuck
echo "excluded_search_path_prefixes = ['/mnt/c']" > $CONFIG_DIR/thefuck/settings.py

# fd
install_missing fd fd "sudo apt install -y fd-find"

# github cli
install_missing gh github-cli "brew install gh"
gh extension install github/gh-copilot

# btop
install_missing btop btop "brew install btop"

# chatgpt cli
install_missing chatgpt chatgpt_cli "curl -L -o chatgpt https://github.com/kardolus/chatgpt-cli/releases/latest/download/chatgpt-linux-arm64 && chmod +x chatgpt && sudo mv chatgpt /usr/local/bin/"
mkdir -p $OPENAI_DATA_HOME
touch $OPENAI_CONFIG_HOME/config.yaml
wget -O $OPENAI_CONFIG_HOME/mdrender.sh https://raw.githubusercontent.com/kardolus/chatgpt-cli/refs/heads/main/scripts/mdrender.sh

# tmuxinator
install_missing tmuxinator tmuxinator "brew install tmuxinator"

# mods
install_missing mods mods "brew install charmbracelet/tap/mods"

# Source bash and zsh files
source $HOME/.bashrc
source $CONFIG_DIR/zsh/.zshrc

echo "All done! You may still need to log into github copilot. To do so, run the following command and follow the instructions:"
echo "    gh auth login --with-token $$GITLAB_ACCESS_TOKEN | gh auth login --scopes copilot"

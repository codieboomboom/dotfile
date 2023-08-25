#Dotfile Shits for WSL

Ah shit, here we go again! Based mostly on https://github.com/Alex-D/dotfiles

# Setting up WSL2 with a distro from MS store

Not relevant here, go search some internet shit for updated guide

Try to enable systemd as this is important for running docker later on (without needing to launch some daemon all the time)

[Systemd support is now available in WSL! - Windows Command Line (microsoft.com)](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/)

# Common dep packages

```bash
#!/bin/bash

sudo apt update && sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    make \
    tig \
    tree \
    zip unzip \
    zsh
```

# GPG Key stuff

- For signing commits + tags (not important for personal usage, but oh well
- Create new one with:

```bash
gpg --full-generate-key
```

- There is option to backup from old system and recover, but not interesting here.
- More info from Github: [https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)

# Time for Git

```bash
#!/bin/bash

# Set username and email for next commands
email="email@address.com"
username="githubusername"
gpgkeyid="keyfrompreviousstep"

# Configure Git
git config --global user.email "${email}"
git config --global user.name "${username}"
git config --global user.signingkey "${gpgkeyid}"
git config --global commit.gpgsign true
git config --global core.pager /usr/bin/less
git config --global core.excludesfile ~/.gitignore

# Generate a new SSH key
ssh-keygen -t rsa -b 4096 -C "${email}"

# Start ssh-agent and add the key to it
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Display the public key ready to be copy pasted to GitHub
cat ~/.ssh/id_rsa.pub
```

# Z-shell AND Oh-my-Zsh

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install nerd-font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "JetBrains Mono Nerd Font Complete Windows Compatible Regular.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Windows%20Compatible%20Regular.ttf

# powerline10k theme with oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.

# Link
ln -sf ~/dev/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dev/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dev/dotfiles/.gitignore ~/.gitignore

code ~/.zshrc # to customize it
```

# Github cli

```bash
#!/bin/zsh

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
#Login with 
gh auth login
```

# Docker

```bash
#!/bin/zsh

# Add Docker to sources.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install tools
sudo apt update && sudo apt install -y \
    docker-ce docker-ce-cli containerd.io

# Add user to docker group
sudo usermod -aG docker $USER
```

# Windows Terminal

```bash
# TODO: refer to Alex-D part and do similar
```

# Node.js

```bash
# Install Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

nvm install --lts
nvm user if needed.
```

# Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

# Vue

```bash
npm install vue
npm update -g @vue/cli
```

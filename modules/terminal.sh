#!/usr/bin/env bash

### BEGIN zsh and tools
sudo apt install --yes zsh tmux
### END zsh and tools

### BEGIN OH MY ZSH
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cat ~/.oh-my-zsh/templates/zshrc.zsh-template | tee --append ~/.zshrc
sudo chsh --shell /bin/zsh
### END OH MY ZSH

### BEGIN FZF for zsh and bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
### END FZF for zsh and bash

### BEGIN Tuning zsh
echo "
bindkey \"^[[1;3C\" forward-word
bindkey \"^[[1;3D\" backward-word
alias sl=\"ls\"
" | tee --append ~/.zshrc
### END Tuning zsh

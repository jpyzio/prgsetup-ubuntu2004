#!/usr/bin/env bash

### BEGIN zsh and tools
sudo apt install --yes zsh tmux
### END zsh and tools

### BEGIN OH MY ZSH
if [[ ! -d ~/.oh-my-zsh ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cat ~/.oh-my-zsh/templates/zshrc.zsh-template | tee --append ~/.zshrc
  sudo chsh --shell /bin/zsh
fi
### END OH MY ZSH

### BEGIN FZF for zsh and bash
if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
### END FZF for zsh and bash

### BEGIN Tuning zsh
grep 'forward-word' ~/.zshrc
if [[ "${?}" == "1" ]]; then
  echo -e "bindkey \"^[[1;3C\" forward-word\nbindkey \"^[[1;3D\" backward-word" | tee --append ~/.zshrc
fi
### END Tuning zsh

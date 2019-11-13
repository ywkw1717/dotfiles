#!/bin/bash

echo "Install the configuration files of Vim....."

if [ ! -e  "$HOME"/.vimrc ]; then
  echo "Create .vimrc"
  cp vim/.vimrc "$HOME"
else
  echo -e "Your .vimrc already exists"
fi

if [ ! -e  "$HOME"/.vim ]; then
  echo -e "Create .vim directory\nCreate dein.toml"
  mkdir "$HOME"/.vim
  cp vim/dein.toml "$HOME"/.vim/
elif [ ! -e  "$HOME"/.vim/dein.toml ]; then
  echo "Create dein.toml"
  cp vim/dein.toml "$HOME"/.vim/
else
  echo "Your dein.toml already exists"
fi

if [ ! -e  "$HOME"/.vim/syntax ]; then
  echo -e "Create syntax directory.\nCopy syntax file in .vim/syntax"
  cp -r vim/syntax "$HOME"/.vim/
else
  echo "Copy syntax file in .vim/syntax"
  cp -i -r vim/syntax/* "$HOME"/.vim/syntax
fi

if [ ! -e  "$HOME"/.vim/template ]; then
  echo "Create template directory. Copy template file in .vim/template"
  cp -r vim/template "$HOME"/.vim/
else
  echo "Copy template file in .vim/template"
  cp -i -r vim/template/* "$HOME"/.vim/template
fi

echo -e "\nInstall the configuration files of Zsh....."

if [ ! -e  "$HOME"/.zplug ]; then
  echo "Install the zplug"
  export ZPLUG_HOME="$HOME"/.zplug
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

if [ ! -e  "$HOME"/.zsh/color ]; then
  echo "Create .zsh/color"
  if [ ! -e  "$HOME"/.zsh/ ]; then
    mkdir -p "$HOME"/.zsh
    echo "Copy color file in .zsh/color"
    cp -r zsh/color "$HOME"/.zsh
  fi
else
  echo "Copy color file in .zsh/color"
  cp -i -r zsh/color "$HOME"/.zsh
fi

if [ ! -e  "$HOME"/.zshrc ]; then
  echo "Create .zshrc"
  cp zsh/.zshrc "$HOME"
else
  echo "Your .zshrc already exists"
fi

echo -e "\nInstall the configuration files of git....."

if [ ! -e  "$HOME"/.gitconfig ]; then
  echo "Create .gitconfig"
  cp git/.gitconfig "$HOME"
else
  echo "Your .gitconfig already exists"
fi

if [ ! -e  "$HOME"/.tmux.conf ]; then
  echo "Create .tmux.conf"
  cp tmux/tmux.conf "$HOME"/.tmux.conf
else
  echo "Your .tmux.conf already exists"
fi

echo -e "\nInstall complete!"

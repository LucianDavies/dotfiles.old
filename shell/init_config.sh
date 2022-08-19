#!/bin/bash

INSTALLDIR=$PWD

packages=(config)

function dotfiles_config_task_link() {
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) LULU: Linking dot files.$(tput sgr 0)"
  echo "---------------------------------------------------------"

  linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
  for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    echo "Creating symlink for $file"
    ln -sfn $file $target
  done



  for i in "${packages[@]}"
  do
    if [ ! -d $HOME/.$i ]; then
        mkdir -p $HOME/.$i
    fi

    echo "---------------------------------------------------------"
    echo "$(tput setaf 2) LULU: Linking ${i} folder.$(tput sgr 0)"
    echo "---------------------------------------------------------"

    for configfile in $INSTALLDIR/$i/*; do
      target=$HOME/.$i/$( basename $configfile )
      echo "Creating symlink for ${configfile} in ${target}"
      ln -sfn $configfile $target
    done
  done

}

function dotfiles_config_task_unlink() {
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) LULU: Unlinking symlink files.$(tput sgr 0)"
  echo "---------------------------------------------------------"

  linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
  for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    echo "Removing symlink for $file"
    unlink $target
  done

  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) LULU: Removing config directory.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  for i in "${packages[@]}"
  do
    sudo rm -rf ~/.$i
  done
}


function dotfiles_config_init() {
  dotfiles_config_task_link
  source ~/.zshrc
}

function dotfiles_config_down() {
  dotfiles_config_task_unlink
}



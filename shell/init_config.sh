INSTALLDIR=$PWD

packages=(
  "config"
  "scripts"
)

function dotfiles_config_task_link() {
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) MINION: Linking symlink files.$(tput sgr 0)"
  echo "---------------------------------------------------------"

  linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
  for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2) MINION: Creating symlink for $file.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ln -sfn $file $target
  done



  for i in "${packages[@]}"
  do
    brew install $i
    if [ ! -d $HOME/.$i ]; then
        mkdir -p $HOME/.$i
    fi

    echo "---------------------------------------------------------"
    echo "$(tput setaf 2) MINION: Installing ${i} files.$(tput sgr 0)"
    echo "---------------------------------------------------------"

    for configfile in $INSTALLDIR/$i/*; do
      target=$HOME/.$i/$( basename $configfile )
      echo "---------------------------------------------------------"
      echo "$(tput setaf 2) MINION: Creating symlink for ${configfile} in ${target}.$(tput sgr 0)"
      echo "---------------------------------------------------------"
      ln -sfn $configfile $target
    done
  done

}

function dotfiles_config_task_unlink() {
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) MINION: Unlinking symlink files.$(tput sgr 0)"
  echo "---------------------------------------------------------"

  linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
  for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2) MINION: Removing symlink for $file.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    unlink $target
  done

  echo "---------------------------------------------------------"
  echo "$(tput setaf 2) MINION: Removing config directory.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  for i in "${packages[@]}"
  do
    rm -rf ~/.$i
  done
}

function dotfiles_config_post_task_link() {
  # NVIM
  nvim +PlugInstall +qall
  nvim +UpdateRemotePlugins +qall
  cp config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim
}


function dotfiles_config_init() {
  dotfiles_config_task_link
  dotfiles_config_post_task_link

  source ~/.bashrc
}

function dotfiles_config_down() {
  dotfiles_config_task_unlink
}



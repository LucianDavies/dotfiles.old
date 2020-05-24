#!/bin/bash

packages=(
"starship"
"tmux"
"neovim"
"ripgrep"
"fzf"
"z"
"jq"
"todo-txt"
)

casks=(
"font-hack-nerd-font"
)

function dotfiles_brew_init {
  if test ! $(which brew); then
      echo "No Homebrew!! Installing..."

      if [[ ( "${OS_TYPE}" == "linux" && "${OS_WSL}" == 0 ) && ( "${OS_DIST_TYPE}" == "ubuntu" || "${OS_DIST_TYPE}" == "debian" ) ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
      fi

      if [ "${OS_TYPE}" == "osx" ]; then
        if test ! $(which gcc); then
          echo "You do not have command line tools installed, install them pls"
          exit 1
        fi
    
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      fi
  fi

  for i in "${packages[@]}"
  do
    brew install $i
  done

  brew tap 'homebrew/cask-fonts'
  for i in "${casks[@]}"
  do
    brew cask install $i
  done

  brew cleanup
  brew doctor
}

function dotfiles_brew_down() {
  echo "Brew Self distructing...."
  if test $(which brew); then
      if [[ ( "${OS_TYPE}" == "linux" && "${OS_WSL}" == 0 ) && ( "${OS_DIST_TYPE}" == "ubuntu" || "${OS_DIST_TYPE}" == "debian" ) ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/uninstall.sh)"
        exit 1
      fi

      if [ "${OS_TYPE}" == "osx" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
      fi
  fi
}

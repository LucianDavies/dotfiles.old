#!/bin/bash
echo "---------------------------------------------------------"
echo "$(tput setaf 2) LULU: Installing homebrew application and tools .$(tput sgr 0)"
echo "---------------------------------------------------------"


packages=(
  starship
  awscli
  azure-cli
  neovim
  azure-functions-core-tools@latest
  tmux
)
casks=()

function dotfiles_applications_init {
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

      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)"
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)"

  brew analytics off
  for i in "${packages[@]}"
  do
    if brew list $i >/dev/null 2>&1; then
        echo $i is already installed
    else
        brew install $i
    fi
  done

  if [ "${OS_TYPE}" == "osx" ]; then
    brew install reattach-to-user-namespace
    brew tap 'homebrew/cask-fonts'
    for i in "${casks[@]}"
    do
      if brew info $i | grep $i >/dev/null 2>&1; then
          echo $i is already installed
      else
          brew tap homebrew/$i && brew cask install $i
      fi
    done
  fi

  brew cleanup
  brew doctor
}

function dotfiles_applications_down() {
  echo "Brew Self distructing...."
  if test $(which brew); then
      if [[ ( "${OS_TYPE}" == "linux" && "${OS_WSL}" == 0 ) && ( "${OS_DIST_TYPE}" == "ubuntu" || "${OS_DIST_TYPE}" == "debian" ) ]]; then
	      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/uninstall.sh)"
      fi

      if [ "${OS_TYPE}" == "osx" ]; then
	      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
      fi
  fi
  
  if test $(which brew); then
    rm -rf "$NVM_DIR"

  fi
}

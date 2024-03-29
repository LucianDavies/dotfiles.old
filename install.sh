#!/bin/zsh

function install_nix {
  if type nix &> /dev/null; then
    echo "Skipping Nix install"
  else
    # Platform Specific install Nix
    platform=$(uname)
    echo "Installing Nix Package Manager"
    sh <(curl -L https://nixos.org/nix/install) --daemon
    wait
  fi
}

function install_home_manager {
  if type home-manager &> /dev/null; then
    echo "Skipping home-manager install"
  else
    echo "Installing home-manager"
    # Install channels
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --update

    # Install home-manager
    nix-shell '<home-manager>' -A install

    # Install darwin
    nix-shell '<darwin>' -A installer
  fi

  # sed "s/USER/$USER/" $HOME/.dotfiles/config/current-home.nix > $HOME/.dotfiles/config/current-home.nix
  # ln -s $HOME/.dotfiles/config/home.nix $HOME/.config/nixpkgs/home.nix

  home-manager build && wait
  home-manager switch && wait
  darwin-rebuild build && wait
  darwin-rebuild switch && wait
}

function install() {
  # Download dotfiles
  # git clone https://github.com/LucianDavies/dotfiles.git $HOME/.dotfiles

  if type zsh &> /dev/null; then
    install_nix && wait
    install_home_manager && wait
  else
    echo "missing zsh"
  fi
}

function yes_or_no {
  while true; do
    read -q yn\?"$* [y/n]: "
    case $yn in
      [Yy]*) echo "" ; return 0  ;;
      [Nn]*) echo "Aborted" ; return  1 ;;
    esac
  done
}

if [[ -d $HOME/.dotfiles ]]; then
  message="~/.dotfiles already exists, would you like to remove and install again?"
  #yes_or_no "$message" && rm -rf "$HOME/.dotfiles" && install
  install
else
  install
fi

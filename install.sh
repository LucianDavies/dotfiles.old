#!/bin/zsh

function install_nix {
  if type nix &> /dev/null; then
    echo "Skipping Nix install"
  else
    # Platform Specific install Nix
    platform=$(uname)
    if [ "$platform" = "Darwin" ]; then
      echo "Installing Nix Package Manager"
      sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
      wait
    else
      echo "Installing Nix Package Manager"
      sh <(curl -L https://nixos.org/nix/install) --no-daemon
      wait
    fi
  fi
  if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    source $HOME/.nix-profile/etc/profile.d/nix.sh;
  fi
}

function install_home_manager {
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

  if type home-manager &> /dev/null; then
    echo "Skipping home-manager install"
  else
    echo "Installing home-manager"
    # Install channels
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --update

    # Install home-manager
    nix-shell '<home-manager>' -A install
  fi

  # Platform Specific home.nix linking
  rm $HOME/.config/nixpkgs/home.nix
  platform=$(uname)
  if [ "$platform" = "Darwin" ]; then
    #sed "s/USER/$USER/" $HOME/.dotfiles/config/home-manager/mac-home.nix > $HOME/.dotfiles/config/current-home.nix
    ln -s $HOME/.dotfiles/config/current-home.nix $HOME/.config/nixpkgs/home.nix
  else
    #cp $HOME/.dotfiles/config/home-manager/linux-home.nix $HOME/.dotfiles/config/current-home.nix
    #sed -i "s/USER/$USER/" $HOME/.dotfiles/config/current-home.nix
    ln -s $HOME/.dotfiles/config/current-home.nix $HOME/.config/nixpkgs/home.nix
  fi
  
  home-manager build && wait
  home-manager switch && wait
}

function install() {
  # Download dotfiles
  git clone https://github.com/LucianDavies/dotfiles.git $HOME/.dotfiles

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
  yes_or_no "$message" && rm -rf "$HOME/.dotfiles" && install
else
  install
fi

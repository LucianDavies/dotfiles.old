#!/bin/bash

function dotfiles_asdf_init() {
  . /usr/local/opt/asdf/asdf.sh

  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  packages=(
    ruby
    erlang
    elixir
    nodejs
    golang
  )

  for i in "${packages[@]}"
  do
    echo $i
    asdf plugin-list | grep $i >/dev/null 2>&1 || asdf plugin-add $i && asdf install $i latest && asdf global $i $(asdf list $i)
  done
  # npm install -g yarn spaceship-prompt vtop caniuse-cmd tldr
}

function dotfiles_asdf_down() {
  # taken care by when we remove nvm using homebrew
  echo "Self distructing...."
  rm -rf ~/.asdf/ ~/.tool-versions
}

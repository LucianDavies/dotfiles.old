#!/bin/bash

function dotfiles_dev_languages_init() {
  source `brew --prefix asdf`/asdf.sh
  bash -c ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  packages=(
    nodejs
  )

  for i in "${packages[@]}"
  do
    echo $i
    asdf plugin-list | grep $i >/dev/null 2>&1 || asdf plugin-add $i && asdf install $i latest && asdf global $i $(asdf list $i)
  done

  npm install -g yarn spaceship-prompt vtop tldr taskbook
  pip3 install --upgrade pynvim --user
  asdf reshim
}

function dotfiles_dev_languages_down() {
  # taken care by when we remove nvm using homebrew
  echo "Self distructing...."
  rm -rf ~/.asdf/ ~/.tool-versions
}

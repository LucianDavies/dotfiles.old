function dotfiles::node::init() {
  . /usr/local/opt/nvm/nvm.sh
  nvm install --lts
  npm install -g spaceship-prompt vtop caniuse-cmd semantic-git-commit-cli tldr is-up-cli diff-so-fancy
}

function dotfiles::node::down() {
  # taken care by when we remove nvm using homebrew
  echo "Self distructing...."
}
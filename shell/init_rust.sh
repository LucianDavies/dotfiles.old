#!/bin/bash

function dotfiles_rust_init() {
  commitHash=$(curl https://raw.githubusercontent.com/rust-lang-nursery/rust-toolstate/master/history/linux.tsv 2> /dev/null \
  | sed 1d | grep "\"rls\":\"test-pass\"" | grep "\"miri\":\"test-pass\"" \
  | grep "\"rustfmt\":\"test-pass\"" | grep "\"rust-by-example\":\"test-pass\"" \
  | grep "\"clippy-driver\":\"test-pass\"" | grep "\"reference\":\"test-pass\"" \
  | head -n1 | cut -d$'\t' -f1)

  commitDate=$(curl -X GET "https://api.github.com/repos/rust-lang/rust/commits/$commitHash" 2> /dev/null \
  | python -c "import sys,json; print json.load(sys.stdin)['commit']['author']['date']")

  curl https://sh.rustup.rs -sSf | sh -s -- --profile default --default-toolchain nightly-$(gdate -d $commitDate +%F)
}

function dotfiles_rust_down() {
  # taken care by when we remove nvm using homebrew
  echo "Self distructing...."
  rustup self uninstall
}

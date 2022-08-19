#!/bin/bash
echo "---------------------------------------------------------"
echo "$(tput setaf 2) LULU: Greetings. Preparing to setup up your environment.$(tput sgr 0)"
echo "---------------------------------------------------------"


# Ask for the administrator password upfront
# if [ "$(uname)" = "Darwin" ]; then
#    sudo -v
# fi

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

INSTALLDIR=$PWD

CORE_LIBS=(
  ##os
  ##applications
  config
)

for lib in ${CORE_LIBS[@]}; do
  source "$INSTALLDIR/shell/init_$lib.sh"
  dotfiles_${lib}_init
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2) LULU: System installation complete. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"
exit

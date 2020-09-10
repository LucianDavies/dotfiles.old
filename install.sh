#!/bin/sh
echo "---------------------------------------------------------"
echo "$(tput setaf 2) LULU: Greetings. Preparing to setup up your environment.$(tput sgr 0)"
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

CORE_LIBS=(
  os
  #applications
  dev_languages
  config
)

for lib in ${CORE_LIBS[@]}; do
  source "$INSTALLDIR/shell/init_$lib.sh"
  dotfiles_${lib}_init
done

source ~/.bashrc

echo "---------------------------------------------------------"
echo "$(tput setaf 2) LULU: System installation complete. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"

exit 0

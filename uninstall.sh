#!/bin/sh
echo "---------------------------------------------------------"
echo "$(tput setaf 2)LULU: Uninstalling everything .$(tput sgr 0)"
echo "---------------------------------------------------------"


INSTALLDIR=$PWD

CORE_LIBS=(
  os
  applications
  #dev_languages
  config
)

for lib in ${CORE_LIBS[@]}; do
  source $INSTALLDIR/shell/init_$lib.sh
  dotfiles_${lib}_down
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LULU: Removed all configs and files. GoodBye.$(tput sgr 0)"
echo "---------------------------------------------------------"

#!/bin/bash

function dotfiles_os_check_osx() {
  if [ -d "/Applications" ]; then
    local DIST_NAME=$(sw_vers -productName)
    local DIST_VERSION=$(sw_vers -productVersion)
    local DIST_BUILD=$(sw_vers -buildVersion)

    export OS_TYPE="osx"
    export OS_DIST_TYPE="osx"
    export OS_DIST_NAME="$DIST_NAME $DIST_VERSION $DIST_BUILD"
  fi
}

function dotfiles_os_check_redhat_dist() {
  local RELEASE_FILE="/etc/redhat-release"

  if [ -f $RELEASE_FILE ]; then
    export OS_TYPE="linux"
    export OS_DIST_TYPE="redhat"
    export OS_DIST_NAME=`cat $REDHAT_RELEASE_FILE`
  fi
}

function dotfiles_os_check_debian_dist() {
  local RELEASE_FILE="/etc/lsb-release"
  if [ -f $RELEASE_FILE ]; then
    local DIST_NAME=$(sed -n 's/^DISTRIB_ID=//p' $RELEASE_FILE)
    local DIST_VERSION=$(sed -n 's/^DISTRIB_RELEASE=//p' $RELEASE_FILE)

    if [[ $DIST_NAME != "" ]]; then
      export OS_TYPE="linux"
      export OS_DIST_TYPE="debian"
      export OS_DIST_NAME="$DIST_NAME $DIST_VERSION"
    fi
  fi
}

function dotfiles_os_check_wsl() {
  grep Microsoft /proc/sys/kernel/osrelease > /dev/null
  if [[ $? == "0" ]]; then
    export OS_WSL=1
  else
    export OS_WSL=0
  fi
}

function dotfiles_os_check_chromeos() {
  local RELEASE_FILE="/etc/lsb-release"
  if [ -f $RELEASE_FILE ]; then
    local CHROMEOS_RELEASE_DESCRIPTION=$(sed -n 's/^CHROMEOS_RELEASE_DESCRIPTION=//p' $RELEASE_FILE)

    if [[ $CHROMEOS_RELEASE_DESCRIPTION != "" ]]; then
      export OS_TYPE="linux"
      export OS_DIST_TYPE="chromeos"
      export OS_DIST_NAME=$CHROMEOS_RELEASE_DESCRIPTION
    fi
  fi
}


function dotfiles_os_init() {
  export OS_TYPE="unknown"
  export OS_DIST_TYPE="unknown"
  export OS_DIST_NAME="Unknown Distribution"

  dotfiles_os_check_chromeos
  dotfiles_os_check_debian_dist
  dotfiles_os_check_redhat_dist
  dotfiles_os_check_osx
  dotfiles_os_check_wsl

  echo "OS\t: ${OS_TYPE} - ${OS_DIST_TYPE} - WSL=${OS_WSL}"
  echo "OS Name\t: ${OS_DIST_NAME}"
}

function dotfiles_os_down() {
  echo "Self distructing...."
  export OS_TYPE="unknown"
  export OS_DIST_TYPE="unknown"
  export OS_DIST_NAME="Unknown Distribution"

  dotfiles_os_check_chromeos
  dotfiles_os_check_debian_dist
  dotfiles_os_check_redhat_dist
  dotfiles_os_check_osx
  dotfiles_os_check_wsl

  echo "OS\t: ${OS_TYPE} - ${OS_DIST_TYPE} - WSL=${OS_WSL}"
  echo "OS Name\t: ${OS_DIST_NAME}"
}



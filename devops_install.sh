#!/usr/bin/env bash
#title           : devops_install.sh
#description     : Install Ansible
#author          : MRP/mrp - Mauro Rosero P.
#company email   : mrosero@panamatech.net
#personal email  : mauro@rosero.one
#date            : 20220301
#version         : 3.05.25
#notes           :
#==============================================================================
# 2023/07/13 14:23 Corrección Bash LINT por ChatGPT 3.5
#==============================================================================

# Error messages
error_header1="ANSBILE & DEVOPS PACK INSTALLATION"
error_header2="========================================="
error_ansible_install="Ansible Execution Version - Error "
error_sops_install="SOPS Execution Version - Error "
error_python_install="Python Execution Version - Error "
error_whiptail_install="Dialog Execution Version - Error "
error_yq_install="Yaml Query (yq) Execution Version - Error "
error_jq_install="Json Query (jq) Execution Version - Error "
error_sudo_install="SuDO Execution Version - Error "
error_root_install="Become root privileges - Error "
error_debian_install="Installing Debian/Ubuntu Packages - Error "
error_sudoers_install="Please, install sudo, configure some user with root privileges and run with this user!"
error_not_installed="Packages not installed: "


### CHECK BASIC REQUIREMENTS TO RUN
get_os_family() {
  os_family=$(grep "^ID_LIKE=" /etc/os-release | cut -d= -f2)
}

install_packages() {
  get_os_family
  case ${os_family} in
    debian)
      INSTALLER=1
      sudo apt install $1
      ;;
    redhat)
      INSTALLER=1
      sudo dnf install $1
      ;;
    *)
      INSTALLER=0
      ;;
  esac
}

su_packages() {
  get_os_family
  case ${os_family} in
    debian)
      INSTALLER=1
      apt install $1
      ;;
    redhat)
      INSTALLER=1
      dnf install $1
      ;;
    *)
      INSTALLER=0
      ;;
  esac
}

check_packages() {
  install=0
  if ! command -v $1 &>/dev/null; then
    install=1
  fi
}

### MAIN DEVELOPERS STATION INSTALLATION (ANSIBLE)
PACKAGES=""

check_packages sudo
if [ "${install}" == "1" ]; then
   su -
   su_packages sudo
   usermod -aG sudo $USER
   exit
fi

check_packages python3
if [ "${install}" == "1" ]; then
   PACKAGES="python3"
fi

check_packages jq
if [ "${install}" == "1" ]; then
   PACKAGES="$PACKAGES jq"
fi

check_packages yq
if [ "${install}" == "1" ]; then
   PACKAGES="$PACKAGES yq"
fi

check_packages wget
if [ "${install}" == "1" ]; then
   PACKAGES="$PACKAGES wget"
fi

check_packages git
if [ "${install}" == "1" ]; then
   PACKAGES="$PACKAGES git"
fi

check_packages curl
if [ "${install}" == "1" ]; then
   PACKAGES="$PACKAGES curl"
fi

if [ "$PACKAGES" != "" ]; then
   install_packages ${PACKAGES}
fi

check_packages sops
if [ "${install}" == "1" ]; then
  get_os_family
  if [ ${os_family} == "debian" ]; then
     SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
     curl -Lo sops.deb "https://github.com/mozilla/sops/releases/latest/download/sops_${SOPS_LATEST_VERSION}_amd64.deb"
     sudo apt --fix-broken install ./sops.deb
     rm -rf sops.deb
  fi
  if [ ${os_family} == "redhat" ]; then
     SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
     curl -Lo sops.rpm "https://github.com/mozilla/sops/releases/latest/download/sops_${SOPS_LATEST_VERSION}_x86_64.rpm"
     sudo dnf install sops.rpm
     rm -rf sops.rpm
  fi
fi

check_packages ansible
if [ "${install}" == "1" ]; then
   python3 -m pip install --user ansible paramiko pyGithub whiptail-dialogs
else
   python3 -m pip install --upgrade ansible paramiko pyGithub whiptail-dialogs
fi

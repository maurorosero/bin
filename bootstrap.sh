#!/usr/bin/env bash
#Bash script     : bootstrap.sh
#Apps            : Personal Bin Utilities (MRosero)
#Description     : Bootstrap Base Packages Install
#Author		     : MRP/mrp - Mauro Rosero P.
#Company email   : mauro@rosero.one
#Personal email  : mauro.rosero@gmail.com
#Date            : 20240501
#Version         : 1.5.8
#Notes           :
#==============================================================================
#==============================================================================

install() {
	local install_home=$1

	# Load bootstrap base messages
	set_messages() {
		pymsg_001="Instalando o actualizando Python a la última versión..."
		pymsg_002="No se pudo determinar el sistema operativo."
		pymsg_003="Python instalado o actualizado correctamente."
	}

	if [ -f "${install_home}/bin/msg/bootstrap.$LANG" ]
	then
		source "${install_home}/bin/msg/bootstrap.$LANG"
	else
		set_messages
	fi

	install_or_update_python() {
		echo "${pymsg_001}"
		if [ "$(uname)" == "Darwin" ]; then
			# En macOS, instalamos o actualizamos Python a través de Homebrew
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			brew install python git curl wget sops gzip
		elif [ -f /etc/debian_version ] || [ -f /etc/os-release ]; then
			# En sistemas Debian y derivados, instalamos o actualizamos Python a través de apt
			apt update
			apt install -y python3 git curl wget sops gzip
		elif [ -f /etc/redhat-release ]; then
			# En sistemas Red Hat, instalamos o actualizamos Python a través de yum
			yum install -y python3 git curl wget sops gzip
		elif [ -f /etc/arch-release ]; then
			# En Arch Linux, instalamos o actualizamos Python a través de pacman
			pacman -Sy --noconfirm python git curl wget sops gzip
		elif [ -f /etc/rc.conf ]; then
			# En BSD, instalamos o actualizamos Python a través de pkg
			pkg install -y python3 git curl wget sops gzip
		else
			echo "${pymsg_002}"
			exit 1
		fi
		echo "${pymsg_003}"
	}

	# Instalar o actualizar Python a la última versión y pre-requisitos bootstrap
	install_or_update_python

}

# Main.- Llamar a la función con sudo
clear

# Load head messages
if [ -f "${HOME}/bin/msg/head.$LANG" ]
then
	source "${HOME}/bin/msg/head.$LANG"
else
	head_000="Utilitarios de Mauro Rosero P. (bootstrap bin)"
fi	

echo "${head_000}"
echo "------------------------------------------------------------------------------"
sudo bash -c "$(declare -f install); install ${HOME}"

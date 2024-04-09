#!/usr/bin/env bash
#bash script     : bootstrap.sh
#apps            : Personal Developer Utilities
#description     : Bootstrap Packages Install
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

install() {
	local install_home=$1
		
	# Load bootstrap messages
	if [ -f "${install_home}/bin/msg/bootstrap.$LANG" ]
	then
		source "${install_home}/bin/msg/bootstrap.$LANG"
	else
		source "${install_home}/bin/msg/bootstrap.es"
	fi	
	
	# Load Python & Ansible Installer Functions
	source "${install_home}/bin/lib/bootstrap.lib"	

	# Instalar o actualizar Python a la última versión
	install_or_update_python

	# Verificar distribución y ejecutar la función correspondiente para instalar Ansible
	if [ -f /etc/debian_version ] || [ -f /etc/os-release ]; then
		install_ansible_debian
	elif [ -f /etc/redhat-release ]; then
		install_ansible_redhat
	elif [ "$(uname)" == "Darwin" ]; then
		install_ansible_macos
	elif [ -f /etc/arch-release ]; then
		install_ansible_arch
	elif [ -f /etc/rc.conf ]; then
		install_ansible_bsd
	else
		echo "${pymsg_014}"
		exit 1
	fi
}

# Main.- Llamar a la función con sudo
clear

# Load head messages
if [ -f "${HOME}/bin/msg/head.$LANG" ]
then
	source "${HOME}/bin/msg/head.$LANG"
else
	source "${HOME}/bin/msg/head.es"
fi	

echo "${head_000}"
echo "------------------------------------------------------------------------------"
sudo bash -c "$(declare -f install); install ${HOME}"

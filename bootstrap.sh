#!/usr/bin/env bash
#bash script     : bootstrap.sh
#apps            : Boostrap Developer Station
#description     : Install base python & ansible
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
	clear
		
	# Load bootstrap messages
	if [ -f "${install_home}/bin/msg/bootstrap.$LANG" ]
	then
		source "${install_home}/bin/msg/bootstrap.$LANG"
	else
		source "${install_home}/bin/msg/bootstrap.es"
	fi	
	
	# Load Python & Ansible Installer Functions
	source "${install_home}/bin/lib/python.lib"	

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

# Llamar a la función con sudo
sudo bash -c "$(declare -f install); install ${HOME}"

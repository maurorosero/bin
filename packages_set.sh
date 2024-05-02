#!/usr/bin/env bash
#bash script     : packages_set.sh
#apps            : MRosero Personal Developer Utilities
#description     : Personal Devops Packages Install
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
    local install_file=$2
		
	# Load bootstrap messages
	if [ -f "${install_home}/bin/msg/packages.$LANG" ]
	then
		source "${install_home}/bin/msg/packages.$LANG"
	else
		source "${install_home}/bin/msg/packages.es"
	fi	
	
	# Load Installer Functions
	source "${install_home}/bin/lib/console.lib"

	# Load Installer Functions
	source "${install_home}/bin/lib/packages.lib"
   
    # Execute packages installation function
    install_packages ${install_file}
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

# Load packages messages
if [ -f "${HOME}/bin/msg/packages.$LANG" ]
then
	source "${HOME}/bin/msg/packages.$LANG"
else
	source "${HOME}/bin/msg/packages.es"
fi	

# Check if dialog is installed
if ! command -v dialog >/dev/null 2>&1
then
    echo "${head_000}"
    echo "------------------------------------------------------------------------------"
    echo >&2 "${head_001}"
    exit 1
fi

# Load Installer Functions
source "${HOME}/bin/lib/console.lib"
get_osname
if [ "${os_name}" == "${head_unknow}"]
then
    show_error_dialog "${head_error}" "${pkmsg_004}"
    exit 2
fi

mz_yesno "${pkmsg_003}" "${head_000}" "${pkmsg_000}"
if [ "${result}" == "0" ]
then
    base_apps_file="requirements.bin"
    apps_file="${HOME}/bin/lib/${base_apps_file}"
    if [ -f "${HOME}/${base_apps_file}" ]
    then
        apps_file="${HOME}/${base_apps_file}"
    fi
    if [ -f "${apps_file}" ]
    then
        sudo bash -c "$(declare -f install); install ${HOME} ${apps_file}"
    else
        show_error_dialog "${head_error}" "${pkmsg_005}"
    fi
    base_snap_file="snap.bin"
    snap_file="${HOME}/bin/lib/${base_snap_file}"
    if [ -f "${HOME}/${base_snap_file}" ]
    then
        snap_file="${HOME}/${base_snap_file}"
    fi
    if [ -f "${apps_file}" ]
    then
        sudo bash -c "$(declare -f install); install ${HOME} ${snap_file}"
    else
        show_error_dialog "${head_error}" "${pkmsg_005}"
    fi
else
     show_error_dialog "${head_info}" "${pkmsg_006}"
fi

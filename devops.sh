#!/usr/bin/env bash
#bash script     : devops.sh
#apps            : MRosero Personal Developer Utilities
#description     : Developers Packages Install
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

install() {
    local install_mode=$1
	local install_home=$2
    local install_file=$3
		
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
   
    # Execute packages with os-packager
    if [ "${install_mode}" == "PKGS" ]
    then
        install_packages ${install_file} "${head_000}" "${pkmsg_000}"
    fi

    # Execute packages with snapd
    if [ "${install_mode}" == "PIP" ]
    then
        snap_packages ${install_file} "${pkmsg_000}" "${pkmsg_000}"
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
    base_apps_file="devops.bin"
    apps_file="${HOME}/bin/lib/${base_apps_file}"
    if [ -f "${HOME}/${base_apps_file}" ]
    then
        apps_file="${HOME}/${base_apps_file}"
    fi
    if [ -f "${apps_file}" ]
    then
        sudo bash -c "$(declare -f install); install "PKGS" ${HOME} ${apps_file}"
    else
        show_error_dialog "${head_error}" "${pkmsg_005}"
    fi

    base_python_file="python.bin"
    python_file="${HOME}/bin/lib/${base_python_file}"
    if [ -f "${HOME}/${base_python_file}" ]
    then
        python_file="${HOME}/${base_python_file}"
    fi
    if [ -f "${python_file}" ]
    then
        bash -c "$(declare -f install); install "PIP" ${HOME} ${python_file}"
    else
        show_error_dialog "${head_error}" "${pkmsg_005}"
    fi
else
     show_error_dialog "${head_info}" "${pkmsg_006}"
fi

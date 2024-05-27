#!/usr/bin/env bash
#bash script     : snap_packages.sh
#apps            : MRosero Personal Developer Utilities
#description     : Snapd Packages Installer
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

    # Load dialog console library
    source "${HOME}/bin/lib/messages.lib"

    # Load Installer Functions
    source "${install_home}/bin/lib/console.lib"

    # Load Installer Functions
    source "${install_home}/bin/lib/packages.lib"

    # Load headers messages
    load_messages "${install_home}" "head"

    # Load packages messages
    load_messages "${install_home}" "packages"
    title="${head_000}"
    apps_title="${pkmsg_300}"

    # Install Base Packages with Snap
    snapd_packages ${install_file}
}

# Main.- Llamar a la función con sudo
clear
# Load dialog console library
source "${HOME}/bin/lib/messages.lib"

# Load dialog console library
source "${HOME}/bin/lib/console.lib"

# Load os packages library
source "${HOME}/bin/lib/packages.lib"

# Load headers messages
load_messages "${HOME}" "head"

# Load packages messages
load_messages "${HOME}" "packages"
title="${head_000}"
apps_title="${pkmsg_300}"

# Check if dialog is not installed, exited!
if ! command -v dialog >/dev/null 2>&1
then
    clear
    echo "${head_000}"
    echo "------------------------------------------------------------------------------"
    echo >&2 "${head_001}"
    exit 1
fi

get_osname
if [ "${os_name}" == "${head_unknow}" ]
then
    show_error_dialog "${os_name} ${head_error}" "${pkmsg_004}"
    exit 2
else
    if [ "${os_name}" != "${head_ubuntu}" ]
    then
        show_error_dialog "${os_name} ${head_error}" "${pkmsg_009}"
        exit 2
    fi
fi

mz_yesno "${pkmsg_010}"
if [ "${result}" == "0" ]
then
    base_apps_file="snap.bin"
    apps_file="${HOME}/bin/lib/${base_apps_file}"
    if [ -f "${HOME}/${base_apps_file}" ]
    then
        apps_file="${HOME}/${base_apps_file}"
    fi
    if [ -f "${apps_file}" ]
    then
        mz_inputpass "${pklbl_001}" "${pkhlp_001}"
        if [ "${codex}" == "0" ]
        then
            if [ -n "${value}" ]
            then
                clear
                echo "${value}" | sudo -S bash -c "$(declare -f install); install ${HOME} ${apps_file}"
                if [ "$?" == "0" ]
                then
                    read
                    clear
                else
                    show_error_dialog "${head_error}" "${pkmsg_008}"
                fi
            else
                show_error_dialog "${head_error}" "${pkmsg_007}"
            fi
        else
            show_error_dialog "${head_error}" "${pkmsg_006}"
        fi
    else
        show_error_dialog "${head_error}" "${pkmsg_005}"
    fi
else
    clear
fi

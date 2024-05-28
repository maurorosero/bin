#!/usr/bin/env bash
#bash script     : gpg_config.sh
#apps            : MRosero Personal Developer Utilities
#description     : Create/Modify gpg config (~/.gnupg/gpg.conf) file by template
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

# Load dialog console library
source "${HOME}/bin/lib/messages.lib"
GPG=gpg

# Load dialog console library
source "${HOME}/bin/lib/console.lib"

# Load gpg library
source "${HOME}/bin/lib/${GPG}.lib"

# Load headers messages
load_messages "${HOME}" "head"

# Load gpg messages
load_messages "${HOME}" "${GPG}"
title="${head_000}"
apps_title="${pgmsg_900}"

# Check if dialog is not installed, exited!
if ! command -v dialog >/dev/null 2>&1
then
    clear
    echo "${head_000}"
    echo "------------------------------------------------------------------------------"
    echo >&2 "${head_001}"
    exit 1
fi

# Check if os is valid!
get_osname
if [ "${os_name}" == "${head_unknow}" ]
then
    show_error_dialog "${head_error}" "${head_os_error}"
    exit 2
fi

# Main Process
mz_yesno "${pgmsg_901}"
if [ "${result}" == "0" ]
then
    set_gpg_config "${GPG_TEMPLATE}" "${GPG_CONFIG}"
    if [ $? -eq 0 ]
    then
        show_error_dialog "${head_info}" "${pgmsg_902}"
    else
        show_error_dialog "${head_error}" "${pgmsg_903} ($?)"
    fi
fi
clear

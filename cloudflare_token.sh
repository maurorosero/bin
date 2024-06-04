#!/usr/bin/env bash
#bash script     : cloudflare_token.sh
#apps            : MRosero Personal Developer Utilities
#description     : Registrar TOKEN para cuenta Cloudflare
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

# Load header messages
load_messages "${HOME}" "head"

# Load cloudflare messages
load_messages "${HOME}" "cloudflare"
title="${head_000}"
apps_title="${cfmsg_000}"

# Load dialog console library
source "${HOME}/${BINLIB_PATH}/console.lib"

# Load cloudflare library
source "${HOME}/${BINLIB_PATH}/cloudflare.lib"



########### MAIN PROGRAM ###########

# Check if dialog is not installed, exited!
if ! command -v dialog >/dev/null 2>&1
then
    clear
    echo "${head_000}"
    echo "------------------------------------------------------------------------------"
    echo >&2 "${head_001}"
    clear
    exit 1
fi

# Check if sops is not installed, exited!
if ! command -v sops >/dev/null 2>&1
then
    show_error_dialog "${head_error}" "${cfmsg_001}"
    exit 2
fi

# Check if os is valid!
get_osname
if [ "${os_name}" == "${head_unknow}" ]
then
    show_error_dialog "${head_error}" "${head_os_error}"
    clear
    exit 3
fi

# Check if sops is not installed, exited!
if ! command -v sops >/dev/null 2>&1
then
    show_error_dialog "${head_error}" "${cfmsg_021}"
    exit 4
fi


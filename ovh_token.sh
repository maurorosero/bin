#!/usr/bin/env bash
#bash script     : ovh_token.sh
#apps            : MRosero Personal Developer Utilities
#description     : Registrar información de acceso para cuenta OVH
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

# Load base library
source "${HOME}/bin/lib/messages.lib"

# Load header messages
load_messages "${HOME}" "head"

# Load console messages
load_messages "${HOME}" "console"

# Load dialog console library
source "${HOME}/${BINLIB_PATH}/console.lib"

# Load db messages
load_messages "${HOME}" "db"

# Load db library
source "${HOME}/${BINLIB_PATH}/db.lib"

# Load ovh messages
load_messages "${HOME}" "ovh"

########### LOCAL FUNCTIONS ###########

# Capturar datos de acceso de CLOUDFLARE y guardarlos de forma segura en SOPS
function safe_cloudflare_sops() {

    # Define gpg capture form
    c_lbl[0]="${ovlbl_001}"
    c_hlp[0]="${ovhlp_001}"
    c_mod[0]=${ovtyp_001}
    c_opt[0]=${ovopt_001}
    c_val[0]=000
    c_lbl[1]="${ovlbl_002}"
    c_hlp[1]="${ovhlp_002}"
    c_mod[1]=${ovtyp_002}
    c_val[1]=001
    c_lbl[2]="${ovlbl_003}"
    c_hlp[2]="${ovhlp_003}"
    c_mod[2]=${ovtyp_003}
    c_val[2]=001
    c_lbl[3]="${ovlbl_004}"
    c_hlp[3]="${ovhlp_004}"
    c_mod[3]=${ovtyp_004}
    c_val[3]=010
    c_end=4

    form_capture
}


########### MAIN PROGRAM ###########

title="${head_000}"
apps_title="${ovmsg_100}"

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
    show_error_dialog "${head_error}" "${ovmsg_001}"
    clear
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
    show_error_dialog "${head_error}" "${ovmsg_021}"
    clear
    exit 4
fi

DB_FILE="${HOME}/${DB_PATH}/${DB_USER}"
QUERY="SELECT subkey_id FROM GPG_SUBKEYS WHERE subkey_type = ${SOPS_TYPE} AND description = '${SOPS_ID}';"
FP_SOPS=$(db_sql_execute_with_result "${DB_FILE}" "${QUERY}")
if [[ -z "${FP_SOPS}"  ]]
then
    show_error_dialog "${head_error}" "${ovmsg_008}"
    clear
    exit 5
fi

mz_yesno "${ovmsg_002}"
case ${result} in
    0)
    declare -a response c_lbl, c_hlp, c_mod, c_opt, c_val
    safe_cloudflare_sops
    rc_sops=$?
    case ${rc_sops} in
        0)
        APIKEY_CRYPT="$(echo "${response[3]}" | base64)"
        SOPS_FILE="${response[0]}.yaml"
        SECRET="\n  ${OV_LBL_APPKEY}: ${response[1]}\n  ${OV_LBL_CONSUMER}: ${response[2]}\n  ${OV_LBL_SECRET}: ${APIKEY_CRYPT}\n"
        sops_crypt_file "${FP_SOPS}" "${HOME}/${SOPS_PATH}" "${SOPS_FILE}" "${SECRET}"
        show_error_dialog "${head_error}" "${ovmsg_004}"
        ;;
        *)
        show_error_dialog "${head_info}" "${head_op_error}"
        ;;
    esac
    ;;
    *)
    show_error_dialog "${head_info}" "${head_op_error}"
    ;;
esac
clear

#!/usr/bin/env bash
#bash script     : fwdemail_token.sh
#apps            : MRosero Personal Developer Utilities
#description     : Registrar información de acceso para cuenta FORWARD EMAIL
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240620
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

# Load fwemail messages
load_messages "${HOME}" "fwdemail"

########### LOCAL FUNCTIONS ###########

# Capturar datos de acceso de CLOUDFLARE y guardarlos de forma segura en SOPS
function safe_fwdemail_sops() {

    # Define gpg capture form
    c_lbl[0]="${fwlbl_001}"
    c_hlp[0]="${fwhlp_001}"
    c_mod[0]=${fwtyp_001}
    c_opt[0]=${fwopt_001}
    c_val[0]=010
    c_end=1

    form_capture
}


########### MAIN PROGRAM ###########

title="${head_000}"
apps_title="${fwmsg_100}"

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
    show_error_dialog "${head_error}" "${fwmsg_001}"
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
    show_error_dialog "${head_error}" "${fwmsg_021}"
    clear
    exit 4
fi

DB_FILE="${HOME}/${DB_PATH}/${DB_USER}"
QUERY="SELECT subkey_id FROM GPG_SUBKEYS WHERE subkey_type = ${SOPS_TYPE} AND description = '${SOPS_ID}';"
FP_SOPS=$(db_sql_execute_with_result "${DB_FILE}" "${QUERY}")
if [[ -z "${FP_SOPS}"  ]]
then
    show_error_dialog "${head_error}" "${fwmsg_008}"
    clear
    exit 5
fi

mz_yesno "${fwmsg_002}"
case ${result} in
    0)
    declare -a response c_lbl, c_hlp, c_mod, c_opt, c_val
    safe_fwdemail_sops
    rc_sops=$?
    case ${rc_sops} in
        0)
        APIKEY_CRYPT="$(echo "${response[0]}" | base64)"
        SOPS_FILE="fwd_${USER}.yaml"
        SECRET="\n  ${FW_LBL_APPKEY}: ${APIKEY_CRYPT}\n"
        sops_crypt_file "${FP_SOPS}" "${HOME}/${SOPS_PATH}" "${SOPS_FILE}" "${SECRET}"
        show_error_dialog "${head_error}" "${fwmsg_004}"
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

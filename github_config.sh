#!/usr/bin/env bash
#bash script     : github_config.sh
#apps            : MRosero Personal Developer Utilities
#description     : Configurar Acceso a Github
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

# Load db messages
load_messages "${HOME}" "db"

# Load ssh messages
load_messages "${HOME}" "ssh"

# Load github messages
load_messages "${HOME}" "github"
title="${head_000}"
apps_title="${ghmsg_000}"

# Load dialog console library
source "${HOME}/${BINLIB_PATH}/console.lib"

# Load sqlite db library
source "${HOME}/${BINLIB_PATH}/db.lib"

# Load gpg library
source "${HOME}/${BINLIB_PATH}/gpg.lib"

# Load ssh library
source "${HOME}/${BINLIB_PATH}/ssh.lib"

# Load github library
source "${HOME}/${BINLIB_PATH}/github.lib"

menu_actions() {
    local head_menu="$1"
    local keys=$(echo -e "$2")
    options=()
    rows=8

    while IFS= read -r line
    do
        name=$(echo "$line" | cut -d':' -f2)
        index=$(echo "$line" | cut -d':' -f1)
        options+=("${index}" "${name}")
        ((rows++))
    done <<< "$keys"

    choice=$(dialog --clear \
                    --erase-on-exit \
                    --cancel-label "${head_exit}" \
                    --backtitle "${title}" \
                    --title "${apps_title}" \
                    --menu "\n${head_menu}" \
                    ${rows} 56 2 \
                    "${options[@]}" \
                    2>&1 >/dev/tty)
    if [ $? -ne 0 ]
    then
        choice="${head_key_end}"
    fi
    echo "${choice}"
}

safe_github_token() {
    local db_file="${HOME}/${DB_PATH}/${DB_USER}"
    declare -a response c_lbl, c_hlp, c_mod, c_val

    # Define gpg capture form
    c_lbl[0]="${ghlbl_001}"
    c_hlp[0]="${ghhlp_001}"
    c_mod[0]=${ghtyp_001}
    c_val[0]=001
    c_lbl[1]="${ghlbl_002}"
    c_hlp[1]="${ghhlp_002}"
    c_mod[1]=${ghtyp_002}
    c_val[1]=001
    c_end=2

    clear
    local query="SELECT subkey_id FROM ${DB_GPG_SUBKEYS} WHERE subkey_type = ${SOPS_TYPE} AND description = '${SOPS_ID}';"
    fp_sops=$(db_sql_execute_with_result "${db_file}" "${query}")
    if [[ -z "${fp_sops}"  ]]
    then
        show_error_dialog "${head_error}" "${ghmsg_008}"
        return 10
    fi

    mz_yesno "${ghmsg_002} ${fp_sops}?"
    case ${result} in
        0)
        form_capture
        if [ $? -eq 0 ]
        then
            set_github_token "${response[0]}" "${response[1]}" "${fp_sops}" "${HOME}/${SOPS_PATH}"
            rc_token=$?
            case ${rc_token} in
                0)
                show_error_dialog "${head_error}" "${ghmsg_004}"
                ;;
                1)
                show_error_dialog "${head_error}" "${ghmsg_006}"
                ;;
                2)
                show_error_dialog "${head_error}" "${ghmsg_007}"
                ;;
                3)
                show_error_dialog "${head_error}" "${ghmsg_009}"
                ;;
                *)
                show_error_dialog "${head_error}" "${ghmsg_005} (${rc_token})"
                ;;
            esac
        else
            show_error_dialog "${head_info}" "${head_op_error}"
        fi
        ;;
        *)
        show_error_dialog "${head_info}" "${head_op_error}"
        ;;
    esac
}

github_config_ssh() {
    mz_yesno "${ghmsg_035}"
    case ${result} in
        0)
        ssh_local_build
        github_set_ssh "${HOME}/${SOPS_PATH}"
        rc_token=$?
        case ${rc_token} in
            0)
            show_error_dialog "${head_error}" "${ghmsg_030}"
            ;;
            1)
            show_error_dialog "${head_error}" "${ghmsg_031}"
            ;;
            2)
            show_error_dialog "${head_error}" "${ghmsg_032}"
            ;;
            3)
            show_error_dialog "${head_error}" "${ghmsg_013}"
            ;;
            *)
            show_error_dialog "${head_error}" "${ghmsg_034} (${rc_token})"
            ;;
        esac
        ;;
        *)
        show_error_dialog "${head_info}" "${head_op_error}"
        ;;
    esac
}

github_config_gpg() {
    # Extraer el GPG_KEY_ID desde la configuración de git
    local GPG_KEY_ID=$(git config --global user.signingkey)

    # Verificar que GPG_KEY_ID esté definido
    if [[ -z "${GPG_KEY_ID}" ]]
    then
        show_error_dialog "${head_error}" "${ghmsg_012}"
        return 2
    fi

    mz_yesno "${ghmsg_025_1} ${GPG_KEY_ID} ${ghmsg_025_2}?"
    clear
    case ${result} in
        0)
        github_set_gpg "${GPG_KEY_ID}" "${HOME}/${SOPS_PATH}"
        rc_token=$?
        case ${rc_token} in
            0)
            show_error_dialog "${head_error}" "${ghmsg_020}"
            ;;
            1)
            show_error_dialog "${head_error}" "${ghmsg_011}"
            ;;
            3)
            show_error_dialog "${head_error}" "${ghmsg_013}"
            ;;
            *)
            show_error_dialog "${head_error}" "${ghmsg_015} (${rc_token})"
            ;;
        esac
        ;;
        *)
        show_error_dialog "${head_info}" "${head_op_error}"
        ;;
    esac
}

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
    show_error_dialog "${head_error}" "${ghmsg_001}"
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
if ! command -v git >/dev/null 2>&1
then
    show_error_dialog "${head_error}" "${ghmsg_021}"
    exit 4
fi

# Main Process
menu_option=""
while [ "${menu_option}" != "${head_key_end}" ]
do
    menu_option=$(menu_actions "${ghmsg_024}" "${ghmnu_000}")
    case "${menu_option}" in
        "${ghmnu_k01}")
        safe_github_token
        ;;
        "${ghmnu_k02}")
        github_config_ssh
        ;;
        "${ghmnu_k03}")
        github_config_gpg
        ;;
    esac
done

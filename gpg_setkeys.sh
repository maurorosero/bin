#!/usr/bin/env bash
#bash script     : gpg_setkeys.sh
#apps            : MRosero Personal Developer Utilities
#description     : Gestionar claves GPG
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
source "${HOME}/${BINLIB_PATH}/console.lib"

# Load os gpg library
source "${HOME}/${BINLIB_PATH}/${GPG}.lib"

# Load sqlite db library
source "${HOME}/${BINLIB_PATH}/db.lib"

# Load git library
source "${HOME}/${BINLIB_PATH}/git.lib"

# Load headers messages
load_messages "${HOME}" "head"

# Load db messages
load_messages "${HOME}" "db"

# Load git messages
load_messages "${HOME}" "git"

# Load gpg messages
load_messages "${HOME}" "${GPG}"
title="${head_000}"
apps_title="${pgmsg_000}"

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

gpg_securekey_add() {
    declare -a response c_lbl, c_hlp, c_mod, c_val

    # Define gpg capture form
    c_lbl[0]="${pglbl_001}"
    c_hlp[0]="${pghlp_001}"
    c_mod[0]=${pgtyp_001}
    c_val[0]=010
    c_lbl[1]="${pglbl_002}"
    c_hlp[1]="${pghlp_002}"
    c_mod[1]=${pgtyp_002}
    c_val[1]=001
    c_lbl[2]="${pglbl_004}"
    c_hlp[2]="${pghlp_004}"
    c_mod[2]=${pgtyp_004}
    c_val[2]=001
    c_lbl[3]="${pglbl_003}"
    c_hlp[3]="${pghlp_003}"
    c_mod[3]=${pgtyp_003}
    c_val[3]=000
    c_end=4

    form_capture
    if [ $? -eq 0 ]
    then
        mz_yesno "${pgmsg_001}"
        if [ "${result}" == "0" ]
        then
            gpg_create_masterkey "${response[0]}" "${response[1]}" "${response[2]}" "${response[3]}" 0 "cert" "${pgmsg_100}"
            if [ $? -eq 0 ]
            then
                show_error_dialog "${head_error}" "${pgmsg_025}"
            else
                show_error_dialog "${head_error}" "${output_log}"
            fi
        else
            show_error_dialog "${head_info}" "${head_op_error}"
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
    fi
}

gpg_idkey_add() {
    declare -a response c_lbl, c_hlp, c_mod, c_val

    # Define gpg capture form
    c_lbl[0]="${pglbl_501}"
    c_hlp[0]="${pghlp_501}"
    c_mod[0]=${pgtyp_501}
    c_val[0]=010
    c_lbl[1]="${pglbl_502}"
    c_hlp[1]="${pghlp_502}"
    c_mod[1]=${pgtyp_502}
    c_val[1]=001
    c_lbl[2]="${pglbl_504}"
    c_hlp[2]="${pghlp_504}"
    c_mod[2]=${pgtyp_504}
    c_val[2]=001
    c_lbl[3]="${pglbl_503}"
    c_hlp[3]="${pghlp_503}"
    c_mod[3]=${pgtyp_503}
    c_val[3]=000
    c_end=4

    form_capture
    if [ $? -eq 0 ]
    then
        mz_yesno "${pgmsg_051}"
        if [ "${result}" == "0" ]
        then
            gpg_create_masterkey "${response[0]}" "${response[1]}" "${response[2]}" "${response[3]}" 0 "encrypt" "${pgmsg_500}"
            if [ $? -eq 0 ]
            then
                show_error_dialog "${head_error}" "${pgmsg_052}"
            else
                show_error_dialog "${head_error}" "${output_log}"
            fi
        else
            show_error_dialog "${head_info}" "${head_op_error}"
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
    fi
}

gpg_sign_subkey_add() {
    local mkey="$1"
    local db_file="${HOME}/${DB_PATH}/${DB_USER}"
    declare -a response c_lbl, c_hlp, c_mod, c_val, c_opt

    # Define gpg capture form
    # Tipo de Uso
    c_lbl[0]="${pglbl_204}"
    c_hlp[0]="${pghlp_204}"
    c_mod[0]=${pgtyp_204}
    c_opt[0]="1 ${pgopt_204_1} off 2 ${pgopt_204_2} on 3 ${pgopt_204_3} off 5 ${pgopt_204_5} off"
    c_val[0]=000
    # Referencia
    c_lbl[1]="${pglbl_203}"
    c_hlp[1]="${pghlp_203}"
    c_mod[1]=${pgtyp_203}
    c_val[1]=001
    # Duración
    c_lbl[2]="${pglbl_201}"
    c_hlp[2]="${pghlp_201}"
    c_mod[2]=${pgtyp_201}
    c_val[2]=011
    # Visibilidad
    c_lbl[3]="${pglbl_205}"
    c_hlp[3]="${pghlp_205}"
    c_mod[3]=${pgtyp_205}
    c_opt[3]="1 ${pgopt_205_1} 2 ${pgopt_205_2}"
    c_val[3]=000
    # Passphrase
    c_lbl[4]="${pglbl_202}"
    c_hlp[4]="${pghlp_202}"
    c_mod[4]=${pgtyp_202}
    c_val[4]=000
    c_end=5

    form_capture
    rc_capture=$?

    if [ ${rc_capture} -eq 0 ]
    then
        if [ "${result}" == "0" ]
        then
            gpg_create_subkey "${mkey}" "${response[0]}" "${response[1]}" "${response[2]}" "${response[3]}" "${response[4]}" "4" "${db_file}" "${pgmsg_200}"
            rc_sign=$?
            case ${rc_sign} in
                0)
                show_error_dialog "${head_info}" "${pgmsg_025}"
                ;;
                2)
                show_error_dialog "${head_error}" "${pgmsg_030}"
                ;;
                100)
                show_error_dialog "${head_error}" "${pgmsg_028}"
                rc_sign=0
                ;;
                *)
                show_error_dialog "${head_error}" "${head_error_unknow} (${rc_sign})"
                ;;
            esac
            return ${rc_sign}
        else
            show_error_dialog "${head_info}" "${head_op_error}"
            return ${result}
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
        return ${rc_capture}
    fi
}

gpg_crypto_subkey_add() {
    local mkey="$1"
    local db_file="${HOME}/${DB_PATH}/${DB_USER}"
    declare -a response c_lbl, c_hlp, c_mod, c_val, c_opt

    # Define gpg capture form
    # Tipo de Uso
    c_lbl[0]="${pglbl_304}"
    c_hlp[0]="${pghlp_304}"
    c_mod[0]=${pgtyp_304}
    c_opt[0]="6 ${pgopt_304_6} on 7 ${pgopt_304_7} off 9 ${pgopt_304_9} off"
    c_val[0]=000
    # Referencia
    c_lbl[1]="${pglbl_303}"
    c_hlp[1]="${pghlp_303}"
    c_mod[1]=${pgtyp_303}
    c_val[1]=001
    # Duración
    c_lbl[2]="${pglbl_301}"
    c_hlp[2]="${pghlp_301}"
    c_mod[2]=${pgtyp_301}
    c_val[2]=011
    # Visibilidad
    c_lbl[3]="${pglbl_305}"
    c_hlp[3]="${pghlp_305}"
    c_mod[3]=${pgtyp_305}
    c_opt[3]="1 ${pgopt_305_1} 2 ${pgopt_305_2}"
    c_val[3]=000
    # Passphrase
    c_lbl[4]="${pglbl_302}"
    c_hlp[4]="${pghlp_302}"
    c_mod[4]=${pgtyp_302}
    c_val[4]=000
    c_end=5

    form_capture
    rc_capture=$?

    if [ ${rc_capture} -eq 0 ]
    then
        if [ "${result}" == "0" ]
        then
            gpg_create_subkey "${mkey}" "${response[0]}" "${response[1]}" "${response[2]}" "${response[3]}" "${response[4]}" "6" "${db_file}" "${pgmsg_300}"
            rc_sign=$?
            case ${rc_sign} in
                0)
                show_error_dialog "${head_info}" "${pgmsg_025}"
                ;;
                2)
                show_error_dialog "${head_error}" "${pgmsg_030}"
                ;;
                100)
                show_error_dialog "${head_error}" "${pgmsg_028}"
                rc_sign=0
                ;;
                *)
                show_error_dialog "${head_error}" "${head_error_unknow} (${rc_sign})"
                ;;
            esac
            return ${rc_sign}
        else
            show_error_dialog "${head_info}" "${head_op_error}"
            return ${result}
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
        return ${rc_capture}
    fi
}

gpg_uid_add() {
    local mkey="$1"
    declare -a response c_lbl, c_hlp, c_mod, c_val

    # Define gpg capture form
    # Nombre Completo
    c_lbl[0]="${pglbl_401}"
    c_hlp[0]="${pghlp_401}"
    c_mod[0]=${pgtyp_401}
    c_val[0]=000
    # Correo Electrónico
    c_lbl[1]="${pglbl_402}"
    c_hlp[1]="${pghlp_402}"
    c_mod[1]=${pgtyp_402}
    c_val[1]=010
    # Comentario
    c_lbl[2]="${pglbl_403}"
    c_hlp[2]="${pghlp_403}"
    c_mod[2]=${pgtyp_403}
    c_val[2]=001
    # Passphrase
    c_lbl[3]="${pglbl_404}"
    c_hlp[3]="${pghlp_404}"
    c_mod[3]=${pgtyp_404}
    c_val[3]=000
    c_end=4

    form_capture
    rc_capture=$?

    if [ ${rc_capture} -eq 0 ]
    then
        if [ "${result}" == "0" ]
        then
            gpg_create_uid "${mkey}" "${response[0]}" "${response[1]}" "${response[2]}" "${response[3]}"
            local rc_uid=$?
            case ${rc_uid} in
                0)
                show_error_dialog "${head_info}" "${pgmsg_037}"
                ;;
                2)
                show_error_dialog "${head_error}" "${pgmsg_038}"
                ;;
                *)
                show_error_dialog "${head_error}" "${head_error_unknow} (${rc_sign})"
                ;;
            esac
            return ${rc_uid}
        else
            show_error_dialog "${head_info}" "${head_op_error}"
            return ${result}
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
        return ${rc_capture}
    fi
}

sign_subkey_add() {
    clear
    selected_key=$(select_master_key "\n${pgmsg_015}" 90)
    if [ -n "${selected_key}" ]
    then
        mz_yesno "${pgmsg_017} ${selected_key}?"
        case ${result} in
            0)
            gpg_sign_subkey_add "${selected_key}"
            if [ $? -eq 0 ]
            then
                show_error_dialog "${head_info}" "${pgmsg_018_1} ${selected_key} ${pgmsg_018_2}"
            else
                show_error_dialog "${head_error}" "${pgmsg_019}"
            fi
            ;;
            *)
            show_error_dialog "${head_info}" "${pgmsg_020}"
            clear
            return ${result}
            ;;
        esac
    else
        show_error_dialog "${head_error}" "${pgmsg_006}"
        return 254
    fi
}

crypto_subkey_add() {
    clear
    selected_key=$(select_master_key "\n${pgmsg_015}" 90)
    if [ -n "${selected_key}" ]
    then
        mz_yesno "${pgmsg_017} ${selected_key}?"
        case ${result} in
            0)
            gpg_crypto_subkey_add "${selected_key}"
            if [ $? -eq 0 ]
            then
                show_error_dialog "${head_info}" "${pgmsg_018_1} ${selected_key} ${pgmsg_018_2}"
            else
                show_error_dialog "${head_error}" "${pgmsg_019}"
            fi
            ;;
            *)
            show_error_dialog "${head_info}" "${pgmsg_020}"
            clear
            return ${result}
            ;;
        esac
    else
        show_error_dialog "${head_error}" "${pgmsg_006}"
        return 254
    fi
}

 gpg_uid_del() {
    local masterkey="$1"
    local uid="$2"
    declare -a response c_lbl, c_hlp, c_mod, c_val

    c_lbl[0]="${pglbl_003}"
    c_hlp[0]="${pghlp_003}"
    c_mod[0]=${pgtyp_003}
    c_val[0]=000
    c_end=1

    form_capture
    if [ $? -eq 0 ]
    then
        mz_yesno "${pgmsg_039_1} ${uid} ${pgmsg_039_2} ${masterkey}?"
        if [ "${result}" == "0" ]
        then
            gpg_delete_uid "${masterkey}" "${uid}" "${response[0]}"
            local rc_delete_uid=$?
            case ${rc_delete_uid} in
                0)
                show_error_dialog "${head_info}" "${pgmsg_047}"
                ;;
                *)
                show_error_dialog "${head_error}" "${head_error_unknow} (${rc_delete_uid})"
                ;;
            esac
        else
            show_error_dialog "${head_info}" "${head_op_error}"
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
    fi
}

gpg_backup() {
    declare -a response c_lbl, c_hlp, c_mod, c_val
    local db_file="${HOME}/${DB_PATH}/${DB_USER}"
    local destino=${HOME}/$(cat ${HOME}/bin/lib/gpg.backup)

    c_lbl[0]="${pglbl_101}"
    c_hlp[0]="${pghlp_101}"
    c_mod[0]=${pgtyp_101}
    c_val[0]=000
    c_end=1

    form_capture
    if [ $? -eq 0 ]
    then
        mz_yesno "${pgmsg_027}"
        if [ "${result}" == "0" ]
        then
            gpg_backup_keyring "${response[0]}" "${destino}" "${db_file}"
            rc_backup=$?
            case ${rc_backup} in
                0)
                show_error_dialog "${head_info}" "${pgmsg_026}"
                ;;
                11)
                show_error_dialog "${head_error}" "${pgmsg_111}"
                ;;
                12)
                show_error_dialog "${head_error}" "${pgmsg_112}"
                ;;
                13)
                show_error_dialog "${head_error}" "${pgmsg_113}"
                ;;
                14)
                show_error_dialog "${head_error}" "${pgmsg_114}"
                ;;
                15)
                show_error_dialog "${head_error}" "${pgmsg_115}"
                ;;
                *)
                show_error_dialog "${head_error}" "${head_error_unknow} (${rc_backup})"
                ;;
            esac
        else
            show_error_dialog "${head_info}" "${head_op_error}"
        fi
    else
        show_error_dialog "${head_info}" "${head_op_error}"
    fi
}

uid_managment() {
    clear
    selected_key=$(select_master_key "\n${pgmsg_031}" 90)
    if [ -n "${selected_key}" ]
    then
        mz_yesno "${pgmsg_032} ${selected_key}?"
        case ${result} in
            0)
            selected_uid=$(select_master_uid "${selected_key}" 80)
            rc_uuid=$?
            case ${rc_uuid} in
                0)
                gpg_uid_del "${selected_key}" "${selected_uid}"
                rc_uiddel=$?
                return ${rc_uiddel}
                ;;
                1)
                return 1
                ;;
                3)
                mz_yesno "${pgmsg_035} ${selected_key}?"
                case ${result} in
                    0)
                    gpg_uid_add "${selected_key}"
                    ;;
                    *)
                    show_error_dialog "${head_info}" "${pgmsg_036}"
                    return ${result}
                    ;;
                esac
                ;;
                *)
                return ${rc_uuid}
                ;;
            esac
            ;;
            *)
            show_error_dialog "${head_info}" "${pgmsg_033}"
            return ${result}
            ;;
        esac
    else
        show_error_dialog "${head_error}" "${pgmsg_006}"
        return 254
    fi
}

set_global_git() {
    clear
    local gpg_sign=$(git config --global commit.gpgSign)
    if [[ "${gpg_sign}" == "true" ]]
    then
        local signing_key=$(git config --global user.signingkey)
        msg_gpg_git="${gtmsg_011_1} ${signing_key}. ${gtmsg_011_2}"
    else
        msg_gpg_git="${gtmsg_012}"
    fi

    mz_yesno "${msg_gpg_git}"
    case ${result} in
        0)
        continue
        ;;
        1)
        show_error_dialog "${head_info}" "${gtmsg_003}"
        return 1
        ;;
        *)
        show_error_dialog "${head_error}" "${gtmsg_009} (${result})"
        return ${result}
        ;;
    esac

    selected_key=$(select_uid_fp_key "\n${gtmsg_006}" 105)
    if [ -n "${selected_key}" ]
    then
        local uid_id=$(echo "${selected_key}" | cut -d"|" -f1)
        local fingerprint=$(echo "${selected_key}" | cut -d"|" -f2)
        local reference=$(get_gpg_full_email_uid "${fingerprint}" "${uid_id}")
        local email=$(echo "${reference}" | grep -oP '(?<=<).*?(?=>)')
        local fullname=$(echo "${reference}" | sed 's/ (.*//')

        # Obtiene la configuración global de user.email
        local actual_email=$(git config --global user.email)

        # Verifica si user.email está configurado
        if [[ -n "${actual_email}" ]]
        then
            local actual_name=$(git config --global --get user.name)
            local msg_git_configure="${gtmsg_010_1} ${actual_name} (${actual_email}). ${gtmsg_010_2} ${fullname} (${email})?"
        else
            local msg_git_configure="${gtmsg_004} ${email}?"
        fi

        mz_yesno "${msg_git_configure}"
        case ${result} in
            0)
            selected_git_sign=$(select_sign_subkey "\n${gtmsg_006}" "${fingerprint}" "${fullname} (${email})" 105)
            rc_selected_git=$?
            case ${rc_selected_git} in
                0)
                # Set git identity
                local git_configured=$(set_global_git_identity "${fullname}" "${email}")
                rc_git_config=$?
                if [ ${rc_git_config} -ne 0 ]
                then
                    show_error_dialog "${head_error}" "${gtmsg_013} (${rc_git_config})"
                    return ${rc_git_config}
                fi
                show_error_dialog "${head_info}" "${gtmsg_008} ${git_configured}"
                # Se git gpg
                git_subkey_id=$(echo "${selected_git_sign}" | cut -d'|' -f1)
                git_subkey_fp=$(echo "${selected_git_sign}" | cut -d'|' -f2)
                set_global_git_gpg "${git_subkey_fp}"
                rc_git_config=$?
                if [ ${rc_git_config} -ne 0 ]
                then
                    show_error_dialog "${head_error}" "${gtmsg_014} (${rc_git_config})"
                    return ${rc_git_config}
                fi
                show_error_dialog "${head_info}" "${gtmsg_015_1} ${git_subkey_fp} ${gtmsg_015_2}"
                ;;
                *)
                show_error_dialog "${head_error}" "${gtmsg_007} (${rc_selected_git})"
                return ${rc_selected_git}
                ;;
            esac
            ;;
            *)
            show_error_dialog "${head_info}" "${gtmsg_003}"
            return ${result}
            ;;
        esac
    else
        show_error_dialog "${head_error}" "${gtmsg_005}"
        return 254
    fi
}

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

# Check if os is valid!
get_osname
if [ "${os_name}" == "${head_unknow}" ]
then
    show_error_dialog "${head_error}" "${head_os_error}"
    clear
    exit 2
fi

check_sqlite_installed
case $? in
    1)
    alias sqlite='sqlite3'
    ;;
    255)
    show_error_dialog "${head_error}" "${dbmsg_002}"
    clear
    exit 3
    ;;
esac


if [ ! -f "${HOME}/${DB_PATH}/${DB_USER}" ]
then
    db_table_exists "${HOME}/${DB_PATH}/${DB_USER}" "${DB_GPG_SUBKEYS}"
    if [ $? -ne 0 ]
    then
        db_create "${HOME}/${DB_PATH}" "${DB_USER}" "${HOME}/${BINLIB_PATH}/${DF_GPG_SUBKEYS}"
        rc_createdb=$?
        case ${rc_createdb} in
            252)
            show_error_dialog "${head_error}" "${dbmsg_003}"
            clear
            exit 252
            ;;
            250)
            show_error_dialog "${head_error}" "${dbmsg_001_1} ${DF_GPG_SUBKEYS} ${dbmsg_001_2}"
            clear
            exit 250
            ;;
            0)
            sleep 1
            ;;
            *)
            show_error_dialog "${head_error}" "${dbmsg_999} (${rc_createdb})"
            clear
            exit ${rc_createdb}
            ;;
        esac
    fi
fi

# Main Process
menu_option=""
while [ "${menu_option}" != "${head_key_end}" ]
do
    menu_option=$(menu_actions "${pgmsg_024}" "${pgmnu_000}")
    case "${menu_option}" in
        "${pgmnu_k01}")
        gpg_idkey_add
        ;;
        "${pgmnu_k02}")
        gpg_securekey_add
        ;;
        "${pgmnu_k03}")
        sign_subkey_add
        ;;
        "${pgmnu_k04}")
        crypto_subkey_add
        ;;
        "${pgmnu_k05}")
        uid_managment
        ;;
        "${pgmnu_k06}")
        set_global_git
        ;;
        "${pgmnu_k09}")
        gpg_backup
        ;;
    esac
done

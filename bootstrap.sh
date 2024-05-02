#!/usr/bin/env bash
#Bash script     : bootstrap.sh
#Apps            : Personal Bin Utilities (MRosero)
#Description     : Bootstrap Base Packages Install
#Author		     : MRP/mrp - Mauro Rosero P.
#Company email   : mauro@rosero.one
#Personal email  : mauro.rosero@gmail.com
#Date            : 20240501
#Version         : 1.5.8
#Notes           :
#==============================================================================
#==============================================================================

install() {
	local install_home=$1
    local bin_home=${install_home}/bin
	local bin_token=$2
	local bin_owner=$3
	local bin_repo=$4
	local download_path=$5

	# Load bootstrap base messages
	set_messages() {
		pymsg_001="Instalando o actualizando Python a la última versión..."
		pymsg_002="No se pudo determinar el sistema operativo."
		pymsg_003="Python instalado o actualizado correctamente."
	}

	if [ -f "${bin_home}/msg/bootstrap.$LANG" ]
	then
		source "${bin_home}/msg/bootstrap.$LANG"
	else
		set_messages
	fi

	install_or_update_python() {
		echo "${pymsg_001}"
		package_list_1="python3 git curl wget zip dialog gettext"
		package_list_2="python git curl wget zip dialog gettext"
		if [ "$(uname)" == "Darwin" ]; then
			# En macOS, instalamos o actualizamos Python a través de Homebrew
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			echo "Instalando ${package_list_2}..."
			brew install ${package_list_2}
		elif [ -f /etc/debian_version ] || [ -f /etc/os-release ]; then
			# En sistemas Debian y derivados, instalamos o actualizamos Python a través de apt
			echo "Instalando ${package_list_1}..."
			apt install -y ${package_list_1}
		elif [ -f /etc/redhat-release ]; then
			# En sistemas Red Hat, instalamos o actualizamos Python a través de yum
			echo "Instalando ${package_list_1}..."
			yum install -y ${package_list_1}
		elif [ -f /etc/arch-release ]; then
			# En Arch Linux, instalamos o actualizamos Python a través de pacman
			echo "Instalando ${package_list_2}..."
			pacman -Sy --noconfirm ${package_list_2}
		elif [ -f /etc/rc.conf ]; then
			# En BSD, instalamos o actualizamos Python a través de pkg
			echo "Instalando ${package_list_1}..."
			pkg install -y ${package_list_1}
		else
			echo "${pymsg_002}"
			exit 1
		fi
		echo "${pymsg_003}"
	}

	bin_download() {
		local gh_auth="Authorization: token $1"
		local gh_owner=$2
		local gh_repos=$3
		local gh_headr="Accept: application/vnd.github.v3+json"
		local gh_url="https://api.github.com"
		local gh_download=$4

		release=$(wget --header="${gh_auth}" --header="${gh_headr}" -qO - ${gh_url}/repos/${gh_owner}/${gh_repos}/releases/latest | grep -o '"name": *"[^"]*"' | sed 's/"name": "\(.*\)"/\1/' | grep "Release" | cut -d\  -f2)
		if [ "${release}" == "" ]
		then
			DOWNLOAD_FILE="none"
		else
		    echo "Release ${release}"
			local gh_asset=${gh_repos}_${release}.zip

			id_asset=$(curl -s -H "${gh_auth}" -H "${gh_headr}" "${gh_url}/repos/${gh_owner}/${gh_repos}/releases/latest" | jq -r --arg gh_asset "$gh_asset" '.assets[] | select(.name == $gh_asset) | .id')
			if [ "${id_asset}" == "" ]
			then
				DOWNLOAD_FILE="none"
			else
				local download_file="${gh_download}/${gh_asset}"
				wget --header="${gh_auth}" --header="Accept: application/octet-stream" -O ${download_file} ${gh_url}/repos/${gh_owner}/${gh_repos}/releases/assets/${id_asset}
				if [ $? == 0 ]
				then
					DOWNLOAD_FILE=${download_file}
				else
					DOWNLOAD_FILE="none"
				fi
			fi
		fi
	}

	# Instalar o actualizar Python a la última versión y pre-requisitos bootstrap
	install_or_update_python

	# Download bin zip project to /tmp
	DOWNLOAD_FILE=""
	if [ ! -d "${bin_home}/.git" ]
	then
		bin_download "${bin_token}" "${bin_owner}" "${bin_repo}" "${download_path}"
		echo "Paquete bin fue descargado en ${DOWNLOAD_FILE}"
		unzip -qu ${DOWNLOAD_FILE} -d ${bin_home}
		echo "Paquete bin ${DOWNLOAD_FILE} fue instaldo!"
		rm -f ${DOWNLOAD_FILE}
		echo -e "\n====================================================="
		echo "   Esta instalación se realizó en modo usuario.      "
		echo "   Utilice este bash script para actualizar.         "
		echo "-----------------------------------------------------"
		echo "   Si desea convertirla en modo de desarrollador,    "
		echo "   y aportar a esta caja de herramientas.            "
		echo "   Solicite e instale su certificado ssh autorizado  "
		echo "   a Mauro Rosero P.:                                "
		echo "       - Email: mauro@rosero.one                     "
		echo "       - Email: mauro.rosero@gmail.com               "
		echo "   entonces:                                         "
		echo "       cd \$HOME                                     "
		echo "       rm -rf bin                                    "
		echo "       git clone git@github.com:maurorosero/bin.git  "
		echo -e "=====================================================\n"
	else
		echo -e "\n================================================="
		echo "   Esta instalación está en modo desarrollador   "
		echo "-------------------------------------------------"
		echo "   Debe tener configurado su certificado ssh     "
		echo "   Use git pull para actualizar bin toolbox:     "
		echo "       cd \$HOME/bin                             "
		echo "       git pull                                  "
		echo -e "=================================================\n"
	fi
}

# Main.- Llamar a la función con sudo
clear

# Load head messages
LOCAL_BIN=${HOME}/bin
GTH_TOKEN=${LOCAL_BIN}/.release_token
BIN_OWNER=maurorosero
BIN_REPOS=bin
DOWNLOAD_PATH=/tmp
DOWNLOAD_FILE=""

if [ -f "${LOCAL_BIN}/msg/head.$LANG" ]
then
	source "${LOCAL_BIN}/msg/head.$LANG"
else
	head_000="Utilitarios de Mauro Rosero P. (bootstrap bin)"
fi	

GB_TOKEN=$(echo "Z2l0aHViX3BhdF8xMUFKTUZBT1kwYjVrNndrSzdHSGx4X3VHeHRPTlVVR0tvUUh2NnlWWnJMNEt2
eUZjYTM0TkFmM1VybUlWZ1dmNjlTSU9PWjVGTHZVbExlQ3VSCg==" | base64 -d)
if [ -n "${GITHUB_TOKEN}" ]
then
	GB_TOKEN=${GITHUB_TOKEN}
else
	if [ -f "${GTH_TOKEN}" ]
	then
		GB_TOKEN=$(cat < ${GTH_TOKEN})
	fi
fi

echo "${head_000}"
echo "------------------------------------------------------------------------------"
sudo bash -c "$(declare -f install); install ${HOME} '${GB_TOKEN}' ${BIN_OWNER} ${BIN_REPOS} ${DOWNLOAD_PATH}"

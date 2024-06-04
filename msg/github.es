#!/usr/bin/env bash
#bash script     : github.es
#apps            : MRosero Personal Developer Utilities
#description     : Head Translate Github Tools (es)
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

ghmsg_000="MROSERO TOOLBOX - GESTIÓN DE CUENTA GITHUB"
ghmsg_300="[ACCESO PERSONAL SSH/GIT]"
ghmsg_400="[FIRMA PERSONAL GPG/GIT]"
ghmsg_001="Operación cancelada. SoPS no ha sido instalado!"
ghmsg_002="Desea configurar un TOKEN PERSONAL para GITHUB con huella digital"
ghmsg_003="Ya hay un TOKEN PERSONAL para GITHUB. Desea generarlo nuevamente?"
ghmsg_004="TOKEN PERSONAL para GITHUB fue guardado satisfactoriamente!"
ghmsg_005="Error desconocido. TOKEN PERSONAL para GITHUB no pudo ser guardado"
ghmsg_006="Argumento no fue obtenido. TOKEN PERSONAL para GITHUB no ha sido guardado"
ghmsg_007="No se creo la carpeta para SOPS. TOKEN PERSONAL para GITHUB no pudo ser guardado!"
ghmsg_008="Operación cancelada. No se encontró huella digital para PERSONAL SOPS (GITHUB)!"
ghmsg_009="Problemas con al API de GITHUB. TOKEN PERSONAL para GITHUB no fue guardado"
ghmsg_010="(Personal)"
ghmsg_011="Argumento no fue obtenido. Firma GPG/GIT no fue registrada en GITHUB!"
ghmsg_012="Operación cancelada. No existe una firma GPG configurada para GIT!"
ghmsg_013="Operación cancelada. No se puedo obtener la información de acceso a GITHUB!"
ghmsg_015="Error desconocido. Firma Personal GPG/GIT no pudo ser configurada en GITHUB"
ghmsg_018="Operación cancelada. No se encontró huella digital para PERSONAL SOPS (GITHUB)!"
ghmsg_024="Seleccione la acción a realizar:"
ghmsg_025_1="Desea registrar su firma personal GPG"
ghmsg_025_2="definida para uso de GIT en GITHUB"
ghmsg_020="Firma Personal GPG para GIT fue configurada satisfactoriamente en GITHUB!"
ghmsg_021="Operación cancelada. git no ha sido instalado!"
ghmsg_022="Personal SSH/GIT"
ghmsg_030="Clave SSH para GIT fue configurada satisfactoriamente en GITHUB!"
ghmsg_031="Operación cancelada. Terraform es requerido y no ha sido instalado!"
ghmsg_032="Argumento no fue obtenido. Clave Personal SSH/GIT no fue registrada en GITHUB!"
ghmsg_034="Error desconocido. Clave Personal SSH/GIT no pudo ser configurada en GITHUB"
ghmsg_035="Desea configurar su clave SSH para GIT?"

ghlbl_001="Usuario"
ghhlp_001="Usuario para la cuenta de GITHUB"
ghtyp_001=1
ghlbl_002="TOKEN (PAT)"
ghhlp_002="Registre su TOKEN GITHUB de Acceso Personal"
ghtyp_002=1

ghmnu_k01="T"
ghmnu_k02="S"
ghmnu_k03="G"
ghmnu_000="${ghmnu_k01}:Configurar Personal Token (PAT)"
ghmnu_000="${ghmnu_000}\n${ghmnu_k02}:Configurar GIT SSH (Personal)"
ghmnu_000="${ghmnu_000}\n${ghmnu_k03}:Establecer Firma Personal GPG/GIT"

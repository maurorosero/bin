#!/usr/bin/env bash
#bash script     : cloudflare.es
#apps            : MRosero Personal Developer Utilities
#description     : Head Translate Cloudflare Tools (es)
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

cfmsg_000="MROSERO TOOLBOX - GESTIÓN DE CUENTA CLOUDFLARE"
cfmsg_100="${cfmsg_000} [TOKEN]"
cfmsg_001="Operación cancelada. SoPS no ha sido instalado!"
cfmsg_002="Desea registrar información de acceso para cuenta de CLOUDFLARE?"
cfmsg_004="Acceso a cuenta CLOUDFLARE fue guardado satisfactoriamente!"
cfmsg_008="Operación cancelada. No se encontró huella digital para PERSONAL SOPS!"

cflbl_001="Correo Electrónico"
cfhlp_001="Correo Electrónico para la cuenta de CLOUDFLARE"
cftyp_001=1
cflbl_002="Cuenta Id"
cfhlp_002="Identificación de la cuenta para CLOUDFLARE"
cftyp_002=1
cflbl_003="Zona"
cfhlp_003="Nombre de dominio o zona DNS que será gestionado por CLOUDFLARE"
cftyp_003=1
cflbl_004="API KEY"
cfhlp_004="Clave API para acceso a cuenta de CLOUDFLARE"
cftyp_004=2

CF_LBL_EMAIL="CF_EMAIL"
CF_LBL_USER="CF_ACCTID"
CF_LBL_ZONE="CF_ZONE"
CF_LBL_APIKEY="CF_APIKEY"

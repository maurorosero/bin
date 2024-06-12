#!/usr/bin/env bash
#bash script     : ovh.es
#apps            : MRosero Personal Developer Utilities
#description     : Head Translate OVH Tools (es)
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

ovmsg_000="MROSERO TOOLBOX - ACCESO DE CUENTA OVH"
ovmsg_100="${ovmsg_000} [API-KEY]"
ovmsg_001="Operación cancelada. SoPS no ha sido instalado!"
ovmsg_002="Desea registrar información de acceso para cuenta de OVH?"
ovmsg_004="Acceso a cuenta OVH fue guardado satisfactoriamente!"
ovmsg_008="Operación cancelada. No se encontró huella digital para PERSONAL SOPS!"

ovlbl_001="ENDPOINT"
ovhlp_001="Región de Infraestructura para la cuenta de OVH"
ovtyp_001=4
ovopt_001_1="ovh-eu Europa"
ovopt_001_2="ovh-ca Canada"
ovopt_001_3="ovh-us USA"
ovopt_001="${ovopt_001_1} ${ovopt_001_2} ${ovopt_001_3}"
ovlbl_002="APPLICATION KEY"
ovhlp_002="Identificación de aplicación para la cuenta de OVH"
ovtyp_002=1
ovlbl_003="CONSUMER KEY"
ovhlp_003="Identificación de la cuenta para OVH"
ovtyp_003=1
ovlbl_004="APPLICATION SECRET"
ovhlp_004="Contraseña de acceso para la API de su cuenta de OVH"
ovtyp_004=2

OV_LBL_APPKEY="OV_APPKEY"
OV_LBL_SECRET="OV_SECRET"
OV_LBL_CONSUMER="OV_CONSUMER"


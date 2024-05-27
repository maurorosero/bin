#!/usr/bin/env bash
#bash script     : gpg.es
#apps            : MRosero Personal Developer Utilities
#description     : Translate GPG & SOPS Messages (es)
#author		     : MRP/mrp - Mauro Rosero P.
#company email   : mauro@rosero.one
#personal email  : mauro.rosero@gmail.com
#date            : 20240201
#version         : 1.0.2
#notes           :
#==============================================================================
#==============================================================================

pgmsg_000="MROSERO TOOLBOX - GESTIONAR CLAVE GPG"
pgmsg_100="[CLAVES GPG DE SEGURIDAD]"
pgmsg_200="[Sub Claves de Firma]"
pgmsg_300="[Sub Claves de Cifrado]"
pgmsg_400="[Identidad (UID)]"
pgmsg_500="[CLAVES GPG DE IDENTIDAD]"
pgmsg_800="[COPIA DE SEGURIDAD GPG KEYRING]"
pgmsg_801="Error exportando base de datos"
pgmsg_802="Error copiando archivos de revocación"
pgmsg_803="Error! No pudo cambiar a carpeta temporal de copia de seguridad..."
pgmsg_804="Error creando copia de seguridad en zip protegido"
pgmsg_805="Error en exportación del GPG KEYRING"
pgmsg_999="[SUBCLAVES]"
pgmsg_900="MROSERO TOOLBOX - CREAR/MODIFICAR GPG.CONF"
pgmsg_001="Desea crear una clave GPG de seguridad?"
pgmsg_003="¡La clave ya existe para este correo electrónico!\nContraseña no fue generada..."
pgmsg_004="Desea eliminar la clave GPG de seguridad?"
pgmsg_005="Seleccione la clave GPG de seguridad a eliminar:"
pgmsg_006="Operación cancelada. Clave GPG de seguridad no fue seleccionada!"
pgmsg_007="Está seguro que quiere eliminar la clave GPG: "
pgmsg_008_1="Clave GPG ("
pgmsg_008_2=") fue eliminada satisfactoriamente!"
pgmsg_009="No se pudo eliminar la clave GPG!"
pgmsg_010="Clave GPG no eliminada. Operación cancelada por el operador!"
pgmsg_011="Seleccione el tipo de subclave GPG a crear:"
pgmsg_014="Desea crear una subclave GPG de firma para "
pgmsg_015="Seleccione clave GPG de Seguridad a la que desea crear subclave de firma:"
pgmsg_017="Está seguro que quiere crear una subclave GPG para "
pgmsg_018_1="Subclave de firma"
pgmsg_018_2="fue creada!"
pgmsg_019="No se pudo crear la subclave GPG!"
pgmsg_020="Subclave GPG no fue creada. Operación cancelada por el operador!"
pgmsg_021="Ya existe una subclave GPG con este correo electrónico"
pgmsg_022="Operación cancelada! Problemas con la base de datos!"
pgmsg_023="Operación cancelada por el operador!"
pgmsg_024="Seleccione la acción a realizar:"
pgmsg_025="Clave GPG de seguridad fue creada satisfactoriamente!"
pgmsg_026="Copia de Seguridad de GPG KEYRING fue realizada satisfactoriamente!"
pgmsg_027="Desea crear una Copia de Seguridad del GPG KEYRING?"
pgmsg_028="No se pudo obtener el ID de la subclave creada."
pgmsg_029="Referencia de subclave GPG no fue creada!"
pgmsg_030="Subclave GPG no fue creada. Contraseña incorrecta!"
pgmsg_031="Seleccione la clave GPG de seguridad para Identidad:"
pgmsg_032="Está seguro que quiere gestionar una identidad para"
pgmsg_033="Identidad GPG no fue gestionada. Operación cancelada por el operador!"
pgmsg_034="Gestionar identidades para"
pgmsg_035="Está seguro que quiere crear una identidad para"
pgmsg_036="Identidad GPG no fue creada. Operación cancelada por el operador!"
pgmsg_037="Identidad GPG fue creada satisfactoriamente!"
pgmsg_038="Identidad GPG no fue creada. Contraseña incorrecta!"
pgmsg_039_1="Está seguro que quiere eliminar la identidad"
pgmsg_039_2="de"
pgmsg_040="Identidad GPG no fue eliminada. Operación cancelada por el operador!"
pgmsg_047="Identidad GPG fue eliminada satisfactoriamente!"

pgmsg_051="Desea crear una clave GPG de identidad?"
pgmsg_052="Clave GPG de identidad fue creada satisfactoriamente!"
pgmsg_111="Ruta de destino para Copia de Seguridad del GPG KEYRING no definida..."
pgmsg_112="Carpeta para Copia de Seguridad del GPG KEYRING no pudo ser creada..."
pgmsg_113="Contraseña para Copia de Seguridad del GPG KEYRING no fue suministrada!"
pgmsg_114="No se puedo exportar el GPG KEYRING!"
pgmsg_115="No se pudo crear la Copia de Respaldo del GPG KEYRING!"


pgmsg_901="Desea crear/modificar la configuración para GPG (gpg.conf)?"
pgmsg_902="Nueva configuración GPG establecida en gpg.conf!"
pgmsg_903="Error no definido en el cambio de la configuración GPG. gpg.conf no fue modificado."

pgmnu_k01="1"
pgmnu_k02="2"
pgmnu_k03="S"
pgmnu_k04="C"
pgmnu_k05="I"
pgmnu_k06="G"
pgmnu_k09="B"
pgmnu_000="${pgmnu_k01}:Crear Clave de Identidad"
pgmnu_000="${pgmnu_000}\n${pgmnu_k02}:Crear Clave de Seguridad"
pgmnu_000="${pgmnu_000}\n${pgmnu_k03}:Adicionar Firma"
pgmnu_000="${pgmnu_000}\n${pgmnu_k04}:Adicionar Cifrado"
pgmnu_000="${pgmnu_000}\n${pgmnu_k05}:Gestionar Identidad"
pgmnu_000="${pgmnu_000}\n${pgmnu_k06}:Configurar firma GIT"
pgmnu_000="${pgmnu_000}\n${pgmnu_k09}:Backup KEYRING GPG"

pglbl_001="Correo Electrónico"
pghlp_001="Correo Electrónico del propietario de la clave GPG de seguridad"
pgtyp_001=1
pglbl_002="Nombre del Propietario"
pghlp_002="Nombre Completo del propietario de la clave GPG de seguridad"
pgtyp_002=1
pglbl_003="Contraseña"
pghlp_003="Contraseña para la clave GPG de seguridad"
pgtyp_003=2
pglbl_004="Comentario"
pghlp_004="Descripción de uso de la clave GPG de seguridad"
pgtyp_004=1

pglbl_101="Contraseña"
pghlp_101="Contraseña para el archivo ZIP"
pgtyp_101=2

pglbl_201="Duración"
pghlp_201="Vigencia de la Firma GPG"
pgtyp_201=1
pglbl_202="Contraseña"
pghlp_202="Contraseña de la Clave GPG de seguridad"
pgtyp_202=2
pglbl_203="Referencia"
pghlp_203="Descripción de uso de la Firma GPG"
pgtyp_203=1
pglbl_204="Tipo de Uso"
pghlp_204="Tipo de uso de la Firma GPG"
pgopt_204_1="Git"
pgopt_204_2="Certificación"
pgopt_204_3="Identidad"
pgopt_204_5="Otros"
pgtyp_204=3
pglbl_205="Visibilidad"
pghlp_205="Visibilidad de la Firma GPG (1=Pública o 2=Privada)"
pgopt_205_1="Pública"
pgopt_205_2="Privada"
pgtyp_205=4

pglbl_301="Duración"
pghlp_301="Vigencia del Cifrado GPG"
pgtyp_301=1
pglbl_302="Contraseña"
pghlp_302="Contraseña de la clave GPG de seguridad"
pgtyp_302=2
pglbl_303="Referencia"
pghlp_303="Descripción de uso del Cifrado GPG"
pgtyp_303=1
pglbl_304="Tipo de Uso"
pghlp_304="Tipo de uso del Cifrado GPG"
pgopt_304_6="SopS"
pgopt_304_7="Passbolt"
pgopt_304_9="Múltiple"
pgtyp_304=3
pglbl_305="Visibilidad"
pghlp_305="Visibilidad del Cifrado GPG (1=Pública o 2=Privada)"
pgopt_305_1="Pública"
pgopt_305_2="Privada"
pgtyp_305=4

pglbl_401="Nombre Completo"
pghlp_401="Nombre Completo de la persona para esta identidad"
pgtyp_401=1
pglbl_402="Correo Electrónico"
pghlp_402="Correo Electrónico para esta identidad"
pgtyp_402=1
pglbl_403="Comentario"
pghlp_403="Descripción de la identidad"
pgtyp_403=1
pglbl_404="Contraseña"
pghlp_404="Contraseña de la clave GPG de seguridad"
pgtyp_404=2

pglbl_501="Correo Electrónico"
pghlp_501="Correo Electrónico del propietario de la clave GPG de identidad"
pgtyp_501=1
pglbl_502="Nombre del Propietario"
pghlp_502="Nombre Completo del propietario de la clave GPG de identidad"
pgtyp_502=1
pglbl_503="Contraseña"
pghlp_503="Contraseña para la clave GPG de identidad"
pgtyp_503=2
pglbl_504="Comentario"
pghlp_504="Descripción de uso de la clave GPG de identidad"
pgtyp_504=1

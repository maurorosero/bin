# MAURO ROSERO TOOLBOX

## Descripción del Proyecto

Este es un proyecto personal y privado alojado en un repositorio de mi cuenta de GitHub. Lo creé para mantener actualizadas mis diferentes computadoras, tanto físicas como virtuales, con mis herramientas de utilidad más comunes. Es el primer proyecto donde aplico técnicas básicas de CI/CD con **GitHub Actions**.

A pesar de que es un proyecto privado, alguno de mis colaboradores y amigos me han solicitado acceso al mismo para su uso. Mediante este sitio web, estoy compartiendo una parte de mis utilitarios no sensibles para su uso por otros y no limitado a mis colaboradores y amigos.

## Modos de Funcionamiento

Existen dos (2) formas de despliegue de uso:
  * Usuario: Se instala mediante este sitio y con las herramientas no sensibles y de uso general
  * Devops: Se requiere un token o acceso ssh al proyecto dado por mí a mis colaboradores de **PANAMATECH ONLINE** u otros colaboradores de programación.

## Instalación

### Usuario

Desde este enlace, descargue el archivo [install_bin.sh](scripts/install_bin.sh). Regularmente o en mi caso va a la carpeta de descargas.

Si esto es así (carpeta de descargas), muevalo a la carpeta /tmp:

    $ mv $HOME/Descargas/install_bin.sh /tmp

y realice los siguietes pasos:

    $ chmod a+x /tmp/install_bin.sh
    $ /tmp/install_bin.sh
    $ rm /tmp/install_bin.sh

o directamente desde la consola, **ejecute esto**:

    $ wget -O - https://maurorosero.github.io/bin/scripts/install_bin.sh | bash

En este punto, le va a pedir su cpntraseña y si es correcta iniciará el proceso de instalación directamente. Una vez terminado, se debe haber creado la **carpeta bin** dentro de la **carpeta HOME** de su usuario.

### Devops

Información reservada solo para colaboradores de **PANAMATECH ONLINE** u otros colaboradores de programación.

## Plataformas de Uso

| Sistema Operativo | Distribución      | Uso     |
|-------------------|-------------------|---------|
| Linux             | Debian/derivados  | Sí      |
|                   | Ubuntu            | Sí      |
|                   | Redhat/derivados  | Sí      |
|                   | Arch              | No test |
| MacOS             |                   | No test |
| Windows           |                   | No      |


## Caja de Herramientas

Es una colección de programas python, script en bash, librerías, y otras variantes de funciones ejecutables diseñadas, especialmente, para funcionar desde la línea de comandos (shell):

| Comando (script)     | Categoria  | Descripción de la funcionalidad                               |
|----------------------|------------|---------------------------------------------------------------|
| setvideo-1600x900.sh | Escritorio | Configura la resolución del segundo monitor a 1600x900 en una |
|                      | (HW)       | resolución virtual para que con paginé con la resolución del  |
|                      |            | monitor principal de mi laptop.                               |
|                      |            |                                                               |
| hexroute             | Redes      | Calcula el string option new-static-routes code 249 para DHCP |
|                      |            | Ejemplo:   route 192.168.20.64/26 vía gateway 192.168.10.62   |
|                      |            | Comando:   hexroute 192.168.20.64/26 192.168.10.62            |
|                      |            | Resultado: 1a:c0:a8:14:40:c0:a8:0a:3e                         |
|                      |            |                                                               |
| packages_set.sh      | Escritorio | Instala una lista de paquetes dados en requirements.txt       |
|                      | (OS)       | de mi elección personal.                                      |
|                      |            |                                                               |
| bootstrap.sh         | Install    | Actualiza este toolbox a la ú ltima versión (modo: usuario)   |
|                      |            |                                                               |
| devops.sh            | Devops     | Instala ansible y el conjunto de herramientas y aplicaciones  |
|                      |            | que uso como desarrollador que incluye infraestructura.       |
|                      |            |                                                               |
|                      |            |                                                               |




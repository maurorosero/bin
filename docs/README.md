# MROSERO TOOLBOX

---

## MI CAJA PERSONAL DE HERRAMIENTAS BASH

Este es un proyecto personal y privado alojado en un repositorio de mi cuenta de GitHub. Lo creé para mantener actualizadas mis diferentes computadoras, tanto físicas como virtuales, con mis herramientas de utilidad más comunes. Es el primer proyecto en el que aplico técnicas básicas de CI/CD con Actions en GitHub.

- **Cada vez que se hace un push al repositorio:**
  - Se actualiza el repositorio espejo/respaldo en la infraestructura de GITLAB de PANAMATECH.

- **Cada vez que se hace un push/merge (por pull request) al repositorio, que conforman un paquete de instalación:**
  - Se crea un nuevo release con dos (2) archivos:
    - **bootstrap.sh:** Un script bash que se utiliza para instalar las herramientas mínimas necesarias para que la caja de herramientas funcione. También instala la carpeta **bin** en la carpeta raíz del $HOME en modo de usuario (para uso personal).
    - **bin_[release].zip:** Un archivo empaquetado con el proyecto en modo de usuario (sin acceso al repositorio ni a archivos de git/github/gitlab). Este archivo se desempaqueta e instala mediante el script bootstrap.sh. Lo hice así para aquellas personas que me solicitaron compartir mi caja de herramientas, algunas de las cuales colaboran conmigo y otras que no son programadoras pero utilizan Linux y están interesadas en estas herramientas.
 

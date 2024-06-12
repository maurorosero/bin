# MROSERO TOOLBOX [TERRAFORM VARIABLES - NAMECHEAP SET DNS SERVER]
# Created Date: 2024-06-04
# Modified Date: 2024-06-04 14:33 TZ-5

variable "NCHP_USERNAME" {
  description = "Usuario para cuenta de NAMECHEAP"
  type        = string
  sensitive   = false
}

variable "NCHP_API_KEY" {
  description = "Clave segura para la API de NAMECHEAP"
  type        = string
  sensitive   = true
}

variable "NCHP_DOMAIN" {
  description = "Dominio en NAMECHEAP al cual se le registrarán los servidores de nombre (NS)"
  type        = string
  sensitive   = false
}

variable "NCHP_NS1" {
  description = "Servidor de Nombre Principal (NS1)"
  type        = string
  sensitive   = false
}

variable "NCHP_NS2" {
  description = "Servidor de Nombre Secundario (NS1)"
  type        = string
  sensitive   = false
}

# MROSERO TOOLBOX [TERRAFORM VARIABLES - SET GPG GITHUB]
# Created Date: 2024-06-03
# Modified Date: 2024-06-03 14:33 TZ-5

variable "GITHUB_TOKEN" {
  description = "Token de acceso personal de GitHub"
  type        = string
  sensitive   = true
}

variable "GPG_KEY" {
  description = "Clave de Firma GPG Pública para GIT"
  type        = string
  sensitive   = true
}

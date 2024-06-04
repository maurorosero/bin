# MROSERO TOOLBOX [TERRAFORM VARIABLES - SET SSH GITHUB]
# Created Date: 2024-06-03
# Modified Date: 2024-06-03 14:33 TZ-5

variable "GITHUB_TOKEN" {
  description = "Token de acceso personal de GitHub"
  type        = string
  sensitive   = true
}

variable "GITHUB_SSH" {
  description = "Referencia para Acceso Personal SSH/GIT"
  type        = string
  sensitive   = true
}

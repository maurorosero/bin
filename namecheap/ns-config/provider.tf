# MROSERO TOOLBOX [TERRAFORM PROVIDERS - NAMECHEAP SET DNS SERVER]
# Created Date: 2024-06-04
# Modified Date: 2024-06-04 14:33 TZ-5

terraform {
  required_providers {
    namecheap = {
      source = "namecheap/namecheap"
      version = ">= 2.0.0"
    }
  }
}

# Namecheap API credentials
provider "namecheap" {
  user_name = var.NCHP_USERNAME
  api_user = var.NCHP_USERNAME
  api_key = var.NCHP_API_KEY
  use_sandbox = false
}

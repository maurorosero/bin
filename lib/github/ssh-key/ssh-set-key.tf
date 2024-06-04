# MROSERO TOOLBOX [TERRAFORM MAIN - SET SSH GITHUB]
# Created Date: 2024-06-03
# Modified Date: 2024-06-03 14:33 TZ-5

resource "github_user_ssh_key" "github_ssh_personal" {
  title = var.GITHUB_SSH
  key   = file("~/.ssh/id_github_rsa.pub")
}

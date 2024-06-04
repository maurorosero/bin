# MROSERO TOOLBOX [TERRAFORM MAIN - SET GPG GITHUB]
# Created Date: 2024-06-03
# Modified Date: 2024-06-03 14:33 TZ-5

resource "github_user_gpg_key" "github_gpg_personal" {
  armored_public_key = var.GPG_KEY
}

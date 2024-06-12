# MROSERO TOOLBOX [TERRAFORM MAIN - NAMECHEAP SET DNS SERVER]
# Created Date: 2024-06-04
# Modified Date: 2024-06-04 14:33 TZ-5

resource "namecheap_domain_records" "set-ns-server" {
  domain = var.NCHP_DOMAIN
  mode = "OVERWRITE"

  nameservers = [
    var.NCHP_NS1,
    var.NCHP_NS2
  ]
}

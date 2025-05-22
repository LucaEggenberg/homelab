### Dns-Entries ###
locals {
  base_domain = "eggenberg.io"

  a_records = {
    "srv-plg-1"   = "10.10.20.11"
    "storage"     = "10.10.10.20"
    "kube-prod-1" = "10.10.20.21"
    "kube-prod-2" = "10.10.20.22"
    "kube-prod-3" = "10.10.20.23"
    "kube"        = "10.10.20.40"
  }

  srv_plg_1_cnames = toset([
    "gameserver"
  ])

  kube_cnames = toset([
    "argocd",
    "longhorn",
    "prowlarr",
    "sonarr",
    "radarr",
    "flaresolverr",
    "qbittorrent",
    "home",
    "kestra"
  ])
}

resource "unifi_dns_record" "a_records" {
  for_each = local.a_records

  name   = "${each.key}.${local.base_domain}"
  type   = "A"
  record = each.value
}

resource "unifi_dns_record" "srv_plg_1_cname" {
  for_each = local.srv_plg_1_cnames

  name   = "${each.key}.srv-plg-1.${local.base_domain}"
  type   = "CNAME"
  record = "srv-plg-1.${local.base_domain}"
}

resource "unifi_dns_record" "kube_cname" {
  for_each = local.kube_cnames

  name   = "${each.key}.kube.${local.base_domain}"
  type   = "CNAME"
  record = "kube.${local.base_domain}"
}

### Port-Forwards ###
resource "unifi_port_forward" "cloudflare_http" {
  for_each = toset([
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
    "104.16.0.0/13",
    "104.24.0.0/14",
    "172.64.0.0/13",
    "131.0.72.0/22"
  ])

  name                   = "cloudflare"
  protocol               = "tcp_udp"
  port_forward_interface = "wan"
  src_ip                 = each.key
  dst_port               = "443,80"
  fwd_ip                 = "10.10.20.40"
  fwd_port               = "443,80"
}

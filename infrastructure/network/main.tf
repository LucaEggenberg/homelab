locals {
  base_domain = "eggenberg.io"

  homelab_servers = {
    "srv-plg-1" = {
      ip     = "10.10.20.11"
      cnames = ["gameserver"]
    }
    "storage" = {
      ip     = "10.10.10.20"
      cnames = []
    }
    "p-kube-1" = {
      ip     = "10.10.20.21"
      cnames = []
    }
    "p-kube-2" = {
      ip     = "10.10.20.22"
      cnames = []
    }
    "p-kube-3" = {
      ip     = "10.10.20.23"
      cnames = []
    }
    "kube" = { # LB
      ip = "10.10.20.40"
      cnames = [
        "homepage",
        "argocd",
        "longhorn",
        "prowlarr",
        "sonarr",
        "radarr",
        "flaresolverr",
        "qbittorrent",
        "huntarr",
        "cleanuparr",
        "kestra",
        "grafana",
        "pdf"
      ]
    }
  }

  cloudflare_ips = [
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
  ]
}

# DNS entry for every server
resource "unifi_dns_record" "a_records" {
  for_each = local.homelab_servers

  name   = "${each.key}.${local.base_domain}"
  type   = "A"
  record = each.value.ip
}

# Generate CNAME records if defined
resource "unifi_dns_record" "cnames" {
  for_each = {
    for cname_obj in flatten([
      for server_name, server_data in local.homelab_servers :
      [
        for cname in lookup(server_data, "cnames", []) :
        {
          key       = "${server_name}-${cname}"
          host_name = server_name
          cname     = cname
        }
      ]
    ]) : cname_obj.key => cname_obj
  }

  name   = "${each.value.cname}.${each.value.host_name}.${local.base_domain}"
  type   = "CNAME"
  record = "${each.value.host_name}.${local.base_domain}"
}

### Port-Forwards ###
resource "unifi_port_forward" "cloudflare_http" {
  for_each = toset(local.cloudflare_ips)

  name                   = "cloudflare"
  protocol               = "tcp_udp"
  port_forward_interface = "wan"
  src_ip                 = each.key
  dst_port               = "443,80"
  fwd_ip                 = "10.10.20.40"
  fwd_port               = "443,80"
}

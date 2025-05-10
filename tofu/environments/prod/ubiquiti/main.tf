### Network ###
resource "unifi_network" "private_vlan" {
    name        = "Private"
    purpose     = "vlan-only"
    subnet      = "10.10.10.0/24"
    dhcp_dns    = ["10.10.10.1", "1.1.1.1", "1.0.0.1"]
    dhcp_enabled = true
    dhcp_start  = "10.10.10.50"
    dhcp_stop   = "10.10.10.254"
    vlan_id     = 1
}

resource "unifi_network" "public_vlan" {
    name        = "Public"
    purpose     = "vlan-only"
    subnet      = "10.10.20.0/24"
    dhcp_enabled = true
    dhcp_start  = "10.10.20.100"
    dhcp_stop   = "10.10.20.254"
    vlan_id     = 2
}

resource "unifi_network" "iot_vlan" {
    name        = "Public"
    purpose     = "vlan-only"
    subnet      = "10.10.20.0/24"
    dhcp_enabled = true
    dhcp_start  = "10.10.30.50"
    dhcp_stop   = "10.10.30.254"
    vlan_id     = 3
}

### Dns-Entries ###
resource "unifi_dns_record" "srv-plg-1" {
    name   = "srv-plg-1.eggenberg.io"
    type   = "A"
    record = "10.10.20.11"
}

resource "unifi_dns_record" "srv-plg-1_cname" {

    for_each = toset([
       "gameserver"
    ])

    name   = join(".", [each.key, "srv-plg-1.eggenberg.io"])
    type   = "CNAME"
    record = "srv-plg-1.eggenberg.io"
}

resource "unifi_dns_record" "kube" {
    name   = "kube.eggenberg.io"
    type   = "A"
    record = "10.10.20.40"
}

resource "unifi_dns_record" "kube_cname" {

    for_each = toset([
        "argocd",
        "longhorn",
        "prowlarr",
        "sonarr",
        "radarr"
    ])

    name   = join(".", [each.key, "kube.eggenberg.io"])
    type   = "CNAME"
    record = "kube.eggenberg.io"
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

    name        = "cloudflare"
    protocol    = "tcp_udp"
    port_forward_interface  = "wan"
    src_ip      = each.key
    dst_port    = "443,80"
    fwd_ip      = "10.10.20.40"
    fwd_port    = "443,80"
}

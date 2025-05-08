resource "unifi_network" "private_vlan" {
    name        = "Private"
    purpose     = "vlan-only"
    subnet      = "10.10.10.0/24"
    dhcp_dns    = ["10.10.10.1", "1.1.1.1", "1.0.0.1"]
    dhcp_enabled = true
    dhcp_start  = "10.10.10.50"
    vlan_id     = 10
}

resource "unifi_network" "public_vlan" {
    name        = "Public"
    purpose     = "vlan-only"
    subnet      = "10.10.20.0/24"
    dhcp_enabled = true
    dhcp_start  = "10.10.20.100" # 0-39 for static ips, 40-99 for kube-lb
    vlan_id     = 20
}

resource "unifi_network" "iot_vlan" {
    name        = "IOT"
    purpose     = "vlan-only"
    subnet      = "10.10.30.0/24"
    dhcp_enabled = true
    dhcp_start  = "10.10.30.50"
    vlan_id     = 30
}

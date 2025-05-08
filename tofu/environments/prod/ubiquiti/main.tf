module "private_vlan" {
    source      = "../../../modules/ubiquiti/network"

    name        = "Private"
    purpose     = "vlan-only"
    subnet      = "10.10.10.0/24"
    dhcp_enabled = true
    vlan_id     = 10
}

module "public_vlan" {
    source      = "../../../modules/ubiquiti/network"

    name        = "Public"
    purpose     = "vlan-only"
    subnet      = "10.10.20.0/24"
    dhcp_enabled = true
    dhcp_start  = "10.10.20.100" # 0-39 for static ips, 40-99 for kube-lb
    vlan_id     = 20
}

module "iot_vlan" {
    source      = "../../../modules/ubiquiti/network"

    name        = "IOT"
    purpose     = "vlan-only"
    subnet      = "10.10.30.0/24"
    dhcp_enabled = true
    vlan_id     = 30
}

output "private_network_id" {
    value = module.private_vlan.network_id
    description = "private network id"
}

output "public_network_id" {
    value = module.public_vlan.network_id
    description = "public network id"
}

output "iot_network_id" {
    value = module.iot_vlan.network_id
    description = "iot network id"
}
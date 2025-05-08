resource "unifi_network" "this" {
    name                = var.name
    purpose             = var.purpose

    dhcp_dns            = var.dhcp_dns
    dhcp_enabled        = var.dhcp_enabled
    dhcp_start          = var.dhcp_start
    dhcp_stop           = var.dhcp_stop
    enabled             = var.enabled
    subnet              = var.subnet
    vlan_id             = var.vlan_id
}

output "network_id" {
    value = unifi_network.this.id
    description = "ID of the created network"
}
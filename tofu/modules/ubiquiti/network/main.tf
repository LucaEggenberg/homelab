resource "unifi_network" "this" {
    name                = var.name
    purpose             = var.purpose
    subnet              = var.subnet
    dhcp_enabled        = var.dhcp_enabled
    dhcp_start          = var.dhcp_start
    dhcp_end            = var.dhcp_end
    vlan_id             = vlan_id
    gateway_ip          = var.gateway_ip
    dns_servers         = var.dns_servers
    domain_name         = var.domain_name
    auto_scale_network  = var.auto_scale_network
    dhcpv6_enabled      = var.dhcpv6_enabled
    dhcpv6_start        = var.dhcpv6_start
    dhcpv6_end          = var.dhcpv6_end
    dhcpv6_ra_enabled   = var.dhcpv6_ra_enabled
}

output "network_id" {
    value = unifi_network.this.id
    description = "ID of the created network"
}
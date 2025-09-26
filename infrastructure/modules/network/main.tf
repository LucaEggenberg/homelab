terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}


resource "unifi_network" "this" {
  name          = var.name
  site          = var.site
  purpose       = "corporate"
  network_group = "LAN"

  subnet    = var.subnet
  vlan_id   = var.vlan_id

  dhcp_enabled        = true
  dhcp_lease          = 86400
  dhcp_relay_enabled  = false
  dhcp_start          = var.dhcp_start
  dhcp_stop           = var.dhcp_stop
  dhcp_dns            = var.dhcp_dns
  multicast_dns       = var.multicast_dns

  
  dhcp_v6_dns_auto           = true
  dhcp_v6_start              = "::2"
  dhcp_v6_stop               = "::7d1"
  dhcpd_boot_enabled         = false
  igmp_snooping              = false
  internet_access_enabled    = true
  ipv6_interface_type        = "none"
  ipv6_pd_start              = "::2"
  ipv6_pd_stop               = "::7d1"
  ipv6_ra_enable             = true
  ipv6_ra_preferred_lifetime = 14400
  ipv6_ra_priority           = "high"

  lifecycle {
    prevent_destroy = true

    # Ignore because of bug that wipes all zone-based rules on network create/update
    # https://github.com/filipowm/terraform-provider-unifi/issues/94
    ignore_changes = all 
  }
}
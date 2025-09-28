terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}

resource "unifi_firewall_zone_policy" "this" {
  site = var.site
  name = var.name
  action = var.action
  enabled = true
  logging = var.logging
  auto_allow_return_traffic = var.auto_allow_return

  source = {
      zone_id = var.src_zone_id
      ip_group_id = var.src_group_id
      port_group_id = var.src_port_group_id
  }

  destination = {
      zone_id = var.dst_zone_id
      ip_group_id = var.dst_group_id
      port_group_id = var.dst_port_group_id
      web_domains = var.web_domains
  }

  lifecycle {
    ignore_changes = [
      index
    ]
  }
}
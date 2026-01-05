terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}

resource "unifi_firewall_zone_policy" "this" {
  site    = var.site
  name    = var.name
  index   = var.index
  action  = var.action
  enabled = true
  logging = var.logging

  source = {
      zone_id       = var.src_zone_id
      ip_group_id   = var.src_group_id
      ips           = var.src_ips
      port_group_id = var.src_port_group_id
      port          = var.src_port
  }

  destination = {
      zone_id       = var.dst_zone_id
      ip_group_id   = var.dst_group_id
      ips           = var.dst_ips
      port_group_id = var.dst_port_group_id
      port          = var.dst_port
      web_domains   = var.web_domains
  }

  protocol   = var.protocol
  ip_version = var.ip_version

  auto_allow_return_traffic = var.auto_allow_return

  lifecycle {
    precondition {
      condition     = !(var.src_group_id != null && var.src_ips != null)
      error_message = "src_group_id and src_ips are mutually exclusive"
    }
    precondition {
      condition     = !(var.dst_group_id != null && var.dst_ips != null)
      error_message = "dst_group_id and dst_ips are mutually exclusive"
    }
    precondition {
      condition     = !(var.src_port_group_id != null && var.src_port != null)
      error_message = "src_port_group_id and src_port are mutually exclusive"
    }
    precondition {
      condition     = !(var.dst_port_group_id != null && var.dst_port != null)
      error_message = "dst_port_group_id and dst_port are mutually exclusive"
    }

    ignore_changes = [
      index
    ]
  }
}
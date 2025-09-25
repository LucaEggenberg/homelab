terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}


resource "unifi_firewall_group" "this" {
    name    = var.name
    site    = var.site
    type    = var.type
    members = var.members
}

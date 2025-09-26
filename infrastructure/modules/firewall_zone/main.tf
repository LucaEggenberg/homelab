terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}


resource "unifi_firewall_zone" "this" {
    name     = var.name
    
    lifecycle {
      ignore_changes = [ networks ]
    }
}
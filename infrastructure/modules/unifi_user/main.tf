terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}


resource "unifi_user" "this" {
    mac                    = var.mac
    name                   = var.name
    fixed_ip               = var.ip
    blocked                = false
    skip_forget_on_destroy = true
    allow_existing         = true
}

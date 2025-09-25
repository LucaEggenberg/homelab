terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}


resource "unifi_port_forward" "this" {
  name                   = var.name
  protocol               = var.protocol
  port_forward_interface = "wan"
  src_ip                 = var.source_ip
  dst_port               = var.port
  fwd_ip                 = var.destination_ip
  fwd_port               = var.port
}

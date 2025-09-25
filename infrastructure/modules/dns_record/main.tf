terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = ">=1.0.0"
    }
  }
}

resource "unifi_dns_record" "this" {
  name   = "${var.host_name}.${var.domain}"
  type   = "A"
  record = var.host_ip
}

resource "unifi_dns_record" "cnames" {
  for_each = toset(var.cnames)

  name   = "${each.value}.${var.host_name}.${var.domain}"
  type   = "CNAME"
  record = unifi_dns_record.this.name
} 
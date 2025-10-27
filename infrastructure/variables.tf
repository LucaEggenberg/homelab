variable "domain" {
  description   = "Base DNS domain"
  type          = string
  default       = "eggenberg.io"
}

variable "unifi_site" {
  type = string
  default = "default"
}

variable "debian_template_name" {
    type = string
    default = "debian-cloud-template"
    description = "vm template for debian"
}

variable "nixos_template_name" {
    type = string
    default = "nixos-template"
    description = "vm template for nixOS"
}

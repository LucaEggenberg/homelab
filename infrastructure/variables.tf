variable "domain" {
  description   = "Base DNS domain"
  type          = string
  default       = "eggenberg.io"
}

variable "unifi_site" {
  type = string
  default = "default"
}

variable "debian_template_id" {
    type = number
    default = 9001
    description = "vm template for debian"
}

variable "nixos_template_id" {
    type = number
    default = 9002
    description = "vm template for debian"
}

variable "site" {
    type = string
    description = "unifi site name"
    default = "default"
}

variable "name" {
    type = string
    description = "policy name"
}

variable "action" {
    type = string
    description = "action: BLOCK or ALLOW"
}

variable "src_zone_id" {
    type = string
    description = "source zone id"
}

variable "dst_zone_id" {
    type = string
    description = "destination zone id"
}

variable "src_group_id" {
    type = string
    description = "source firewall ip group"
}

variable "dst_group_id" {
    type = string
    description = "destination firewall ip group"
}

variable "port_group_id" {
    type = string
    description = "firewall port group"
}

variable "logging" {
    type = bool
    default = false
}

variable "auto_allow_return" {
    type = bool
    default = true
}
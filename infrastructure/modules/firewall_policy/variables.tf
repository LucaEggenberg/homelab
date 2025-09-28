variable "site" {
    type = string
    description = "unifi site name"
    default = "default"
}

variable "name" {
    type = string
    description = "policy name"
}

variable "index" {
    type = number
    description = "index (priority)"
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
    default = null
}

variable "src_port_group_id" {
    type = string
    description = "source port group"
    default = null
}

variable "dst_group_id" {
    type = string
    description = "destination firewall ip group"
    default = null
}

variable "dst_port_group_id" {
    type = string
    description = "destination port group"
    default = null
}

variable "src_port" {
    type = number
    description = "source port"
    default = null
}

variable "dst_port" {
    type = number
    description = "destination port"
    default = null
}

variable "web_domains" {
    type = list(string)
    description = "if dst_zone is external: domains for the rule"
    default = null
}

variable "protocol" {
    type = string
    description = "protocol"
    default = null
}

variable "ip_version" {
    type = string
    description = "ip version (IPV4, IPV6 or BOTH)"
}

variable "logging" {
    type = bool
    default = false
}

variable "auto_allow_return" {
    type = bool
    default = true
}
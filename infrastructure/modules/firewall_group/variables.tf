variable "site" {
    type = string
    description = "unifi site name"
    default = "default"
}

variable "name" {
    type = string
    description = "firewall group name"
}

variable "type" {
    type = string
    description = "group type: address-group or port-group"
}

variable "members" {
    type = list(string)
    description = "members (ip, ip-range, port, port-range)"
}
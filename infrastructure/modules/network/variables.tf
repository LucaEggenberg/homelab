variable "site" {
    type = string
    description = "unifi site name"
    default = "default"
}

variable "name" {
  type        = string
  description = "network / vlan name"
}

variable "subnet" {
  type        = string
  description = "cidr of the subnet"
}

variable "vlan_id" {
  type        = number
  default     = null
  description = "unique id for the number"
}

variable "dhcp_start" {
  type        = string
  description = "dhcp range start"
}

variable "dhcp_stop" {
  type        = string
  description = "dhcp range stop"
}

variable "dhcp_dns" {
  type        = list(string)
  default     = []
  description = "dns servers assigned by dhcp"
}

variable "multicast_dns" {
  type        = bool
  default     = true
  description = "forward multicast traffic for iot device discovery"
}

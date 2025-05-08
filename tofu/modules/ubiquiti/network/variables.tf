variable "name" {
    type        = string
    description = "network name"
}

variable "purpose" {
    type        = string
    description = "network-purpose (guest, lan, vlan-only)"
    default     = "vlan-only"
}

variable "subnet" {
    type        = string
    description = "subnet (eg. 192.168.1.1/24)"
}

variable "vlan_id" {
    type        = number
    description = "vlan id"
}

variable "dhcp_enabled" {
    type        = bool
    description = "activate dhcp for this network"
    default     = false
}

variable "dhcp_start" {
    type        = string
    description = "dhcp start address"
    default     = null 
}

variable "dhcp_stop" {
    type        = string
    description = "dhcp end address"
    default     = null
}

variable "dhcp_dns" {
  type        = list(string)
  description = "dns servers"
  default     = []
}

variable "enabled" {
  type        = bool
  description = "dns servers"
  default     = true
}

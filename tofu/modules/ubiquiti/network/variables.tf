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

variable "dhcp_end" {
    type        = string
    description = "dhcp end address"
    default     = null
}

variable "gateway_ip" {
  type        = string
  description = "gatway address"
  default     = null
}

variable "dns_servers" {
  type        = list(string)
  description = "dns servers"
  default     = []
}

variable "domain_name" {
  type        = string
  description = "network domain name"
  default     = null
}

variable "auto_scale_network" {
  type        = bool
  description = "auto scale network"
  default     = false
}

variable "dhcpv6_enabled" {
  type        = bool
  description = "dhcpv6 enabled for network"
  default     = false
}

variable "dhcpv6_start" {
  type        = string
  description = "dhcpv6 start address"
  default     = null
}

variable "dhcpv6_end" {
  type        = string
  description = "dhcpv6 end address"
  default     = null
}

variable "dhcpv6_ra_enabled" {
  type        = bool
  description = "dhcpv6 router advertisements enabled"
  default     = false
}
variable "name" {
    type = string
    description = "vm/host name"
}

variable "network" {
    type = object({
      vlan_id = number
      gateway = string
      ip = string
    })
    description = "network settings"
}

variable "node" {
    type = string
    default = "p-prmx-1"
    description = "name of the node"
}

variable "template" {
    type = string
    description = "vm template id"
}

variable "memory" {
    type = number
    default = 1024
    description = "memory (MiB)"
}

variable "disk_size" {
    type = string
    default = "10G"
    description = "disk size"
}

variable "storage_pool" {
    type = string
    default = "zfs-vm-data"
    description = "storage pool name"
}

variable "ssh_keys" {
    type = list(string)
    description = "list of ssh public keys"
    default = []
}

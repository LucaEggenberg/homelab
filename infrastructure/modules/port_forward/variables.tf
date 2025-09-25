variable "name" {
    type = string
    description = "policy name"
}

variable "protocol" {
    type = string
    description = "protocol tcp, udp or tcp_udp"
    default = "tcp"
}

variable "source_ip" {
    type = string
    description = "source ip / cidr"
    default = null
}

variable "port" {
    type = string
    description = "comma separated list of ports"
}

variable "destination_ip" {
    type = string
    description = "ip to forward to"
}
variable "domain" {
  type = string
  description = "dns domain"
}

variable "host_name" {
    type = string
    description = "name of the host"
}

variable "host_ip" {
    type = string
    description = "ip of the host"
}

variable "cnames" {
    type = list(string)
    description = "list of cnames associated with this host"
    default = []
}
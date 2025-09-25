variable "name" {
    type = string
    description = "zone name"
}

variable "network_ids" {
    type = list(string)
    description = "member network ids"
}

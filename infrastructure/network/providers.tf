terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = "1.0.0"
    }
  }
}

provider "unifi" {
  # Configuration options
  api_key = var.api_key
  api_url = "https://10.10.10.1/"
  allow_insecure = true
}
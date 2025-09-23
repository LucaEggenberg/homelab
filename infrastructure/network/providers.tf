terraform {
  required_providers {
    unifi = {
      source = "filipowm/unifi"
      version = "1.0.0"
    }
  }
}

provider "unifi" {
  # UNIFI_API
  # UNIFI_API_KEY
  allow_insecure = true
}
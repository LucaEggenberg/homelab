terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "3.0.2-rc04"
        }
        unifi = {
            source = "filipowm/unifi"
            version = "1.0.0"
        }
    }
}

provider "proxmox" {
    # PM_API_TOKEN_SECRET
    pm_api_token_id = "tofu@pam!tofu-token"
    pm_api_url = "https://p-prmx-1.eggenberg.io:8006/api2/json"
    pm_tls_insecure     = false   
}

provider "unifi" {
    # UNIFI_API_KEY
    api_url = "https://10.10.10.1/"
    allow_insecure = true
}

terraform {
  required_providers {
    proxmox = {
        source = "telmate/proxmox"
        version = "3.0.2-rc04"
    }
  }
}

resource "proxmox_vm_qemu" "server" {
    name            = var.name
    target_node     = var.node
    clone           = var.template

    memory          = var.memory
    agent   = 1
    os_type = "cloud-init"
    onboot  = true
    scsihw  = "virtio-scsi-pci"

    disk {
        slot    = "scsi0"
        size    = var.disk_size
        storage = var.storage_pool
        type    = "disk"
    }

    network {
        id      = 0
        bridge  = "vmbr0"
        model   = "virtio"
        tag     = var.network.vlan_id
    }

    ipconfig0   = "ip=${var.network.ip}/24,gw=${var.network.gateway}"    
    sshkeys     = join("\n", var.ssh_keys)
}
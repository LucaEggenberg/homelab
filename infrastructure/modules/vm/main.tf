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
  agent           = 1
  clone           = var.template
  full_clone      = true

  onboot  = true

  bios     = "seabios"
  cores    = var.cpus
  sockets  = var.sockets
  cpu_type = "host"
  memory   = var.memory
  balloon  = 1024 #minimum memory

  scsihw   = "virtio-scsi-single"

  network {
      id      = 0
      bridge  = "vmbr0"
      model   = "virtio"
      tag     = var.network.vlan_id
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.storage_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = var.storage_pool
          size = var.disk_size
          iothread =  true
          discard = true
        }
      }
    }
  }

  ipconfig0   = "ip=${var.network.ip}/24,gw=${var.network.gateway}"    
  sshkeys     = join("\n", var.ssh_keys)
}
locals {
    networks            = yamldecode(file("${path.module}/data/networks.yml"))["networks"]
    zones               = yamldecode(file("${path.module}/data/zones.yml"))["zones"]
    firewall_groups     = yamldecode(file("${path.module}/data/firewall_groups.yml"))["groups"]
    firewall_policies   = yamldecode(file("${path.module}/data/firewall_policies.yml"))["policies"]
    cloudflare_cidrs    = yamldecode(file("${path.module}/data/cloudflare_cidrs.yml"))["cloudflare_cidrs"]

    network_ids = { for key, group_ref in module.networks : upper(key) => group_ref.id }
    zone_ids    = { for key, group_ref in module.zones : upper(key) => group_ref.id }
    group_ids   = { for key, group_ref in module.firewall_groups : upper(key) => group_ref.id }

    hosts       = yamldecode(file("${path.module}/data/hosts.yml"))["hosts"]
    hosts_map   = { for s in local.hosts : s.id => s }

    vm_templates = {
        debian = var.debian_template_name
        nixos = var.nixos_template_name
    }

    ssh_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLTvjhfe4YWatJ3Y19rYj8YHGmiki5AMqDykfkFH5/f"
    ]
}

module "networks" {
    source = "./modules/network"
    for_each = local.networks

    site        = var.unifi_site
    name        = each.value.name
    subnet      = each.value.subnet
    vlan_id     = each.value.vlan_id
    dhcp_start  = each.value.dhcp_start
    dhcp_stop   = each.value.dhcp_stop
    dhcp_dns    = lookup(each.value, "dhcp_dns", [])
    multicast_dns = lookup(each.value, "multicast_dns", false)
}

module "zones" {
    source = "./modules/firewall_zone"
    for_each = local.zones

    name = each.value.name
}

module "firewall_groups" {
    source = "./modules/firewall_group"
    for_each = local.firewall_groups    

    site    = var.unifi_site
    name    = each.key
    type    = each.value.type
    members = each.value.members
}

module "policies" {
    source = "./modules/firewall_policy"
    for_each = local.firewall_policies

    site    = var.unifi_site
    name    = each.value.name
    action  = each.value.action

    src_zone_id  = local.zone_ids[upper(each.value.src_zone)]
    dst_zone_id  = local.zone_ids[upper(each.value.dst_zone)]

    src_group_id        = try(local.group_ids[upper(each.value.src_group)], null)
    dst_group_id        = try(local.group_ids[upper(each.value.dst_group)], null)

    src_port_group_id   = try(local.group_ids[upper(each.value.src_ports)], null)
    dst_port_group_id   = try(local.group_ids[upper(each.value.dst_ports)], null)

    web_domains         = lookup(each.value, "web_domains", null)

    logging             = lookup(each.value, "logging", false)
    auto_allow_return   = try(each.value.auto_allow_return, true)
}

module "static_leases" {
    source = "./modules/unifi_user"

    for_each = {
        for s in local.hosts : s.id => s
        if try (lookup(s, "mac", null)) != null
    }

    mac  = each.value.mac
    name = each.value.host
    ip   = each.value.ip
}

module "cf_port_forwards" {
    source = "./modules/port_forward"
    for_each    = toset(local.cloudflare_cidrs)

    name        = "cf-${replace(each.key, "/", "-")}-https"
    protocol    = "tcp"
    port        = "443,80"
    destination_ip = local.hosts_map["kube"].ip
    source_ip   = each.key
}

module "vms" {
    source = "./modules/vm"
    for_each = {
        for id, s in local.hosts_map : id => s if s.type == "virtual"
    }

    name            = each.value.host
    tags            = join(",", lookup(each.value.proxmox, "tags", [ "untagged" ]))
    template        = local.vm_templates[each.value.proxmox.template]
    memory          = lookup(each.value.proxmox, "memory", 1024)
    cpus            = lookup(each.value.proxmox, "cpus", 1)
    disk_size       = lookup(each.value.proxmox, "disk_size", "10G")
    storage_pool    = lookup(each.value.proxmox, "storage_pool", "zfs-vm-data")
    node            = lookup(each.value.proxmox, "node", "p-prmx-1")
    ssh_keys        = local.ssh_keys

    network = {
        ip      = each.value.ip
        vlan_id = local.networks[each.value.proxmox.vlan].vlan_id
        gateway = local.networks[each.value.proxmox.vlan].gateway
    }
}

module "dns_records" {
    source  = "./modules/dns_record"
    for_each = local.hosts_map

    domain      = var.domain
    host_name   = each.value.host
    host_ip     = each.value.ip
    cnames      = lookup(each.value, "cnames", [])
}

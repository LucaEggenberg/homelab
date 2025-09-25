
# DNS RECORD
tofu import 'module.dns_records["p-kube-2"].unifi_dns_record.this' default:681f91e9989bcd3555b13e04
tofu import 'module.dns_records["p-kube-3"].unifi_dns_record.this' default:681f91e9989bcd3555b13e0d
tofu import 'module.dns_records["p-kube-1"].unifi_dns_record.this' default:681f91e9989bcd3555b13e17
tofu import 'module.dns_records["kube"].unifi_dns_record.this' default:681f91e9989bcd3555b13e21
tofu import 'module.dns_records["p-storage-1"].unifi_dns_record.this' default:68d2db4b0635d1504b4ab27c
tofu import 'module.dns_records["p-prmx-1"].unifi_dns_record.this' default:68d3d9a00635d1504b4ad25d

# cnames
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["sonarr"]' default:681f91e9989bcd3555b13dfd
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["argocd"]' default:681f91e9989bcd3555b13dff
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["longhorn"]' default:681f91e9989bcd3555b13e06
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["prowlarr"]' default:681f91e9989bcd3555b13e16
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["radarr"]' default:681f91e9989bcd3555b13e1c
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["flaresolverr"]' default:6821b936989bcd3555b18e29
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["qbittorrent"]' default:6821b936989bcd3555b18e2b
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["kestra"]' default:682ef626989bcd3555b385d3
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["homepage"]' default:684f137c85ef6b3e9084baf2
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["pdf"]' default:68ab04f99b633c059bb964b2
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["huntarr"]' default:68cff1c20635d1504b4a56a6
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["cleanuparr"]' default:68d01f2a0635d1504b4a5c65
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["api.minio"]' default:68d29c530635d1504b4aaa3d
tofu import 'module.dns_records["kube"].unifi_dns_record.cnames["ui.minio"]' default:68d2a2a80635d1504b4aaaf9

# Groups
tofu import 'module.firewall_groups["nas_ips"].unifi_firewall_group.this' 684b08b3e0726e516bbda091
tofu import 'module.firewall_groups["homeassistant_ips"].unifi_firewall_group.this' 684b093be0726e516bbda0bc
tofu import 'module.firewall_groups["kube_ips"].unifi_firewall_group.this' 684b14fde0726e516bbda250
tofu import 'module.firewall_groups["smb_nfs_ports"].unifi_firewall_group.this' 684b17c8e0726e516bbda2ac
tofu import 'module.firewall_groups["homeassistant_ports"].unifi_firewall_group.this' 684c2b7de0726e516bbdc5b2

# Policies
tofu import 'module.policies["kube_smb_nfs"].unifi_firewall_zone_policy.this' default:684b15c9e0726e516bbda275
tofu import 'module.policies["kube_haos_https"].unifi_firewall_zone_policy.this' default:684b18d0e0726e516bbda2f8

# Zone
tofu import 'module.zones["internal"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df736
tofu import 'module.zones["external"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df737
tofu import 'module.zones["gateway"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df738
tofu import 'module.zones["vpn"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df739
tofu import 'module.zones["hotspot"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df73a
tofu import 'module.zones["dmz"].unifi_firewall_zone.this' default:67c0a34b5d722d0f495df73b
tofu import 'module.zones["restricted"].unifi_firewall_zone.this' default:68d2ed9d0635d1504b4ab4df

# Network
tofu import 'module.networks["private"].unifi_network.this' 6724ffec8a9cad6cf6065f50
tofu import 'module.networks["public"].unifi_network.this'  6724ff5bf24a5f421b54136f
tofu import 'module.networks["iot"].unifi_network.this'     672500a4f24a5f421b541389
tofu import 'module.networks["restricted"].unifi_network.this' 68d2ed800635d1504b4ab4d8

# Forward
tofu import 'module.cf_port_forwards["108.162.192.0/18"].unifi_port_forward.this' default:681f91e9989bcd3555b13def
tofu import 'module.cf_port_forwards["103.31.4.0/22"].unifi_port_forward.this' default:681f91e9989bcd3555b13df1
tofu import 'module.cf_port_forwards["197.234.240.0/22"].unifi_port_forward.this' default:681f91e9989bcd3555b13df3
tofu import 'module.cf_port_forwards["131.0.72.0/22"].unifi_port_forward.this' default:681f91e9989bcd3555b13df5
tofu import 'module.cf_port_forwards["188.114.96.0/20"].unifi_port_forward.this' default:681f91e9989bcd3555b13df7
tofu import 'module.cf_port_forwards["141.101.64.0/18"].unifi_port_forward.this' default:681f91e9989bcd3555b13df9
tofu import 'module.cf_port_forwards["173.245.48.0/20"].unifi_port_forward.this' default:681f91e9989bcd3555b13dfb
tofu import 'module.cf_port_forwards["162.158.0.0/15"].unifi_port_forward.this' default:681f91e9989bcd3555b13e01
tofu import 'module.cf_port_forwards["198.41.128.0/17"].unifi_port_forward.this' default:681f91e9989bcd3555b13e03
tofu import 'module.cf_port_forwards["104.24.0.0/14"].unifi_port_forward.this' default:681f91e9989bcd3555b13e0b
tofu import 'module.cf_port_forwards["190.93.240.0/20"].unifi_port_forward.this' default:681f91e9989bcd3555b13e0e
tofu import 'module.cf_port_forwards["104.16.0.0/13"].unifi_port_forward.this' default:681f91e9989bcd3555b13e0f
tofu import 'module.cf_port_forwards["172.64.0.0/13"].unifi_port_forward.this' default:681f91e9989bcd3555b13e12
tofu import 'module.cf_port_forwards["103.21.244.0/22"].unifi_port_forward.this' default:681f91e9989bcd3555b13e15
tofu import 'module.cf_port_forwards["103.22.200.0/22"].unifi_port_forward.this' default:681f91e9989bcd3555b13e18

# User
tofu import 'module.static_leases["p-kube-2"].unifi_user.this' 6807e666876a585aa0388c19
tofu import 'module.static_leases["p-kube-3"].unifi_user.this' 6807e88f876a585aa0388c69
tofu import 'module.static_leases["p-kube-1"].unifi_user.this' 6807d0fe876a585aa0388943
tofu import 'module.static_leases["p-storage-1"].unifi_user.this' 6800edca876a585aa0379452
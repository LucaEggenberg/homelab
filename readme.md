[![Nix](https://img.shields.io/badge/Nix-0F2733?&style=plasticc&logo=nixos&logoColor=5277C3)](https://nixos.org/)
[![Terraform](https://img.shields.io/badge/Terraform-0F2733?&style=plasticc&logo=terraform&logoColor=844FBA)](https://developer.hashicorp.com/terraform)
[![OpenTofu](https://img.shields.io/badge/OpenTofu-0F2733?&style=plasticc&logo=opentofu&logoColor=F0CD13)](https://opentofu.org/docs/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-326CE5?&style=plastic&logo=kubernetes&logoColor=white)](https://kubernetes.io/docs/home/)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-0F2733?style=plastic&logo=Argo&logocolor=EF7B4D)](https://argo-cd.readthedocs.io/en/stable/)

# Homelab

Documenting my homelab journey and moving towards a single source of truth

## Overview
### Technologies
---
This repo is built around a declarative and Gitops driven stack:
- Kubernetes (k3s)
    - ArgoCD for application lifecycle management
    - Sealed-Secrets Gitops friendly kubernetes secret management.
- OpenTofu for infrastructure provisioning
- NixOS for host and vm configuration
- Proxmox as a virtualization platform
- TrueNas for network-attached storage

## Architecture
### OS
---
A single monolithic NixOS flake under `./nixos/flake.nix` defines the complete system configuration for both physical and virtual hosts.

All machines are configured declaratively through this flake, including base system-settings, services and user-accounts.

### Provisioning
---
OpenTofu is used to interface with Unifi for network configuration and with Proxmox or virtual machine lifecycle management.

Infrastructure definitions are abstracted into yaml data files. These act as a high-level, provider-agnostic description of resources, which are then translated into OpenTofu resources. This approach reduces code duplication and limits direct exposure to provider-specific implementation details.

#### **`./infrastructure/main.tf`**
Responsible for converting yaml resources under `./infrastructure/data/` into OpenTofu resources.

#### **`./infrastructure/data/hosts.yml`**
Represents a host on the network, either physical or virtual.

Host definitinos automatically result in:
- A static DHCP lease when a mac-address is provided
- A DNS A record for the hostname
- DNS CNAME records for each configured cname and subdomain

For virtual hosts, the corresponding virtual machine is also created and managed in Proxmox.

example: 
```yaml
# physical machine
- id: p-name-1 # unique resource name
  type: physical
  host: p-name-1 # hostname
  ip: "0.0.0.0"
  mac: ""
  cnames: [] # list of cnames for internal dns
  subdomains: [] # subdomains in internal dns
  meta:
    role: server # tags for organisation

# virtual machine
- id: v-name-1 # unique resource name
  type: virtual
  host: v-name-1
  ip: "0.0.0.0"
  cnames: []
  proxmox: # proxmox settings
    template: nixos
    bios: ovmf
    vlan: private # target vlan
    memory: 2048
    cpus: 1
    tags:
      - virtual-machine
  meta:
    role: virtual-machine
```

#### **`./infrastructure/data/zones.yml`**
Holds available Zones from Unifi. This is a readonly collection for id resolution. No resources are created, modified or deleted.

#### **`./infrastructure/data/networks.yml`**
Holds Vlans/Networks from Unifi. This is a readonly collection for id resolution. No resources are created, modified or deleted.

#### **`./infrastructure/data/firewall_groups.yml`**
Holds reusable groups to be used in firewall policies.

example:
```yaml
# ip group
nas_ip:
  type: address-group
  members: # can hold ranges, multiple entries or CIDRs
    - "10.10.10.20" 

# port group
web_ports:
  type: port-group
  members: # can hold ranges or multiple entries
    - "80"
    - "443"
```

#### **`./infrastructure/data/firewall_policies.yml`**
Represents Unifi Zone-Policy records.

example:
```yaml
wan_allow_traefik_public_https:
  name: "WAN -> Traefik Public (HTTP/HTTPS)"
  action: "ALLOW"
  src_zone: "external" # from zones yaml
  dst_zone: "dmz" # from zones yaml
  dst_group: "traefik_public_vip" # destination ip group
  dst_ip: NULL # for directly specifying single ip
  dst_ports: "web_ports" # for groups
  dst_port: NULL # for directly assigining single port
  logging: true
  auto_allow_return: true
```

### Network Topology
---
#### Vlans
| Network | Zone | Subnet |
| :--- | :--- | :--- |
| Private | Internal | 10.10.10.0/24 |
| Public | DMZ | 10.10.20.0/24 |
| IOT | Hotspot | 10.10.30.0/24 |
| Management | Internal | 10.10.11.0/24 |

#### Hosts
| Host | IP | Description |
| :--- | :--- | :--- |
| p-kube-1 | 10.10.20.21 | k3s node 1 |
| p-kube-2 | 10.10.20.22 | k3s node 2 |
| p-kube-3 | 10.10.20.23 | k3s node 3 |
| p-prmx-1 | 10.10.10.5 | Proxmox |
| p-storage-1 | 10.10.10.20 | Truenas |
| v-gitlab-runner-1 | 10.10.10.6 | NixOS gitlab runner |
| v-jellyfin-1 | 10.10.20.10 | Jellyfin vm with gpu passthrough |
| v-immich-1 | 10.10.20.11 | Immich vm |

#### Services
| Service | IP | Description |
| :--- | :--- | :--- |
| kube-public | 10.10.10.40 | public/external kube vip |
| kube-internal | 10.10.10.50 | internal kube vip |
| ILO | 10.10.11.222 | HPE ILO (for p-prmx-1) |

### Kubernetes
---
Kubernetes Apps follow the ArgoCD App of Apps pattern. 

An ApplicationSet resource defined in `./argocd/applicationset.yml` ensures all application definitions under `./argocd/applications/` are continusously reconciled.

These Application resources point to `./applications/kubernetes/` as a source, where all manifests will be created.

## Usage
Clone the repository:
```sh
git clone ssh://git@git.eggenberg.io:2222/luca/homelab.git
cd homelab
```

### OpenTofu
---
Create .env file:
```sh
cp .env.template .env
```

Use:
```sh
tofu init
tofu plan
tofu apply
``` 

### Kubernetes
---
#### Applications / Services
Kubernetes Apps are managed through ArgoCD.

ArgoCD Application-Definitions live under `./argocd/applications/`

Manifests are managed under `./applications/kubernetes/<namespace>/`

#### Secrets
To allow kubernetes secrets to be stored in Git, they are encrypted using sealed-secrets.

1: Create the secret as usual
2: Seal:
```sh
kubeseal --controller-name sealed-secrets --format yaml < secret.yml > sealed-secret.yml

# or if kubeseal is not installed
nix-shell -p kubeseal --run "kubeseal --controller-name sealed-secrets --format yaml < secret.yml > sealed-secret.yml"
```

### NixOS
#### Build
All Nix-Hosts include a local administrator usesr (luca) and a dedicated gitlab user for automated rebuilds.

To apply changes run:
```sh
cd nixos
nixos-rebuild switch --target-host 0.0.0.0 --use-remote-sudo --flake .#configname
```

#### Secrets
Nix-Secrets are encrypted using sops-nix. The secrets are grouped into 'Domains' so that they don't need to be reencrypted for every new host.

Ed25519 SSH-Keys are stored in 1password and converted to age for the clients to decrypt their secrets.

Convert SSH-Key to age:
```sh
nix-shell -p ssh-to-age --run 'ssh-to-age -private-key -i ./path/to/privkey > ./path/to/keys.txt'
```

On the host: ensure target directory exists
```sh
sudo mkdir -pv /var/lib/sops
```

Append new Domain-key
```sh
cat /path/to/keys.txt | ssh <user>@<host> 'sudo tee -a /var/lib/sops/keys.txt'
```

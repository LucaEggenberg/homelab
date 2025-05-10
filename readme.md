# HomeLab

Documenting my homelab journey.

Exploring the world of IT-Infrastructure and expanding my knowledge this repository is my learning ground. This repository is meant to at some point completely automate my infrastructure and act as a single source of truth.

---

## <ins>Structure:</ins>

## `/tofu` ![terraform](https://img.shields.io/badge/Terraform-0F2733?&style=plasticc&logo=terraform&logoColor=844FBA) ![opentofu](https://img.shields.io/badge/OpenTofu-0F2733?&style=plasticc&logo=opentofu&logoColor=F0CD13)
Contains OpenTofu configurations for managing infrastructure components:

-   Network definitions
    - VLans
    - Port-forwards
-   DNS configurations 

### Usage
1. initialize `tofu init`
2. plan changes `tofu plan`
3. apply changes `tofu apply`
4. refer to <a href="https://opentofu.org/docs/">documentation</a>

## `/docker` ![docker](https://img.shields.io/badge/docker-1C63ED?&style=plastic&logo=docker&logoColor=white)
Includes `docker-compose` projects deployed to a dedicated server for:

-   Testing environments
-   Computational tasks

### Usage
1. Clone / Pull latest changes `git clone` / `git pull`
2. navigate to desired container / stack
3. spin up `docker-compose up -d`

## `/kubernetes` ![kubernetes](https://img.shields.io/badge/kubernetes-326CE5?&style=plastic&logo=kubernetes&logoColor=white) ![argocd](https://img.shields.io/badge/ArgoCD-0F2733?style=plastic&logo=Argo&logocolor=EF7B4D)
Features Kubernetes manifests and configurations related to container orchestration.

### Usage
1. Install Argocd according to <a href="https://argo-cd.readthedocs.io/en/stable/">docs</a>
2. Cd into kubernetes/argocd
3. Apply applicationset `kubectl apply -f applicationset.yml` 

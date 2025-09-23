# Homelab

[![Terraform](https://img.shields.io/badge/Terraform-0F2733?&style=plasticc&logo=terraform&logoColor=844FBA)](https://opentofu.org/docs/) 
[![OpenTofu](https://img.shields.io/badge/OpenTofu-0F2733?&style=plasticc&logo=opentofu&logoColor=F0CD13)](https://opentofu.org/docs/)
[![Docker](https://img.shields.io/badge/docker-1C63ED?&style=plastic&logo=docker&logoColor=white)](https://docs.docker.com/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-326CE5?&style=plastic&logo=kubernetes&logoColor=white)](https://kubernetes.io/docs/home/) 
[![ArgoCD](https://img.shields.io/badge/ArgoCD-0F2733?style=plastic&logo=Argo&logocolor=EF7B4D)](https://argo-cd.readthedocs.io/en/stable/)
[![Kestra](https://img.shields.io/badge/Kestra-1D77FF?style=plastic&logo=kestra&logoColor=white)](https://kestra.io/docs)

Documenting my homelab journey and moving towards a single source of truth

---

## Repository Structure

### `infrastructure/`
Core infrastructure components provisioned and managed using OpenTofu

each subdirectory represents an enclosed domain.

- **`network/`**: Contains network and dns configuration
- **`kubernetes/`**:Contains configuration and provisioning of K8s nodes
- **`modules/`**: OpenTofu modules

### `applications/`
Defines the applications deployed in my homelab

- **`kubernetes/`**: Contains Kubernetes manifests and Helm charts managed by ArgoCD
* **`docker/`**: Contains docker-compose definitions for apps deployed outside k8s

### `argocd/`
Declarative configurations for ArgoCD

- **`applications/`**: ArgoCD Application definitions

### `automation/`
workflows, scripts and other automation-logic

- **`kestra/`**: Kestra workflow definitions
module "network" {
    source = "./network"

    base_domain = "eggenberg.io"
    
    hosts = {
        "p-storage-1" = { ip = "10.10.10.20", cnames = [] }
        
        "p-kube-1" = { ip = "10.10.20.21", cnames = [] }
        "p-kube-2" = { ip = "10.10.20.22", cnames = [] }
        "p-kube-3" = { ip = "10.10.20.23", cnames = [] }
        "kube" = { #LB
            ip = "10.10.20.40", 
            cnames = [
                "homepage",
                "argocd",
                "longhorn",
                "prowlarr",
                "sonarr",
                "radarr",
                "flaresolverr",
                "qbittorrent",
                "huntarr",
                "cleanuparr",
                "kestra",
                "pdf",
                "api.minio",
                "ui.minio"
            ] 
        }
    }
}
terraform {
  backend "s3" {
    bucket = "tofu-state" 
    key    = "homelab/terraform.tfstate"
    region = "ch"
    endpoint = "https://api.minio.kube.eggenberg.io"

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
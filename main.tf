terraform {
  required_providers {
    pf9 = {
      source  = "platform9/pf9"
      version = "0.1.5"
    }
  }
}

variable "azure_client_secret" {
  type = string
}

variable "pf9_password" {
  type = string
}

provider "pf9" {
  du_username = "kellystuard@gmail.com"
  du_password = var.pf9_password
  du_fqdn     = "pmkft-1645583018-86454.platform9.io"
  du_tenant   = "service"
}

resource "pf9_azure_cloud_provider" "azure_provider" {
    name            = "terraform-azure-provider"
    type            = "azure"
    project_uuid    = "31592f06c7a54be6ac05080d074111cb"
    client_id       = "2d905d61-af49-41d9-aacf-49ae0bd5fa33"
    client_secret   = var.azure_client_secret
    subscription_id = "9aa6ae03-466d-4162-8457-9687a997befe"
    tenant_id       = "b38e7353-d045-4e5b-9ae4-ae80715d456d"
}

resource "pf9_cluster" "azure_cluster-1" {
  project_uuid        = pf9_azure_cloud_provider.azure_provider.project_uuid
  cloud_provider_uuid = pf9_azure_cloud_provider.azure_provider.id
  name                = "azure-cluster-1"
  containers_cidr     = "10.20.0.0/16"
  services_cidr       = "10.21.0.0/16"
  num_masters         = 1
  num_workers         = 1
  
  # azure-specific
  location   = "northcentralus"
  zones      = ["1"]
  ssh_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdEryX/VLN+on3YrWegvNIJM9FriiwLAeaH1Oqw4v6j6xQKjaZPc3wlbCT0fqu4Se1E9HdPNaeBa59SvL/VgVNwgpctDYTYIuh4oKyKwAz4ZGwGfDPL/Cyp6sFXnbBeanTjX6c29PuXKV4AiM+iC70jC6+LCA5NbXZnVFHckCYGupKZY/DQNSYhMqJy0IP2HuLAHgpK65uAKGP4H/f701ljQk5KL54APk3JU+3tBUs+F11viRV/zfFtZ1WJExLtlIuji7n4bKx9htP8VKdfyq3Vgl68hIhmwzQZBiI0RnEuxdJH55HJ+BpjmW6y/GiBnSpGfks1R4zCxKBBViwqN1x imported-openssh-key"
  master_sku = "Standard_A4_v2"
  worker_sku = "Standard_A4_v2"
}

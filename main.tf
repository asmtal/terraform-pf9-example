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

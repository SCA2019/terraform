# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}


resource "azurerm_kubernetes_cluster" "default" {
  name                = "rg_sb_eastus_45960_1_170628036528"
  location            = "East US"
  resource_group_name = "rg_sb_eastus_45960_1_170628036528"
  dns_prefix          = "${random_pet.prefix.id}-k8s"
  kubernetes_version  = "1.26.10"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}

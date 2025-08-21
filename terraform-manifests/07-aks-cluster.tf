# aks_cluster.tf - Improved with proper integrations

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster-${random_pet.aksrandom.id}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-${random_pet.aksrandom.id}"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                         = "system"
    node_count                   = 1
    vm_size                     = "Standard_D2s_v3"
    os_disk_size_gb             = 30
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  # Integrate Azure AD for RBAC
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [azuread_group.aks_administrators.object_id]
  }

  # Integrate Log Analytics for monitoring
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
  }

  tags = {
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

# Worker node pool for application workloads
resource "azurerm_kubernetes_cluster_node_pool" "worker_pool" {
  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size              = "Standard_D2s_v3"
  node_count           = 2
  os_disk_size_gb      = 30

  node_labels = {
    "nodepool-type" = "worker"
    "environment"   = var.environment
  }

  tags = {
    Environment = var.environment
    NodePool    = "worker"
    CreatedBy   = "Terraform"
  }
}
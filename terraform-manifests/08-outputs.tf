# outputs.tf - Enhanced with additional useful outputs

# AKS Cluster essentials
output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.aks_rg.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.aks_rg.location
}

# Kubernetes connection details
output "kubernetes_version" {
  description = "Kubernetes version used by the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}

output "kube_config_raw" {
  description = "Raw kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}

# Monitoring and security
output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.insights.id
}

output "aks_admin_group_id" {
  description = "Object ID of the AKS administrators group"
  value       = azuread_group.aks_administrators.object_id
}

# Connection commands
output "cluster_connect_command" {
  description = "Command to connect to the AKS cluster"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks_rg.name} --name ${azurerm_kubernetes_cluster.aks_cluster.name}"
}
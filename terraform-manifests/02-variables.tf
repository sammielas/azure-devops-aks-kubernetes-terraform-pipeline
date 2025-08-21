# variables.tf - Improved with proper defaults and validation

# Azure Location
variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "centralus"
  
  validation {
    condition = can(regex("^[a-z0-9]+$", var.location))
    error_message = "Location must be a valid Azure region name in lowercase without spaces."
  }
}

# Azure Resource Group Name
variable "resource_group_name" {
  type        = string
  description = "This variable defines the Resource Group base name"
  default     = "terraform-aks"
  
  validation {
    condition     = length(var.resource_group_name) > 0 && length(var.resource_group_name) <= 64
    error_message = "Resource group name must be between 1 and 64 characters."
  }
}

# Azure AKS Environment Name
variable "environment" {
  type        = string  
  description = "This variable defines the Environment (dev, staging, prod)"
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

# Node pool configuration
variable "system_node_count" {
  type        = number
  description = "Number of nodes in the system pool"
  default     = 1
  
  validation {
    condition     = var.system_node_count >= 1 && var.system_node_count <= 10
    error_message = "System node count must be between 1 and 10."
  }
}

variable "worker_node_count" {
  type        = number
  description = "Number of nodes in the worker pool"
  default     = 2
  
  validation {
    condition     = var.worker_node_count >= 1 && var.worker_node_count <= 100
    error_message = "Worker node count must be between 1 and 100."
  }
}
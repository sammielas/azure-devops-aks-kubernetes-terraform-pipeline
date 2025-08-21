# Terraform Configuration - Latest Standards
# 1. Terraform Settings Block with version constraints and required providers
# 2. Provider configuration for AzureRM
# 3. Random pet resource for naming conventions

terraform {
  # Required Terraform version - updated to latest stable
  required_version = ">= 1.5"
  
  # Required providers with updated versions
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# AzureRM Provider configuration
provider "azurerm" {
  # Removed hardcoded subscription_id - use environment variables or Azure CLI authentication
  features {
    # Resource group configuration for proper cleanup
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Random pet resource for generating unique names
resource "random_pet" "aksrandom" {
  length = 2
  separator = "-"
}
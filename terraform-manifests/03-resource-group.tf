resource "azurerm_resource_group" "aks_rg" {
  name     = "terraform-aks-dev-${random_pet.aksrandom.id}"  # Add random suffix
  location = "East US"
  
  tags = {
    Environment = "Development"
    CreatedBy   = "Terraform"
  }
}
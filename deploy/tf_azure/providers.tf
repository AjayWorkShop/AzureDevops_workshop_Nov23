terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.81.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "sa"
    storage_account_name = "qtst"
    container_name       = "tfstatfile"
    key                  = "azuredevopsdemo.terraform.tfstate"
}

}

provider "azurerm" {
 features {
   
 }
}


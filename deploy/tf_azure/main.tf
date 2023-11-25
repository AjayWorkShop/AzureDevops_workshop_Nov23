
resource "azurerm_resource_group" "aks_rg"{
    name = "myAksResourceGroup"
    location = "East US"

depends_on = [ azurerm_resource_group.sa, azurerm_storage_account.sa_qtst, azurerm_storage_container.statefile]
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name = "myAKSCluster"
    location = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    dns_prefix = "myAKSCluster"


default_node_pool{
    name = "default"
    node_count = "1"
    vm_size = "Standard_B2ms"
}

identity{
    type = "SystemAssigned"
}

tags = {
    Environment = "Prod"
}

depends_on = [ azurerm_resource_group.aks_rg ]
}


output "kube_config" {
    value = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config_raw
    sensitive = true
}



resource "azurerm_resource_group" "sa" {
    name = "sa"
    location = "East US"
  
}

resource "azurerm_storage_account" "sa_qtst" {
    name = "qtst"
    resource_group_name = azurerm_resource_group.sa.name
    location = azurerm_resource_group.sa.location
    account_tier = "Standard"
    account_replication_type = "LRS"
depends_on = [ azurerm_resource_group.sa ]
}

resource "azurerm_storage_container" "statefile" {
    name = "tfstatfile"
    storage_account_name = azurerm_storage_account.sa_qtst.name
    container_access_type = "public"

  depends_on = [ azurerm_storage_account.sa_qtst ]
}



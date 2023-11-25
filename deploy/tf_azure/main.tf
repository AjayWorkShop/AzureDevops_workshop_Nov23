

resource "azurerm_resource_group" "aks_rg"{
    name = "myAksResourceGroup"
    location = "East US"

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

}


output "kube_config" {
    value = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config_raw
    sensitive = true
}


provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "aks-rg" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "myaksdns"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_DS2_v2"
  }

  service_principal  {
    client_id = "98802061-a5ad-41c4-b8f5-57129928fe98"
    client_secret = "YqI8Q~6dKJq7olh5Xtyh4c4ihVpCUjAEqCSt5ctx"
    
  }

  tags = {
    environment = "dev"
  }
}

#output "kubeconfig" {
#  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_config[0].kube_config
#}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

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
  #identity {
   # type = "SystemAssigned"
  #}
  service_principal  {
    client_id = "2f791644-dc40-414a-ba2b-877130f949f2"
    client_secret = "iQi8Q~QjvL.~dguV~kuBaRTUl1U82hF-UZY8HdrV"

 }

  #tags = {
  #  environment = "dev"
  #}
}

#output "kubeconfig" {
#  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_config[0].kube_config
#}
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

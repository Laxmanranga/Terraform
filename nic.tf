resource "azurerm_network_interface" "NIC1" {
    #count = 1
    name = "${var.vm1}-nic"
    location = var.location
    resource_group_name = data.azurerm_resource_group.existingrg.name
    enable_accelerated_networking = true
    
    ip_configuration {
      name = "IPconfig"
      subnet_id = data.azurerm_subnet.subnet.id
      private_ip_address_allocation = "Static"
    }
    #terraform apply -target="azurerm_network_interface.NIC1"  -auto-approve
      tags = {
    SystemOwner = "Hervé Rodigue"
     Enviroment="Production"
    ServiceCatalog="UniC10"
    CostCenter="1244122000"
    ServiceName="Compute"
    #ProjectName="FireFly"
  }
}
##########################################################

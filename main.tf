#az account set --subscription MGD-EMEA-DIHG-AS-Prod
terraform {

  backend "azurerm" {
    resource_group_name  = "jonnychipz-infra"
    storage_account_name = "jonnychipztstate"
    container_name       = "tstate"
    key                  = "77Q4LUB5o9wRdbPYDt+0kGZP+L8Sj9E/FNXg7lZBQS5z3mLod5cyan4wA19CR1SmlqIRUFQfhuQrPVaGzNhjGw=="
  }
  required_version = ">=0.12"
    required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existingrg" {
  name = "terraform"
}
data "azurerm_subnet" "subnet" {
  name                 = var.sn
  virtual_network_name = var.vn
  resource_group_name  = data.azurerm_resource_group.existingrg.name
}

#it's all start about VM1 
resource "azurerm_virtual_machine" "vm1" {
  name = var.vm1
  location = var.location
  resource_group_name = data.azurerm_resource_group.existingrg.name
  network_interface_ids = [azurerm_network_interface.NIC1.id]
  vm_size = "Standard_B2s"
  boot_diagnostics {
    enabled = "true"
    storage_uri = "https://acgaccount1.blob.core.windows.net/"
  }
 storage_image_reference {
    id = "/subscriptions/43d73918-19de-4298-8a63-27ee7d7f59d8/resourceGroups/ManagedImage/providers/Microsoft.Compute/images/Final-Image"
  }
  os_profile {
    computer_name=var.vm1
    admin_username=var.vm_username
    admin_password = var.vm_password
  }
  storage_os_disk{
    name = "${var.vm1}-Os_Disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }
  storage_data_disk {
    name="${var.vm1}-DataDisk"
    caching="ReadWrite"
    create_option="Empty"
    disk_size_gb="16"
    lun=0
    managed_disk_type="StandardSSD_LRS"
  }
  os_profile_windows_config {
    timezone = "W. Europe Standard Time"
    provision_vm_agent = true
  }
     tags = {
    SystemOwner = "Hervé Rodigue"
     Enviroment="Production"
    ServiceCatalog="UniC10"
    CostCenter="1244122000"
    ServiceName="Compute"
    #ProjectName="FireFly"
  }
  
}


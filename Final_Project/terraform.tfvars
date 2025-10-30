#######################################################
# Global Settings
#######################################################

region = "eastus"

tags = {
  environment = "dev"
  owner       = "infrastructure-team"
  project     = "full-env-deployment"
}

#######################################################
# Networking Configuration
#######################################################

vnet_name       = "main-vnet"
address_space   = ["10.0.0.0/16"]
subnet_name     = "subnet-main"
subnet_prefixes = ["10.0.1.0/24"]

#######################################################
# Network Security Group Configuration
#######################################################

nsg_name      = "main-nsg"
allowed_ports = [22, 80, 443]

#######################################################
# Virtual Machine Configuration
#######################################################

vm_name        = "main-vm"
vm_size        = "Standard_B2s"
admin_username = "azureuser"
admin_password = "ChangeMe123!" # ⚠️ Replace with a secure secret or use a secret manager

#######################################################
# Patch Management Configuration
#######################################################

patch_schedule_day  = "Sunday"
patch_schedule_time = "02:00"

region               = "eastus2"
vm_size              = "Standard_B2s"
admin_password       = "SuperSecureP@ssword123"
patch_schedule_day   = "Saturday"
patch_schedule_time  = "01:00"
tags = {
  environment = "production"
  owner       = "cloudops"
  project     = "patch-demo"
}

variable "region" {
  description = "Azure region for all resources"
  type        = string
  default     = "eastus"
}

variable "vm_size" {
  description = "VM instance size"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "patch_schedule_day" {
  description = "Day of the week for patch management (e.g., Sunday)"
  type        = string
  default     = "Sunday"
}

variable "patch_schedule_time" {
  description = "Time of day for patch management (24h format, UTC)"
  type        = string
  default     = "02:00"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "team-cloud"
  }
}

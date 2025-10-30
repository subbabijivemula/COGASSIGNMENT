
# Variables for Automation Module
variable "business_unit" {
  description = "Business unit or application name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "log_analytics_sku" {
  description = "SKU for the Log Analytics workspace"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Retention period in days for Log Analytics workspace"
  type        = number
}

variable "automation_account_sku" {
  description = "SKU for the Automation Account"
  type        = string
}

variable "update_solution_name" {
  description = "Name of the update management solution"
  type        = string
}

variable "update_solution_publisher" {
  description = "Publisher of the update management solution"
  type        = string
}

variable "update_solution_product" {
  description = "Product name of the update management solution"
  type        = string
}

variable "schedule_frequency" {
  description = "Frequency of the patch schedule"
  type        = string
}

variable "schedule_interval" {
  description = "Interval for the patch schedule"
  type        = number
}

variable "schedule_description" {
  description = "Description for the patch schedule"
  type        = string
}

variable "tag_filter" {
  description = "Tag filter for targeting VMs"
  type        = string
}

variable "linux_classifications" {
  description = "Linux update classifications to include"
  type        = list(string)
}

variable "linux_excluded_packages" {
  description = "Linux packages to exclude from updates"
  type        = list(string)
}

variable "linux_included_packages" {
  description = "Linux packages to include in updates"
  type        = list(string)
}

variable "linux_reboot_setting" {
  description = "Reboot setting for Linux updates"
  type        = string
}

variable "schedule_name" {
  description = "Name of the patch schedule"
  type        = string
}

variable "update_config_name" {
  description = "Name of the update configuration"
  type        = string
}

variable "timezone" {
  description = "Timezone for the schedule"
  type        = string
}

variable "start_time" {
  description = "Start time for the patch schedule (ISO 8601 format)"
  type        = string
}

variable "patch_days" {
  description = "Days of the week for patching"
  type        = list(string)
}

variable "vm_name" {
  description = "Name of the VM to manage"
  type        = string
}

variable "vm_ids" {
  description = "List of VM resource IDs to manage"
  type        = list(string)
}

variable "vm_resource_group_id" {
  description = "Resource group ID containing the VM"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

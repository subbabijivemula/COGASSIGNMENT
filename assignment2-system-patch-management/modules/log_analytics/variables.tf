variable "name" {
  type        = string
  description = "The name of the resource."
}

variable "location" {
  type        = string
  description = "The Azure region where the resource will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resource will be created."
}

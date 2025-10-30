# Assignment 1: Virtual Machines & Networking

## Objective
Deploy a secure Linux web server using reusable Terraform modules.

## Directory Structure
modules/
├── network/
├── nsg/
└── vm/
main.tf
variables.tf
outputs.tf


## Requirements
- Azure subscription
- Terraform v1.5+ installed
- Logged into Azure CLI (`az login`)

## Usage

terraform init
terraform plan
terraform apply -auto-approve

After deployment, Terraform will output the VM’s public IP.
Access your NGINX server in a browser:
http://<PUBLIC_IP>

Modules
1. Network

Creates VNet and Subnet.
Inputs: vnet_name, vnet_cidr, subnet_name, subnet_cidr
Output: subnet_id

2. NSG

Creates security group allowing ports 22 (SSH) and 80 (HTTP).
Inputs: nsg_name, location, resource_group_name
Output: nsg_id

3. VM

Creates Ubuntu VM with NGINX installed.
Inputs: vm_name, subnet_id, nsg_id, credentials
Output: public_ip
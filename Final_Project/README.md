This Terraform configuration deploys a complete Azure environment including:
    Virtual Network & Subnet
    Network Security Group (NSG)
    Virtual Machine with Admin Credentials
    Automated Patch Management (via Automation Account or Update Management)


-->Architecture Diagram:

                 ┌──────────────────────────────┐
                 │        Resource Group        │
                 │ (auto-created by Terraform)  │
                 └──────────────┬───────────────┘
                                │
           ┌────────────────────┼────────────────────┐
           │                    │                    │
  ┌────────▼───────┐    ┌───────▼────────┐   ┌───────▼────────┐
  │ Virtual Network │    │ Network SecGrp │   │ Virtual Machine│
  │   (10.0.0.0/16)│    │  (Rules for RDP│   │  + Public IP   │
  │  + Subnet       │    │  SSH, HTTP)    │   │  + NSG Assoc.  │
  └─────────────────┘    └────────────────┘   └───────┬────────┘
                                                       │
                                                ┌──────▼─────────┐
                                                │ Patch Mgmt     │
                                                │ (Schedule Job) │
                                                └────────────────┘



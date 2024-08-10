# Terraform Azure Infrastructure Deployment

This repository contains Terraform scripts for deploying and managing a secure, scalable, and robust infrastructure on Microsoft Azure. The infrastructure is designed to support modern web applications, ensuring high availability, security, and efficient traffic management. The deployment includes a multi-tier architecture with virtual networks, subnets, network security groups, virtual machines, load balancers, application gateways, and integrated security and monitoring services.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup and Deployment](#setup-and-deployment)
- [Resources Deployed](#resources-deployed)
- [Monitoring and Security](#monitoring-and-security)
- [Maintenance and Updates](#maintenance-and-updates)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed
- An Azure account with appropriate permissions
- Azure CLI installed and configured
- Basic knowledge of Terraform and Azure infrastructure

## Setup and Deployment

### 1. Clone the Repository
git clone https://github.com/Rawspey/Zenzprjext.git
cd terraform-azure-infrastructure
### 2. Configure Azure CLI
Login to your Azure account using the Azure CLI:
az login

### 3. Initialize Terraform
Initialize the Terraform configuration:

terraform init
### 4. Review and Edit Variables
Review and modify the variables.tf file to match your environment and requirements.

### 5. Plan the Deployment
Generate an execution plan:

terraform plan
### 6. Apply the Configuration
Deploy the infrastructure:

terraform apply
### 7. Verify the Deployment
Once the deployment is complete, verify the resources in the Azure portal.

### Modules
The Terraform configuration is modularized following best practices. Each resource module is stored in the /modules directory

## Resources Deployed
This Terraform script deploys the following Azure resources, organized in a multi-tier architecture:

## Resource Group (`zenpayrg`)
A container that holds all the related resources for easy management.

## Virtual Network (`zenpayvnet`)
A logically isolated network to securely connect resources.

### Subnets
- **web**: For web-facing virtual machines.
- **db**: For database servers, isolated from the web tier.
- **appgw**: For the application gateway.

### Network Security Groups (`web_nsg`, `db_nsg`)
Define security rules to control inbound and outbound traffic to the subnets.

### Network Interfaces (`web_nic`, `db_nic`)
Interfaces attached to virtual machines to enable network connectivity.

## Availability Set (`web_avset`)
Ensures web VMs are distributed across multiple fault and update domains for high availability.

## Virtual Machines
- **`web_vm`**: Two instances to host web applications.
- **`db_vm`**: A single instance to host the database.

## Public IP Addresses
- **`web_lb_pip`**: Static public IP for the load balancer.
- **`appgw_pip`**: Static public IP for the application gateway.

## Load Balancer (`web_lb`)
Distributes incoming web traffic across the web VMs.

## Application Gateway (`zenpay-appgw`)
Manages web traffic with advanced routing and security features.

## Recovery Services Vault (`zenpay_recovery_vault`)
Provides backup services for the VMs and databases.

## Azure Security Center
Monitors and manages the security posture, including security contacts, auto-provisioning of security agents, and log analytics integration.

### Monitoring and Security
The infrastructure includes configurations for monitoring and managing security:

- **Azure Security Center Contact (`security_contact`)**: Specifies a contact for security alerts.
- **Auto Provisioning (`auto_provisioning`)**: Automatically provisions security agents on supported resources.
- **Log Analytics Workspace (`securitypostlog`)**: Collects and analyzes log data.
- **Security Center Workspace (`securityposturews`)**: Links the Log Analytics workspace to Azure Security Center for comprehensive monitoring and security management.

## Maintenance and Updates
To update the infrastructure, modify the Terraform scripts as needed and re-apply the configuration:

terraform apply

## To destroy the infrastructure, use:
terraform destroy

## Troubleshooting
If you encounter issues during deployment, consider the following steps:

1. Verify Azure CLI authentication and permissions.
2. Check the syntax and configuration in the Terraform scripts.
3. Review the Terraform plan and apply logs for errors.
4. Ensure that all dependencies and prerequisites are met.
5. For detailed troubleshooting, refer to the official Terraform documentation and Azure documentation.

## Contributing
We welcome contributions to improve this project. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/your-feature).
3. Commit your changes (git commit -m 'Add your feature').
4. Push to the branch (git push origin feature/your-feature).
5. Open a pull request.
   
## License
This project is licensed under the MIT License. See the LICENSE file for details.

Thank you for using this Terraform Azure infrastructure deployment guide. For any questions or support, please contact femirawlings@gmail.com.

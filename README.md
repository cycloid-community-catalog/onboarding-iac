# Onboarding Infrastructure as Code (IaC)

This repository contains Terraform modules for deploying infrastructure across multiple cloud providers (AWS, Azure, and GCP). The modules are designed for onboarding scenarios and include both basic infrastructure components and Node.js application deployment capabilities.

## 🏗️ Architecture Overview

The repository is organized by cloud provider and includes modules for:

- **Networking**: VPCs, subnets, security groups, and network configurations
- **Compute**: Virtual machines and EC2 instances
- **Storage**: S3 buckets and storage solutions
- **Databases**: RDS instances for managed databases
- **Applications**: Node.js web applications with automated deployment

## 📁 Repository Structure

```
onboarding-iac/
├── aws/                    # AWS-specific modules
│   ├── ec2/               # Basic EC2 instance module
│   ├── ec2-nodejs/        # EC2 with Node.js app deployment
│   ├── key_pair/          # SSH key pair management
│   ├── network/           # VPC, subnets, and networking
│   ├── rds/               # RDS database instances
│   └── s3/                # S3 bucket storage
├── azure/                 # Azure-specific modules
│   ├── network/           # Virtual networks and subnets
│   └── vm-nodejs/         # Azure VM with Node.js app
├── gcp/                   # Google Cloud Platform modules
│   ├── network/           # VPC networks and firewall rules
│   └── vm-nodejs/         # GCP VM with Node.js app
└── README.md
```

## ☁️ Cloud Providers

### AWS Modules

#### `aws/network`
Creates a complete VPC setup with public and private subnets.

**Resources Created:**
- VPC with configurable CIDR
- Internet Gateway
- Public and Private Subnets
- Route Tables and Associations
- Optional NAT Gateway

**Key Variables:**
- `vpc_cidr`: VPC CIDR block (default: "10.0.0.0/16")
- `vpc_public_subnet`: Public subnet CIDR (default: "10.0.0.0/24")
- `vpc_private_subnet`: Private subnet CIDR (default: "10.0.1.0/24")
- `nat_gateway`: Enable NAT gateway (default: false)

#### `aws/ec2`
Basic EC2 instance module with security groups.

**Resources Created:**
- EC2 instance with Debian AMI
- Security group with configurable ports
- Root block device

**Key Variables:**
- `vm_instance_type`: Instance type (default: "t2.micro")
- `vm_disk_size`: Disk size in GB (default: "20")
- `service_ports`: Array of TCP ports to allow (default: [])
- `subnet_id`: Subnet for deployment

#### `aws/ec2-nodejs`
EC2 instance with automated Node.js application deployment.

**Resources Created:**
- EC2 instance with Debian AMI
- Security group (SSH + HTTP)
- User data script for app deployment

**Key Variables:**
- `git_app_url`: Git repository URL for the application
- `vm_instance_type`: Instance type (default: "t3a.small")
- `vm_disk_size`: Disk size in GB (default: "20")

**Application Deployment:**
- Installs Node.js and npm
- Clones the specified Git repository
- Builds the React/Node.js application
- Configures Nginx as a web server
- Serves the application on port 80

#### `aws/rds`
Managed RDS database instance.

**Resources Created:**
- RDS instance with configurable engine
- Security groups for database access
- Subnet group for private deployment

**Key Variables:**
- `rds_engine`: Database engine (default: "mysql")
- `rds_engine_version`: Engine version (default: "5.7")
- `rds_instance_class`: Instance type (default: "db.t3.medium")
- `rds_allocated_storage`: Storage size in GB (default: "32")

#### `aws/s3`
S3 bucket for object storage.

**Resources Created:**
- S3 bucket with configurable name
- Optional KMS encryption
- IAM policies for access control

**Key Variables:**
- `s3_bucket_name`: Name of the S3 bucket

#### `aws/key_pair`
SSH key pair management.

**Resources Created:**
- AWS key pair resource
- Public key configuration

### Azure Modules

#### `azure/network`
Azure virtual network and subnet configuration.

**Resources Created:**
- Resource Group
- Virtual Network
- Subnet
- Network Security Group

**Key Variables:**
- `rg_name`: Resource group name
- `azure_location`: Azure region (default: "West Europe")

#### `azure/vm-nodejs`
Azure VM with Node.js application deployment.

**Resources Created:**
- Virtual Machine with Ubuntu
- Network interface
- Public IP address
- User data script for app deployment

**Key Variables:**
- `git_app_url`: Git repository URL for the application
- `vm_instance_type`: VM size (default: "Standard_DS2_v2")
- `vm_disk_size`: Disk size in GB (default: "30")
- `azure_location`: Azure region

### GCP Modules

#### `gcp/network`
Google Cloud VPC network and firewall configuration.

**Resources Created:**
- VPC Network
- Subnet
- Firewall rules

**Key Variables:**
- `network_name`: VPC network name

#### `gcp/vm-nodejs`
Google Compute Engine VM with Node.js application.

**Resources Created:**
- Compute Engine instance
- Network interface
- External IP
- User data script for app deployment

**Key Variables:**
- `git_app_url`: Git repository URL for the application
- `vm_machine_type`: Machine type (default: "n2-standard-2")
- `vm_disk_size`: Disk size in GB (default: "20")

## 🚀 Quick Start

### Prerequisites

- Terraform >= 1.0
- Cloud provider CLI tools configured
- Appropriate cloud provider credentials

### Basic Usage

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd onboarding-iac
   ```

2. **Choose your cloud provider and navigate to the desired module:**
   ```bash
   cd aws/ec2-nodejs  # Example: AWS Node.js deployment
   ```

3. **Create a `terraform.tfvars` file:**
   ```hcl
   customer = "your-company"
   env      = "dev"
   project  = "onboarding"
   git_app_url = "https://github.com/your-org/your-app.git"
   ```

4. **Initialize and apply:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Example: Complete AWS Setup

```hcl
# 1. Create network infrastructure
module "network" {
  source = "./aws/network"
  
  customer = "acme"
  env      = "dev"
  project  = "webapp"
  
  vpc_cidr           = "10.0.0.0/16"
  vpc_public_subnet  = "10.0.0.0/24"
  vpc_private_subnet = "10.0.1.0/24"
  nat_gateway        = true
}

# 2. Deploy Node.js application
module "webapp" {
  source = "./aws/ec2-nodejs"
  
  customer = "acme"
  env      = "dev"
  project  = "webapp"
  
  git_app_url = "https://github.com/acme/webapp.git"
  subnet_id   = module.network.public_subnet_id
}

# 3. Create database
module "database" {
  source = "./aws/rds"
  
  customer = "acme"
  env      = "dev"
  project  = "webapp"
  
  vpc_id = module.network.vpc_id
}
```

## 🏷️ Tagging Strategy

All modules use a consistent tagging strategy with Cycloid-specific tags:

- `cycloid`: "true"
- `env`: Environment name (dev, staging, prod)
- `project`: Project name
- `customer`: Customer/company name
- `extra_tags`: Additional custom tags

## 🔧 Configuration

### Required Variables

All modules require these core variables:
- `customer`: Customer/company identifier
- `env`: Environment name
- `project`: Project identifier

### Optional Variables

Each module provides sensible defaults for optional variables. Check individual module `variables.tf` files for complete documentation.

## 📝 Notes

- **AMI Management**: EC2 modules use `lifecycle { ignore_changes = [ami] }` to prevent AMI updates from causing unnecessary recreations
- **Security**: Default security groups allow SSH (port 22) and HTTP (port 80) access
- **User Data**: Node.js modules include automated application deployment via user data scripts
- **Multi-Cloud**: Modules are designed to be cloud-agnostic where possible, with provider-specific optimizations

## 🤝 Contributing

1. Follow the existing module structure
2. Include comprehensive variable documentation
3. Use consistent naming conventions
4. Test modules across different environments
5. Update this README when adding new modules

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For questions or issues:
1. Check the module-specific documentation
2. Review Terraform logs for detailed error messages
3. Ensure all required variables are provided
4. Verify cloud provider credentials and permissions
# -----------------------------
# Terraform Infrastructure Code
# -----------------------------

# Installation Steps
# 1. Clone the repository:
#    ```sh
#    git clone https://github.com/Danielkis97/Host-a-simple-webpage-on-AWS
#    cd Host-a-simple-webpage-on-AWS
#    ```

# 2. Set up the AWS credentials:
#    Edit the `terraform.tfvars` file with your AWS credentials:
#    ```plaintext
#    aws_access_key = "your-access-key"
#    aws_secret_key = "your-secret-key"
#    region         = "eu-north-1"
#    ami            = "ami-079c4d86630be4b6a"
#    instance_type  = "t3.micro"
#    key_name       = "your-key-name"
#    vpc_id         = "your-vpc-id"
#    ```

# 3. Initialize Terraform:
#    ```sh
#    terraform init
#    ```

# 4. Create an execution plan to review changes:
#    ```sh
#    terraform plan
#    ```

# 5. Apply the execution plan to deploy infrastructure:
#    ```sh
#    terraform apply
#    ```

# 6. To destroy the infrastructure (optional):
#    ```sh
#    terraform destroy
#    ```

# ------------------------------
# Providers Configuration
# ------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ... Rest of the code continues here

# ------------------------------
# Additional Infrastructure Code
# ------------------------------

# Define your VPC, subnets, security groups, etc.


#!/bin/bash

# Set variables
PRIVATE_KEY_PATH="C:/Users/danie/key.pem"
TERRAFORM_DIR="C:/Users/danie/PycharmProjects/Cloud Programming"
INSTANCE_USERNAME="ec2-user"

# Initialize Terraform
echo "Initializing Terraform..."
cd "$TERRAFORM_DIR" || exit
terraform init

# Apply Terraform configuration
echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Get the public IP of the instance
INSTANCE_IP=$(terraform output -raw instanceIPv4)
echo "Instance IP Address: $INSTANCE_IP"

# Wait for the instance to start up
echo "Waiting for instance to start up..."
sleep 30

# SSH into the instance
echo "Connecting to the instance via SSH..."
ssh -i "$PRIVATE_KEY_PATH" -o "StrictHostKeyChecking=no" "$INSTANCE_USERNAME@$INSTANCE_IP"

# After SSH session is closed, destroy the Terraform-managed infrastructure
echo "Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

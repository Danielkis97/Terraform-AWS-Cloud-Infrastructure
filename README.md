# AWS Infrastructure Deployment

## Overview
This project sets up a simple infrastructure on AWS using Terraform. The infrastructure includes a Virtual Private Cloud (VPC), subnets, an Internet Gateway, security groups, EC2 instances, an Elastic Load Balancer (ELB), and an Auto Scaling Group (ASG). The goal is to deploy a web application in a secure and scalable manner.

## UML Diagram
The following UML diagram illustrates the structure of the AWS infrastructure deployed by this project:

![UML Diagram](link_to_your_UML_diagram)

## Infrastructure Explanation
The infrastructure setup includes the following components:
- **VPC:** A Virtual Private Cloud to provide an isolated environment.
- **Subnets:** Distributed across multiple availability zones for high availability.
- **Security Groups:** To control inbound and outbound traffic.
- **EC2 Instances:** Virtual servers to host the web application.
- **Elastic Load Balancer:** To distribute incoming traffic across multiple EC2 instances.
- **Auto Scaling Group:** To automatically adjust the number of EC2 instances based on demand.

## Setup and Installation
> [!IMPORTANT]
> Follow these steps to set up and deploy the infrastructure.

### Prerequisites
- AWS Account with the necessary permissions.
- AWS CLI configured with your credentials.
- Terraform installed on your local machine.

### Installation Steps

1. **Clone the repository:**
    ```sh
    git clone https://github.com/Danielkis97/Host-a-simple-webpage-on-AWS.git
    cd Host-a-simple-webpage-on-AWS
    ```

2. **Set up AWS credentials:**
   Edit the `terraform.tfvars` file with your specific AWS configurations:
   ```plaintext
   aws_access_key = "your-access-key"
   aws_secret_key = "your-secret-key"
   region         = "eu-north-1"
   ami            = "ami-079c4d86630be4b6a"
   instance_type  = "t3.micro"
   key_name       = "your-key-name"
   vpc_id         = "your-vpc-id"

3. **Initialize Terraform:**
   ```sh
   terraform init
   ```
4. **Create an execution plan:**
   ```sh
   terraform plan
   ```

6. **Apply the execution plan to deploy the infrastructure:**
   ```sh
   terraform apply
   ```

6. **Destroy the infrastructure (optional):**
   ```sh
   terraform destroy
   ```
## Using the Infrastructure

Once deployed, the infrastructure will include:

- **Publicly accessible EC2 instances:** Running the web application.
- **Load Balancing:** Managed by the Elastic Load Balancer to handle incoming traffic.
- **Automatic Scaling:** Managed by the Auto Scaling Group to handle varying levels of traffic.

## Running Tests

To ensure that the infrastructure is functioning correctly, you can manually access the EC2 instances via the Load Balancer's DNS name and verify the web application's availability.

## Directory Structure

- **autoscaling.tf:** Defines the Auto Scaling Group and scaling policies to automatically adjust the number of EC2 instances based on load.
- **data.tf:** Manages external data sources, such as retrieving information about AWS availability zones.
- **ec2.tf:** Configures the EC2 instances, including their launch templates and security groups.
- **elastic_load_balancer.tf:** Configures the Elastic Load Balancer, including its listener, target groups, and health checks.
- **launch_template.tf:** Defines the launch template for EC2 instances, including AMI, instance type, and user data scripts.
- **main.tf:** Main configuration file for setting up the AWS infrastructure.
- **outputs.tf:** Specifies the outputs of the Terraform run, such as the public IP of the EC2 instances and the DNS name of the Load Balancer.
- **variables.tf:** Defines all the variables used in the project, such as AMI IDs, instance types, and region.
- **terraform.tfvars:** Contains the actual values for the variables defined in `variables.tf`, such as AWS credentials and specific resource IDs.

## Possible Bugs and Solutions

- **Resource Name Conflicts:**
  - **Scenario:** If you try to deploy the infrastructure more than once without cleaning up the previous setup, you might run into issues where resources have the same name.
  - **Solution:** Add unique identifiers (like random strings or environment-specific names) to your resource names to avoid these conflicts.

- **Hitting AWS API Limits:**
  - **Scenario:** If you create or delete a lot of resources quickly, you might hit AWS’s limits on how many requests you can make.
  - **Solution:** Slow down your Terraform runs or add retry logic to avoid overwhelming the AWS API.

- **Invalid AWS Credentials:**
  - **Scenario:** If your AWS credentials are wrong or have expired, Terraform commands won’t work properly.
  - **Solution:** Double-check that your `terraform.tfvars` file has the correct credentials or set up your credentials using environment variables to keep them secure.


## Examples

Here’s how you might interact with the deployed infrastructure:

- **Access the Web Application:** After the infrastructure is deployed, navigate to the Load Balancer's DNS name in your web browser to view the web application.

- **Scale the Application:** Trigger scaling by simulating high CPU usage on the EC2 instances, and observe how the Auto Scaling Group adjusts the number of running instances.

> [!TIP]
> Keep your Terraform state files secure, especially if you're working in a shared environment.

                  

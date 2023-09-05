# Terraform AWS GuardDuty Configuration

This Terraform configuration sets up AWS GuardDuty to monitor specific AWS resources, including EC2 instances, and configure threat intelligence feeds, CloudWatch Events, and SNS notifications.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

1. AWS Account: You must have an active AWS account with sufficient permissions to create GuardDuty resources.

2. AWS CLI: Ensure the AWS Command Line Interface (CLI) is installed and configured with the necessary credentials.

3. Terraform: Install Terraform on your local machine. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).

## Configuration Files

This Terraform configuration is organized into separate files:

- `variables.tf`: Contains variable definitions, including the list of EC2 instance IDs you want to monitor.

- `provider.tf`: Configures the AWS provider, specifying the AWS region.

- `main.tf`: Contains the main Terraform code for creating GuardDuty resources, threat intelligence sets, CloudWatch Events, SNS topics, and attaching GuardDuty to EC2 instances.

## Usage

1. Clone this repository to your local machine.

2. Edit the `variables.tf` file to specify the list of EC2 instance IDs you want to monitor.

3. Ensure your AWS CLI is configured with the necessary credentials.

4. Run the following Terraform commands:

   ```shell
   terraform init
   terraform plan
   terraform apply

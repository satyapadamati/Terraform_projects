# Terraform Project: VPC and EC2 Instance Creation

This Terraform project automates the creation of a Virtual Private Cloud (VPC) along with an EC2 instance on AWS. It provisions a VPC, a public subnet, an Internet Gateway (IGW), a route table, a security group, and an EC2 instance within the subnet.

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Resources Created](#resources-created)
- [Cleanup](#cleanup)
- [License](#license)

## Project Overview

This project demonstrates how to use Terraform to provision the following AWS infrastructure:
- A custom VPC with a CIDR block of `10.10.0.0/16`.
- A public subnet within the VPC with a CIDR block of `10.10.1.0/24`.
- An Internet Gateway (IGW) attached to the VPC.
- A custom route table associated with the public subnet.
- A security group that allows inbound SSH (port 22) and HTTP (port 80) access.
- An EC2 instance in the public subnet, with the security group applied.

## Architecture

The Terraform script provisions:
- **VPC**: A VPC with CIDR block `10.10.0.0/16`.
- **Subnet**: A public subnet with CIDR block `10.10.1.0/24` in availability zone `us-east-1a`.
- **Internet Gateway (IGW)**: Attached to the VPC for internet access.
- **Route Table**: Routes outbound traffic from the subnet through the IGW.
- **Security Group**: Allows SSH (port 22) and HTTP (port 80) from any IP.
- **EC2 Instance**: A `t2.micro` instance running Amazon Linux 2, located in the public subnet.

## Prerequisites

Before running this Terraform script, ensure you have:
- **Terraform** installed (v1.0+ recommended).
- An **AWS account** with permissions to create resources.
- **AWS CLI** configured with your credentials or an IAM role.
- A valid **key pair** in the AWS region you're deploying to.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/terraform-vpc-ec2.git
   cd terraform-vpc-ec2

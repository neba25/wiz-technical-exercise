# Wiz Technical Exercise

## Goal

Deploy a secure two-tier application using:

- Terraform
- AWS
- Docker
- Kubernetes
- MongoDB
- GitHub Actions

## Architecture

Internet

↓

Application Load Balancer

↓

Amazon EKS

↓

Todo Application

↓

MongoDB (EC2)

↓

Daily Backup

↓

Amazon S3

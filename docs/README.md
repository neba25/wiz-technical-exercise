# 🚀 Wiz Technical Exercise -- Production Ready DevOps Platform

> **End-to-End AWS DevOps Project using Terraform, Docker, GitHub
> Actions, Amazon ECR, Amazon EKS, MongoDB, and Amazon S3**

------------------------------------------------------------------------



------------------------------------------------------------------------

# 1. Executive Summary

This project demonstrates a complete production-style DevOps workflow on
AWS. Infrastructure is provisioned using Terraform, the application is
containerized with Docker, built automatically by GitHub Actions, stored
in Amazon ECR, deployed to Amazon EKS, connected to MongoDB running on
EC2, and protected with automated daily backups to Amazon S3.

------------------------------------------------------------------------

# 2. Solution Architecture

``` text
Developer
    │
Git Push
    │
GitHub
    │
GitHub Actions
    │
Docker Build
    │
Amazon ECR
    │
Amazon EKS
 ┌──────────────┐
 │ Tasky Pods   │
 └──────┬───────┘
        │
 Kubernetes LoadBalancer
        │
 MongoDB (EC2)
        │
mongodump + Cron
        │
 Amazon S3
```

------------------------------------------------------------------------

# 3. Project Objectives

-   Provision infrastructure as code.
-   Deploy Kubernetes on AWS.
-   Automate CI/CD.
-   Containerize the application.
-   Store images securely.
-   Deploy a highly available application.
-   Protect the database using automated backups.
-   Apply least-privilege IAM.

------------------------------------------------------------------------

# 4. Technology Stack

  Layer           Technology
  --------------- -----------------------
  Cloud           AWS
  IaC             Terraform
  Containers      Docker
  Orchestration   Amazon EKS
  CI/CD           GitHub Actions
  Registry        Amazon ECR
  Database        MongoDB
  Compute         EC2 Ubuntu
  Backup          Amazon S3 + mongodump
  Language        Go

------------------------------------------------------------------------

# 5. Repository Structure

``` text
wiz-technical-exercise/
├── .github/workflows/
├── kubernetes/
├── scripts/
├── tasky/
├── terraform/
├── README.md
```

------------------------------------------------------------------------

# 6. Infrastructure Provisioning (Terraform)

Terraform provisions:

-   VPC
-   Public Subnets
-   Private Subnets
-   Internet Gateway
-   NAT Gateway
-   Route Tables
-   Security Groups
-   IAM Roles
-   Amazon EKS
-   Managed Node Group
-   MongoDB EC2
-   Amazon ECR
-   Amazon S3 Backup Bucket

Benefits: - Repeatable deployments - Version controlled infrastructure -
Easy disaster recovery

------------------------------------------------------------------------

# 7. AWS Services Used

## VPC

Provides an isolated network.

## Public Subnets

Host internet-facing resources.

## Private Subnets

Host EKS worker nodes.

## Internet Gateway

Provides inbound/outbound internet connectivity.

## NAT Gateway

Allows private resources to download packages securely.

## EC2

Hosts MongoDB.

## EKS

Runs the Tasky application.

## ECR

Stores Docker images.

## IAM

Provides least-privilege authentication.

## S3

Stores automated MongoDB backups.

------------------------------------------------------------------------

# 8. Docker Containerization

A multi-stage Docker build compiles the Go application and produces a
lightweight runtime image based on Alpine Linux.

Benefits: - Smaller image - Faster deployment - Reduced attack surface

------------------------------------------------------------------------

# 9. GitHub Actions

Pipeline: 1. Checkout repository 2. Configure AWS credentials 3. Login
to Amazon ECR 4. Build Docker image 5. Push image to Amazon ECR

------------------------------------------------------------------------

# 10. Amazon ECR

Stores versioned Docker images.

Image scanning is enabled to identify vulnerabilities.

------------------------------------------------------------------------

# 11. Amazon EKS

Tasky is deployed as a Deployment with multiple replicas behind a
LoadBalancer Service.

------------------------------------------------------------------------

# 12. Kubernetes Resources

-   Namespace
-   Secret
-   Deployment
-   Service (LoadBalancer)

Secrets store the MongoDB URI and application secret.

------------------------------------------------------------------------

# 13. MongoDB on EC2

MongoDB runs on Ubuntu EC2 and is accessed by the application over the
VPC private network.

------------------------------------------------------------------------

# 14. Networking Flow

Browser → LoadBalancer → Tasky Pods → MongoDB EC2

------------------------------------------------------------------------

# 15. Security

Implemented: - IAM Roles - Least-Privilege S3 Policy - Kubernetes
Secrets - S3 Server-Side Encryption - ECR Image Scanning

Improvement completed: - Removed AdministratorAccess after validation.

------------------------------------------------------------------------

# 16. Backup & Disaster Recovery

Backup process: 1. mongodump 2. Compress archive 3. Upload to Amazon S3
4. Cleanup temporary files 5. Daily Cron execution

------------------------------------------------------------------------

# 17. Monitoring Recommendations

Future enhancements: - CloudWatch Container Insights - Prometheus -
Grafana - Horizontal Pod Autoscaler

------------------------------------------------------------------------

# 18. Deployment Walkthrough

1.  Terraform Apply
2.  MongoDB EC2
3.  Docker Build
4.  GitHub Actions
5.  Amazon ECR
6.  Kubernetes Deploy
7.  Verify Application
8.  Configure Backup

------------------------------------------------------------------------

# 19. Validation

Verified: - Terraform - EKS - GitHub Actions - ECR - Kubernetes -
LoadBalancer - MongoDB - Login - Todo CRUD - S3 Backup - Cron Automation

-

# 20. Conclusion

This project demonstrates a complete cloud-native DevOps lifecycle
including infrastructure provisioning, automated CI/CD, Kubernetes
deployment, secure networking, least-privilege IAM, persistent database
integration, and automated disaster recovery backups.

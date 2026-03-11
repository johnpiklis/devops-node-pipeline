DevOps Pipeline for Node.js Application

Endpoints:
http://localhost:3000/status
http://localhost:3000/health
curl -X POST http://localhost:3000/process \



This repository contains a production-ready DevOps pipeline and infrastructure setup for a simple Node.js web application. The project demonstrates how a modern DevOps workflow can be implemented using containerization, continuous integration, infrastructure as code, and secure deployment practices.

The goal of this project is to simulate the process of joining a fast-growing engineering team and delivering a reliable, scalable, and secure deployment pipeline for a backend application.


The solution includes:

Containerization using Docker

Automated CI/CD pipelines with GitHub Actions

Infrastructure provisioning with Terraform

Cloud deployment on Amazon Web Services

Security scanning with SonarQube and Snyk

Zero-downtime deployment strategies


Project Architecture:

The overall architecture follows modern DevOps and cloud-native principles.

Developer → GitHub Repository
        │
        ▼
GitHub Actions CI/CD Pipeline
        │
        ▼
Docker Image Build
        │
        ▼
Container Registry
        │
        ▼
AWS Infrastructure (Terraform)
        │
        ▼
Application Load Balancer
        │
        ▼
EC2 Instances / Container Runtime
        │
        ▼
Node.js Application

This architecture ensures:

High availability

Automated deployments

Secure infrastructure

Observability and monitoring

Application Overview

The application is a basic Node.js REST API running on port 3000.

Endpoints:

Endpoint	Method	Description
/health	GET	Returns application health status
/status	GET	Returns application running status
/process	POST	Simulates a processing request

Example response:

GET /health
{
 "status": "healthy"
}
Part 1 – Containerization

Containerization ensures that the application runs consistently across development, testing, and production environments.

This project uses Docker to package the application and its dependencies.

Dockerfile

The Dockerfile follows best practices including:

Multi-stage builds

Minimal base image

Non-root user execution

Reduced attack surface

Example build process:

Stage 1: Build dependencies
Stage 2: Copy only required files
Stage 3: Run application as non-root user


Benefits:

Smaller image size

Improved security

Faster deployments

Docker Compose

A docker-compose.yml file is provided for local development.

Services included:

Service	Purpose
Node.js App	API service
PostgreSQL / Redis	Database or cache

Example architecture:

Node.js Container
       │
       ▼
Database Container

Environment variables are configured for both services.

Example:

APP_PORT=3000
DB_HOST=database
DB_USER=postgres
DB_PASSWORD=securepassword

This allows developers to run the full environment locally.

Run locally with:

docker-compose up --build
Part 2 – CI/CD Pipeline (GitHub Actions)

Continuous Integration and Continuous Deployment are implemented using GitHub Actions.

The pipeline runs automatically on:

Push to main

Pull requests to main

CI/CD Workflow Stages
1. Install Dependencies

The pipeline installs project dependencies.

npm install
2. Run Tests

Automated API tests validate application functionality before deployment.

Endpoints tested:

GET /health
GET /status
POST /process

Testing ensures that broken code is not deployed.

3. Static Code Analysis

Code quality checks are performed using:

SonarQube

Linting tools

This helps detect:

Code smells

Bugs

Security vulnerabilities

4. Security Scanning

Container and dependency vulnerabilities are scanned using:

Snyk

This ensures:

Vulnerable libraries are detected early

Containers do not contain known CVEs

5. Build Docker Image

The application container image is built using Docker.

docker build -t devops-node-app .
6. Push to Container Registry

Images are pushed to:

Docker Hub
or

GitHub Container Registry

This allows the deployment infrastructure to pull the latest image automatically.

Part 3 – Infrastructure as Code (Terraform)

Infrastructure is provisioned using Terraform.

This ensures infrastructure is:

Reproducible

Version controlled

Scalable

Resources provisioned include:

Resource	Purpose
VPC	Network isolation
Subnets	Multi-availability zone deployment
Security Groups	Access control
EC2 Instances	Application compute
Application Load Balancer	Traffic distribution
SSL Certificate	HTTPS encryption

Example infrastructure layout:

VPC
 ├── Public Subnet (1a)
 ├── Public Subnet (1b)
 │
 └── Application Load Balancer
        │
        ▼
     EC2 Instances
        │
        ▼
    Node.js Containers
Terraform Workflow

Infrastructure is deployed using the standard Terraform workflow:

terraform init
terraform plan
terraform apply

Benefits include:

Infrastructure automation

Reduced manual configuration

Improved reliability

Part 4 – Deployment Strategy

To ensure high availability, the deployment strategy supports zero-downtime deployments.

Two strategies were considered:

Rolling Deployment

Instances are updated gradually without interrupting traffic.

Instance 1 → Update
Instance 2 → Update
Instance 3 → Update

This ensures service continuity.

Blue-Green Deployment

Two environments exist:

Environment	Role
Blue	Current production
Green	New version

Traffic is switched only after the new version is verified.

Benefits:

Instant rollback

No downtime

Safer deployments

Part 5 – Security and Observability

Security and monitoring are critical in production systems.

Several security best practices were implemented.

Secrets Management

Secrets are never stored in source code or GitHub repositories.

Sensitive data is stored using:

GitHub Secrets

Environment variables

Cloud secret management services

Examples:

DOCKERHUB_USERNAME
DOCKERHUB_PASSWORD
AWS_ACCESS_KEY
AWS_SECRET_KEY
HTTPS Encryption

All traffic to the application is encrypted using SSL certificates provisioned through AWS.

Benefits:

Secure data transmission

Protection against man-in-the-middle attacks

Container Security

The Docker container follows security best practices:

Runs as non-root user

Uses minimal base image

Only necessary ports exposed

Logging

Basic application logging is implemented using console logs.

Example:

console.log("Request received")

These logs can be integrated with cloud monitoring tools.

Health Checks

The /health endpoint allows infrastructure components such as load balancers to verify service availability.

Example usage:

GET /health

This enables automated failure detection and recovery.

Part 6 – Running the Application Locally
Prerequisites

Install the following tools:

Node.js

Docker

Docker Compose

Run Using Node.js
npm install
npm start

The application will run on:

http://localhost:3000
Run Using Docker

Build and run the container:

docker build -t devops-node-app.
docker run -p 3000:3000 devops-node-app
Run with Docker Compose
docker-compose up --build
Accessing the Application

Once deployed locally:

http://localhost:3000/health
http://localhost:3000/status

Example test request:

curl http://localhost:3000/health
Deploying the Application

Deployment steps:

Push code to GitHub

CI/CD pipeline runs automatically

Docker image is built

Image is pushed to container registry

Terraform deploys infrastructure

Load balancer routes traffic to application

Key Design Decisions

Several design choices were made to ensure reliability, security, and scalability.

Containerization

Docker ensures environment consistency across development and production.

CI/CD Automation

GitHub Actions provides automated builds and testing, ensuring faster delivery and reduced human errors.

Infrastructure as Code

Terraform was chosen to ensure infrastructure is fully reproducible and version controlled.

Security

Security scanning with SonarQube and Snyk helps identify vulnerabilities early in the development lifecycle.

Conclusion

This project demonstrates the implementation of a modern DevOps workflow capable of supporting a production-ready Node.js application.

Key highlights include:

Automated CI/CD pipeline

Containerized application

Infrastructure provisioning with Terraform

Cloud deployment on AWS

Security scanning and best practices

Zero-downtime deployment strategies

The architecture ensures scalability, reliability, and maintainability while following modern DevOps principles.

# Containerized Laravel Platform

## 1. Project Overview

This project demonstrates the implementation of a production-oriented DevOps environment for a containerized Laravel application.

The solution covers the complete DevOps lifecycle, including infrastructure provisioning, containerized application deployment, monitoring, centralized logging, automated backup and restore, and continuous integration/continuous deployment (CI/CD).

The primary goal of this project is to build a reliable, maintainable, and reproducible deployment environment by following industry best practices while keeping the architecture simple enough for a single-server deployment.

## 2. Solution Architecture

The solution consists of several integrated components:

- Linux Server (Ubuntu)
- Containerized Laravel Application
- MySQL Database
- Nginx Reverse Proxy
- Prometheus for Metrics Collection
- Grafana for Visualization
- Loki + Grafana Alloy for Centralized Logging
- Node Exporter & cAdvisor for Infrastructure Monitoring
- Jenkins for CI/CD Automation
- Shell Script + Cron Job for Backup Automation

The architecture is designed to keep the deployment simple while still following production-oriented DevOps practices.

> Architecture Diagram

![Architecture](docs/architecture.png)

## 3. Technology Stack

| Category                | Technology                  |
| ----------------------- | --------------------------- |
| Operating System        | Ubuntu Server 24.04 LTS     |
| Application             | Laravel 10 (Laravel Breeze) |
| Web Server              | Nginx                       |
| Database                | MySQL 8                     |
| Containerization        | Docker                      |
| Container Orchestration | Docker Compose              |
| CI/CD                   | Jenkins                     |
| Monitoring              | Prometheus                  |
| Dashboard               | Grafana                     |
| Logging                 | Loki                        |
| Log Collector           | Grafana Alloy               |
| Metrics Exporter        | Node Exporter, cAdvisor     |
| Backup                  | Shell Script + Cron         |
| Version Control         | Git & GitHub                |

## 4. Design Decisions

Several technologies were selected based on simplicity, maintainability, and production readiness.

| Technology     | Reason                                                           |
| -------------- | ---------------------------------------------------------------- |
| Ubuntu         | Stable, lightweight, and widely used in production environments. |
| DigitalOcean   | Simple provisioning process and cost-effective cloud platform.   |
| Docker         | Ensures consistent deployment across different environments.     |
| Docker Compose | Simplifies multi-container application management.               |
| Laravel        | Lightweight sample application with database integration.        |
| Jenkins        | Automates build, deployment, and delivery processes.             |
| Prometheus     | Efficient metrics collection with pull-based architecture.       |
| Grafana        | Powerful dashboard and visualization platform.                   |
| Loki           | Lightweight centralized logging integrated with Grafana.         |
| Grafana Alloy  | Collects and forwards logs to Loki.                              |

## 5. Infrastructure Provisioning

### Cloud Platform

This project uses **DigitalOcean** as the cloud provider.

DigitalOcean was selected because it offers:

- Simple virtual machine provisioning.
- Public IP availability.
- Reliable Ubuntu images.
- Easy SSH access.
- Cost-effective pricing.
- Suitable environment for Docker workloads.

### Server Specification

| Component        | Specification    |
| ---------------- | ---------------- |
| Operating System | Ubuntu 24.04 LTS |
| vCPU             | 2                |
| RAM              | 4 GB             |
| Storage          | 60 GB SSD        |
| Public Network   | Enabled          |
| Authentication   | SSH Key          |

### Provisioning Method

The virtual machine is provisioned manually through the DigitalOcean Control Panel.

After provisioning, server initialization is automated using shell scripts to install Docker, Docker Compose, configure firewall rules, and prepare the runtime environment.

This approach keeps the configuration consistent while reducing repetitive manual setup.

For production environments, Infrastructure as Code (IaC) using Terraform would be recommended to automate the entire provisioning process.

## 6. Containerization & Deployment

The application is fully containerized using Docker and orchestrated with Docker Compose. Each component runs inside its own dedicated container following the single responsibility principle.

### Application Stack

| Service     | Description                  |
| ----------- | ---------------------------- |
| Laravel App | PHP-FPM application          |
| Nginx       | Reverse proxy and web server |
| MySQL 8     | Relational database          |

### Docker Best Practices

The Docker image is built following several production-oriented best practices:

- Multi-stage Docker build
- Minimal runtime image
- Non-root application user (`www-data`)
- Environment variables managed through `.env`
- Docker Compose for multi-container orchestration
- Dedicated Docker bridge network
- Health check for PHP-FPM container

### Deployment Process

The deployment process is fully automated through Jenkins.

1. Build Docker image
2. Push image to Docker Hub
3. Pull latest image on the target server
4. Start containers using Docker Compose
5. Validate application availability

Using Docker ensures that every deployment uses the exact same application image, making deployments consistent, reproducible, and easy to maintain.

## 7. Monitoring & Logging

> This section will be completed after the monitoring stack has been implemented.

## 8. Backup & Restore Strategy

> This section will be completed after the backup and restore mechanism has been implemented.

## 9. CI/CD Pipeline

Continuous Integration and Continuous Deployment (CI/CD) are implemented using Jenkins Multibranch Pipeline.

### Pipeline Workflow

```text
Checkout Code
        │
        ▼
Setup Environment Config
        │
        ▼
Prepare Environment
        │
        ▼
Build Docker Image
        │
        ▼
Push to Docker Hub
        │
        ▼
Manual Approval (Production Only)
        │
        ▼
Deploy to Remote Server
        │
        ▼
Post Deployment Validation
```

### Pipeline Features

- Automatic source code checkout from GitHub
- Environment-specific configuration
- Docker image build automation
- Docker Hub integration
- Manual approval before production deployment
- Automated deployment through SSH
- Docker Compose based deployment
- Post-deployment validation

This pipeline minimizes manual deployment tasks while ensuring every deployment follows the same repeatable process.

## 10. Security Considerations

> This section will be updated after all infrastructure components have been secured.

## 11. Production Considerations

> This section will be updated after the complete solution has been implemented.

## 12. Future Improvements

> Future improvements will be documented after the project implementation has been completed.

## 13. Project Structure

> Repository structure will be documented after all project components have been organized.

## 14. Deployment Guide

> Deployment instructions will be added after the infrastructure implementation is finalized.

## 15. Screenshots

> Screenshots will be added after all components have been successfully deployed.

## 16. Author

**Denna Mandela**

DevOps Engineer

- GitHub: https://github.com/dennamandela
- LinkedIn: https://linkedin.com/in/dennamandela

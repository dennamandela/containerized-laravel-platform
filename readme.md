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
| Application             | Laravel 12 (Laravel Breeze) |
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
| RAM              | 2 GB             |
| Storage          | 60 GB SSD        |
| Public Network   | Enabled          |
| Authentication   | SSH Key          |

### Provisioning Method

The virtual machine is provisioned manually through the DigitalOcean Control Panel.

After provisioning, server initialization is automated using shell scripts to install Docker, Docker Compose, configure firewall rules, and prepare the runtime environment.

This approach keeps the configuration consistent while reducing repetitive manual setup.

For production environments, Infrastructure as Code (IaC) using Terraform would be recommended to automate the entire provisioning process.

## 6. Containerization & Deployment

## 7. Monitoring & Logging

## 8. Backup & Restore Strategy

## 9. CI/CD Pipeline

## 10. Security Considerations

## 11. Production Considerations

## 12. Future Improvements

## 13. Project Structure

## 14. Deployment Guide

## 15. Screenshots

## 16. Author

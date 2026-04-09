# ⭐ AWS DevSecOps End-to-End Platform

## 🔹 Overview

The Roboshop project is a microservices-based e-commerce application deployed on **AWS** using modern **DevOps practices**. **Packer** builds custom AMIs for EC2 instances and EKS nodes, while **Terraform** provisions the full infrastructure, including VPCs, subnets, EC2 databases, and an EKS cluster with both Spot and On-Demand node groups. **Cluster Autoscaler** ensures nodes scale automatically as pods increase with traffic, while **Horizontal Pod Autoscaler (HPA)** dynamically scales microservices based on CPU, memory, or custom metrics.

**GitHub Actions** pipelines automate CI/CD, building Docker images, running tests, and pushing updates. **ArgoCD** with Helm charts deploys services into EKS, ensuring consistent, version-controlled releases. Secrets and configuration values are managed securely with **Vault** and injected via **External-Secrets**, while **Ansible** automates OS-level configuration for EC2 instances.

Traffic management uses **ALB** for external requests (Layer-7) and **NLB** for internal service communication (Layer-4), while **Istio** enforces service-to-service security. Data in transit is encrypted with HTTPS/TLS, and data at rest is protected with **AWS KMS**. Observability is provided by **Prometheus, Grafana, ELK**, and **New Relic**, enabling monitoring, logging, tracing, and alerting.

Overall, Roboshop combines **automation, scalability, security, and observability** to deliver a robust, highly available e-commerce platform on AWS.


## 📊 Architecture Diagram

![Architecture](https://github.com/balusena/aws-devsecops-end-to-end-platform/blob/main/roboshop_architecture.png)

## 🔗 Tools Tech Stack

- **Cloud:** AWS (EKS, EC2, VPC, ALB, NLB, KMS, WAF)
- **Infrastructure as Code:** Terraform, Packer
- **Configuration Management:** Ansible
- **CI/CD:** GitHub Actions
- **GitOps:** ArgoCD, Helm
- **Containerization:** Docker, Kubernetes (EKS)
- **Security:** Vault, Istio (mTLS), TLS/SSL
- **Observability:** Prometheus, Grafana, ELK, New Relic, Kiali, Jaeger

## ✨ Key Features

- End to End DevSecOps Implementation
- Infrastructure as Code (Terraform + Packer)
- GitOps based Deployment (ArgoCD + Helm)
- Secure Secret Management (Vault + External Secrets)
- Service Mesh with Istio (mTLS, traffic control)
- Auto Scaling (HPA + Cluster Autoscaler)
- Full Observability (Metrics, Logs, Traces)
- Production Ready AWS Architecture

## 🔹 How Everything Works Together

1. **Packer builds images → `roboshop-packer-images`**
    - Creates AMIs for EC2 instances and EKS nodes with pre-installed dependencies and security hardening.

2. **Terraform creates infrastructure → `roboshop-terraform`**
    - Provisions EC2 instances, VPCs, subnets, route tables, EKS cluster with node groups, and supporting tools like Vault, ELK stack, and GitHub Runner.

3. **GitHub Actions runs CI/CD pipelines → `roboshop-github-actions`**
    - Automates builds, tests, Docker image creation, and deployment triggers.

4. **ArgoCD with Helm deploys apps into EKS → `roboshop-helm`**
    - Ensures version-controlled, consistent deployments using Helm charts.

5. **Configuration values fetched via Vault → `roboshop-config-values`**
    - Securely injects secrets and environment specific configurations into Kubernetes pods using External-Secrets.

6. **Ansible configures OS-level automation → `roboshop-ansible`**
    - Automates system setup, package installation, and application dependencies.

7. **Application runs via Docker images → built and deployed using GitHub Actions**

8. **Traffic management**
    - NLB handles internal traffic (Layer-4)
    - ALB handles external traffic (Layer-7)

9. **Security**
    - North-South: WAF, HTTPS, TLS/SSL
    - East-West: Istio Service Mesh for mTLS and policy enforcement

10. **Data protection**
    - In transit: HTTPS/TLS
    - At rest: AWS KMS

11. **Monitoring & Observability**
    - Metrics: Prometheus, New Relic
    - Visualization: Grafana, Kiali (Istio Service Mesh)
    - Logging: ELK Stack
    - Tracing: Jaeger (Distributed Tracing)
    - Alerts: Prometheus Alertmanager (emails via Amazon SES), New Relic

12. **Automation**
    - Bash/Python scripts for operational tasks

## 🔹 Project Layers

### 1. [roboshop-terraform](https://github.com/baludevopsb85/roboshop-terraform) → 🏗️ Infrastructure Layer
**Purpose:** Defines and provisions AWS infrastructure  
**Manages:** Environments (Dev/Stage/Prod), GitHub Workflows, Helm Charts, Vault, ELK, GitHub Runner, ELB (ALB/NLB), VPC, EKS, EC2, IAM roles, ECR, KMS, WAF  
**Why:** Automates infrastructure creation, ensures reproducibility, supports multi-environment deployment

### 2. [roboshop-helm](https://github.com/baludevopsb85/roboshop-helm) → 🚀 Application Deployment Layer
**Purpose:** Defines how apps run inside Kubernetes  
**Manages:** Deployments, Services, Ingress, Autoscaling, ConfigMaps, Secrets  
**Why:** Standardized deployments, versioning, rollback, environment-based configs

### 3. [roboshop-packer-images](https://github.com/baludevopsb85/roboshop-packer-images) → 🖼️ Image Build Layer
**Purpose:** Creates custom AMIs  
**Manages:** Base OS, Docker, security hardening, app dependencies  
**Why:** Faster, consistent, and secure deployments

### 4. [roboshop-config-values](https://github.com/baludevopsb85/roboshop-config-values) → ⚙️ Configuration Layer
**Purpose:** Environment-specific configuration management  
**Manages:** Dev/Prod configs, resource limits, URLs/endpoints  
**Why:** Separates config from code for safer deployments

### 5. [roboshop-github-actions](https://github.com/baludevopsb85/roboshop-github-actions) → 🔄 CI/CD Automation
**Purpose:** Automates build and deployment pipelines  
**Manages:** Terraform runs, image builds, deployment triggers  
**Why:** Eliminates manual work, ensures consistency, enables continuous delivery

### 6. [roboshop-ansible](https://github.com/baludevopsb85/roboshop-ansible) → ⚙️ Configuration Management
**Purpose:** Automates server configuration  
**Manages:** Package installation, system setup, app dependencies  
**Why:** Reusable automation scripts, used by Packer for image creation

### 7. APP → 🧪 Application Layer

**Microservices & Repositories:**
- [roboshop-frontend](https://github.com/baludevopsb85/roboshop-frontend)
- [roboshop-catalogue](https://github.com/baludevopsb85/roboshop-catalogue)
- [roboshop-cart](https://github.com/baludevopsb85/roboshop-cart)
- [roboshop-user](https://github.com/baludevopsb85/roboshop-user)
- [roboshop-payment](https://github.com/baludevopsb85/roboshop-payment)
- [roboshop-shipping](https://github.com/baludevopsb85/roboshop-shipping)
- [roboshop-dispatch](https://github.com/baludevopsb85/roboshop-dispatch)

**Purpose:** Core application code and business logic   
**Manages:** Microservices, Dockerfiles, CI/CD workflows, app configs  
**Contains:** frontend, catalogue, cart, user, payment, shipping, dispatch  

## 👥 Who Is This For?

> [!IMPORTANT]
> This collection is perfect for:
>
> - **DevOps & DevSecOps & MLOps Engineers**: Get quick access to the tools you use every day.
> - **Sysadmins**: Simplify operations with easy-to-follow guides.
> - **Developers**: Understand the infrastructure behind your applications.
> - **DevOps Newcomers**: Transform from beginner to expert with in-depth concepts and hands-on projects.

## 🛠️ How to Use This Repository

> [!NOTE]
> 1. **Explore the Categories**: Navigate through the folders to find the tool or technology you’re interested in.
> 2. **Use the Repositories**: Each repository is designed to provide quick access to the most important concepts and projects.

## 🤝 Contributions Welcome!

We believe in the power of community! If you have a tip, command, or configuration that you'd like to share, please contribute to this repository. Whether it’s a new tool or an addition to an existing content, your input is valuable.

## 📢 Stay Updated

This repository is constantly evolving with new tools and updates. Make sure to ⭐ star this repo to keep it on your radar!

## Liking the Project?

# ⭐❤️

If you find this project helpful, please consider giving it a ⭐! It helps others discover the project and keeps me motivated to improve it.

Thank you for your support!
---
## ✍🏼 Author

### Bala Senapathi
DevSecOps Engineer | Cloud & Automation | MLOps | AIOps | GitOps Specialist

![Author Image](https://github.com/balusena/aws-devsecops-end-to-end-platform/blob/main/banner.png)

---
Made with ❤️ and passion to contribute to the DevOps community by [Bala Senapathi](https://github.com/balusena)



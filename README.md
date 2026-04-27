# ⭐ AWS DevSecOps End-to-End Platform

## 🔹 Overview

The Roboshop project is a microservices-based e-commerce application deployed on **AWS** using modern **DevOps practices**. **Packer** builds custom AMIs for EC2 instances and EKS nodes, while **Terraform** provisions the full infrastructure, including VPCs, subnets, EC2 databases, and an EKS cluster with both Spot and On-Demand node groups. **Cluster Autoscaler** ensures nodes scale automatically as pods increase with traffic, while **Horizontal Pod Autoscaler (HPA)** dynamically scales microservices based on CPU, memory, or custom metrics.

**GitHub Actions** pipelines automate CI/CD, building Docker images, running tests, and pushing updates. **ArgoCD** with Helm charts deploys services into EKS, ensuring consistent, version-controlled releases. Secrets and configuration values are managed securely with **Vault** and injected via **External-Secrets**, while **Ansible** automates OS-level configuration for EC2 instances.

Traffic management uses **ALB** for external requests (Layer-7) and **NLB** for internal service communication (Layer-4), while **Istio** enforces service-to-service security. Data in transit is encrypted with HTTPS/TLS, and data at rest is protected with **AWS KMS**. Observability is provided by **Prometheus, Grafana, ELK**, and **New Relic**, enabling monitoring, logging, tracing, and alerting.

Overall, Roboshop combines **automation, scalability, security, and observability** to deliver a robust, highly available e-commerce platform on AWS.

---

## 📂 Project Structure

```text

aws-devsecops-end-to-end-platform/
│
├── roboshop-packer-images/
│   ├── golden-image-ansible/
│   │   └── ansible.pkr.hcl
│   │
│   ├── roles/
│   │   └── rhel9-hardended/
│   │       └── tasks/
│   │           └── main.yml
│   │
│   └── main.yml
│
├── roboshop-config-values/
│   ├── main.tf
│   ├── Makefile
│   ├── terraform.tf
│   └── variables.tf
│
├── roboshop-ansible/
│   ├── Makefile
│   ├── roboshop.yml
│   │
│   └── roles/
│       ├── cart/
│       │   ├── tasks/main.yml
│       │   └── templates/cart.service
│       │
│       ├── catalogue/
│       │   ├── files/mongo.repo
│       │   ├── tasks/main.yml
│       │   ├── templates/catalogue.service
│       │   └── vars/main.yml
│       │
│       ├── common/
│       │   ├── defaults/main.yml
│       │   ├── files/docker.repo
│       │   ├── node_exporter.service
│       │   └── tasks/
│       │       ├── app-prereq.yml
│       │       ├── docker.yml
│       │       ├── lvm.yml
│       │       ├── main.yml
│       │       ├── maven.yml
│       │       ├── node_exporter.yml
│       │       ├── nodejs.yml
│       │       ├── python.yml
│       │       └── systemd.yml
│       │
│       ├── elk/
│       │   ├── tasks/main.yml
│       │   └── templates/
│       │       ├── beats.conf
│       │       ├── elastic.repo
│       │       └── nginx.conf
│       │
│       ├── frontend/
│       │   ├── tasks/main.yml
│       │   ├── templates/nginx.conf
│       │   └── vars/main.yml
│       │
│       ├── github-runner/
│       │   ├── tasks/main.yml
│       │   ├── templates/docker.service
│       │   ├── github-runner.service
│       │   └── vars/main.yml
│       │
│       ├── mongodb/
│       │   ├── files/mongo.repo
│       │   ├── meta/main.yml
│       │   ├── tasks/main.yml
│       │   └── vars/main.yml
│       │
│       ├── mysql/
│       │   ├── meta/main.yml
│       │   ├── tasks/main.yml
│       │   └── vars/main.yml
│       │
│       ├── payment/
│       │   ├── tasks/main.yml
│       │   ├── templates/payment.service
│       │   └── vars/main.yml
│       │
│       ├── rabbitmq/
│       │   ├── files/eabbitmq.repo
│       │   ├── mets/main.yml
│       │   ├── tasks/main.yml
│       │   └── vars/main.yml
│       │
│       ├── redis/
│       │   ├── meta/main.yml
│       │   ├── tasks/main.yml
│       │   └── vars/main.yml
│       │
│       ├── shipping/
│       │   ├── tasks/main.yml
│       │   ├── templates/shipping.service
│       │   └── vars/main.yml
│       │
│       ├── user/
│       │   ├── tasks/main.yml
│       │   ├── templates/user.service
│       │   └── vars/main.yml
│       │
│       └── vault/
│           ├── files/hashicorp.repo
│           ├── files/vault.hcl
│           └── tasks/main.yml
│
├── roboshop-terraform/
│   ├── .github/workflows/
│   │   ├── apply.yml
│   │   ├── destroy.yml
│   │   └── helm-apply.yml
│   │
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tfvars
│   │   │   └── state.tfvars
│   │   └── prod/
│   │       ├── main.tfvars
│   │       └── state.tfvars
│   │
│   ├── helm-charts/
│   │   ├── environments/
│   │   │   ├── dev/
│   │   │   │   ├── main.tfvars
│   │   │   │   └── state.tfvars
│   │   │   └── prod/
│   │   │       ├── main.tfvars
│   │   │       └── state.tfvars
│   │   │
│   │   ├── helm-values/
│   │   │   ├── argo.yml
│   │   │   ├── cluster-issuer.yml
│   │   │   ├── filebeat.yml
│   │   │   ├── ingress.yml
│   │   │   └── kube-stack.yml
│   │   │
│   │   ├── alb.tf
│   │   ├── data.tf
│   │   ├── helm.tf
│   │   ├── iam.tf
│   │   ├── locals.tf
│   │   ├── Makefile
│   │   ├── provider.tf
│   │   └── variable.tf
│   │
│   ├── modules/
│   │   ├── ec2/
│   │   │   ├── data.tf
│   │   │   ├── iam.tf
│   │   │   ├── local.tf
│   │   │   ├── locals.tf
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   │
│   │   ├── eks/
│   │   │   ├── iam.tf
│   │   │   ├── main.tf
│   │   │   └── variables.tf
│   │   │
│   │   ├── vpc/
│   │   │   ├── locals.tf
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   │
│   │   └── tools/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   │
│   ├── main.tf
│   ├── Makefile
│   ├── provider.tf
│   └── variables.tf
│
├── roboshop-helm/
│   ├── env-dev/
│   │   ├── cart.yml
│   │   ├── catalogue.yml
│   │   ├── frontend.yml
│   │   ├── payment.yml
│   │   ├── shipping.yml
│   │   └── user.yml
│   │
│   ├── templates/
│   │   ├── _helpers.tpl
│   │   ├── database-job.yml
│   │   ├── deploy.yml
│   │   ├── external-secret.yml
│   │   ├── hpa.yml
│   │   ├── ingress.yaml
│   │   ├── istio.yaml
│   │   ├── service.yml
│   │   └── service-account.yaml
│   │
│   ├── Chart.yml
│   ├── Makefile
│   └── value.yaml
│
└── APP/
    │
    ├── roboshop-cart/
    │   ├── .github/workflows/
    │   │   ├── app-cicd-main.yml
    │   │   ├── cicd-branch.yml
    │   │   └── deploy.yml
    │   ├── Dockerfile
    │   ├── packer.json
    │   └── server.js
    │
    ├── roboshop-catalogue/
    │   ├── .github/workflows/
    │   │   ├── cicd-branch.yml
    │   │   ├── cicd-main.yml
    │   │   ├── deploy.yml
    │   │   └── schema-image-build.yml
    │   ├── db/
    │   │   ├── Dockerfile
    │   │   ├── master-data.js
    │   │   ├── mongo.repo
    │   │   └── run.sh
    │   ├── Dockerfile
    │   ├── package.json
    │   └── server.js
    │
    ├── roboshop-dispatch/
    │   └── main.go
    │
    ├── roboshop-frontend/
    │   ├── .github/workflows/
    │   │   ├── cicd-branch.yml
    │   │   ├── cicd-main.yml
    │   │   └── deploy.yml
    │   │
    │   ├── css/
    │   │   ├── auto-complete.css
    │   │   └── style.css
    │   │
    │   ├── js/
    │   │   ├── auto-complete.js
    │   │   └── controller.js
    │   │
    │   ├── images/
    │   │   ├── Aplha.png
    │   │   ├── CNA.png
    │   │   ├── EMM.png
    │   │   ├── EPE.png
    │   │   ├── Ewooid.png
    │   │   ├── HPTD.png
    │   │   ├── placeholder.png
    │   │   ├── RED.png
    │   │   ├── RMC.png
    │   │   ├── SHCE.png
    │   │   ├── STAN-1.png
    │   │   ├── UHJ.png
    │   ├── media/
    │   │   ├── graph.png
    │   │   ├── instana_icon_square.png
    │   │   └── stan.png
    │   │
    │   ├── cart.html
    │   ├── empty.html
    │   ├── eum.html
    │   ├── index.html
    │   ├── login.html
    │   ├── payment.html
    │   ├── product.html
    │   ├── search.html
    │   ├── shipping.html
    │   ├── splash.html
    │   ├── Dockerfile
    │   └── nginx.conf
    │
    ├── roboshop-payment/
    │   ├── .github/workflows/
    │   │   ├── cicd-branch.yml
    │   │   ├── cicd-main.yml
    │   │   └── deploy.yml
    │   ├── Dockerfile
    │   ├── payment.ini
    │   ├── payment.py
    │   ├── rabbitmq.py
    │   └── requirements.txt
    │
    ├── roboshop-shipping/
    │   ├── .github/workflows/
    │   │   ├── cicd-branch.yml
    │   │   ├── cicd-main.yml
    │   │   ├── deploy.yml
    │   │   └── schema-image-build.yml
    │   │
    │   ├── db/
    │   │   ├── app-user.sql
    │   │   ├── master-data.sql
    │   │   ├── schema.sql
    │   │   └── run.sh
    │   │
    │   ├── src/main/java/com/instana/roboshop/shipping/
    │   │   ├── Calculator.java
    │   │   ├── CartHelper.java
    │   │   ├── City.java
    │   │   ├── CityRepository.java
    │   │   ├── Code.java
    │   │   ├── CodeRepository.java
    │   │   ├── Controller.java
    │   │   ├── JpaConfig.java
    │   │   ├── RetryableDataSource.java
    │   │   ├── Ship.java
    │   │   ├── ShippingServiceApplication.java
    │   │
    │   ├── src/main/resources/application.properties
    │   ├── Dockerfile
    │   ├── pom.xml
    │   └── run.sh
    │
    └── roboshop-user/
        ├── .github/workflows/
        │   ├── app-cicd-main.yml
        │   ├── cicd-branch.yml
        │   └── deploy.yml
        ├── Dockerfile
        ├── packer.json
        └── server.js
        
```

---

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

---

## ✨ Key Features

- End to End DevSecOps Implementation
- Infrastructure as Code (Terraform + Packer)
- GitOps based Deployment (ArgoCD + Helm)
- Secure Secret Management (Vault + External Secrets)
- Service Mesh with Istio (mTLS, traffic control)
- Auto Scaling (HPA + Cluster Autoscaler)
- Full Observability (Metrics, Logs, Traces)
- Production Ready AWS Architecture

---

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
    - NLB handles internal traffic (Layer-4).
    - ALB handles external traffic (Layer-7).

9. **Security**
    - North-South: WAF, HTTPS, TLS/SSL.
    - East-West: Istio Service Mesh for mTLS and policy enforcement.

10. **Data protection**
    - In transit: HTTPS/TLS.
    - At rest: AWS KMS.

11. **Monitoring & Observability**
    - Metrics: Prometheus, New Relic.
    - Visualization: Grafana, Kiali (Istio Service Mesh).
    - Logging: ELK Stack.
    - Tracing: Jaeger (Distributed Tracing).
    - Alerts: Prometheus Alertmanager (emails via Amazon SES), New Relic.

12. **Automation**
    - Bash/Python scripts for operational tasks.

---

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

---

## 🖼️ Application Screenshots

**Application & Microservices Flow:**

![roboshop-application-flow](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-application-flow.png)

- ==> Screenshot displaying Roboshop landing page and list of Categories:

![roboshop-landing-page-categories-list](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-landing-page-categories-list.png)

**Screenshot displaying the Login/Register page to register the user to use Roboshop Application:**

![roboshop-login-register](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-login-register.png)

**Screenshot displaying the registered user information after login into the Roboshop Application:**

![roboshop-register-user-information](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-register-user-information.png)

**Screenshot displaying the empty cart for user bala senapathi before making the order:**

![roboshop-empty-user-cart](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-empty-user-cart.png)

**Screenshot displaying the addition of items to the user bala senapathi cart from list of categories:**

![roboshop-adding-item-to-user-cart](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-adding-item-to-user-cart.png)

**Screenshot displaying the Shopping cart for the user bala senapathi:**

![roboshop-shopping-user-cart](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-shopping-user-cart.png)

**Screenshot displaying the shipping information across the world with country and location info:**

![roboshop-shipping-information](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-shipping-information.png)

**Screenshot displaying the Review of order with Quantity, Item Name and Total Price:**

![roboshop-review-order-quantity](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-review-order-quantity.png)

**Screenshot displaying the payment confirmation with placed order and Order ID details:**

![roboshop-payment-confirmation-order](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-payment-confirmation-order.png)

**Screenshot displaying the order history with Order ID, Items, Total price with shipping details:**

![roboshop-full-order-details-history](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/app/roboshop-full-order-details-history.png)

---

## 🚀 Load Testing Roboshop Application

**Screenshot displaying running of load test on Roboshop application with 1000 Clients for 1 Hour:**

![roboshop-load-test](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test.png)

---

## 📊 Monitoring & Observability Dashboards

### Load Testing & Performance Observations

- HPA, node autoscaling, and pod health checks are enabled.
- Resources have been adjusted to handle higher load.
- Latency is still noticeable, likely due to slow database queries or application processing.
- Distributed tracing is recommended to pinpoint the exact bottleneck.

#### Load Test Scenario 1
![roboshop-load-test-1](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-1.png)

#### Load Test Scenario 2
![roboshop-load-test-2](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-2.png)

### APM Insights
- Most of the transaction time is spent on database queries.
- Application processing contributes only a minor portion to overall latency.

![roboshop-load-test-db-error](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-db-error.png)

#### Shipping Service Overview
- High-level view of the Shipping service in New Relic showing overall health, throughput, and error rates.

![roboshop-shipping-new-relic](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-shipping-new-relic.png)

### Shipping Transactions
- Detailed breakdown of transactions in the Shipping service.
- Shows latency per operation and identifies which requests are slower than expected.

![roboshop-shipping-transactions-new-relic](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-shipping-transactions-new-relic.png)

### Database Segment Time
- Time spent on database queries contributing to latency.
- Highlights segments where optimization is needed to reduce response times.

![roboshop-shipping-database-segment-time-new-relic](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-shipping-database-segment-time-new-relic.png)

### Optimization with Redis Caching
- Redis was deployed for Shipping to offload database queries.
- Latency has partially stabilized, showing noticeable improvement, though it hasn’t fully resolved the issue yet.

![roboshop-load-test-enable-db-redis](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-enable-db-redis.png)

### CI/CD Impact During Load
- During load, a CI/CD deployment of the Shipping application caused temporary errors.
- These errors were deployment-related and do not indicate system issues.

![roboshop-load-test-shipping-cicd](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-shipping-cicd.png)

### Post-Fix Load Testing
- Fixed database ignore settings for Shipping during deployment.
- Increased maximum resource limits for the service.
- Result: Application sustained the load successfully with no errors.

![roboshop-load-test-error-reduction](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-load-test-error-reduction.png)

### HPA Improvements

#### Before HPA
- Roboshop experienced higher latency under load.
- The application could not scale pods automatically, causing performance bottlenecks.

![roboshop-before-hpa-more-latency](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-before-hpa-more-latency.png)

#### After Adding HPA (Min 2 Pods)
- Automatic pod scaling helped distribute traffic evenly.
- Latency was reduced and performance improved during peak usage.

![roboshop-adding-hpa-min-2-pods](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-adding-hpa-min-2-pods.png)

#### HPA Handling Load Efficiently
- Load was not perfectly even across all pods, but HPA-managed pods handled traffic efficiently.
- Application responses remained good with reduced latency.

![roboshop-adding-hpa-response-good](https://raw.githubusercontent.com/balusena/aws-devsecops-end-to-end-platform/main/images/load/roboshop-adding-hpa-response-good.png)

---

## 👥 Who Is This For?

> [!IMPORTANT]
> This collection is perfect for:
>
> - **DevOps & DevSecOps & MLOps Engineers**: Get quick access to the tools you use every day.
> - **Sysadmins**: Simplify operations with easy-to-follow guides.
> - **Developers**: Understand the infrastructure behind your applications.
> - **DevOps Newcomers**: Transform from beginner to expert with in-depth concepts and hands-on projects.

---

## 🛠️ How to Use This Repository

> [!NOTE]
> 1. **Explore the Categories**: Navigate through the folders to find the tool or technology you’re interested in.
> 2. **Use the Repositories**: Each repository is designed to provide quick access to the most important concepts and projects.

---

## 🤝 Contributions Welcome!

We believe in the power of community! If you have a tip, command, or configuration that you'd like to share, please contribute to this repository. Whether it’s a new tool or an addition to an existing content, your input is valuable.

---

## 📢 Stay Updated

This repository is constantly evolving with new tools and updates. Make sure to ⭐ star this repo to keep it on your radar!

---

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

# 🚀 VProfile Dockerized Deployment on AWS using Terraform

Deploying the VProfile Java application on AWS using Docker, Docker Compose, Terraform, and an Application Load Balancer (ALB) with path-based routing.

---

# 📖 Project Overview

This project demonstrates how to provision AWS infrastructure using Terraform, deploy a multi-container Dockerized Java application, and expose multiple applications behind a single Application Load Balancer.

### Technologies Used

- AWS EC2
- AWS VPC
- AWS Application Load Balancer
- AWS Security Groups
- Terraform
- Docker
- Docker Compose
- Java (Spring)
- Tomcat
- MySQL
- RabbitMQ
- Memcached
- Nginx

---

# 🏗 Architecture Diagram

![Architecture Diagram](screenshots/architecture-diagram.png)

---

# 📐 Architecture

```
                    Internet
                        │
                        ▼
             Application Load Balancer
                     HTTP :80
                        │
         ┌──────────────┴──────────────┐
         │                             │
         ▼                             ▼
   /login , /signup              /second/*
         │                             │
         ▼                             ▼
   Java Application              Nginx Application
      (Tomcat)                    (Static Website)
         │
         │
 ┌───────┼───────────────────────┐
 │       │                       │
 ▼       ▼                       ▼
MySQL  RabbitMQ             Memcached
```

---

# 📁 Project Structure

```text
vprofile-dockerized
│
├── second-app/
├── src/
├── terraform/
│   ├── modules/
│   ├── templates/
│   ├── userdata/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   └── main.tf
│
├── docker-compose.yml
├── Dockerfile
├── Dockerfile.db
├── Dockerfile.mc
├── Dockerfile.rmq
└── README.md
```

---

# ⚙ Infrastructure Components

- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Groups
- EC2 Instance
- Application Load Balancer
- Target Groups
- Listener Rules

---

# 🐳 Docker Services

The deployment consists of five containers.

| Container | Purpose |
|------------|----------|
| Java App | Main Spring Application |
| MySQL | Database |
| RabbitMQ | Message Broker |
| Memcached | Cache |
| Nginx | Second Static Website |

---

# 🌐 ALB Routing

| URL | Destination |
|------|-------------|
| `/` | Java Application |
| `/login` | Java Application |
| `/signup` | Java Application |
| `/second/` | Nginx Application |

---

# 📸 Deployment Screenshots

## 1. Architecture Diagram

![Architecture](screenshots/architecture-diagram.png)

---

## 2. Terraform Deployment

Terraform successfully provisioned the AWS infrastructure.

![Terraform Apply](screenshots/terraform-deployment.png)

---

## 3. AWS Network (VPC & Subnets)

Custom VPC with networking resources created by Terraform.

![VPC](screenshots/vpc.png)

---

## 4. EC2 Instance

Docker host running all application containers.

![EC2](screenshots/ec2-instance.png)

---

## 5. Application Load Balancer

Internet-facing ALB exposing the applications.

![ALB](screenshots/alb.png)

---

## 6. Listener Rules

Path-based routing configuration.

- `/` → Java Application
- `/second/*` → Nginx Application

![Listener Rules](screenshots/listener-rules.png)

---

## 7. Target Groups

Healthy Target Groups attached to the ALB.

![Target Groups](screenshots/target-groups.png)

---

## 8. Docker Containers

Running Docker containers inside the EC2 instance.

```bash
docker ps
```

![Docker Containers](screenshots/docker-containers.png)

---

## 9. Java Application

VProfile Java application running successfully.

![Java App](screenshots/java-app.png)

---

## 10. Second Application

Nginx static website served through the ALB.

![Second App](screenshots/second-app.png)

---

# 🚀 Deployment Steps

### Clone Repository

```bash
git clone https://github.com/Mohamed-Mosad-98/vprofile-dockerized.git
cd vprofile-dockerized
```

### Initialize Terraform

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

### Deploy Containers

```bash
docker compose up --build -d
```

---

# ✅ Verification

Verify Docker containers

```bash
docker ps
```

Verify Java application

```
http://ALB-DNS/login
```

Verify second application

```
http://ALB-DNS/second/
```

---

# 📌 Key Features

- Infrastructure as Code using Terraform
- Modular Terraform Design
- Dockerized Multi-Service Application
- Secure AWS Networking
- Application Load Balancer
- Path-Based Routing
- Automated EC2 Provisioning
- Docker Compose Deployment
- Multi-stage Docker Build
- Production-ready Project Structure

---

# 👨‍💻 Author

**Mohamed Mosad**

GitHub

https://github.com/Mohamed-Mosad-98

LinkedIn

https://www.linkedin.com/in/mohamed-mosad-516aa717b/

---

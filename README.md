#  VProfile Dockerized Deployment on AWS using Terraform

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

<img width="1536" height="1024" alt="diagram" src="https://github.com/user-attachments/assets/4771f47c-cbad-441f-bdab-045a91fe6ea9" />

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


## 1. Terraform Deployment

Terraform successfully provisioned the AWS infrastructure.

<img width="1920" height="1080" alt="terraform apply" src="https://github.com/user-attachments/assets/2c285a38-5831-46ad-bdf7-78f01d9047fc" />


---

## 2. AWS Network (VPC & Subnets)

Custom VPC with networking resources created by Terraform.

<img width="1920" height="1080" alt="vpc" src="https://github.com/user-attachments/assets/8d43ca8d-fce4-4320-9169-fe7dfb8c3e5d" />


---


## 3. Application Load Balancer

Internet-facing ALB exposing the applications.

<img width="1920" height="1080" alt="LB" src="https://github.com/user-attachments/assets/3fb2752a-1acb-4d2e-b9a3-6dff9d75d5b2" />

---

## 4. Listener Rules

Path-based routing configuration.

- `/` → Java Application
- `/second/*` → Nginx Application
<img width="1920" height="1080" alt="LISITENER" src="https://github.com/user-attachments/assets/35b53f01-28f5-48dd-b082-08d798e07e52" />



---

## 5. Target Groups

Healthy Target Groups attached to the ALB.

<img width="1920" height="1080" alt="JAVA-TARGET GROUP" src="https://github.com/user-attachments/assets/8352ba76-21a8-4534-b1eb-4142fb764a64" />

<img width="1920" height="1080" alt="NGINX-TARGET GROUP" src="https://github.com/user-attachments/assets/ea9dd086-8468-437e-8086-f07f437a7bae" />


---

## 6. Docker Containers

Running Docker containers inside the EC2 instance.

```bash
docker ps
```

<img width="1920" height="1080" alt="DOCKER PS" src="https://github.com/user-attachments/assets/d17f88d6-47fb-429f-b538-3f91d5a59f34" />


---

## 7. Java Application

VProfile Java application running successfully.

<img width="1920" height="1080" alt="SIGN UP PAGE" src="https://github.com/user-attachments/assets/1d3e1dfc-1b35-4dd3-ae43-d4ad169b5269" />


---

## 8. Second Application

Nginx static website served through the ALB.

<img width="1920" height="1080" alt="SECOND APP" src="https://github.com/user-attachments/assets/3da46ad0-6530-4de1-ad33-87fd44630789" />


---

#  Deployment Steps

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

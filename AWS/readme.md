# AWS IAM and EC2 Overview

##  IAM (Identity and Access Management)

AWS IAM allows you to manage users, groups, roles, and permissions to securely control access to AWS services and resources.

---

###  User Creation
![alt text](/images/image.png)

---

###  Group Creation
![alt text](/images/image-1.png)

---

###  Attaching Policies to User Groups
![alt text](/images/image-2.png)

---

###  Creating a Role for EC2 Instance
This role allows EC2 instances to upload files directly to S3 without needing credentials.

![alt text](/images/image-3.png)

---

###  Attaching Role to EC2 Instance (Instance Profile)
Attach the created role to the EC2 instance to allow direct S3 uploads.

![alt text](/images/image-4.png)

---

##  IAM Permission Boundary

A **permission boundary** is an advanced IAM feature that defines the maximum level of permissions an IAM user or role can have — even if their policies grant more.

Think of it as a **“safety guardrail.”**

Even though the user has AdminAccess, the permission boundary limits them to only read access to S3.  
Everything else (EC2, IAM, CloudFormation, etc.) is blocked.

---

## Multi-Factor Authentication (MFA)

| Type | Examples | Description |
|------|-----------|-------------|
| **Virtual MFA App (TOTP-based)** | Google Authenticator, Authy, Microsoft Authenticator, 1Password, LastPass Authenticator | Generates a 6-digit one-time password (changes every 30 seconds). Installed on phone or computer. |
| **U2F / FIDO2 Security Key (Hardware)** | YubiKey, Feitian, Thetis Key, Titan Security Key | Physical USB/NFC key used for MFA authentication. More secure and phishing-resistant. |
| **Hardware Token (OATH TOTP)** | Gemalto, SurePassID, Symantec hardware tokens | Dedicated small keychain device that generates codes like an authenticator app. |
| **Smart Card / CAC (Enterprise SSO)** | PIV cards, corporate access cards | Used in organizations with centralized identity systems (e.g., military or enterprise). |
| **SMS-based MFA (Deprecated)** | Text message with OTP | Used previously, now not recommended for IAM due to weaker security and possible unavailability. |

---

##  AWS Access Analyzer

**What It Actually Does:**

Access Analyzer automatically scans and analyzes resource-based policies across your AWS account or organization.  
It creates findings whenever:

- A resource is **publicly accessible** (e.g., an open S3 bucket)
- A resource is **shared with another AWS account**, organization, or external identity provider

It uses **automated reasoning (mathematical logic)** to simulate access paths and determine if anyone outside your account could access your data.

---

##  EC2 Overview

###  EC2 Instance Types

There are **7 major types** of EC2 instances.

Example: `m5.2xlarge`  
- `m`: instance class  
- `5`: generation  
- `2xlarge`: size within the class

---

## EC2 Purchasing Options

| Option | Description | Best For |
|---------|-------------|-----------|
| **On-Demand Instances** | Pay per second/hour for compute capacity. No long-term commitment. | Short-term, unpredictable workloads. |
| **Reserved Instances (RI)** | Commit for 1 or 3 years to a specific instance type and region for up to 75% discount. | Steady workloads. |
| **Savings Plans** | Commit to spend a fixed amount (e.g., $100/month) for flexible discounts. | Workloads that change instance types or regions. |
| **Spot Instances** | Buy unused capacity at up to 90% discount. Can be reclaimed anytime. | Fault-tolerant or batch jobs. |
| **Dedicated Hosts / Instances** | Physical servers dedicated to your account. | Compliance or licensing needs. |
| **Capacity Reservations** | Reserve capacity in a specific AZ for guaranteed availability. | Mission-critical workloads. |

---

##  EC2 Tenancy

Tenancy defines how your EC2 instance is placed on AWS infrastructure.

| Tenancy Type | Description | Use Case |
|---------------|-------------|-----------|
| **Shared (Default)** | Multiple customers share same hardware, isolated virtually. | Most common and cost-effective. |
| **Dedicated Instance** | Runs on hardware dedicated to your account. | Physical isolation from other customers. |
| **Dedicated Host** | You control a full physical server for compliance or licensing. | BYOL (Bring Your Own License) or regulated workloads. |

---

## ⚡ Spot Instances & Spot Fleet

### Spot Instance
- Uses **unused EC2 capacity** at up to **90% discount**
- AWS can **reclaim** the instance anytime (2-minute warning)
- Great for:  
  - Data analysis  
  - CI/CD runners  
  - Machine learning training  
  - Video rendering  

### Spot Fleet
A **Spot Fleet** is a collection of Spot + On-Demand instances.

You define:
- Desired capacity  
- Launch specifications  
- Budget or price limits  

AWS automatically launches the **cheapest combination** to meet your needs.

---

##  Placement Groups

Placement Groups control how your EC2 instances are **physically placed** in AWS data centers to optimize performance or fault tolerance.

| Type | Description | Use Case |
|-------|--------------|----------|
| **Cluster Placement Group** | Instances close together in one AZ for low latency, high throughput. | HPC, Big Data. |
| **Spread Placement Group** | Instances on distinct racks for fault isolation. | Small number of critical instances. |
| **Partition Placement Group** | Divides instances into logical partitions across racks. | Distributed systems (HDFS, Cassandra). |

---

##  Elastic Network Interface (ENI)

An **ENI** is a virtual network card attached to EC2 instances in a VPC.

Each ENI includes:
- Private IP address  
- One or more secondary IPs  
- MAC address  
- Security groups  

---

##  EC2 Hibernate

EC2 **Hibernate** saves the instance’s **in-memory (RAM) state** to its EBS volume when stopped, so when restarted, it resumes instantly from where it left off.

---

##  EC2 Instance Families

| Family | Example Types | Best For |
|---------|----------------|----------|
| **General Purpose** | T, M | Balanced compute, memory, and network. |
| **Compute Optimized** | C | High-performance computing. |
| **Memory Optimized** | R, X, Z | Memory-intensive workloads. |
| **Storage Optimized** | I, D, H | High storage throughput and capacity. |

---


# EBS (Elastic Block Storage)

Amazon EBS allows you to create storage volumes and attach them to Amazon EC2 instances. Once attached, you can create a file system on top of these volumes.

An Amazon EBS Snapshot is a point-in-time backup of your EBS volume.

- Back up your data for disaster recovery.

- Create new volumes with the same data.

- Move data between regions or accounts.

#### Snapshots are stored in Amazon S3 (managed by AWS internally) snapshots are stored in S3 internally, AWS manages that storage behind the scenes — it’s not in your visible S3 buckets.

#### we can sell our AMI on marketplace 

Types of EBS volumes



SSD-based (General Purpose / Provisioned IOPS)	Optimized for low latency and high IOPS (transactions per second).	gp2, gp3, io1, io2
HDD-based (Throughput Optimized / Cold)	Optimized for large, sequential workloads.	st1, sc1
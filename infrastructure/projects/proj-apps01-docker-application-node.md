---
title: "Proj-Apps01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-Apps01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "applications", "docker", "portainer"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.3"
status: "Draft"
last_updated: "2025-03-07"
---

# **Proj-Apps01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-Apps01 is the **primary application server** for the Proxmox Astronomy Lab, running **containerized applications using Docker and Portainer** on **Ubuntu 24.04**. It provides **centralized deployment, management, and execution of project-level services**, including **source control, dashboards, API gateways, and collaboration tools**.

This server is optimized for **microservices, visualization dashboards, API management, and secure service deployment**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | APPS-01 |
| **Service Type**   | Application Hosting Infrastructure |
| **Service Category** | Project Services Deployment |
| **Business Criticality** | High |
| **Service Owner**  | Lab Engineer |

### **1.3 Service Hours**  

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Best-effort during business hours |
| **Maintenance Windows** | As required, change-controlled |

---

## **2. Service Level Agreements**  

### **2.1 Service Level Targets**  

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Application Uptime** | 99.99% | Prometheus monitoring |
| **Container Start Time** | â‰¤ 5s | Docker stats |
| **Backup Sync Interval** | â‰¤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Container performance & health monitoring |
| **Grafana** | Service execution and visualization |
| **Loki** | Log aggregation for application events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-Apps01 is a **Docker-based application server** running **Portainer** for **centralized container management and orchestration**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-apps01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 12GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Container Storage) |
| **Networking** | VLAN20 (Production) |
| **Container Engine** | Docker 24.x |
| **Management Tool** | Portainer |

### **3.3 Application & Container Configuration**  

| **Category** | **Application** | **Container Name** | **Port** | **Access Level** |
|-------------|---------------|----------------|------|---------------|
| **Source Control** | Gitea (project-specific) | gitea | 3001 | Developers |
| **Visualization** | Grafana (project-specific) | grafana-server | 3000 | Engineers |
| **File Collaboration** | Nextcloud | nextcloud | 8082 | Project Teams |
| **Web Interfaces** | NGINX | nginx | 80/443 | Public/Restricted |
| **Dashboard** | Dashy (project-specific) | dashy | 4000 | Admins |
| **API Gateway** | Kong | kong-api | 8000 | Microservices |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | Docker Volume Snapshots + Proxmox Snapshots |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Portainer RBAC, Entra ID Authentication |
| **Logging & Auditing** | Wazuh + Loki + Docker Logs |
| **Container Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Docker Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Encryption & Protection** | ISO 27001 |

---

## **5. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | â± Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.3 | 2025-03-07 | Fully aligned with service documentation template, restored missing sections |


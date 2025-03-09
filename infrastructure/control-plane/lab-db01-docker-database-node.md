---
title: "Lab-DB01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-DB01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "database", "portainer", "docker"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Lab-DB01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-DB01 is a **Portainer worker node** managed by **Lab-Port01**, responsible for hosting **containerized database services** used across the Proxmox Astronomy Lab. It provides **structured and time-series data management, high-performance storage, and secure access for applications** running on **Lab-Apps01 and Proj-Apps01**.

This node is part of the **Portainer-managed cluster**, ensuring **consistent deployment, database orchestration, and security enforcement**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | DB-01 |
| **Service Type**   | Database Hosting Infrastructure |
| **Service Category** | Containerized Database Services |
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
| **Database Uptime** | 99.99% | Prometheus monitoring |
| **Query Response Time** | ≤ 50ms | Grafana query analysis |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Database performance & health monitoring |
| **Grafana** | Query execution and latency visualization |
| **Loki** | Log aggregation for database events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Database snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-DB01 is a **Portainer worker node** controlled by **Lab-Port01**, running **containerized database services for structured and time-series data storage**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-db01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Database Storage) |
| **Networking** | VLAN20 (Production) |
| **Container Engine** | Docker 24.x |
| **Management Tool** | Portainer (Controlled by Lab-Port01) |

### **3.3 Database Services & Configuration**  

| **Database** | **Container Name** | **Port** | **Usage** |
|-------------|----------------|------|---------------|
| **PostgreSQL** | postgres | 5432 | General structured data |
| **TimescaleDB** | timescaledb | 5433 | Time-series data processing |
| **MariaDB** | mariadb | 3306 | Application-based storage |
| **Redis** | redis-cache | 6379 | In-memory caching |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | Database Snapshots + Docker Volume Backups |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Portainer RBAC, Entra ID Authentication |
| **Logging & Auditing** | Wazuh + Loki + PostgreSQL Logs |
| **Database Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS PostgreSQL & Docker Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Encryption & Protection** | ISO 27001 |

---

## **5. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial version, defines Lab-DB01 as a Portainer worker node controlled by Lab-Port01 |

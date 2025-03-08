---
title: "Lab-Apps01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-Apps01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "applications", "portainer", "docker"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Lab-Apps01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-Apps01 is a **Portainer worker node** managed by **Lab-Port01**, responsible for hosting **lab-wide applications and containerized services** within the Proxmox Astronomy Lab. It provides **essential infrastructure services, monitoring applications, and internal tools** that support research operations and system management.

This node is part of the **Portainer-managed cluster**, ensuring **standardized deployment, container orchestration, and security enforcement**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | APPS-02 |
| **Service Type**   | Application Hosting Infrastructure |
| **Service Category** | Lab Services Deployment |
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
| **Container Start Time** | ≤ 5s | Docker stats |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
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

Lab-Apps01 is a **Portainer worker node** controlled by **Lab-Port01**, running **containerized applications and lab-wide services**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-apps01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 8GB |
| **Storage** | 32GB C:\ (OS) + 250GB D:\ (Container Storage) |
| **Networking** | VLAN20 (Production) |
| **Container Engine** | Docker 24.x |
| **Management Tool** | Portainer (Controlled by Lab-Port01) |

### **3.3 Application & Container Configuration**  

| **Category** | **Application** | **Container Name** | **Port** | **Access Level** |
|-------------|---------------|----------------|------|---------------|
| **Monitoring** | Prometheus | prometheus | 9090 | Engineers |
| **Logging** | Loki | loki | 3100 | Engineers |
| **Visualization** | Grafana | grafana | 3000 | Engineers |
| **Service Discovery** | Traefik | traefik | 80/443 | System |
| **Security** | Wazuh Agent | wazuh | 1514 | Admins |

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
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial version, defines Lab-Apps01 as a Portainer worker node controlled by Lab-Port01 |

---
title: "Lab-Port01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-Port01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "portainer", "container-management"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.1"
status: "Draft"
last_updated: "2025-03-07"
---

# **Lab-Port01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-Port01 is the **centralized Portainer control node** for managing **containerized workloads across Portainer worker nodes** within the Proxmox Astronomy Lab. It provides **container lifecycle management, orchestration, and security enforcement** for **Proj-Apps01, Lab-Apps01, Lab-DB01, and other worker nodes**.

This node serves as the **GUI and API control plane**, allowing for **role-based access, container policy enforcement, and automated service deployment**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | PORT-01 |
| **Service Type**   | Container Orchestration Infrastructure |
| **Service Category** | Containerized Application Management |
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
| **Container Management Availability** | 99.99% | Prometheus monitoring |
| **Deployment Time for New Services** | â‰¤ 1 minute | Portainer logs |
| **Backup Sync Interval** | â‰¤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Container performance & health monitoring |
| **Grafana** | Service execution and visualization |
| **Loki** | Log aggregation for container events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-Port01 is the **Portainer control node**, managing **multiple Portainer worker nodes** that run project and lab-level applications.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-port01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 8GB |
| **Storage** | 32GB C:\ (OS) + 250GB D:\ (Portainer Data) |
| **Networking** | VLAN20 (Production) |
| **Container Engine** | Docker 24.x |
| **Management Tool** | Portainer CE |

### **3.3 Managed Worker Nodes**  

| **Worker Node** | **Purpose** | **Role** |
|---------------|-----------|--------|
| **Proj-Apps01** | Project-specific applications | Portainer Worker |
| **Lab-Apps01** | Lab-level services | Portainer Worker |
| **Lab-DB01** | Database hosting | Portainer Worker |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | Docker Volume Snapshots + Proxmox Snapshots |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Service Management**  

### **4.1 Access Management**  

| **User Role** | **Access Level** | **Authorization Process** |
|--------------|----------------|---------------------------|
| **Lab Engineer** | Full Admin | Portainer Superuser Role |
| **Infrastructure Ops** | Container Monitoring | Role-Based Access |
| **Service Desk** | Read-Only | Ticket-Only Access |
| **Change Manager** | Approves containerized changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Portainer Control Node Down** | High | P1 | 15 min | 4 hours |
| **Container Deployment Failure** | Medium | P2 | 30 min | 6 hours |
| **Unauthorized API Access** | Critical | P1 | Immediate | Investigation & Lockdown |

### **4.3 Change Management**  

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Standard** | No | Pre-approved | Next maintenance window |
| **Normal** | Yes | CAB Approval | Scheduled downtime |
| **Emergency** | Yes | Immediate | ASAP |

---

## **5. Security and Compliance**  

### **5.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Portainer RBAC, Entra ID Authentication |
| **Logging & Auditing** | Wazuh + Loki + Docker Logs |
| **Container Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Docker Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Encryption & Protection** | ISO 27001 |

---

## **6. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | â± Pending |

---

## **7. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.1 | 2025-03-07 | Fully realigned to template, added missing sections |


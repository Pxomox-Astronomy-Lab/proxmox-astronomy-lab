<!-- ---
title: "Lab-Ansible01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-Ansible01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "automation", "ansible", "awx"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Lab-Ansible01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-Ansible01 is the **primary automation and configuration management server** for the Proxmox Astronomy Lab. It runs **Ansible and AWX on Ubuntu 24.04**, providing **infrastructure as code (IaC) capabilities, automated provisioning, and system state enforcement** across all managed nodes.

This node ensures **consistent system deployments, repeatable configurations, and automated compliance enforcement**, supporting both **infrastructure and application-level automation**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | ANS-01 |
| **Service Type**   | Automation & Configuration Management |
| **Service Category** | Infrastructure as Code (IaC) |
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
| **Playbook Execution Time** | ≤ 10 minutes | AWX job logs |
| **Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | System performance & job execution monitoring |
| **Grafana** | Playbook execution & automation metrics visualization |
| **Loki** | Log aggregation for automation events |
| **Wazuh** | Security monitoring & compliance tracking |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-Ansible01 runs **Ansible and AWX on Ubuntu 24.04**, providing **centralized automation and orchestration capabilities**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-ansible01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 8GB |
| **Storage** | 32GB C:\ (OS) + 250GB D:\ (Automation Data) |
| **Networking** | VLAN10 (Control Plane) |
| **Automation Stack** | Ansible, AWX |

### **3.3 Automation & Orchestration Services**  

| **Service** | **Type** | **Port** | **Purpose** |
|------------|---------|------|---------------|
| **Ansible** | Native Service | CLI-based | Configuration management |
| **AWX** | Web UI | 8052 | Automation execution & orchestration |
| **Redis** | Native Service | 6379 | AWX job queue |
| **PostgreSQL** | Native Service | 5432 | AWX metadata storage |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | System Snapshots + Config Backups |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID Authentication, RBAC Enforcement |
| **Logging & Auditing** | Wazuh + Loki + Ansible Logs |
| **Automation Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Ansible & Ubuntu Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Integrity & Protection** | ISO 27001 |

---

## **5. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial version, defines Lab-Ansible01 as the automation & configuration management server |



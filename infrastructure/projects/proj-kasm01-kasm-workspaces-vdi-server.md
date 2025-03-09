---
title: "Proj-KASM01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-KASM01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "kasm", "virtual-desktop", "security"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Proj-KASM01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-KASM01 is the **Kasm Workspaces server** for the Proxmox Astronomy Lab, running **Kasm on Ubuntu 24.04**. It provides **secure, isolated, and browser-based virtual desktop environments** for research, administration, and secure access to sensitive workloads.

This node ensures **segmented and controlled access to virtualized environments**, supporting **containerized remote desktops, secure browsing, and sandboxed development**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | KASM-01 |
| **Service Type**   | Virtual Desktop Infrastructure (VDI) |
| **Service Category** | Secure Virtual Workspaces |
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
| **Session Startup Time** | ≤ 10s | Kasm logs |
| **Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Virtual session health monitoring |
| **Grafana** | Session performance visualization |
| **Loki** | Log aggregation for session events |
| **Wazuh** | Security monitoring & intrusion detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-KASM01 runs **Kasm Workspaces on Ubuntu 24.04**, providing **containerized, browser-based virtual desktops for secure and isolated workloads**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-kasm01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 8 vCPUs |
| **RAM** | 32GB |
| **Storage** | 128GB C:\ (OS) + 1TB D:\ (Workspace Storage) |
| **Networking** | VLAN20 (Production) |
| **Virtual Desktop Software** | Kasm Workspaces |

### **3.3 Virtual Desktop Services**  

| **Workspace Type** | **Purpose** |
|------------------|------------|
| **Secure Browser** | Isolated web access |
| **Linux Desktop** | Research & administrative use |
| **Development Environment** | Sandboxed coding workspace |
| **Custom Containers** | Specialized workloads & apps |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | System Backups + Configuration Snapshots |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID Authentication, RBAC Enforcement |
| **Logging & Auditing** | Wazuh + Loki + Kasm Logs |
| **Session Isolation** | Enforced via containerization |
| **Encryption** | TLS for remote sessions, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Ubuntu & VDI Benchmark Compliance |
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
| 1.0 | 2025-03-07 | Initial version, defines Proj-KASM01 as the Kasm Workspaces virtual desktop infrastructure server |

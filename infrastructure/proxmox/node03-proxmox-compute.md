<!-- ---
title: "Node03 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Node03, including infrastructure, security, compliance, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "compute", "itil", "proxmox"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Node03 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Node03 is a **general-purpose compute node** within the Proxmox Astronomy Lab, supporting **database workloads, DNS services, and research compute tasks**. It plays a crucial role in **maintaining lab-wide database services, DNS resolution, and GIS processing.**

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | NODE03-003 |
| **Service Type**   | Core Infrastructure |
| **Service Category** | Compute |
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
| **Availability** | 99.9% uptime | Prometheus alerts |
| **Performance** | Low-latency compute | Grafana metrics |
| **Recovery Time** | RTO: 4 hours | Proxmox restore test |
| **Recovery Point** | RPO: 1 week | PBS verification |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | System health, resource usage |
| **Loki** | Log aggregation for debugging |
| **Grafana** | Visual dashboards for monitoring trends |
| **Wazuh** | Security monitoring, intrusion detection |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Node03 runs on **Proxmox VE**, providing **database, DNS, and compute resources** for research and infrastructure workloads.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | compute-database-03 |
| **OS** | Proxmox VE 8 |
| **CPU** | AMD Ryzen 5700U |
| **RAM** | 64GB DDR4 |
| **Storage** | 2TB NVMe (Samsung PM893 Enterprise) |
| **Networking** | 1Gbps (Management - VLAN5) + 2.5Gbps (VM Traffic - VLAN10) + All VLANs mapped via Linux Bridges |

### **3.3 Dependencies**  

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox Cluster | No HA, manual VM balancing monthly |
| **Required By** | proj-pg01, proj-pggis01, lab-dns01, lab-dns02 | Compute loss for database and DNS workloads |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | Proxmox Backup Server |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 week |

---

## **4. Service Management**  

### **4.1 Access Management**  

| **User Role** | **Access Level** | **Authorization Process** |
|--------------|----------------|---------------------------|
| **Lab Engineer** | Full Admin | Proxmox RBAC |
| **Database Admin** | PostgreSQL & GIS Management | DB Role-Based Access |
| **Infrastructure Ops** | Resource Management | Role-Based |
| **Service Desk** | Limited Read | Ticket-Only Access |
| **Change Manager** | Approves infrastructure changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Node Offline** | High | P1 | 15 min | 4 hours |
| **Performance Issue** | Medium | P2 | 1 hour | 24 hours |

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
| **Access Control** | SSH Key-Based Access |
| **Disk Encryption** | LUKS for NVMe storage |
| **Logging & Auditing** | Wazuh + Loki |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CISv8.1 Level 1 (Nodes), CISv8.1 Level 2 (Ubuntu 24 Servers), CISv9 Level 1 (Server 2025) |
| **Security Monitoring** | NIST 800-53 |
| **Backup & Recovery** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **Infrastructure Overview** | Proxmox Astronomy Lab Infrastructure |
| **Security Policy** | CISv8 Compliance Framework |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial documentation for Node03 with service classification, dependencies, access management, and compliance details |



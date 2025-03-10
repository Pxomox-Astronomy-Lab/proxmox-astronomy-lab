<!-- ---
title: "Proj-FS01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-FS01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "file-server", "windows-server", "storage"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Proj-FS01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-FS01 is the **primary Windows file server** for the Proxmox Astronomy Lab, running **Windows Server 2025**. It provides **centralized file storage, shared directories, and access-controlled data repositories** for various lab services and administrative users.

It is configured with **NTFS permissions, Access-Based Enumeration (ABE), and storage quotas**, ensuring **secure, organized, and efficient file access**. All access is strictly controlled via **Entra ID-based authentication**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | FS-01 |
| **Service Type**   | File Storage Infrastructure |
| **Service Category** | Storage & Data Management |
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
| **File Share Availability** | 99.99% uptime | Prometheus monitoring |
| **Read/Write Latency** | ≤ 5ms | Grafana network monitoring |
| **Data Recovery Time** | RTO: 4 hours | Restore test validation |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Windows Server health monitoring |
| **Grafana** | File share performance visualization |
| **Loki** | Log aggregation for file access & security events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | File system backup status |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-FS01 is a **Windows Server 2025-based file server**, providing **centralized and secure file storage** for all lab operations.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-fs01.beardinthe.cloud |
| **OS** | Windows Server 2025 |
| **CPU** | 2 vCPUs |
| **RAM** | 6GB |
| **Storage** | 32GB C:\ (OS) + 250GB D:\ (File Shares) |
| **Networking** | VLAN20 (Production) |
| **Storage Quotas** | Enforced per user group |
| **Access Control** | NTFS Permissions + Entra Authentication |

### **3.3 File Share Configuration**  

| **Share Name** | **Path** | **Permissions** |
|--------------|------|-------------|
| **Admin** | `D:\Shares\Admin` | Domain Admins Only |
| **Engineering** | `D:\Shares\Engineering` | Engineers & IT Staff |
| **Projects** | `D:\Shares\Projects` | Assigned Research Groups |
| **Public** | `D:\Shares\Public` | Read-Only for All Users |

### **3.4 Access Control & Authentication**  

- **User Authentication:** Entra ID-integrated authentication (No local accounts)
- **Access Control:** NTFS permissions with **least privilege model**
- **Conditional Access Policies:** Enforced for privileged file shares
- **Encryption:** BitLocker-enabled volumes

### **3.5 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | Windows Server Backup + Proxmox Snapshots |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Service Management**  

### **4.1 Access Management**  

| **User Role** | **Access Level** | **Authorization Process** |
|--------------|----------------|---------------------------|
| **Lab Engineer** | Full Admin | NTFS Permissions + Entra RBAC |
| **Infrastructure Ops** | File Share Management | Role-Based Access |
| **Service Desk** | Read-Only | Ticket-Only Access |
| **Change Manager** | Approves storage policy changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **File Server Down** | High | P1 | 15 min | 4 hours |
| **Storage Quota Reached** | Medium | P2 | 30 min | 6 hours |
| **Unauthorized File Access** | Critical | P1 | Immediate | Investigation & Lockdown |

---

## **5. Security and Compliance**  

### **5.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID RBAC, NTFS Permissions |
| **Logging & Auditing** | Wazuh + Loki + Windows Event Logs |
| **File Share Hardening** | CIS-recommended policies enforced |
| **Conditional Access** | Location & Device Compliance enforced |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CISv9 Level 1 (Windows Server 2025) |
| **Security Monitoring** | NIST 800-53 |
| **Data Encryption & Protection** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **File Server Policy** | Storage Quota & Access Management |
| **Backup & Recovery Plan** | Disaster Recovery Guidelines |
| **NTFS Permission Structure** | Role-Based Access Policy |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |



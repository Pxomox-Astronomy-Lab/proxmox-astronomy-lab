<!-- ---
title: "RDS01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of RDS01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "remote-desktop", "windows-server", "entra"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **RDS01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

RDS01 is the **Remote Desktop Services (RDS) server** for the **beardinthe.cloud** environment, running **Windows Server 2025** with **Office 2024 LTSC**. It provides **a secure remote desktop environment** for **administrators and technical support staff** who require access to **management tools and enterprise applications**.

All access to RDS01 is **strictly controlled via Entra Private Access**, ensuring that **no open firewall ports** are exposed. **Privileged role access requires passwordless Multi-Factor Authentication (MFA)** for additional security.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | RDS-01 |
| **Service Type**   | Remote Desktop Infrastructure |
| **Service Category** | Virtual Desktop Services |
| **Business Criticality** | Medium |
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
| **RDS Availability** | 99.9% uptime | Prometheus monitoring |
| **Session Latency** | ≤ 100ms | Grafana network monitoring |
| **MFA Compliance** | 100% | Entra ID logs |
| **Recovery Time** | RTO: 4 hours | VM restore test |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Windows Server health monitoring |
| **Grafana** | Performance visualization |
| **Loki** | Log aggregation for RDS events |
| **Wazuh** | Security monitoring and intrusion detection |
| **Entra Audit Logs** | MFA & login activity monitoring |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

RDS01 is a **Windows Server 2025-based Remote Desktop Services (RDS) host**, providing **desktop access** for administrative and technical support tasks.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | rds01.beardinthe.cloud |
| **OS** | Windows Server 2025 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 125GB C:\ (OS) + 100GB D:\ (User Profiles) |
| **Networking** | VLAN20 (Production) |
| **RDS Role** | Session Host |
| **Authentication** | Entra Private Access + MFA |

### **3.3 Access Control & Authentication**  

- **Access Method:** **Only accessible via Entra Private Access** (No direct RDP exposure)
- **User Authentication:** **MFA required** for privileged accounts
- **Passwordless Authentication:** Enforced for **Admin-level roles**
- **Session Timeouts:** Configured per security policy

### **3.4 Installed Applications**  

- **Microsoft Office 2024 LTSC** (Excel, Word, Outlook, PowerPoint, Access)
- **Windows Admin Center** (Remote server management)
- **Hyper-V Manager** (VM management)
- **Proxmox Web UI Access** (Restricted to Admins)
- **Custom Scripts & Tools** (For lab infrastructure management)

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
| **Lab Engineer** | Full Admin | Entra PIM Assignment |
| **Infrastructure Ops** | Standard User | Entra RBAC |
| **Service Desk** | Limited Read | Ticket-Only Access |
| **Change Manager** | Approves RDS changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **RDS Server Down** | High | P1 | 15 min | 4 hours |
| **Session Latency Issues** | Medium | P2 | 30 min | 6 hours |
| **MFA Bypass Attempt** | Critical | P1 | Immediate | Investigation & Lockdown |

---

## **5. Security and Compliance**  

### **5.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra Private Access, Passwordless MFA |
| **Logging & Auditing** | Wazuh + Loki + Entra Audit Logs |
| **RDS Hardening** | CIS-recommended policies enforced |
| **Conditional Access** | Location & Device Compliance enforced |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CISv9 Level 1 (Windows Server 2025) |
| **Security Monitoring** | NIST 800-53 |
| **MFA Enforcement** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **Remote Access Policy** | Entra Private Access Configuration |
| **Office 2024 LTSC Deployment** | Installation & License Management |
| **RDS Hardening Guide** | Security Policies & Best Practices |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |



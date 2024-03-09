---
title: "DC02 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of DC02, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "active-directory", "windows-server", "entra"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **DC02 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

DC02 is the **Read-Only Domain Controller (RODC)** for the **beardinthe.cloud** Active Directory domain. It provides **directory services redundancy, read-only authentication, and fault tolerance** for the Proxmox Astronomy Lab. This ensures continued **directory availability** in case of failure of the primary domain controller (DC01). It also integrates with **Entra ID (Azure AD)** via **Azure AD Connect**, but does **not** participate in write operations or synchronization tasks.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | AD-DC02 |
| **Service Type**   | Identity Infrastructure |
| **Service Category** | Authentication & Directory Services |
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
| **Authentication Availability** | 99.99% uptime | AD health checks |
| **Directory Replication Delay** | â‰¤ 15 minutes | AD Replication Monitor |
| **Read-Only Integrity** | 100% | AD DS Policy Enforcement |
| **Recovery Time** | RTO: 4 hours | VM restore & AD database recovery test |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Windows Server health monitoring |
| **Grafana** | Performance visualization |
| **Loki** | Log aggregation for domain controller events |
| **Wazuh** | Security monitoring and intrusion detection |
| **AD Replication Monitor** | Ensures directory replication consistency |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

DC02 is a **Windows Server 2025-based Read-Only Domain Controller (RODC)**, designed for **high availability and security**. It enables **limited authentication and directory lookups** without allowing direct changes to AD objects.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | dc02.beardinthe.cloud |
| **OS** | Windows Server 2025 |
| **CPU** | 2 vCPUs |
| **RAM** | 6GB |
| **Storage** | 125GB C:\ (OS) + 50GB D:\ (Logs) |
| **Networking** | VLAN20 (Production) |
| **DNS Role** | Secondary DNS for lab infrastructure |
| **Time Sync** | Syncs from DC01 (Authoritative) |

### **3.3 Active Directory Integration**  

- **Domain:** `beardinthe.cloud`
- **Functional Level:** Windows Server 2025
- **Replication Mode:** Read-Only (RODC, Site-Scoped Replication)
- **GPO Enforcement:** Local Read-Only Policies (Centrally Managed by DC01)
- **Azure AD Connect:** No direct sync (Relies on DC01)
- **Seamless SSO:** Kerberos-based authentication for Entra-integrated apps

### **3.4 Backup and Recovery**  

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
| **Lab Engineer** | Full Admin | Group Policy & ADUC Access |
| **Infrastructure Ops** | Limited Admin | Entra PIM Assignment |
| **Service Desk** | Read-Only | Ticket-Only Access |
| **Change Manager** | Approves domain policy changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Domain Controller Failure** | Medium | P2 | 15 min | 4 hours |
| **Replication Failure** | Medium | P2 | 30 min | 6 hours |
| **SSO Outage** | Medium | P2 | 30 min | 6 hours |

---

## **5. Security and Compliance**  

### **5.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | RODC Read-Only Admin Group Restriction |
| **Logging & Auditing** | Wazuh + Entra Audit Logs |
| **GPO Hardening** | CIS-recommended policies enforced |
| **Azure AD Conditional Access** | Limits access based on location & compliance |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CISv9 Level 1 (Windows Server 2025) |
| **Security Monitoring** | NIST 800-53 |
| **Hybrid Identity Security** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **Hybrid Identity Overview** | Entra ID Integration Architecture |
| **Group Policy Documentation** | AD GPO Structure & Security Policies |
| **Azure AD Connect Configuration** | Sync & Federation Settings |

---

## **âœ… Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | â± Pending |


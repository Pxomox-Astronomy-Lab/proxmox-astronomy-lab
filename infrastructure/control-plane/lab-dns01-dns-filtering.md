---
title: "Lab-DNS01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-DNS01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "dns", "technitium", "networking"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.1"
status: "Draft"
last_updated: "2025-03-07"
---

# **Lab-DNS01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-DNS01 is the **primary recursive and filtering DNS server** for the Proxmox Astronomy Lab. It runs **Technitium DNS Server on Ubuntu 24.04**, configured to **serve secondary zones from the domain controllers (DCs)** and enforce **privacy and security-focused DNS filtering**.

This node ensures **secure, fast, and resilient DNS resolution**, supporting **internal name resolution, recursive DNS lookups, and DNS-based malware/ad blocking**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | DNS-01 |
| **Service Type**   | Core Networking Infrastructure |
| **Service Category** | DNS Services |
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
| **DNS Query Resolution Time** | ≤ 10ms | Grafana DNS metrics |
| **Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | System performance & DNS query monitoring |
| **Grafana** | DNS query analysis & visualization |
| **Loki** | Log aggregation for DNS events |
| **Wazuh** | Security monitoring & intrusion detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-DNS01 runs **Technitium DNS Server on Ubuntu 24.04**, providing **internal DNS resolution, recursive DNS, and security-focused filtering**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-dns01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 2 vCPUs |
| **RAM** | 4GB |
| **Storage** | 32GB C:\ (OS) + 50GB D:\ (DNS Logs) |
| **Networking** | VLAN10 (Control Plane) |
| **DNS Software** | Technitium DNS Server |

### **3.3 DNS Configuration**  

| **Zone Type** | **Domain** | **Purpose** |
|-------------|--------------|---------------|
| **Secondary Forward** | beardinthe.cloud | Replicated from AD DCs |
| **Secondary Reverse** | 192.168.10.x | Reverse lookup from AD DCs |
| **Recursive** | External queries | Provides caching resolution |
| **DNS Filtering** | Malware & Ad Blocking | Privacy-focused blocklists enforced |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | DNS Config Snapshots + System Backups |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID Authentication, RBAC Enforcement |
| **Logging & Auditing** | Wazuh + Loki + DNS Logs |
| **DNS Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, DNS over HTTPS (DoH) enabled |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Technitium & Ubuntu Benchmark Compliance |
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
| 1.1 | 2025-03-07 | Updated Lab-DNS01 to use Technitium instead of BIND, added filtering and AD integration details |

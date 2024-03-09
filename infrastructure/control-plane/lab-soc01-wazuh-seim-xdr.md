---
title: "Lab-SOC1 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-SOC1, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "security", "wazuh", "siem"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Lab-SOC1 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-SOC1 is the **primary Security Operations Center (SOC) server** for the Proxmox Astronomy Lab, responsible for **real-time security monitoring, intrusion detection, and compliance auditing**. It runs **Wazuh on Ubuntu 24.04**, providing **host-based intrusion detection (HIDS), log analysis, and security event correlation** across the labâ€™s infrastructure.

This node ensures **continuous threat monitoring, centralized logging, and security alerting**, supporting **threat intelligence, vulnerability assessment, and forensic analysis**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | SOC-01 |
| **Service Type**   | Security & Monitoring Infrastructure |
| **Service Category** | Security Operations & Threat Detection |
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
| **Security Event Processing Latency** | â‰¤ 5s | Wazuh logs |
| **Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | â‰¤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | System performance & SOC health monitoring |
| **Grafana** | Security event visualization |
| **Loki** | Log aggregation for security events |
| **Wazuh** | Intrusion detection & compliance monitoring |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-SOC1 runs **Wazuh on Ubuntu 24.04**, providing **centralized security monitoring, log analysis, and SIEM capabilities**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-soc1.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Security Logs) |
| **Networking** | VLAN10 (Control Plane) |
| **Security Stack** | Wazuh, Loki, Security Dashboards |

### **3.3 Security Monitoring & Logging Services**  

| **Service** | **Type** | **Port** | **Purpose** |
|------------|---------|------|---------------|
| **Wazuh Manager** | Native Service | 1514 | Security event correlation |
| **Loki** | Native Service | 3100 | Log aggregation |
| **Prometheus** | Native Service | 9090 | Metrics collection |
| **Grafana** | Native Service | 3000 | Security dashboarding |
| **OSSEC Agents** | Endpoint Agents | N/A | Host-based intrusion detection |

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
| **Logging & Auditing** | Wazuh + Loki + System Logs |
| **SOC Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Ubuntu & Security Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Integrity & Protection** | ISO 27001 |

---

## **5. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | â± Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial version, defines Lab-SOC1 as the primary security operations center server |


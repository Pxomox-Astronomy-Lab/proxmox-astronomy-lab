<!-- ---
title: "Lab-Mon01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Lab-Mon01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "monitoring", "ubuntu", "influxdb"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.1"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Lab-Mon01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Lab-Mon01 is the **primary monitoring and logging server** within the Proxmox Astronomy Lab, responsible for **system observability, performance monitoring, and security logging**. It runs **Prometheus, Grafana, Loki, and Wazuh as native services** on **Ubuntu 24.04**, with **InfluxDB running as a Docker container for Kubernetes cluster metrics**.

This node ensures **real-time analytics, historical performance tracking, and security event correlation** across the lab’s infrastructure.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | MON-01 |
| **Service Type**   | Monitoring & Logging Infrastructure |
| **Service Category** | System Observability & Security Logging |
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
| **Monitoring Uptime** | 99.99% | Prometheus alerts |
| **Log Ingestion Latency** | ≤ 5s | Loki metrics |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | System performance & health monitoring |
| **Grafana** | Visualization & dashboards |
| **Loki** | Log aggregation and indexing |
| **Wazuh** | Security monitoring & intrusion detection |
| **InfluxDB** | Kubernetes cluster metrics storage |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Lab-Mon01 runs **all monitoring services natively on Ubuntu 24.04**, with **InfluxDB as the only containerized component** for Kubernetes cluster metric storage.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | lab-mon01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Monitoring Data) |
| **Networking** | VLAN20 (Production) |
| **Monitoring Stack** | Prometheus, Grafana, Loki, Wazuh, InfluxDB (Docker) |

### **3.3 Monitoring & Logging Services**  

| **Service** | **Type** | **Port** | **Purpose** |
|------------|---------|------|---------------|
| **Prometheus** | Native Service | 9090 | Metrics collection |
| **Grafana** | Native Service | 3000 | Data visualization |
| **Loki** | Native Service | 3100 | Log aggregation |
| **Wazuh** | Native Service | 1514 | Security & compliance monitoring |
| **InfluxDB** | Docker Container | 8086 | Kubernetes metrics storage |

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
| **Monitoring Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Ubuntu & Docker Benchmark Compliance |
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
| 1.1 | 2025-03-07 | Fully corrected Lab-Mon01; removed Portainer reference, clarified native service execution |



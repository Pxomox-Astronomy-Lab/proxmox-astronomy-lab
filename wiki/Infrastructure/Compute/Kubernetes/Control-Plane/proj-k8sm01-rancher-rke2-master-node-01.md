<!-- ---
title: "Proj-K8SM01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-K8SM01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "kubernetes", "rke2", "cluster-management"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Proj-K8SM01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-K8SM01 is the **primary Kubernetes control plane node** for the Proxmox Astronomy Lab, running **RKE2 on Ubuntu 24.04**. It provides **cluster orchestration, API management, and workload scheduling** for Kubernetes workloads across the lab’s research and production environments.

This node ensures **high availability, API reliability, and secure workload orchestration**, supporting **containerized applications, microservices, and automation workflows**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | K8SM-01 |
| **Service Type**   | Kubernetes Control Plane |
| **Service Category** | Cluster Orchestration |
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
| **K8s API Response Time** | ≤ 50ms | Prometheus metrics |
| **Cluster Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Kubernetes cluster health monitoring |
| **Grafana** | API performance visualization |
| **Loki** | Log aggregation for cluster events |
| **Wazuh** | Security monitoring & intrusion detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-K8SM01 runs **RKE2 on Ubuntu 24.04**, providing **Kubernetes API and cluster orchestration**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-k8sm01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Cluster Data) |
| **Networking** | VLAN20 (Production) |
| **Kubernetes Distribution** | RKE2 |

### **3.3 Kubernetes Control Plane Components**  

| **Component** | **Purpose** |
|--------------|------------|
| **etcd** | Stores cluster state |
| **kube-apiserver** | Handles API requests |
| **kube-scheduler** | Assigns workloads to nodes |
| **kube-controller-manager** | Manages cluster state |
| **CoreDNS** | Internal DNS resolution |

### **3.4 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | ETCD Snapshots + System Backups |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Security and Compliance**  

### **4.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID Authentication, RBAC Enforcement |
| **Logging & Auditing** | Wazuh + Loki + Kubernetes Logs |
| **Kubernetes Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for API traffic, LUKS for storage |

### **4.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS Kubernetes & Ubuntu Benchmark Compliance |
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
| 1.0 | 2025-03-07 | Initial version, defines Proj-K8SM01 as the primary Kubernetes control plane node |



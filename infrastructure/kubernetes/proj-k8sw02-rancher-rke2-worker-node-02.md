---
title: "Proj-K8SW02 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-K8SW02, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "kubernetes", "rke2", "worker-node"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Proj-K8SW02 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-K8SW02 is a **Kubernetes worker node** in the Proxmox Astronomy Lab, running **RKE2 on Ubuntu 24.04**. It provides **compute resources, workload scheduling, and container execution** for **scientific research applications, automation pipelines, and observability services**.

This node ensures **high-performance computing, AI/ML workload execution, and balanced workload distribution**, supporting **data processing and distributed computing frameworks**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | K8SW-02 |
| **Service Type**   | Kubernetes Worker Node |
| **Service Category** | Compute & Workload Execution |
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
| **Pod Deployment Time** | â‰¤ 30s | Prometheus metrics |
| **Node Uptime** | 99.99% | Prometheus alerts |
| **Backup Sync Interval** | â‰¤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Kubernetes node health monitoring |
| **Grafana** | Pod execution & resource usage visualization |
| **Loki** | Log aggregation for node workloads |
| **Wazuh** | Security monitoring & intrusion detection |
| **Proxmox Backup Server** | Snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-K8SW02 runs **RKE2 on Ubuntu 24.04**, providing **compute resources for distributed workloads and AI/ML research**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-k8sw02.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 8 vCPUs |
| **RAM** | 32GB |
| **Storage** | 64GB C:\ (OS) + 1TB D:\ (Workload Data) |
| **Networking** | VLAN20 (Production) |
| **Kubernetes Distribution** | RKE2 |

### **3.3 Kubernetes Worker Node Services**  

| **Component** | **Purpose** |
|--------------|------------|
| **kubelet** | Manages containers on the node |
| **kube-proxy** | Maintains network rules for services |
| **Container Runtime** | Runs containerized workloads |
| **CNI Plugin** | Handles networking for pods |

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
| **Logging & Auditing** | Wazuh + Loki + Kubernetes Logs |
| **Node Hardening** | CIS-recommended policies enforced |
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
| VintageDon | Lead Engineer | 2025-03-07 | â± Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-07 | Initial version, defines Proj-K8SW02 as a Kubernetes worker node |


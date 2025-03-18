<!-- 
---
title: "Kubernetes Worker Nodes - Proxmox Astronomy Lab"
description: "Overview of the Kubernetes worker nodes, their configuration, and workload distribution in the RKE2 cluster"
author: "VintageDon"
tags: ["kubernetes", "worker-nodes", "rke2", "infrastructure", "research-compute"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔋 **1. Kubernetes Worker Nodes**

## 🔍 **1.1 Overview**

The Kubernetes Worker Nodes provide the **compute foundation** for our research workloads, data processing pipelines, and scientific applications. Configured as part of our RKE2 cluster, these nodes deliver the **processing power, memory, and storage resources** required for radio astronomy data analysis and AI-driven signal processing.

This section documents the **architecture, configuration, and operations** of the worker nodes powering our research environment.

---

## 🏢 **2. Architecture**

### **2.1 Worker Node Deployment**

Our RKE2 worker node architecture consists of:

- **Five standard worker nodes** - Running general-purpose workloads
- **Distributed deployment** - Nodes spread across multiple Proxmox hosts
- **Storage-optimized configuration** - Enhanced local storage for data-intensive workloads

### **2.2 Node Specifications**

| **Node** | **IP Address** | **vCPU** | **RAM** | **Disk 1** | **Disk 2** | **Proxmox Host** |
|----------|---------------|----------|--------|-----------|-----------|----------------|
| [**proj-k8sw01**](proj-k8sw01-rancher-rke2-worker-node-01.md) | 10.25.20.7 | 8 | 32GB | 150GB | 1000GB | node01 |
| [**proj-k8sw02**](proj-k8sw02-rancher-rke2-worker-node-02.md) | 10.25.20.8 | 8 | 32GB | 150GB | 1000GB | node02 |
| [**proj-k8sw03**](proj-k8sw03-rancher-rke2-worker-node-03.md) | 10.25.20.9 | 8 | 32GB | 150GB | 1000GB | node03 |
| [**proj-k8sw04**](proj-k8sw04-rancher-rke2-worker-node-04.md) | 10.25.20.10 | 8 | 32GB | 150GB | 2000GB | node04 |
| [**proj-k8sw05**](proj-k8sw05-rancher-rke2-worker-node-05.md) | 10.25.20.11 | 8 | 32GB | 150GB | 1000GB | nas01 |

---

## 💻 **3. Workload Distribution**

### **3.1 Node Labels & Taints**

Worker nodes utilize Kubernetes labels to control workload placement:

- **General-purpose nodes** - No taints, accept all compatible workloads
- **Storage-optimized node** - Tagged for data-intensive applications
- **Role-based labels** - Structured workload distribution

### **3.2 Workload Types**

The worker nodes host a variety of research and infrastructure workloads:

| **Workload Type** | **Primary Nodes** | **Example Applications** |
|------------------|------------------|--------------------------|
| **Data Processing** | k8sw01, k8sw02, k8sw03 | SDR signal processing, time-series analysis |
| **Database Services** | k8sw04 | PostgreSQL, TimescaleDB, Milvus vector DB |
| **AI/ML Pipelines** | k8sw01, k8sw04 | TensorFlow Serving, model training |
| **Storage Services** | k8sw04, k8sw05 | MinIO S3 storage |
| **Web Applications** | k8sw01, k8sw02 | Research dashboards, API services |

---

## 🔐 **4. Security Configuration**

### **4.1 Hardening Measures**

Worker nodes implement comprehensive security measures:

- **RKE2 CIS profile** - Follows CIS Kubernetes Benchmark v1.8
- **Ubuntu 24.04 (CISv8 Level 2)** - Hardened base operating system
- **Container image scanning** - Trivy-based vulnerability detection
- **Pod Security Standards** - Enforced baseline pod security
- **Network Policy** - Granular network access control

### **4.2 Workload Isolation**

- **Resource quotas** - Prevent resource exhaustion attacks
- **Pod Security Context** - Enforced non-root container execution
- **Container sandboxing** - Runtime isolation between workloads
- **Namespace separation** - Logical workload boundaries

---

## 💾 **5. Storage Configuration**

### **5.1 Local Storage**

Each worker node provides local storage for performance-sensitive workloads:

- **System volume** - 150GB for OS and Kubernetes components
- **Data volume** - 1000GB-2000GB for local persistent volumes
- **Local-path storage class** - High-performance ephemeral storage

### **5.2 External Storage Integration**

Worker nodes connect to external storage services:

- **NFS client** - Access to centralized NFS storage
- **SMB connectivity** - Integration with Windows file shares
- **MinIO S3** - Object storage for research data

---

## 🔄 **6. Scaling & Resilience**

### **6.1 Scaling Strategy**

The worker node deployment supports flexible scaling:

- **Horizontal scaling** - Additional worker nodes can be added
- **Vertical scaling** - Resources can be increased on existing nodes
- **Workload distribution** - Pod anti-affinity prevents concentration

### **6.2 Resilience Measures**

Worker nodes are designed for high reliability:

- **Pod disruption budgets** - Prevent excessive simultaneous downtime
- **Multi-node deployment** - Applications span multiple worker nodes
- **Automatic rescheduling** - Pods restart on node failures
- **Node auto-repair** - Ansible automation for common issues

---

## 🛠️ **7. Management**

### **7.1 Updates & Maintenance**

Worker nodes follow a structured update process:

- **Rolling updates** - Sequential node updates to prevent downtime
- **Cordoning and draining** - Graceful workload migration during maintenance
- **Proxmox backups** - Pre-update snapshots for recovery
- **Automated validation** - Post-update verification of node health

### **7.2 Node Lifecycle**

- **Provisioning** - Automated via Ansible playbooks
- **Configuration** - GitOps-driven configuration management
- **Decommissioning** - Controlled workload migration and removal

---

## 📈 **8. Monitoring**

### **8.1 Observability Integration**

Worker nodes are monitored through:

- **Prometheus Node Exporter** - Deployed as daemonsets on worker nodes
- **Metrics forwarding** - Data sent to centralized monitoring (lab-mon01)
- **Loki logging** - Centralized log aggregation
- **Wazuh agents** - Security monitoring and compliance

---

## 🔗 **9. Related Documentation**

| **Document** | **Description** |
|--------------|----------------|
| [Control Plane](../control-plane/README.md) | Kubernetes management plane |
| [Storage Architecture](../../storage/README.md) | Persistent storage infrastructure |
| [Monitoring Infrastructure](../../control-plane/lab-mon01-prometheus-monitoring-logging-stack.md) | Centralized monitoring services |
| [Project Services](../../projects/README.md) | Research applications deployed on Kubernetes |

---

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Worker Nodes README | VintageDon |

<!-- 
---
title: "Kubernetes - Proxmox Astronomy Lab"
description: "Overview of the Kubernetes infrastructure, including control plane nodes, worker nodes, and research workloads"
author: "VintageDon"
tags: ["kubernetes", "rke2", "containers", "research-workloads", "infrastructure"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🚢 **Kubernetes - Proxmox Astronomy Lab**

## **1. Overview**

The Kubernetes cluster provides **containerized orchestration** for research workloads, data processing pipelines, and scientific applications. Built on **RKE2 (Rancher Kubernetes Engine 2)**, the cluster balances performance, security, and manageability to support the lab's scientific mission.

This section documents the **architecture, components, and configurations** that enable our research operations.

---

## **2. Cluster Architecture**

### **2.1 Core Components**

Our Kubernetes deployment follows a high-availability architecture with:

- **3 Control Plane Nodes** → Providing redundant management services
- **5 Worker Nodes** → Hosting research workloads and processing pipelines
- **1 Specialized Node** → Supporting Kasm Workspaces for secure research VDI

This architecture ensures **resilience against node failures** while providing sufficient compute capacity for our research needs.

### **2.2 Node Distribution**

Nodes are strategically distributed across Proxmox hosts to maximize availability:

| **Proxmox Host** | **Kubernetes Nodes** |
|------------------|----------------------|
| **node01** | proj-k8sm01, proj-k8sw01 |
| **node02** | proj-k8sm02, proj-k8sw02 |
| **node03** | proj-k8sm03, proj-k8sw03 |
| **node04** | proj-k8sw04 |
| **nas01**  | proj-k8sw05, proj-kasm01 |

---

## **3. Control Plane**

The Control Plane manages all Kubernetes operations, including scheduling, API services, and cluster state management.

| **Node Documentation** | **Purpose** |
|----------------------|-------------|
| [proj-k8sm01-rancher-rke2-master-node-01.md](proj-k8sm01-rancher-rke2-master-node-01.md) | Primary control plane node |
| [proj-k8sm02-rancher-rke2-master-node-02.md](proj-k8sm02-rancher-rke2-master-node-02.md) | Secondary control plane node |
| [proj-k8sm03-rancher-rke2-master-node-03.md](proj-k8sm03-rancher-rke2-master-node-03.md) | Tertiary control plane node |

The control plane is configured for **high availability with etcd clustering** and follows **CISv8 Level 2 hardening** for enhanced security.

---

## **4. Worker Nodes**

Worker nodes run the actual research workloads and scientific applications. Each worker node is configured with appropriate resources and security controls.

| **Node Documentation** | **Purpose** |
|----------------------|-------------|
| [proj-k8sw01-rancher-rke2-worker-node-01.md](proj-k8sw01-rancher-rke2-worker-node-01.md) | General workload node |
| [proj-k8sw02-rancher-rke2-worker-node-02.md](proj-k8sw02-rancher-rke2-worker-node-02.md) | General workload node |
| [proj-k8sw03-rancher-rke2-worker-node-03.md](proj-k8sw03-rancher-rke2-worker-node-03.md) | General workload node |
| [proj-k8sw04-rancher-rke2-worker-node-04.md](proj-k8sw04-rancher-rke2-worker-node-04.md) | Storage-optimized node |
| [proj-k8sw05-rancher-rke2-worker-node-05.md](proj-k8sw05-rancher-rke2-worker-node-05.md) | General workload node |

---

## **5. Research Workloads**

The Kubernetes cluster hosts several critical research workloads that support our astronomy mission:

### **5.1 Data Processing Pipelines**

- **SDR Signal Processing** → Automated ingestion and processing of radio astronomy data
- **Hydrogen Line Analysis** → Specialized pipelines for hydrogen line detection and analysis
- **Time-Series Processing** → Long-duration observation processing and storage

### **5.2 Infrastructure Services**

- **MinIO Object Storage** → S3-compatible storage for research datasets
- **PostgreSQL & TimescaleDB** → Database services for structured research data
- **Milvus Vector Database** → Vector storage for AI-enhanced signal analysis

### **5.3 AI/ML Components**

- **TensorFlow Serving** → Model hosting for inference and prediction
- **Airflow Orchestration** → Workflow automation for data science pipelines
- **Ollama** → Local language model hosting for research assistance

---

## **6. Security & Compliance**

The Kubernetes deployment incorporates RKE2's enterprise-grade security focus, which was originally developed for U.S. Federal Government requirements:

- **RKE2 Security Foundation** → Built with security-first architecture that enables:
- Default configurations that satisfy CIS Kubernetes Benchmark v1.8
- Hardened components with regular CVE scanning
- Minimized attack surface through component consolidation

- **Lab-Specific Controls**:
- **CISv8 Level 2 Benchmarks** → Applied to underlying Ubuntu 24.04 nodes
- **Network Policy Enforcement** → Cilium-based micro-segmentation
- **RBAC Implementation** → Strict role-based access control
- **Pod Security Admission** → Restricted pod security standard enforcement
- **Secret Management** → Encrypted etcd storage for sensitive data

- **Compliance Considerations**:
- While we don't operate in FIPS 140-2 mode (which RKE2 supports), our implementation maintains high security standards
- Daily automated security scanning validates ongoing compliance
- Regular security patching through our change management process

---

## **7. Storage Architecture**

The cluster leverages multiple storage technologies for different use cases:

- **Longhorn** → Replicated block storage for stateful workloads
- **NFS Storage Class** → Shared storage for large datasets
- **S3 Object Storage** → Long-term storage for processed research data

---

## **8. Related Documentation**

| **Section** | **Relevance** |
|------------|---------------|
| [Control Plane](../control-plane/README.md) | Management services that support Kubernetes operations |
| [Storage](../storage/README.md) | Persistent storage infrastructure for Kubernetes workloads |
| [Projects](../projects/README.md) | Research applications deployed on Kubernetes |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Kubernetes README | VintageDon |

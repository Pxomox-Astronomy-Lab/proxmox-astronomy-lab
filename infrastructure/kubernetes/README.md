<!-- 
---
title: "Kubernetes - Proxmox Astronomy Lab"
description: "Documentation of RKE2-based Kubernetes infrastructure providing containerized workload capabilities for research applications"
author: "VintageDon"
tags: ["kubernetes", "containers", "infrastructure", "rke2", "rancher", "orchestration"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["RKE2", "Traefik", "Proxmox", "Control Plane"]
implements_policies: ["Container Security Policy", "Research Workload Policy"]
phase: "phase-3"
---
-->

# 🎡 **Kubernetes - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The Kubernetes environment within the Proxmox Astronomy Lab provides a scalable, automated, and resilient platform for containerized research workloads, AI/ML pipelines, and microservices. Built on RKE2 (Rancher Kubernetes Engine 2), this environment combines enterprise-grade security with high-performance computing capabilities to support scientific research while maintaining compliance with industry best practices.

This section documents the architecture, node configurations, security controls, and operational practices that govern the Kubernetes infrastructure, serving as the definitive reference for containerized workloads within the lab.

---

# 🏗️ **2. Control Plane Infrastructure**

## **2.1 Management Nodes**

The Kubernetes control plane consists of three management nodes that provide high availability and resilience for cluster operations.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **proj-k8sm01** | Primary RKE2 master node with etcd, API server, and scheduler components | [k8sm01 Documentation](./proj-k8sm01-rancher-rke2-master-node-01.md) |
| **proj-k8sm02** | Secondary RKE2 master node with redundant control plane services | [k8sm02 Documentation](./proj-k8sm02-rancher-rke2-master-node-02.md) |
| **proj-k8sm03** | Tertiary RKE2 master node completing the HA control plane | [k8sm03 Documentation](./proj-k8sm03-rancher-rke2-master-node-03.md) |

---

# 🖥️ **3. Compute Resources**

## **3.1 Worker Nodes**

The worker nodes provide the computational resources for running containerized workloads, with specialized nodes for GPU-accelerated tasks.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **proj-k8sw01** | General-purpose worker node for standard workloads | [k8sw01 Documentation](./proj-k8sw01-rancher-rke2-worker-node-01.md) |
| **proj-k8sw02** | General-purpose worker node for standard workloads | [k8sw02 Documentation](./proj-k8sw02-rancher-rke2-worker-node-02.md) |
| **proj-k8sw03** | General-purpose worker node for standard workloads | [k8sw03 Documentation](./proj-k8sw03-rancher-rke2-worker-node-03.md) |
| **proj-k8sw04** | GPU-accelerated worker node with RTX A4000 | [k8sw04 Documentation](./proj-k8sw04-rancher-rke2-worker-node-04.md) |
| **proj-k8sw05** | GPU-accelerated worker node with GeForce 1660 Ti | [k8sw05 Documentation](./proj-k8sw05-rancher-rke2-worker-node-05.md) |

## **3.2 Special-Purpose Nodes**

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **proj-kasm01** | Kasm Workspaces VDI server for secure remote research | [kasm01 Documentation](../projects/proj-kasm01-kasm-workspaces-vdi-server.md) |

---

# 🛠️ **4. Kubernetes Services & Workloads**

## **4.1 Core Platform Services**

The following core services provide essential functionality within the Kubernetes environment:

| **Service** | **Function** | **Location** |
|------------|-------------|-------------|
| **Traefik Ingress** | Layer 7 routing, TLS termination, and API gateway | [K8s Deployments](/docs/Applications/Containerized-Services/Kubernetes-Workloads/Traefik-Ingress.md) |
| **RKE2 Cluster** | Core Kubernetes distribution and management | [RKE2 Documentation](/docs/Applications/Containerized-Services/Kubernetes-Workloads/RKE2-Cluster.md) |
| **Storage Operators** | NFS and local-path provisioners for persistent storage | [Storage Documentation](/docs/Infrastructure/Storage/Object-Storage/README.md) |

---

# 🔗 **5. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **RKE2 Master Node 01** | Documentation for proj-k8sm01 | [proj-k8sm01-rancher-rke2-master-node-01.md](./proj-k8sm01-rancher-rke2-master-node-01.md) |
| **RKE2 Master Node 02** | Documentation for proj-k8sm02 | [proj-k8sm02-rancher-rke2-master-node-02.md](./proj-k8sm02-rancher-rke2-master-node-02.md) |
| **RKE2 Master Node 03** | Documentation for proj-k8sm03 | [proj-k8sm03-rancher-rke2-master-node-03.md](./proj-k8sm03-rancher-rke2-master-node-03.md) |
| **RKE2 Worker Node 01** | Documentation for proj-k8sw01 | [proj-k8sw01-rancher-rke2-worker-node-01.md](./proj-k8sw01-rancher-rke2-worker-node-01.md) |
| **RKE2 Worker Node 02** | Documentation for proj-k8sw02 | [proj-k8sw02-rancher-rke2-worker-node-02.md](./proj-k8sw02-rancher-rke2-worker-node-02.md) |
| **RKE2 Worker Node 03** | Documentation for proj-k8sw03 | [proj-k8sw03-rancher-rke2-worker-node-03.md](./proj-k8sw03-rancher-rke2-worker-node-03.md) |
| **RKE2 Worker Node 04** | Documentation for proj-k8sw04 | [proj-k8sw04-rancher-rke2-worker-node-04.md](./proj-k8sw04-rancher-rke2-worker-node-04.md) |
| **RKE2 Worker Node 05** | Documentation for proj-k8sw05 | [proj-k8sw05-rancher-rke2-worker-node-05.md](./proj-k8sw05-rancher-rke2-worker-node-05.md) |

---

# 🔄 **6. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical host nodes running Kubernetes VMs | [Infrastructure Documentation](/infrastructure/README.md) |
| **Control Plane** | Core services supporting Kubernetes operations | [Control Plane Documentation](/infrastructure/control-plane/README.md) |
| **Projects** | Research applications running on Kubernetes | [Projects Documentation](/infrastructure/projects/README.md) |
| **AI/ML Platforms** | Machine learning workloads on Kubernetes | [AI/ML Documentation](/docs/Applications/AI-ML-Platforms/README.md) |
| **Security & Compliance** | Security policies implemented in Kubernetes | [Security Documentation](/docs/Compliance-Security/README.md) |

---

# ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for Kubernetes directory | VintageDon |

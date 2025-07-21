<!--
---
title: "Kubernetes Management via Portainer"
description: "Enterprise RKE2 Kubernetes cluster management through Portainer's unified web interface within the Proxmox Astronomy Lab hybrid infrastructure"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4"
date: "2025-07-20"
version: "1.0"
status: "Published"
tags:
- type: [directory-overview/kubernetes-management/infrastructure-orchestration]
- domain: [kubernetes-orchestration/rke2-management/container-platform]
- tech: [portainer/rke2/kubernetes/cluster-management]
- phase: [phase-2]
related_documents:
- "[Portainer Main](../README.md)"
- "[RKE2 Infrastructure](../../k8s-rke2/README.md)"
- "[Docker Management](../docker-management/README.md)"
---
-->

# ☸️ **Kubernetes Management via Portainer**

Enterprise-grade RKE2 Kubernetes cluster management through Portainer's unified web interface, providing comprehensive orchestration capabilities for the Proxmox Astronomy Lab's hybrid infrastructure. This directory contains documentation and procedures for managing our 3-node RKE2 Kubernetes cluster through Portainer's centralized management platform.

## **Overview**

Kubernetes management via Portainer represents the advanced orchestration layer of our containerized infrastructure strategy within the hybrid architecture. Portainer provides enterprise-grade web-based management for our RKE2 Kubernetes cluster, enabling efficient workload deployment, resource monitoring, and automated scaling for distributed astronomical computing tasks.

The Kubernetes management layer serves as the primary platform for ML/AI workloads, distributed data processing, and scalable microservices supporting DESI data analysis, quasar research, and anomaly detection pipelines. This approach leverages Kubernetes' native orchestration capabilities while maintaining simplified management through Portainer's intuitive interface.

---

## **📂 Directory Contents**

This section provides systematic navigation to all Kubernetes management documentation and procedures within the Portainer ecosystem.

### **Management Categories**

| **Category** | **Purpose** | **Documentation Status** |
|--------------|-------------|-------------------------|
| **Cluster Operations** | Node management, cluster health, and scaling procedures | In Development |
| **Workload Deployment** | Pod, deployment, and service management workflows | In Development |
| **Resource Management** | CPU, memory, storage allocation and quotas | In Development |
| **Networking Configuration** | Service mesh, ingress, and cluster networking | In Development |
| **Storage Integration** | Persistent volumes, storage classes, and data management | Planned |
| **ML/AI Pipeline Management** | Ray clusters, GPU scheduling, and distributed computing | Planned |

### **Key Procedures**

| **Procedure** | **Purpose** | **Status** |
|---------------|-------------|------------|
| **Application Deployment Workflow** | Step-by-step application deployment via Portainer UI | Pending |
| **Scaling and Resource Management** | Horizontal and vertical scaling best practices | Pending |
| **Service Discovery Configuration** | Internal service communication and DNS setup | Pending |
| **Monitoring and Alerting Setup** | Integration with mon01 observability stack | Pending |

---

## **📁 Repository Structure**

``` markdown
kubernetes-management/
├── 📚 cluster-operations/      # Cluster management procedures
│   ├── node-management.md     # Node addition, removal, maintenance
│   ├── cluster-scaling.md     # Cluster capacity and scaling operations
│   └── health-monitoring.md   # Cluster health and diagnostics
├── 🏗️ workload-templates/     # Kubernetes deployment templates
│   ├── astronomical-apps/     # DESI, ML, and research application templates
│   ├── data-processing/       # ETL and pipeline deployment templates
│   └── monitoring-services/   # Observability service deployments
├── 📋 networking/             # Kubernetes networking configurations
│   ├── service-definitions/   # Service discovery and routing
│   ├── ingress-configs/       # External access and load balancing
│   └── network-policies/      # Security and traffic control
├── 💾 storage-management/     # Persistent volume configurations
│   ├── storage-classes.md     # Storage class definitions and usage
│   ├── pv-management.md       # Persistent volume lifecycle
│   └── backup-strategies.md   # Kubernetes-native backup approaches
├── 📝 README.md              # This file
└── 📄 troubleshooting.md     # Common K8s issues and resolutions
```

### **Navigation Guide:**

- **[📚 Cluster Operations](cluster-operations/)** - Node and cluster-level management procedures
- **[🏗️ Workload Templates](workload-templates/)** - Pre-configured application deployment templates
- **[📋 Networking](networking/)** - Service discovery, ingress, and network policy management
- **[💾 Storage Management](storage-management/)** - Persistent volume and data management strategies

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the infrastructure knowledge graph.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Docker Management](../docker-management/README.md)** | Complementary container platform for different workload types | [../docker-management/README.md](../docker-management/README.md) |
| **[Portainer Security & RBAC](../security-rbac/README.md)** | Access control and security policies for Kubernetes management | [../security-rbac/README.md](../security-rbac/README.md) |
| **[RKE2 Infrastructure](../../k8s-rke2/README.md)** | Underlying Kubernetes cluster installation and configuration | [../../k8s-rke2/README.md](../../k8s-rke2/README.md) |
| **[Storage Infrastructure](../../storage/README.md)** | Persistent volume backend integration and data management | [../../storage/README.md](../../storage/README.md) |
| **[AI & Machine Learning](../../../ai-and-machine-learning/README.md)** | ML/AI workload deployment and GPU resource management | [../../../ai-and-machine-learning/README.md](../../../ai-and-machine-learning/README.md) |

---

## **Getting Started**

For new users approaching Kubernetes management via Portainer:

1. **Start Here:** [Portainer Main Documentation](../README.md) - Understanding the overall Portainer ecosystem
2. **Cluster Access:** [Security & RBAC Guide](../security-rbac/README.md) - Configuring Kubernetes RBAC and access
3. **First Deployment:** Workload Templates (pending) - Deploying applications to the cluster
4. **Advanced Operations:** Resource Management and Scaling - Optimizing cluster utilization

---

## **🎯 Enterprise Integration**

### **RKE2 Cluster Architecture**

Kubernetes management via Portainer operates on our 3-node RKE2 cluster:

- **proj-k8s01** (32GB RAM, 16 vCPU) - Control plane and worker node
- **proj-k8s02** (32GB RAM, 16 vCPU) - Worker node with high-availability
- **proj-k8s03** (32GB RAM, 16 vCPU) - Worker node for distributed workloads

### **Production Workloads**

Current Kubernetes-managed services supporting astronomical research:

- **Ray distributed computing clusters** for ML/AI pipeline processing
- **DESI anomaly detection workloads** processing 1.6M+ spectral datasets
- **Microservices for data processing** supporting cosmic void and quasar analysis
- **Monitoring and observability services** integrated with centralized mon01 stack

### **Hybrid Architecture Benefits**

Kubernetes management via Portainer provides:

- **Scalable ML/AI computing** with automatic resource allocation and GPU scheduling
- **Microservices architecture** for modular astronomical data processing pipelines
- **High availability** for critical research computing services across multiple nodes
- **Resource efficiency** through container orchestration and automatic scaling

### **Integration with Strategic VMs**

The RKE2 cluster integrates seamlessly with our strategic VM infrastructure:

- **Database connectivity** to proj-pg01 PostgreSQL for persistent astronomical data
- **Storage integration** with Proxmox-managed persistent volumes and backup systems
- **Monitoring alignment** with centralized observability stack on dedicated VMs

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: portainer, kubernetes-management, rke2, cluster-orchestration, enterprise-infrastructure

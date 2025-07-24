<!--
---
title: "RKE2 Kubernetes Infrastructure"
description: "Enterprise-grade RKE2 Kubernetes cluster providing distributed computing and container orchestration for astronomical research workloads within the Proxmox Astronomy Lab"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4"
date: "2025-07-20"
version: "1.0"
status: "Published"
tags:
- type: [directory-overview/kubernetes-infrastructure/distributed-computing]
- domain: [kubernetes/rke2/container-orchestration/distributed-systems]
- tech: [rke2/kubernetes/containerd/cluster-management]
- phase: [phase-2]
related_documents:
- "[Infrastructure Overview](../README.md)"
- "[Portainer Kubernetes Management](../portainer/kubernetes-management/README.md)"
- "[AI & Machine Learning](../../ai-and-machine-learning/README.md)"
---
-->

# ☸️ **RKE2 Kubernetes Infrastructure**

Enterprise-grade RKE2 Kubernetes cluster providing distributed computing, container orchestration, and scalable microservices platform for astronomical research workloads within the Proxmox Astronomy Lab's hybrid infrastructure. This 3-node cluster serves as the foundation for ML/AI computing, distributed data processing, and high-availability services.

## **Overview**

RKE2 Kubernetes infrastructure represents the advanced distributed computing layer of our hybrid architecture, enabling sophisticated container orchestration, automatic scaling, and high-availability services for compute-intensive astronomical research. The cluster leverages Rancher's RKE2 distribution to provide enterprise-grade security, compliance, and operational reliability.

The RKE2 implementation supports our most demanding computational workloads, including DESI data analysis, machine learning pipelines, and distributed astronomical computing tasks. This platform integrates seamlessly with our strategic VM infrastructure while providing the scalability and resilience required for production scientific computing environments.

---

## **📂 Directory Contents**

This section provides systematic navigation to all RKE2 cluster documentation and operational procedures.

### **Infrastructure Categories**

| **Category** | **Purpose** | **Documentation Status** |
|--------------|-------------|-------------------------|
| **Cluster Architecture** | Node configuration, networking, and cluster topology | In Development |
| **Installation & Configuration** | RKE2 deployment procedures and cluster setup | In Development |
| **Workload Management** | Application deployment, scaling, and lifecycle management | In Development |
| **Networking & Service Mesh** | Cluster networking, service discovery, and traffic management | In Development |
| **Storage Integration** | Persistent volumes, storage classes, and data management | Planned |
| **Security & RBAC** | Kubernetes-native security, role-based access control | Planned |
| **Monitoring & Observability** | Cluster metrics, logging, and alerting integration | Planned |
| **Backup & Disaster Recovery** | Cluster state backup and recovery procedures | Planned |

### **Key Procedures**

| **Procedure** | **Purpose** | **Status** |
|---------------|-------------|------------|
| **Cluster Deployment Guide** | Complete RKE2 installation and configuration | Pending |
| **Node Management Procedures** | Adding, removing, and maintaining cluster nodes | Pending |
| **Application Deployment Workflow** | Standard procedures for workload deployment | Pending |
| **Cluster Upgrade Procedures** | Safe upgrade processes and rollback procedures | Pending |

---

## **📁 Repository Structure**

``` markdown
k8s-rke2/
├── 📚 cluster-setup/          # Installation and configuration
│   ├── installation-guide.md # Complete RKE2 deployment procedures
│   ├── node-configuration.md # Individual node setup and joining
│   ├── networking-setup.md   # Cluster networking and CNI configuration
│   └── initial-config.md     # Post-installation configuration steps
├── 🏗️ workload-management/   # Application deployment and management
│   ├── deployment-procedures.md # Standard deployment workflows
│   ├── scaling-strategies.md # Horizontal and vertical scaling approaches
│   ├── service-management.md # Service discovery and load balancing
│   └── namespace-organization.md # Multi-tenancy and resource organization
├── 📋 networking/             # Cluster networking and connectivity
│   ├── cni-configuration.md  # Container Network Interface setup
│   ├── ingress-management.md # External access and load balancing
│   ├── service-mesh.md       # Advanced networking and traffic management
│   └── network-policies.md   # Security and traffic control policies
├── 💾 storage/               # Persistent storage and data management
│   ├── storage-classes.md    # Storage class definitions and usage
│   ├── pv-management.md      # Persistent volume lifecycle management
│   ├── backup-strategies.md  # Kubernetes-native backup approaches
│   └── data-migration.md     # Data movement and migration procedures
├── 🔒 security/              # Kubernetes security and compliance
│   ├── rbac-configuration.md # Role-based access control setup
│   ├── pod-security.md       # Pod security policies and standards
│   ├── secrets-management.md # Credential and configuration security
│   └── compliance-validation.md # Security framework compliance
├── 📊 monitoring/            # Observability and performance monitoring
│   ├── metrics-collection.md # Prometheus integration and metrics
│   ├── logging-aggregation.md # Centralized logging with Loki
│   ├── alerting-rules.md     # Alert definitions and escalation
│   └── performance-tuning.md # Cluster optimization and tuning
├── 📝 README.md              # This file
└── 📄 troubleshooting.md     # Common issues and resolution procedures
```

### **Navigation Guide:**

- **[📚 Cluster Setup](cluster-setup/)** - Installation, configuration, and initial deployment procedures
- **[🏗️ Workload Management](workload-management/)** - Application deployment and lifecycle management
- **[📋 Networking](networking/)** - Cluster networking, service discovery, and connectivity
- **[💾 Storage](storage/)** - Persistent volume management and data strategies

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the infrastructure knowledge graph.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Portainer Kubernetes Management](../portainer/kubernetes-management/README.md)** | Web-based cluster management and orchestration interface | [../portainer/kubernetes-management/README.md](../portainer/kubernetes-management/README.md) |
| **[AI & Machine Learning](../../ai-and-machine-learning/README.md)** | Primary platform for ML/AI workload deployment and distributed computing | [../../ai-and-machine-learning/README.md](../../ai-and-machine-learning/README.md) |
| **[Storage Infrastructure](../storage/README.md)** | Backend storage integration for persistent volumes and data management | [../storage/README.md](../storage/README.md) |
| **[Automation & Orchestration](../automation-and-orchestration/README.md)** | GitOps workflows and Infrastructure as Code integration | [../automation-and-orchestration/README.md](../automation-and-orchestration/README.md) |
| **[Monitoring & Observability](../../docs/monitoring-observability/README.md)** | Cluster monitoring, logging, and alerting integration | [../../docs/monitoring-observability/README.md](../../docs/monitoring-observability/README.md) |

---

## **Getting Started**

For new administrators approaching RKE2 Kubernetes infrastructure:

1. **Start Here:** [Cluster Setup Guide](cluster-setup/installation-guide.md) - Complete deployment procedures
2. **Node Management:** [Node Configuration](cluster-setup/node-configuration.md) - Individual node setup and joining
3. **First Workload:** [Deployment Procedures](workload-management/deployment-procedures.md) - Application deployment workflows
4. **Advanced Operations:** [Networking](networking/) and [Storage](storage/) - Advanced cluster configuration

---

## **🏗️ Cluster Architecture**

### **3-Node RKE2 Cluster Configuration**

Our production RKE2 cluster consists of three enterprise-grade nodes providing high availability and distributed computing capabilities:

| **Node** | **Role** | **Resources** | **Network** | **Storage** |
|----------|----------|---------------|-------------|-------------|
| **proj-k8s01** | Control Plane + Worker | 32GB RAM, 16 vCPU | 10.25.20.4 | 1TB NVMe |
| **proj-k8s02** | Worker | 32GB RAM, 16 vCPU | 10.25.20.5 | 1TB NVMe |
| **proj-k8s03** | Worker | 32GB RAM, 16 vCPU | 10.25.20.6 | 1TB NVMe |

**Total Cluster Capacity:** 96GB RAM, 48 vCPU, 3TB distributed storage

### **Network Architecture**

- **CNI:** Calico for network policy enforcement and pod networking
- **Service Mesh:** Planned Istio integration for advanced traffic management
- **Ingress:** NGINX Ingress Controller for external access and load balancing
- **DNS:** CoreDNS for service discovery and internal name resolution

### **Storage Strategy**

- **CSI Driver:** Proxmox CSI for persistent volume provisioning
- **Storage Classes:** Multiple classes for different performance and durability requirements
- **Backup Integration:** Velero for application-consistent backup and disaster recovery

---

## **🚀 Production Workloads**

### **Current Deployments**

RKE2 cluster currently supports production astronomical research computing:

**ML/AI Computing:**

- **Ray distributed computing clusters** for large-scale machine learning pipelines
- **DESI anomaly detection workloads** processing 1.6M+ astronomical spectra
- **GPU-accelerated workloads** for deep learning and image processing (planned)

**Data Processing:**

- **Scalable microservices** for astronomical data ETL and transformation
- **Event-driven processing** for real-time data analysis and alerting
- **Batch computing** for large-scale statistical analysis and modeling

**Infrastructure Services:**

- **Monitoring and observability** components integrated with centralized mon01 stack
- **CI/CD pipelines** supporting automated research software deployment
- **Development environments** for collaborative astronomical software development

### **Integration with Hybrid Architecture**

RKE2 cluster integrates seamlessly with strategic VM infrastructure:

- **Database Connectivity:** Direct access to proj-pg01 PostgreSQL for persistent astronomical data
- **Storage Integration:** Proxmox-backed persistent volumes with enterprise backup strategies
- **Monitoring Alignment:** Unified observability with VM-based monitoring infrastructure
- **Security Integration:** Consistent access control and authentication across hybrid platforms

---

## **🔒 Enterprise Security**

### **Security Framework**

RKE2 implementation follows enterprise security best practices:

- **CIS Kubernetes Benchmark** compliance for hardened cluster configuration
- **Pod Security Standards** enforcement for workload security policies
- **Network Policies** for micro-segmentation and traffic control
- **Secrets Management** with external secret store integration (planned)

### **Access Control**

- **Kubernetes RBAC** with fine-grained role and permission management
- **Service Account Management** for application-specific access control
- **Admission Controllers** for policy enforcement and resource validation
- **Audit Logging** for comprehensive security monitoring and compliance

### **Compliance Alignment**

- **NIST Cybersecurity Framework** alignment for risk management
- **CIS Controls v8** implementation for baseline security controls
- **Research Computing Standards** appropriate for sensitive astronomical data

---

## **📊 Operational Excellence**

### **Monitoring and Observability**

Comprehensive monitoring integrated with enterprise observability stack:

- **Prometheus** for metrics collection and alerting
- **Grafana** dashboards for cluster and workload visualization
- **Loki** for centralized log aggregation and analysis
- **Jaeger** for distributed tracing and performance analysis (planned)

### **Performance Optimization**

Cluster optimized for astronomical computing requirements:

- **Resource Management** with appropriate requests and limits for scientific workloads
- **Node Affinity** for optimal workload placement across cluster nodes
- **Auto-Scaling** with Horizontal Pod Autoscaler for dynamic workload management
- **Performance Tuning** for compute-intensive astronomical applications

### **Disaster Recovery**

Enterprise-grade backup and recovery capabilities:

- **Velero** for application-consistent cluster backup
- **ETCD Backup** for cluster state protection and recovery
- **Multi-Zone Resilience** across Proxmox cluster nodes
- **Recovery Testing** with regular disaster recovery validation

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: rke2, kubernetes, distributed-computing, container-orchestration, enterprise-infrastructure

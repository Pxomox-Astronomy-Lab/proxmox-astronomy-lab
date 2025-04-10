<!-- 
---
title: "Kubernetes RKE2 Infrastructure"
description: "Documentation for the RKE2 Kubernetes implementation in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["kubernetes", "rke2", "rancher", "containers", "orchestration", "k8s"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# ☸️ **Kubernetes RKE2 Infrastructure**

# 🔍 **1. Overview**

The Proxmox Astronomy Lab implements a production-grade Kubernetes environment using Rancher Kubernetes Engine 2 (RKE2), a CNCF-certified Kubernetes distribution focused on security and compliance. This infrastructure provides container orchestration for our research workloads, data processing pipelines, and AI/ML applications while maintaining a hardened security posture.

Our RKE2 implementation creates a scalable, resilient platform with enterprise features like high availability, role-based access control, and integrated monitoring, allowing for efficient management of containerized applications across our scientific and operational domains.

---

# 🛠️ **2. Cluster Architecture**

## **2.1 Control Plane**

The highly-available control plane manages the overall cluster state and orchestration.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Management Node 01** | Primary control plane | [K8SM01](/k8s-rancher-rke2/control-plane/k8sm01/README.md) |
| **Management Node 02** | Secondary control plane | [K8SM02](/k8s-rancher-rke2/control-plane/k8sm02/README.md) |
| **Management Node 03** | Tertiary control plane | [K8SM03](/k8s-rancher-rke2/control-plane/k8sm03/README.md) |

## **2.2 Worker Nodes**

Compute resources that run application workloads and containers.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Worker Nodes 01-03** | General-purpose workloads | [Worker 01-03](/k8s-rancher-rke2/worker-nodes/general-purpose/README.md) |
| **Worker Node 04** | GPU-accelerated workloads | [Worker 04](/k8s-rancher-rke2/worker-nodes/gpu-compute/README.md) |
| **Worker Node 05** | Storage-optimized workloads | [Worker 05](/k8s-rancher-rke2/worker-nodes/storage-optimized/README.md) |

---

# 📊 **3. Workload Management**

## **3.1 Namespace Organization**

Logical separation of workloads by function and team.

| **Namespace** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **research** | Scientific applications | [Research Namespace](/k8s-rancher-rke2/workloads/research/README.md) |
| **monitoring** | Observability stack | [Monitoring Namespace](/k8s-rancher-rke2/workloads/monitoring/README.md) |
| **ai-ml** | Machine learning pipelines | [AI/ML Namespace](/k8s-rancher-rke2/workloads/ai-ml/README.md) |
| **database** | Database services | [Database Namespace](/k8s-rancher-rke2/workloads/database/README.md) |

## **3.2 Deployment Methodology**

Methodologies for deploying and managing applications.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Helm Charts** | Package management | [Helm Configuration](/k8s-rancher-rke2/deployment/helm/README.md) |
| **GitOps (ArgoCD)** | Declarative deployments | [GitOps Pipeline](/k8s-rancher-rke2/deployment/gitops/README.md) |
| **Rancher Apps** | Application catalog | [Rancher Apps](/k8s-rancher-rke2/deployment/rancher-apps/README.md) |

---

# 🔒 **4. Security Implementation**

## **4.1 Access Control**

Security mechanisms for authentication and authorization.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **RBAC** | Role-based access control | [RBAC Configuration](/k8s-rancher-rke2/security/rbac/README.md) |
| **Entra Integration** | Microsoft identity integration | [Identity Federation](/k8s-rancher-rke2/security/identity/README.md) |
| **Network Policies** | Network security controls | [Network Policies](/k8s-rancher-rke2/security/network-policies/README.md) |

## **4.2 Hardening Measures**

Additional security controls for the Kubernetes environment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Pod Security Standards** | Workload security policies | [PSS Configuration](/k8s-rancher-rke2/security/pod-security/README.md) |
| **CIS Benchmarks** | Compliance with security standards | [CIS Implementation](/k8s-rancher-rke2/security/cis-benchmarks/README.md) |
| **Secret Management** | Secure credential handling | [Secret Management](/k8s-rancher-rke2/security/secrets/README.md) |

---

# 💾 **5. Storage Integration**

## **5.1 Storage Classes**

Different storage options for various workload requirements.

| **Storage Class** | **Function** | **Documentation** |
|-------------------|-------------|-------------------|
| **Local-Path** | Node-local storage | [Local Storage](/k8s-rancher-rke2/storage/local-path/README.md) |
| **NFS** | Network file storage | [NFS Provisioner](/k8s-rancher-rke2/storage/nfs/README.md) |
| **MinIO S3** | Object storage | [MinIO Integration](/k8s-rancher-rke2/storage/minio/README.md) |

## **5.2 Backup Solutions**

Data protection for Kubernetes workloads.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Velero** | Cluster-wide backup | [Velero Configuration](/k8s-rancher-rke2/backups/velero/README.md) |
| **Volume Snapshots** | PVC backups | [Volume Snapshots](/k8s-rancher-rke2/backups/volume-snapshots/README.md) |

---

# 👁️ **6. Monitoring & Observability**

## **6.1 Monitoring Stack**

Comprehensive monitoring for cluster and applications.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Prometheus** | Metrics collection | [Prometheus Setup](/k8s-rancher-rke2/monitoring/prometheus/README.md) |
| **Grafana** | Visualization and dashboards | [Grafana Configuration](/k8s-rancher-rke2/monitoring/grafana/README.md) |
| **AlertManager** | Alert routing | [AlertManager](/k8s-rancher-rke2/monitoring/alertmanager/README.md) |

## **6.2 Logging Solution**

Centralized logging for troubleshooting and analysis.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Loki** | Log aggregation | [Loki Setup](/k8s-rancher-rke2/logging/loki/README.md) |
| **Promtail** | Log collection | [Promtail Configuration](/k8s-rancher-rke2/logging/promtail/README.md) |
| **Log Retention** | Log lifecycle management | [Log Retention](/k8s-rancher-rke2/logging/retention/README.md) |

---

# 🗂️ **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **control-plane** | Management node documentation | [Control Plane](/k8s-rancher-rke2/control-plane/README.md) |
| **worker-nodes** | Worker node configuration | [Worker Nodes](/k8s-rancher-rke2/worker-nodes/README.md) |
| **workloads** | Application deployments | [Workloads](/k8s-rancher-rke2/workloads/README.md) |
| **security** | Security configurations | [Security](/k8s-rancher-rke2/security/README.md) |
| **storage** | Storage provisioners | [Storage](/k8s-rancher-rke2/storage/README.md) |
| **monitoring** | Observability stack | [Monitoring](/k8s-rancher-rke2/monitoring/README.md) |
| **logging** | Logging infrastructure | [Logging](/k8s-rancher-rke2/logging/README.md) |
| **deployment** | Deployment methodologies | [Deployment](/k8s-rancher-rke2/deployment/README.md) |
| **backups** | Backup solutions | [Backups](/k8s-rancher-rke2/backups/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Cluster Architecture** | Overall architecture design | [Architecture](/k8s-rancher-rke2/cluster-architecture.md) |
| **Installation Procedure** | Cluster deployment steps | [Installation](/k8s-rancher-rke2/installation-procedure.md) |
| **Upgrade Procedure** | Version upgrade process | [Upgrade](/k8s-rancher-rke2/upgrade-procedure.md) |
| **Disaster Recovery** | Recovery procedures | [DR Plan](/k8s-rancher-rke2/disaster-recovery.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Underlying virtualization | [Infrastructure](/infrastructure/README.md) |
| **Monitoring** | Extended observability | [Monitoring](/monitoring/README.md) |
| **Applications** | Containerized applications | [Applications](/docs/Applications/README.md) |
| **Research Projects** | Scientific workloads | [Research](/docs/Research-Projects/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |

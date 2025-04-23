<!-- 
---
title: "Kubernetes RKE2 Infrastructure Documentation"
description: "Central knowledge base for the RKE2-based Kubernetes infrastructure in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["kubernetes", "rke2", "cluster", "rancher", "infrastructure", "documentation", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Proxmox", "Infrastructure Management", "Container Orchestration"]
---
-->

# 🚢 **Kubernetes RKE2 Infrastructure**

# 🔍 **1. Overview**

The Kubernetes infrastructure in the Proxmox Astronomy Lab is built on RKE2, a CNCF-certified Kubernetes distribution focused on security and compliance. This documentation hub provides comprehensive information about the cluster architecture, configuration, management, and operations. The RKE2 cluster serves as the foundation for containerized applications, scientific workloads, and data processing pipelines that support the lab's radio astronomy research activities.

Designed with both security and performance in mind, the cluster follows infrastructure-as-code principles with all configurations maintained in version control. The architecture balances high availability, resource efficiency, and workload isolation while adhering to security best practices and compliance requirements.

---

# 📂 **2. Core Infrastructure Documentation**

## **2.1 Cluster Architecture**

Comprehensive documentation of the Kubernetes cluster design, components, and integration.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **RKE2 Cluster Overview** | Overall architecture and design | [Cluster Overview](01-rke2-cluster-overview.md) |
| **Node Configuration** | Node roles, resources, and setup | [Node Configuration](02-node-configuration.md) |
| **Networking** | CNI, ingress, and network security | [Networking](03-networking.md) |
| **Storage** | Persistent volumes and data management | [Storage](04-storage.md) |
| **Security & Compliance** | Hardening and compliance controls | [Security & Compliance](05-security-compliance.md) |
| **GPU Infrastructure** | GPU node setup and configuration | [GPU Infrastructure](06-gpu-infrastructure.md) |
| **Backup & Recovery** | Disaster recovery procedures | [Backup & Recovery](07-backup-disaster-recovery.md) |

## **2.2 Core Service Components**

Documentation for essential cluster services that enable application deployment and management.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Traefik Ingress** | External access to services | [Traefik Ingress](service-docs/traefik-ingress.md) |
| **cert-manager** | TLS certificate management | [Certificate Management](service-docs/cert-manager.md) |
| **Rancher Management** | Cluster management interface | [Rancher Management](service-docs/rancher-management.md) |
| **NVIDIA GPU Operator** | GPU management for AI/ML | [GPU Operator](service-docs/gpu-operator.md) |

---

# 🛠️ **3. Operational Documentation**

## **3.1 Management Procedures**

Routine operational tasks for maintaining the Kubernetes infrastructure.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Cluster Upgrades** | RKE2 version upgrade process | [Upgrade Procedures](operational/cluster-upgrades.md) |
| **Monitoring & Alerting** | Infrastructure observability | [Monitoring Guide](operational/monitoring-alerting.md) |

---

# 🗂️ **4. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **service-docs** | Individual service documentation | [Service Documentation](service-docs/README.md) |
| **operational** | Operational procedures and guides | [Operational Guides](operational/README.md) |
| **troubleshooting** | Problem resolution guides | [Troubleshooting Guides](troubleshooting/README.md) |
| **examples** | Example manifests and configurations | [Example Configurations](examples/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **RKE2 Cluster Overview** | Primary cluster architecture document | [Cluster Overview](01-rke2-cluster-overview.md) |
| **Security & Compliance** | Security controls documentation | [Security & Compliance](05-security-compliance.md) |
| **Cluster Upgrades** | Version upgrade procedures | [Upgrade Procedures](operational/cluster-upgrades.md) |
| **Disaster Recovery** | Recovery from cluster failures | [Recovery Procedures](operational/disaster-recovery.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical hardware and virtualization | [Infrastructure Documentation](../infrastructure/README.md) |
| **Applications** | Workloads running on Kubernetes | [Applications Documentation](../applications/README.md) |
| **Security** | Security policies and compliance | [Security Documentation](../compliance-security/README.md) |
| **Observatory Projects** | Scientific workloads and data pipelines | [Observatory Documentation](../research-projects/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial documentation structure | VintageDon |

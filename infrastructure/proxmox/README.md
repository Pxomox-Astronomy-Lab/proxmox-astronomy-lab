<!-- 
---
title: "Proxmox Virtualization - Proxmox Astronomy Lab"
description: "Documentation of the Proxmox VE hypervisor infrastructure that forms the foundation for all virtualized resources in the lab environment"
author: "VintageDon"
tags: ["proxmox", "infrastructure", "virtualization", "hypervisor", "cluster", "high-availability", "pve"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Kubernetes", "Storage", "Networking", "Control Plane"]
implements_policies: ["Infrastructure Security Policy", "High Availability Policy"]
phase: "phase-1"
---
-->

# 🔄 **Proxmox Virtualization - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The Proxmox Virtual Environment (PVE) serves as the **virtualization foundation** for the entire Proxmox Astronomy Lab, providing a robust, secure, and high-performance platform for all virtual machines, containers, and storage resources. This infrastructure combines enterprise-grade high availability features with open-source technologies to create a cohesive and resilient compute environment.

This section documents the Proxmox cluster architecture, node configurations, performance tuning, storage integration, and operational practices that govern the virtualization layer, establishing the essential foundation for all higher-level services and research workloads.

---

# 🏢 **2. Cluster Architecture**

## **2.1 Physical Nodes**

The Proxmox cluster consists of five physical nodes, each with specialized roles and capabilities within the environment.

| **Node** | **Hardware** | **Role** | **Documentation** |
|---------|------------|---------|-------------------|
| **node01** | Ryzen 5700U, 64GB RAM, 2TB NVMe | General-purpose virtualization, K8s management | [node01 Documentation](/infrastructure/compute/proxmox/node01-proxmox-compute.md) |
| **node02** | Ryzen 5700U, 64GB RAM, 2TB NVMe | General-purpose virtualization, K8s management | [node02 Documentation](/infrastructure/compute/proxmox/node02-proxmox-compute.md) |
| **node03** | Ryzen 5700U, 64GB RAM, 2TB NVMe | General-purpose virtualization, K8s management | [node03 Documentation](/infrastructure/compute/proxmox/node03-proxmox-compute.md) |
| **node04** | Ryzen 5950X, 128GB RAM, 4TB NVMe, RTX A4000 | GPU-accelerated workloads, AI/ML, databases | [node04 Documentation](/infrastructure/compute/proxmox/node04-proxmox-gpu-hpc.md) |
| **node05** | Ryzen 3700X, 128GB RAM, 64TB raw storage | Storage services, backups, file shares | [node05 Documentation](/infrastructure/compute/proxmox/node05-proxmox-zfs-storage.md) |

## **2.2 Resource Distribution**

The following table shows the current VM resource allocation across the cluster nodes:

| **Node** | **VMs Assigned** | **vCPU Used** | **RAM Used** |
|---------|-----------------|--------------|--------------|
| **node01** | proj-k8sm01, proj-k8sw01, dc01, lab-soc1 | 16/16 | 58GB/64GB |
| **node02** | proj-k8sm02, proj-k8sw02, lab-dns01, lab-mon01, lab-ansible01, lab-apps01 | 18/16 | 66GB/64GB |
| **node03** | proj-k8sm03, proj-k8sw03, lab-db01, dc02, proj-dns01 | 16/16 | 64GB/64GB |
| **node04** | proj-k8sw04, proj-pg01, proj-pggis01, proj-pgts01, proj-rds01, proj-apps01, proj-fs01, lab-port01 | 28/32 | 86GB/128GB |
| **node05** | proj-k8sw05, proj-kasm01 | 14/16 | 56GB/128GB |

---

# 🛠️ **3. Configuration & Management**

## **3.1 High Availability Features**

The Proxmox cluster implements several high availability mechanisms to ensure service continuity.

| **Feature** | **Implementation** | **Documentation** |
|------------|-------------------|-------------------|
| **Quorum Management** | 3 quorum nodes with controlled fencing | [High Availability Documentation](/docs/Infrastructure/Compute/Proxmox/high-availability.md) |
| **VM Migration** | Live migration over dedicated 10G network | [Migration Documentation](/docs/Infrastructure/Compute/Proxmox/vm-migration.md) |
| **Storage Redundancy** | Replicated storage with journaling | [Storage Documentation](/infrastructure/storage/README.md) |

## **3.2 Performance Tuning**

Optimizations applied to maximize virtualization performance across the cluster.

| **Optimization** | **Purpose** | **Documentation** |
|-----------------|------------|-------------------|
| **CPU Pinning** | Dedicated cores for critical VMs | [CPU Optimization](/docs/Infrastructure/Compute/Proxmox/cpu-optimization.md) |
| **Memory Ballooning** | Dynamic memory management | [Memory Management](/docs/Infrastructure/Compute/Proxmox/memory-management.md) |
| **I/O Scheduling** | Storage I/O priority control | [I/O Optimization](/docs/Infrastructure/Compute/Proxmox/io-optimization.md) |

---

# 📄 **4. VM Templates & Standards**

## **4.1 Golden Images**

Standardized, security-hardened VM templates used for consistent deployment.

| **Template** | **Specifications** | **Security Baseline** |
|-------------|-------------------|----------------------|
| **Ubuntu 24.04 Server** | 2 vCPU, 4GB RAM base | CISv8 Level 2 |
| **Windows Server 2025** | 2 vCPU, 6GB RAM base | CISv9 Level 1 |
| **Ubuntu 24.04 Desktop** | 4 vCPU, 8GB RAM base | CISv8 Level 1 |

---

# 💾 **5. Storage Integration**

## **5.1 Storage Types**

Multiple storage technologies integrated for different performance and capacity needs.

| **Storage Type** | **Implementation** | **Use Case** |
|-----------------|-------------------|-------------|
| **Local LVM-Thin** | Local NVMe storage with thin provisioning | VM disks, high-performance workloads |
| **NFS Storage** | Shared storage for migration support | VM disks requiring live migration |
| **Ceph RBD** | Planned distributed storage | Future scale-out storage (Phase 4) |

---

# 🔗 **6. Directory Contents**

This section provides direct navigation to key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **High Availability Configuration** | HA cluster setup and management | [High Availability Documentation](/docs/Infrastructure/Compute/Proxmox/high-availability.md) |
| **VM Templates** | Standard VM image specifications | [VM Templates Documentation](/docs/Infrastructure/Compute/Proxmox/vm-templates.md) |
| **Performance Tuning** | Optimization guidelines | [Performance Documentation](/docs/Infrastructure/Compute/Proxmox/performance-tuning.md) |
| **Backup Strategy** | VM backup configurations | [Backup Documentation](/docs/Infrastructure/Compute/Proxmox/backup-strategy.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical hosts running Proxmox | [Infrastructure Documentation](/infrastructure/README.md) |
| **Networking** | Network infrastructure for Proxmox | [Networking Documentation](/infrastructure/networking/README.md) |
| **Storage** | Storage systems integrated with Proxmox | [Storage Documentation](/infrastructure/storage/README.md) |
| **Control Plane** | Core services running on Proxmox VMs | [Control Plane Documentation](/infrastructure/control-plane/README.md) |
| **Kubernetes** | Container platform on Proxmox VMs | [Kubernetes Documentation](/infrastructure/kubernetes/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for Proxmox virtualization | VintageDon |

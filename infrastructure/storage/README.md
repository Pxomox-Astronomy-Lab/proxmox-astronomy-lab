<!-- 
---
title: "Storage Infrastructure - Proxmox Astronomy Lab"
description: "Documentation of multi-tiered storage architecture, technologies, and services supporting the lab's research and computing needs"
author: "VintageDon"
tags: ["storage", "infrastructure", "zfs", "nfs", "s3", "proxmox", "backup"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Proxmox", "Kubernetes", "Databases", "Backup Services"]
implements_policies: ["Data Protection Policy", "Backup and Recovery Policy"]
phase: "phase-1"
---
-->

# 💾 **Storage Infrastructure - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The storage infrastructure of the Proxmox Astronomy Lab implements a comprehensive, multi-tiered approach to data management that balances performance, capacity, and reliability requirements for both infrastructure services and research workloads. This architecture encompasses local high-performance storage, network-attached storage systems, object storage, and dedicated backup resources.

This section documents the complete storage architecture, technologies, implementation details, and operational practices that govern the lab's data storage capabilities, serving as the authoritative reference for all storage-related configurations and design decisions.

---

# 🖥️ **2. Physical Storage Resources**

## **2.1 Node-Level Storage**

Each physical node in the cluster is equipped with specialized storage resources based on its role and workload profile.

| **Node** | **Boot Drive** | **Primary Storage** | **Additional Storage** | **Network** |
|---------|---------------|---------------------|----------------------|-------------|
| **Node01** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node02** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node03** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node04** | 256GB SATA SSD | 4TB Samsung PM893 NVMe | - | 2× 10GbE |
| **Node05** | 256GB SATA SSD | 2× 4TB Samsung PM893 NVMe | 2× 4TB Intel DC4510 SSD<br>8× 8TB HDD (ZFS RAID10) | 2× 10GbE |

## **2.2 Storage Technologies**

The storage architecture utilizes multiple technologies to provide appropriate performance and reliability for different workload types.

| **Technology** | **Implementation** | **Primary Use Case** |
|---------------|-------------------|----------------------|
| **LVM-Thin** | Local NVMe with thin provisioning | VM disks, high-performance workloads |
| **ZFS** | RAID10 with SSD caching | Reliable data storage, snapshots, backup targets |
| **NFS** | Shared network storage | VM migration support, research data |
| **S3 Object Storage** | MinIO on ZFS backend | Research datasets, unstructured data |
| **SMB/CIFS** | Windows file shares | User data, documentation, shared resources |

---

# 🔄 **3. Storage Services**

## **3.1 Network Storage Services**

These services provide network-accessible storage for various workload types.

| **Service** | **Host** | **Protocol** | **Primary Use** | **Documentation** |
|------------|---------|--------------|----------------|-------------------|
| **Windows File Shares** | lab-fs01, lab-fs02 | SMB | AD-integrated file storage | [Windows Storage](/docs/Infrastructure/Storage/NFS/README.md) |
| **NFS Storage** | lab-fs03 | NFSv4 | Kubernetes persistent volumes | [NFS Storage](/docs/Infrastructure/Storage/NFS/README.md) |
| **Object Storage** | lab-fs03 | S3 | Research datasets, backups | [Object Storage](/docs/Infrastructure/Storage/Object-Storage/README.md) |

## **3.2 Backup Infrastructure**

The backup architecture ensures comprehensive data protection through multiple approaches.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox Backup Server** | VM backup repository on Node05 | [PBS Documentation](/docs/Infrastructure/Storage/Backup-Strategy/README.md) |
| **ZFS Snapshots** | Point-in-time recovery | [ZFS Snapshot Strategy](/docs/Infrastructure/Storage/Backup-Strategy/README.md) |
| **Azure Blob Storage** | Offsite backup repository | [Cloud Backup](/entra-hybrid-cloud/storage-services/azure-blob-keyvault01-backups.md) |

---

# 📊 **4. Performance Characteristics**

Storage performance is optimized for different workload types with the following typical metrics:

| **Storage Tier** | **Sequential Read** | **Sequential Write** | **Random Read IOPS** | **Random Write IOPS** |
|-----------------|---------------------|----------------------|----------------------|------------------------|
| **Local NVMe** | 6.5 GB/s | 5.0 GB/s | 900K | 600K |
| **ZFS SSD Mirror** | 4.8 GB/s | 2.2 GB/s | 320K | 100K |
| **ZFS HDD Pool** | 1.8 GB/s | 1.2 GB/s | 5K | 2K |
| **NFS Storage** | 1.1 GB/s | 950 MB/s | 45K | 28K |
| **SMB Storage** | 1.0 GB/s | 900 MB/s | 40K | 25K |

---

# 🛡️ **5. Data Protection & Resiliency**

## **5.1 Backup Strategy**

The backup implementation provides comprehensive protection with structured retention policies.

| **Backup Type** | **Frequency** | **Retention** | **Storage Location** |
|----------------|--------------|--------------|----------------------|
| **VM Backups** | Daily | 7 daily, 4 weekly, 3 monthly | Proxmox Backup Server |
| **ZFS Snapshots** | Hourly | 24 hourly, 7 daily | Local ZFS storage |
| **Critical Data Backups** | Weekly | 12 weekly | Azure Blob Storage |

## **5.2 Redundancy & Resilience**

Data resilience is ensured through multiple redundancy approaches.

| **Technique** | **Implementation** | **Documentation** |
|--------------|-------------------|-------------------|
| **RAID10** | ZFS mirrored vdevs | [ZFS Configuration](/docs/Infrastructure/Storage/zfs-configuration.md) |
| **Multi-Path I/O** | NFS/SMB with multipath networking | [Multipath Configuration](/docs/Infrastructure/Storage/multipath-configuration.md) |
| **Replication** | ZFS send/receive between nodes | [Replication Strategy](/docs/Infrastructure/Storage/replication-strategy.md) |

---

# 🔗 **6. Directory Contents**

This section provides direct navigation to documentation resources:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **ZFS Configuration** | ZFS pool setup and management | [ZFS Configuration](/docs/Infrastructure/Storage/zfs-configuration.md) |
| **Backup Strategy** | Comprehensive backup procedures | [Backup Strategy](/docs/Infrastructure/Storage/Backup-Strategy/README.md) |
| **NFS Configuration** | NFS server and client setup | [NFS Configuration](/docs/Infrastructure/Storage/NFS/README.md) |
| **Object Storage** | S3-compatible storage implementation | [Object Storage](/docs/Infrastructure/Storage/Object-Storage/README.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical hosts utilizing storage | [Infrastructure Documentation](/infrastructure/README.md) |
| **Proxmox** | Virtualization platform integrated with storage | [Proxmox Documentation](/infrastructure/proxmox/README.md) |
| **Kubernetes** | Container platform using persistent storage | [Kubernetes Documentation](/infrastructure/kubernetes/README.md) |
| **Entra Hybrid Cloud** | Cloud storage integration | [Cloud Storage Documentation](/entra-hybrid-cloud/storage-services/README.md) |
| **Security & Compliance** | Storage security policies | [Security Documentation](/docs/Compliance-Security/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for storage infrastructure | VintageDon |

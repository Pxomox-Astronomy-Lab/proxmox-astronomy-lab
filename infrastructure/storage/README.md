<!-- 
---
title: "Proxmox Astronomy Lab - Storage Infrastructure"
description: "Overview of the lab's storage architecture, technologies, and resources"
author: "VintageDon"
tags: ["storage", "zfs", "nfs", "s3", "smb", "proxmox"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 💾 **Proxmox Astronomy Lab - Storage Infrastructure**

Our storage infrastructure implements a multi-tiered approach to data management, balancing performance, capacity, and reliability for both infrastructure services and research workloads.

## 📊 **1. Storage Architecture**

The lab's storage design incorporates multiple storage technologies and access methods to meet diverse requirements:

- **Local NVMe** for performance-critical virtualization and database workloads
- **ZFS storage pool** for reliable, resilient data storage with snapshots
- **Network file services** including SMB, NFS, and S3 object storage
- **Dedicated high-speed network paths** for storage traffic

## 🖥️ **2. Node Storage Resources**

Each node features strategically allocated storage resources based on its role and workload profile.

| **Node** | **Boot Drive** | **Primary Storage** | **Additional Storage** | **Network** |
|---------|---------------|---------------------|----------------------|-------------|
| **Node01** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node02** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node03** | 256GB SATA SSD | 2TB Samsung PM893 NVMe | - | 2× 2.5GbE |
| **Node04** | 256GB SATA SSD | 4TB Samsung PM893 NVMe | - | 2× 10GbE |
| **Node05** | 256GB SATA SSD | 2× 4TB Samsung PM893 NVMe | 2× 4TB Intel DC4510 SSD<br>8× 8TB HDD (ZFS RAID10) | 2× 10GbE |

### **2.1 Node05 ZFS Configuration**

Node05 serves as our primary ZFS storage node with:

- **8× 8TB HDDs** in mirrored vdevs (effective RAID10)
- **SLOG (ZIL)** on dedicated 32GB NVMe partition
- **L2ARC** cache on Intel DC4510 SSD partition
- **Dataset structure** optimized for different workload types

## 🌐 **3. Network Storage Services**

The lab provides multiple network storage services for various workload types.

| **Service** | **Host** | **Protocol** | **Primary Use** | **Performance** |
|------------|---------|--------------|----------------|----------------|
| **Windows File Shares** | lab-fs01, lab-fs02 | SMB | AD-integrated file storage | 10GbE multipath |
| **NFS Storage** | lab-fs03 | NFSv4 | Kubernetes persistent volumes | 10GbE |
| **Object Storage** | lab-fs03 | S3 | Research datasets, backups | 10GbE |
| **Bulk Storage** | lab-fs03 | SMB, NFS | Archive data, media | 10GbE |

### **3.1 Windows Scale-Out File Server**

The lab-fs01 and lab-fs02 servers implement Windows Server 2025 Scale-Out File Server with:

- **Active-active file shares** with transparent failover
- **SMB Multichannel** for performance and redundancy
- **Kerberos authentication** via Active Directory integration
- **Access-based enumeration** and granular permissions

### **3.2 OpenMediaVault Storage Server**

The lab-fs03 server provides flexible storage options through OpenMediaVault with:

- **ZFS backend** for data integrity and snapshots
- **MinIO S3 gateway** for object storage
- **NFSv4 exports** with Kerberos security
- **Snapshot-based backups** to secondary storage

## 🔄 **4. Backup Architecture**

Our backup strategy ensures comprehensive data protection:

- **Proxmox Backup Server** on Node05 for VM backups
- **ZFS snapshots** for point-in-time recovery
- **Offsite replication** for critical datasets
- **Structured retention policies** (7 daily, 4 weekly, 3 monthly)

## 📊 **5. Performance Characteristics**

Storage performance is optimized for different workload types:

| **Storage Tier** | **Sequential Read** | **Sequential Write** | **Random Read IOPS** | **Random Write IOPS** |
|-----------------|---------------------|----------------------|----------------------|------------------------|
| **Local NVMe** | 6.5 GB/s | 5.0 GB/s | 900K | 600K |
| **ZFS SSD Mirror** | 4.8 GB/s | 2.2 GB/s | 320K | 100K |
| **ZFS HDD Pool** | 1.8 GB/s | 1.2 GB/s | 5K | 2K |
| **NFS Storage** | 1.1 GB/s | 950 MB/s | 45K | 28K |
| **SMB Storage** | 1.0 GB/s | 900 MB/s | 40K | 25K |

These values represent typical performance under normal workloads.

## 🔍 **6. Monitoring & Management**

Storage resources are continuously monitored for health, capacity, and performance:

- **SMART monitoring** for drive health status
- **ZFS pool status** monitoring via Prometheus
- **Capacity trending** with automated alerts
- **Performance metrics** for throughput and latency

## 📑 **7. Documentation Resources**

Detailed storage documentation is available:

- **ZFS Configuration Guide** - Pool layouts and tuning parameters
- **Backup Procedures** - Complete backup workflows
- **Filesystem Structure** - Dataset organization and mount points
- **Recovery Procedures** - Steps for data recovery scenarios

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial storage README | VintageDon |

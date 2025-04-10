# 💾 **Storage Infrastructure**

# 🔍 **1. Overview**

The storage infrastructure of the Proxmox Astronomy Lab provides the foundation for data persistence, scientific datasets, and system backups through a multi-tiered architecture. Our storage design balances performance, capacity, and resilience while accommodating the specialized needs of radio astronomy data processing, virtualization workloads, and long-term archival storage.

This section documents our tiered storage approach, which ranges from high-performance NVMe storage for critical workloads to capacity-optimized ZFS arrays for scientific datasets and object storage for cloud-compatible access patterns. Each storage tier is designed with appropriate performance characteristics, data protection mechanisms, and access methods.

---

# 🏗️ **2. Storage Architecture**

## **2.1 Design Principles**

Our storage infrastructure is built on these core principles:

| **Principle** | **Implementation Approach** | **Documentation** |
|--------------|---------------------------|-------------------|
| **Performance Tiering** | Workload-appropriate storage types | [Storage Tiers](storage-tiering.md) |
| **Data Protection** | RAID, replication, and snapshots | [Data Protection](data-protection-strategy.md) |
| **Resilience** | Distributed storage across nodes | [Storage Resilience](storage-resiliency.md) |
| **Scalability** | Expandable capacity design | [Capacity Planning](capacity-planning.md) |

## **2.2 Storage Tiers**

Our environment implements multiple storage tiers with different performance characteristics:

| **Tier** | **Technology** | **Performance** | **Capacity** | **Use Case** | **Documentation** |
|---------|--------------|---------------|------------|------------|-------------------|
| **Tier 1** | Local NVMe | Very High | 16TB | VM OS disks, databases | [NVMe Tier](storage-tiers/nvme-tier.md) |
| **Tier 2** | ZFS on SSDs | High | 24TB | Active datasets, K8s storage | [SSD Tier](storage-tiers/ssd-tier.md) |
| **Tier 3** | ZFS on HDDs | Medium | 48TB | Scientific data, archives | [HDD Tier](storage-tiers/hdd-tier.md) |
| **Tier 4** | Object Storage | Variable | Unlimited | Backups, cloud integration | [Object Tier](storage-tiers/object-tier.md) |

---

# 🧩 **3. Storage Implementations**

## **3.1 Local Storage**

Host-local storage for performance-critical workloads:

| **Node** | **Storage Configuration** | **Capacity** | **Documentation** |
|---------|--------------------------|------------|-------------------|
| **Node01-03** | 2TB NVMe (OS), 2TB NVMe (VMs) | 4TB per node | [Node Local Storage](local-storage/compute-nodes.md) |
| **Node04** | 2TB NVMe (OS), 2x4TB NVMe (VMs) | 10TB | [HPC Node Storage](local-storage/hpc-node.md) |
| **Node05** | 2TB NVMe (OS), 8x8TB SAS (ZFS) | 64TB raw | [Storage Node](local-storage/storage-node.md) |

## **3.2 Shared Storage**

Clustered storage systems for shared access:

| **Implementation** | **Technology** | **Use Case** | **Documentation** |
|-------------------|--------------|------------|-------------------|
| **NFS Shares** | ZFS-backed exports | VM storage, shared data | [NFS Configuration](NFS/nfs-configuration.md) |
| **MinIO S3** | Object storage | Cloud-compatible storage | [Object Storage](Object-Storage/minio-configuration.md) |
| **iSCSI** | ZFS-backed LUNs | Block storage for databases | [iSCSI Configuration](iscsi-configuration.md) |

---

# 📊 **4. Performance Characteristics**

## **4.1 Benchmark Results**

Measured performance of storage systems:

| **Storage System** | **Sequential Read** | **Sequential Write** | **Random Read** | **Random Write** | **Documentation** |
|-------------------|-------------------|---------------------|---------------|----------------|-------------------|
| **NVMe Local** | 3.5 GB/s | 3.0 GB/s | 650K IOPS | 600K IOPS | [NVMe Benchmarks](benchmarks/nvme-performance.md) |
| **ZFS SSD Pool** | 1.2 GB/s | 1.0 GB/s | 110K IOPS | 90K IOPS | [ZFS SSD Benchmarks](benchmarks/zfs-ssd-performance.md) |
| **ZFS HDD Pool** | 450 MB/s | 400 MB/s | 1.2K IOPS | 0.9K IOPS | [ZFS HDD Benchmarks](benchmarks/zfs-hdd-performance.md) |

## **4.2 Optimization Strategies**

Techniques for maximizing storage performance:

| **Strategy** | **Implementation** | **Documentation** |
|--------------|-------------------|-------------------|
| **ZFS Tuning** | ARC size, recordsize, compression | [ZFS Optimization](optimization/zfs-tuning.md) |
| **Network Optimization** | Jumbo frames, LACP bonding | [Storage Networking](optimization/storage-networking.md) |
| **Caching** | NVMe L2ARC, SLOG devices | [ZFS Caching](optimization/zfs-caching.md) |

---

# 📦 **5. Backup & Recovery**

## **5.1 Backup Strategy**

Our comprehensive backup approach:

| **Backup Type** | **Technology** | **Schedule** | **Retention** | **Documentation** |
|---------------|--------------|------------|------------|-------------------|
| **VM Backups** | Proxmox Backup Server | Daily | 7 daily, 4 weekly | [VM Backup](Backup-Strategy/vm-backup-procedures.md) |
| **File Backups** | Restic to S3 | Weekly | 4 weekly, 12 monthly | [File Backup](Backup-Strategy/file-backup-procedures.md) |
| **Database Backups** | Native + Restic | Daily | 7 daily, 4 weekly | [DB Backup](Backup-Strategy/database-backup-procedures.md) |

## **5.2 Disaster Recovery**

Procedures for recovering from storage failures:

| **Scenario** | **Recovery Approach** | **Documentation** |
|--------------|---------------------|-------------------|
| **Node Failure** | VM restoration from backups | [Node Recovery](disaster-recovery/node-failure.md) |
| **Storage Array Failure** | ZFS pool recovery procedures | [ZFS Recovery](disaster-recovery/zfs-recovery.md) |
| **Full Site Recovery** | Complete environment restoration | [DR Plan](disaster-recovery/site-recovery.md) |

---

# 🔐 **6. Security & Compliance**

## **6.1 Security Controls**

Storage-specific security measures:

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|-------------------------|
| **Encryption** | ZFS native encryption | Key verification |
| **Access Control** | ZFS permissions, ACLs | Permission auditing |
| **Secure Deletion** | Data sanitization procedures | Verification scanning |

## **6.2 Compliance Mapping**

Storage controls mapped to compliance frameworks:

| **CIS Control** | **Implementation** | **Evidence Location** |
|-----------------|-------------------|----------------------|
| **CIS 3.1** | Data classification and protection | Data inventory |
| **CIS 3.4** | Data encryption in transit and at rest | Configuration documentation |
| **CIS 10.2** | Recovery testing procedures | Test results documentation |

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Backup-Strategy** | Backup procedures and configurations | [Backup Strategy README](Backup-Strategy/README.md) |
| **NFS** | NFS server configuration and exports | [NFS README](NFS/README.md) |
| **Object-Storage** | S3-compatible storage implementation | [Object Storage README](Object-Storage/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Storage Architecture Overview** | High-level storage design document | [Architecture Overview](storage-architecture-overview.md) |
| **Performance Optimization Guide** | Tuning guidelines for storage systems | [Optimization Guide](performance-optimization-guide.md) |
| **Capacity Planning** | Storage growth management strategy | [Capacity Planning](capacity-planning.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Parent directory for storage | [Infrastructure README](../README.md) |
| **Compute** | Consumer of storage resources | [Compute README](../Compute/README.md) |
| **Networking** | Network connectivity for storage services | [Networking README](../Networking/README.md) |
| **Observatory-Hardware** | Data source for storage systems | [Observatory Hardware README](../Observatory-Hardware/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial storage README | VintageDon |

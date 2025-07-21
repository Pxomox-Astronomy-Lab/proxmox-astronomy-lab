# 💾 **Storage**

This wiki section provides enterprise-grade storage administration guides for the high-performance NVMe infrastructure across the 7-node Proxmox Astronomy Lab cluster. The documentation covers essential storage management procedures including enterprise vs. prosumer drive selection, NVMe TRIM/discard optimization, and node-level S.M.A.R.T. monitoring for production astronomical research workloads. These procedures ensure optimal storage performance, reliability, and longevity supporting multi-terabyte DESI datasets and high-I/O scientific computing applications.

## **Overview**

Storage infrastructure serves as the performance foundation for the hybrid research computing platform, providing enterprise-grade data management for both RKE2 Kubernetes workloads and critical PostgreSQL databases. The Proxmox Astronomy Lab implements 13+ TB of high-performance NVMe storage using enterprise-grade Samsung MZ1LB1T9HALS and MZALB3T8HALS drives with comprehensive S.M.A.R.T. monitoring and optimized discard configurations. This storage architecture supports production DESI analysis workloads, ML training datasets, and enterprise database systems with sub-millisecond I/O performance and enterprise reliability characteristics.

This wiki provides practical procedures for storage administrators, infrastructure engineers, and platform operators managing enterprise NVMe deployments. Each guide covers proven storage optimization techniques specific to the lab's high-performance requirements with considerations for drive longevity, performance optimization, and enterprise monitoring supporting astronomical research computing at scale.

---

## **📂 Directory Contents**

This section provides navigation to all storage administration guides and procedures.

### **📋 Core Storage Management**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[enterprise-drives-vs-prosumer.md](enterprise-drives-vs-prosumer.md)** | Why used enterprise drives provide better value than new prosumer drives | Enterprise storage procurement and cost optimization |
| **[proxmox-discard-nvme-optimization.md](proxmox-discard-nvme-optimization.md)** | Why Proxmox discard function is essential for NVMe longevity and performance | NVMe performance optimization and wear leveling |
| **[node-level-smart-monitoring.md](node-level-smart-monitoring.md)** | How to check S.M.A.R.T. data on drives at the Proxmox node level | Enterprise storage health monitoring and predictive maintenance |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[lvm-thin-provisioning-optimization.md](lvm-thin-provisioning-optimization.md)** | LVM thin provisioning configuration for research workloads | Storage administrators |
| **[storage-pool-performance-tuning.md](storage-pool-performance-tuning.md)** | NVMe storage pool performance optimization | Infrastructure engineers |
| **[backup-storage-strategies.md](backup-storage-strategies.md)** | Enterprise backup and data protection strategies | Platform administrators |

---

## **🏗️ Repository Structure**

```markdown
wiki/storage/
├── README.md                                    # This overview document
├── enterprise-drives-vs-prosumer.md            # Enterprise vs prosumer drive analysis
├── proxmox-discard-nvme-optimization.md        # NVMe discard and TRIM optimization
├── node-level-smart-monitoring.md              # S.M.A.R.T. monitoring procedures
├── lvm-thin-provisioning-optimization.md       # LVM thin provisioning optimization
├── storage-pool-performance-tuning.md          # Storage performance optimization
└── backup-storage-strategies.md                # Enterprise backup strategies
```

---

## **🔧 Lab Storage Configuration**

The storage deployment provides enterprise-grade performance and reliability across the 7-node cluster:

### **Enterprise NVMe Infrastructure**

| **Drive Model** | **Capacity** | **Type** | **Deployment** |
|----------------|--------------|----------|----------------|
| **Samsung MZ1LB1T9HALS-00007** | 1.92 TB | Enterprise NVMe (PM983) | Primary system and workload storage |
| **Samsung MZALB3T8HALS-00003** | 3.84 TB | Enterprise NVMe (PM9A3) | High-capacity workload storage |
| **Samsung MZ1LB1T9HBLS-000FB** | 1.88 TB | Enterprise NVMe (PM983a) | Performance-optimized storage |
| **Samsung SSD 990 PRO** | 2.00 TB | Prosumer NVMe | Supplemental high-performance storage |

### **Storage Performance Characteristics**

| **Metric** | **Enterprise NVMe** | **Performance Benefit** |
|------------|-------------------|----------------------|
| **DWPD (Drive Writes Per Day)** | 1.0-3.0 DWPD | Sustained high-write workloads for research data |
| **Endurance Rating** | 3,500-10,500 TBW | Multi-year reliability for production deployments |
| **Error Correction** | Advanced ECC with power-loss protection | Data integrity for critical research datasets |
| **Thermal Management** | Enterprise thermal throttling | Consistent performance under sustained load |

### **Storage Pool Architecture**

| **Storage Pool** | **Configuration** | **Purpose** |
|------------------|------------------|-------------|
| **pve (System)** | LVM on 273GB partition | Proxmox system storage and VM templates |
| **nvmethin01-04** | LVM thin provisioning | VM disk storage with overprovisioning |
| **Database Storage** | Dedicated high-IOPS volumes | PostgreSQL and research database workloads |
| **ML/AI Storage** | High-throughput volumes | Training datasets and model storage |

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Storage Integration** |
|--------------|------------------|----------------------|
| **[proxmox/](../proxmox/README.md)** | Virtualization platform management | VM storage provisioning and optimization |
| **[backup/](../backup/README.md)** | Data protection and recovery | Storage snapshot and backup integration |
| **[monitoring/](../monitoring/README.md)** | Infrastructure observability | Storage metrics, S.M.A.R.T. monitoring, and alerting |

### **Platform Integration**

| **Category** | **Relationship** | **Storage Integration** |
|--------------|------------------|----------------------|
| **[databases/](../databases/README.md)** | Database storage optimization | High-IOPS storage for PostgreSQL and research databases |
| **[k8s/](../k8s/README.md)** | Kubernetes persistent volumes | Container storage and persistent volume management |
| **[security/](../../security/README.md)** | Storage security and encryption | Data-at-rest protection and access control |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within storage administration.

### **For Storage Administrators**

**Procurement Planning:** [enterprise-drives-vs-prosumer.md](enterprise-drives-vs-prosumer.md)  
**Performance Optimization:** [proxmox-discard-nvme-optimization.md](proxmox-discard-nvme-optimization.md)  
**Health Monitoring:** [node-level-smart-monitoring.md](node-level-smart-monitoring.md)  
**Capacity Management:** [lvm-thin-provisioning-optimization.md](lvm-thin-provisioning-optimization.md)

### **For Infrastructure Engineers**

**Drive Selection:** [enterprise-drives-vs-prosumer.md](enterprise-drives-vs-prosumer.md)  
**NVMe Optimization:** [proxmox-discard-nvme-optimization.md](proxmox-discard-nvme-optimization.md)  
**Performance Tuning:** [storage-pool-performance-tuning.md](storage-pool-performance-tuning.md)  
**Monitoring Setup:** [node-level-smart-monitoring.md](node-level-smart-monitoring.md)

### **For Platform Administrators**

**Cost Analysis:** [enterprise-drives-vs-prosumer.md](enterprise-drives-vs-prosumer.md)  
**Configuration Optimization:** [proxmox-discard-nvme-optimization.md](proxmox-discard-nvme-optimization.md)  
**Health Management:** [node-level-smart-monitoring.md](node-level-smart-monitoring.md)  
**Backup Planning:** [backup-storage-strategies.md](backup-storage-strategies.md)

### **For Research Computing Teams**

**Performance Understanding:** [proxmox-discard-nvme-optimization.md](proxmox-discard-nvme-optimization.md)  
**Storage Health:** [node-level-smart-monitoring.md](node-level-smart-monitoring.md)  
**Capacity Planning:** [lvm-thin-provisioning-optimization.md](lvm-thin-provisioning-optimization.md)  
**Data Protection:** [backup-storage-strategies.md](backup-storage-strategies.md)

---

## **💡 Enterprise Storage Philosophy**

The storage infrastructure demonstrates sophisticated understanding of enterprise storage economics and performance optimization.

### **Enterprise vs. Prosumer Value Proposition**

| **Factor** | **Used Enterprise** | **New Prosumer** | **Enterprise Advantage** |
|------------|-------------------|-------------------|-------------------------|
| **Total Cost of Ownership** | Superior $/TBW ratio | Higher cost per endurance unit | 2-5x better value for sustained workloads |
| **Reliability Engineering** | Enterprise-grade components | Consumer-optimized design | Power-loss protection, advanced ECC |
| **Performance Consistency** | Sustained performance guarantee | Performance degradation under load | Predictable I/O for research workloads |
| **Operational Lifecycle** | Predictable wear patterns | Variable endurance characteristics | Simplified capacity planning and replacement |

### **NVMe Optimization Strategy**

| **Optimization** | **Implementation** | **Benefit** |
|------------------|-------------------|-------------|
| **Discard/TRIM** | Proxmox discard=on configuration | Optimal wear leveling and performance maintenance |
| **Over-provisioning** | LVM thin provisioning with headroom | Consistent performance and extended drive life |
| **IOThread Optimization** | Dedicated I/O threads per VM disk | Reduced latency and improved parallelism |
| **Block Size Optimization** | Aligned allocation for database workloads | Maximized throughput for research applications |

### **S.M.A.R.T. Monitoring Excellence**

| **Monitoring Aspect** | **Enterprise Implementation** | **Research Computing Value** |
|-----------------------|------------------------------|----------------------------|
| **Predictive Analytics** | Wearout percentage tracking | Proactive drive replacement planning |
| **Performance Metrics** | Temperature and throughput monitoring | Thermal management and performance validation |
| **Reliability Indicators** | Error rate and reallocated sector tracking | Data integrity assurance for critical research |
| **Operational Intelligence** | Historical trend analysis | Informed procurement and scaling decisions |

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: storage, nvme, enterprise-drives, smart-monitoring, discard-optimization, proxmox-storage, performance-tuning, research-computing

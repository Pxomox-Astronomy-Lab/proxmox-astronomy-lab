# 🖥️ **Proxmox VE**

This wiki section provides enterprise-grade administration guides for Proxmox Virtual Environment (VE) across the 7-node Proxmox Astronomy Lab cluster. The documentation covers essential Proxmox infrastructure management procedures including predictable network interface naming, enterprise boot partition configuration, and LACP bonding for high-availability networking. These procedures ensure reliable, scalable virtualization infrastructure supporting both RKE2 Kubernetes workloads and strategic static VMs for astronomical research computing.

## **Overview**

Proxmox VE serves as the foundational virtualization platform for the hybrid infrastructure, providing enterprise-grade VM management and container orchestration capabilities. The Proxmox Astronomy Lab implements Proxmox VE 8.4.5 across seven nodes with standardized network configurations, security hardening, and enterprise storage management. This configuration supports both dynamic Kubernetes workloads via RKE2 and critical infrastructure services through strategic VM placement, enabling scalable astronomical research computing with enterprise reliability and performance characteristics.

This wiki provides practical procedures for infrastructure administrators, network engineers, and platform operators managing enterprise Proxmox deployments. Each guide covers tested configurations specific to the lab's hybrid architecture with considerations for high-availability networking, secure boot implementation, and enterprise storage optimization supporting DESI data analysis and ML workloads.

---

## **📂 Directory Contents**

This section provides navigation to all Proxmox administration guides and procedures.

### **📋 Core Infrastructure Configuration**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[setup-predictable-network-names.md](setup-predictable-network-names.md)** | Configure systemd predictable network interface naming | Enterprise network consistency and automation |
| **[setup-boot-partition-larger-nvme.md](setup-boot-partition-larger-nvme.md)** | Create boot partitions on large NVMe drives with separate workload volumes | Enterprise storage architecture and workload isolation |
| **[setup-lacp-bond.md](setup-lacp-bond.md)** | Configure LACP bonding for high-availability networking | Enterprise network redundancy and bandwidth aggregation |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[proxmox-cluster-maintenance.md](proxmox-cluster-maintenance.md)** | Cluster maintenance and upgrade procedures | Infrastructure engineers |
| **[vm-template-management.md](vm-template-management.md)** | Enterprise VM template creation and management | Platform administrators |
| **[storage-pool-optimization.md](storage-pool-optimization.md)** | NVMe storage pool configuration and optimization | Storage administrators |

---

## **🏗️ Repository Structure**

```markdown
wiki/proxmox/
├── README.md                                    # This overview document
├── setup-predictable-network-names.md          # Systemd network naming configuration
├── setup-boot-partition-larger-nvme.md         # Enterprise boot partition setup
├── setup-lacp-bond.md                          # LACP bonding configuration
├── proxmox-cluster-maintenance.md              # Cluster maintenance procedures
├── vm-template-management.md                   # VM template management
└── storage-pool-optimization.md                # Storage optimization procedures
```

---

## **🔧 Lab Proxmox Configuration**

The Proxmox deployment provides enterprise-grade virtualization across the 7-node hybrid cluster:

### **Cluster Architecture**

| **Component** | **Specification** | **Purpose** |
|---------------|------------------|-------------|
| **Proxmox VE Version** | 8.4.5 (pve-manager/8.4.5/57892e8e6cb35b) | Enterprise virtualization platform |
| **Cluster Nodes** | 7 nodes (~140 cores, ~1TB RAM, 13+ TB storage) | Distributed compute and storage resources |
| **Boot Mode** | EFI (Secure Boot enabled) | Enterprise security and UEFI standards |
| **Kernel Version** | Linux 6.8.12-12-pve | Production kernel with virtualization optimization |

### **Network Infrastructure**

| **Network Type** | **Configuration** | **Purpose** |
|------------------|------------------|-------------|
| **Management Network** | vmbr0 bridge (10.16.207.x/24) | Proxmox management and administration |
| **Data Network** | vmbr1 bridge with VLAN segmentation | VM workload communication and isolation |
| **LACP Bonding** | bond0 (spf0+spf1, 802.3ad) | High-availability 10G network connectivity |
| **VLAN Segmentation** | VLANs 10-60 for workload isolation | Network security and traffic management |

### **Storage Configuration**

| **Storage Type** | **Implementation** | **Purpose** |
|------------------|-------------------|-------------|
| **System Storage** | Local LVM (pve volume group, ~273GB) | Proxmox system and configuration storage |
| **Workload Storage** | Thin LVM pools (nvmethin01-04, multi-TB) | VM disk storage with thin provisioning |
| **Enterprise NVMe** | Samsung enterprise SSDs with S.M.A.R.T. monitoring | High-performance storage for research workloads |
| **ZFS Integration** | Planned for backup and snapshot capabilities | Enterprise data protection and recovery |

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Proxmox Integration** |
|--------------|------------------|------------------------|
| **[k8s/](../k8s/README.md)** | RKE2 Kubernetes orchestration | VM-based Kubernetes node hosting and management |
| **[docker/](../docker/README.md)** | Container runtime management | Docker containers within Proxmox VMs |
| **[networking/](../networking/README.md)** | Network infrastructure configuration | VLAN, bonding, and bridge management |

### **Platform Integration**

| **Category** | **Relationship** | **Proxmox Integration** |
|--------------|------------------|------------------------|
| **[security/](../../security/README.md)** | Infrastructure security hardening | Secure boot, access control, and compliance |
| **[monitoring/](../monitoring/README.md)** | Infrastructure observability | Proxmox metrics, VM monitoring, and alerting |
| **[backup/](../backup/README.md)** | Data protection and recovery | VM backup, snapshot management, and disaster recovery |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within Proxmox administration.

### **For Infrastructure Engineers**

**Network Setup:** [setup-predictable-network-names.md](setup-predictable-network-names.md)  
**Storage Configuration:** [setup-boot-partition-larger-nvme.md](setup-boot-partition-larger-nvme.md)  
**High Availability:** [setup-lacp-bond.md](setup-lacp-bond.md)  
**Cluster Management:** [proxmox-cluster-maintenance.md](proxmox-cluster-maintenance.md)

### **For Network Engineers**

**Interface Naming:** [setup-predictable-network-names.md](setup-predictable-network-names.md)  
**LACP Configuration:** [setup-lacp-bond.md](setup-lacp-bond.md)  
**Network Troubleshooting:** [proxmox-cluster-maintenance.md](proxmox-cluster-maintenance.md)  
**VLAN Management:** [setup-lacp-bond.md](setup-lacp-bond.md)

### **For Storage Administrators**

**Boot Partitions:** [setup-boot-partition-larger-nvme.md](setup-boot-partition-larger-nvme.md)  
**Storage Optimization:** [storage-pool-optimization.md](storage-pool-optimization.md)  
**Template Management:** [vm-template-management.md](vm-template-management.md)  
**Capacity Planning:** [proxmox-cluster-maintenance.md](proxmox-cluster-maintenance.md)

### **For Platform Administrators**

**Initial Setup:** [setup-predictable-network-names.md](setup-predictable-network-names.md)  
**Enterprise Configuration:** [setup-boot-partition-larger-nvme.md](setup-boot-partition-larger-nvme.md)  
**High Availability:** [setup-lacp-bond.md](setup-lacp-bond.md)  
**Operations Management:** [proxmox-cluster-maintenance.md](proxmox-cluster-maintenance.md)

---

## **🏢 Enterprise Implementation Context**

The Proxmox infrastructure serves as the foundation for sophisticated astronomical research computing at enterprise scale.

### **Production Workload Support**

| **Workload Type** | **VM Configuration** | **Resource Allocation** |
|-------------------|---------------------|------------------------|
| **DESI Cosmic Void Analysis** | PostgreSQL VMs with optimized storage | 30GB+ database workloads with enterprise I/O |
| **ML/AI Research** | GPU-enabled VMs with distributed computing | RTX A4000 GPU passthrough for Ray clusters |
| **RKE2 Kubernetes Nodes** | Container-optimized VMs | Dynamic workload scheduling and orchestration |
| **Infrastructure Services** | Dedicated service VMs | Authentication, monitoring, and backup services |

### **Enterprise Standards Compliance**

| **Standard** | **Implementation** | **Benefit** |
|--------------|-------------------|-------------|
| **CIS Controls v8** | Security hardening and configuration management | Enterprise security baseline |
| **Secure Boot** | UEFI with TPM 2.0 and secure boot validation | Boot integrity and firmware security |
| **Network Segmentation** | VLAN isolation and role-based access | Defense in depth and workload isolation |
| **Enterprise Storage** | NVMe with S.M.A.R.T. monitoring and redundancy | High-performance, reliable data storage |

### **Scalability and Performance**

| **Metric** | **Current Capability** | **Target Enterprise Scale** |
|------------|----------------------|----------------------------|
| **Compute Density** | ~140 cores across 7 nodes | Enterprise-grade parallel processing |
| **Storage Performance** | 10G+ NVMe with thin provisioning | Sub-millisecond I/O for research workloads |
| **Network Bandwidth** | 10G LACP bonding with redundancy | High-bandwidth data movement and replication |
| **Management Scale** | Centralized cluster management | Enterprise operations and automation |

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: proxmox-ve, virtualization, enterprise-infrastructure, networking, storage, cluster-management, hybrid-architecture

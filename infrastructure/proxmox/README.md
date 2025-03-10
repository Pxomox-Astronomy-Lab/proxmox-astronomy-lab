<!-- ---
title: "Proxmox Nodes - Proxmox Astronomy Lab"
description: "Comprehensive overview of the Proxmox nodes that form the foundation of the Proxmox Astronomy Lab, including compute specifications, networking, virtualization, and performance characteristics."
author: "VintageDon"
tags: ["proxmox", "nodes", "compute", "virtualization", "infrastructure"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---
 -->

# **Proxmox Nodes - Proxmox Astronomy Lab**

## **1. Overview**

The **Proxmox Astronomy Lab** is built on a **five-node Proxmox VE cluster**, providing a balanced mix of **compute, storage, and specialized workload resources**. Each node serves a specific purpose in the overall architecture, with carefully selected hardware to ensure optimal performance, energy efficiency, and high availability.

This document provides a detailed overview of the **node architecture, hardware specifications, performance characteristics, and role-based deployments** that form the foundation of the lab's infrastructure.

---

## **2. Node Architecture Summary**

The lab's Proxmox nodes are organized into **distinct workload categories** to ensure optimal resource utilization and workload segmentation:

| **Node Type** | **Count** | **Primary Purpose** | **Hardware Profile** |
|--------------|----------|---------------------|---------------------|
| **General Compute Nodes** | 3 | Kubernetes management, control plane services, general-purpose virtualization | Small-form-factor Ryzen 5700U, 64GB RAM, NVMe storage |
| **High-Performance Node** | 1 | AI/ML workloads, GPU compute, database hosting | Desktop-class Ryzen 5950X (Eco Mode), 128GB RAM, RTX A4000 GPU |
| **Storage-Focused Node** | 1 | File shares, S3 gateway, backup services | Desktop-class Ryzen 3700X (Eco Mode), 128GB RAM, 64TB raw storage |

### **2.1 Infrastructure Capacity**

The lab's consolidated resources provide a substantial virtualization platform:

| **Resource** | **Quantity** | **Details** |
|--------------|------------|-------------|
| **CPU Cores** | 48 physical cores | 96 threads (3 × 8/16c + 1 × 16/32c + 1 × 8/16c) |
| **RAM** | 448GB total | 3 × 64GB + 2 × 128GB |
| **Local SSD Storage** | 11TB NVMe/SSD | 3 × 2TB + 1 × 4TB + 1 × 1TB |
| **HDD Storage** | 64TB raw | 8 × 8TB in RAID configurations |
| **GPU** | 1 × RTX A4000 | 16GB VRAM, 6144 CUDA cores |
| **Network Speeds** | Mixed | 1Gbps, 2.5Gbps, and 10Gbps connections |

### **2.2 Monthly Operating Costs**

Based on the Columbus, OH average electricity rate of $0.123/kWh (as of 2025):

| **Component** | **Power Consumption** | **Monthly Cost** | **Notes** |
|--------------|---------------------|-----------------|----------|
| **3 × Compute Nodes** | 25-35W each (avg) | $9.00-$12.50 | Efficient 5700U APUs |
| **High-Performance Node** | 65-85W (Eco Mode) | $7.50-$9.80 | 5950X undervolted in Eco Mode |
| **Storage Node** | 60-80W (Eco Mode) | $6.90-$9.20 | 3700X + 8 HDDs in Eco Mode |
| **Networking Equipment** | 20-25W | $2.30-$2.90 | Switches, firewall |
| **Total** | 215-295W | $25.70-$34.40 | Entire infrastructure |

Operating the lab in Eco Mode significantly reduces energy consumption with minimal performance impact, maintaining approximately 90-95% of full performance while reducing power draw by 30-40%.

---

## **3. Node Specifications**

### **3.1 Compute Nodes (node01, node02, node03)**

These three identical nodes provide the **foundation for Kubernetes management** and **general-purpose virtualization**:

| **Component** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Chassis** | Small Form Factor (SFF) | Low-footprint mini-PC design |
| **CPU** | AMD Ryzen 5700U | 8 cores/16 threads, 1.8-4.3GHz, 15W TDP |
| **RAM** | 64GB DDR4-3200 | 2x32GB SODIMM configuration |
| **Boot Storage** | 256GB SATA SSD | Crucial MX500 system drive |
| **VM Storage** | 2TB NVMe | Samsung PM893 Enterprise-grade NVMe (LVM thin pool) |
| **Networking** | 1Gbps + 2.5Gbps | Separate management & VM traffic |
| **OS** | Proxmox VE 8.0 | Latest stable release |
| **VM Capacity** | ~32 VMs per node | Based on average resource allocation |

These compute nodes are **energy-efficient** (25-35W typical load) while still providing **substantial virtualization capabilities** through the highly efficient Ryzen 5700U APUs.

### **3.2 High-Performance Node (node04)**

This node is designed for **AI/ML workloads, GPU-accelerated computing, and database hosting**:

| **Component** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Chassis** | Desktop Tower | Full-sized case with expansion slots |
| **CPU** | AMD Ryzen 5950X | 16 cores/32 threads, 3.4-4.9GHz, 65W TDP (Eco Mode) |
| **RAM** | 128GB DDR4-3600 | 4x32GB DIMM configuration |
| **Boot Storage** | 256GB SATA SSD | Crucial MX500 system drive |
| **VM Storage** | 4TB NVMe | Samsung PM893 Enterprise-grade NVMe (LVM thin pool) |
| **GPU** | NVIDIA RTX A4000 | 16GB VRAM, 6144 CUDA cores, passthrough-ready |
| **Networking** | 1Gbps + 2 × 10Gbps SFP+ | LACP-enabled high-speed connectivity |
| **OS** | Proxmox VE 8.0 | Latest stable release with GPU passthrough |
| **VM Capacity** | ~24 high-perf VMs | Or fewer GPU-accelerated workloads |

This node supports **AI/ML research**, **database hosting**, and **compute-intensive workloads** with its GPU passthrough capabilities and high core count CPU running in Eco Mode for efficiency.

### **3.3 Storage-Focused Node (node05)**

This node provides **file shares, S3 gateway, and backup capabilities** for the entire cluster:

| **Component** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Chassis** | Storage Tower | Multiple 3.5" drive bays |
| **CPU** | AMD Ryzen 3700X | 8 cores/16 threads, 3.6-4.4GHz, 65W TDP (Eco Mode) |
| **RAM** | 128GB DDR4-3200 | 4x32GB DIMM configuration |
| **Boot Storage** | 256GB SATA SSD | Crucial MX500 system drive |
| **Cache Storage** | 1TB NVMe | Samsung PM893 Enterprise for cache |
| **HDD Storage** | 8 × 8TB HDDs | RAID configuration |
| **Networking** | 1Gbps + 2 × 10Gbps SFP+ | LACP-enabled high-speed storage connectivity |
| **OS** | Proxmox VE 8.0 | Latest stable release |
| **Storage Capacity** | ~48TB usable | With fault tolerance and redundancy |

This node runs **Windows and Linux file services**, **S3 gateway for object storage**, and **MongoDB for unstructured data storage**.

---

## **4. Networking Configuration**

### **4.1 Network Segmentation**

Each node utilizes **multiple network interfaces** to separate different traffic types:

| **Network Type** | **Speed** | **Purpose** |
|-----------------|----------|------------|
| **1Gbps** | Proxmox cluster traffic, node management |
| **2.5Gbps** | Production VM networks, storage access (Nodes 1-3) |
| **10Gbps** | High-speed storage traffic, VM migration (Nodes 4-5) |

### **4.2 VLAN Configuration**

All nodes implement **VLAN tagging** for logical network separation:

| **VLAN ID** | **Purpose** | **Subnet** | **Nodes** |
|------------|------------|------------|----------|
| **VLAN5** | Management | 10.25.5.0/24 | All |
| **VLAN10** | Control Plane | 10.25.10.0/24 | All |
| **VLAN20** | Production | 10.25.20.0/24 | All |
| **VLAN30** | Development | 10.25.30.0/24 | All |
| **VLAN40** | Provisioning | 10.25.40.0/24 | All |
| **VLAN50** | Migration | 10.25.50.0/24 | All |
| **VLAN60** | Cluster Traffic | 10.25.60.0/24 | All |

---

## **5. Storage Architecture**

### **5.1 Local Storage**

Each node provides **local storage for VM deployment** using LVM thin provisioning:

| **Node** | **Storage Type** | **Configuration** | **Usable Capacity** | **Purpose** |
|----------|----------------|-------------------|---------------------|------------|
| **node01-03** | NVMe (local-lvm) | LVM thin-provisioned | 2TB each | General VM storage |
| **node04** | NVMe (local-lvm) | LVM thin-provisioned | 4TB | High-performance VM storage |
| **node05** | NVMe + HDD | LVM thin-provisioned | 1TB SSD + 48TB HDD | Storage services |

### **5.2 Shared Storage**

The lab implements a non-hyperconverged approach to storage with several shared options:

| **Storage Name** | **Type** | **Hosted On** | **Capacity** | **Purpose** |
|-----------------|---------|--------------|-------------|------------|
| **SMB/CIFS Shares** | Windows File Shares | VM on node05 | 20TB | VM data, file services |
| **S3 Gateway** | Object Storage | VM on node05 | 15TB | Backups, research data |
| **MongoDB** | Unstructured Storage | VM on node04 | 2TB | Document storage, metadata |

---

## **6. Performance Characteristics**

### **6.1 Compute Performance**

| **Node Type** | **Single-Thread Score** | **Multi-Thread Score** | **VM Density** | **Use Case** |
|--------------|------------------------|------------------------|----------------|------------|
| **node01-03** | 2850 (PassMark) | 15400 (PassMark) | ~32 VMs | General workloads |
| **node04** | 3475 (PassMark) | 45320 (PassMark) | ~24 VMs | High-performance workloads |
| **node05** | 3350 (PassMark) | 24800 (PassMark) | ~16 VMs | Storage-focused services |

### **6.2 Storage Performance**

| **Storage Type** | **Read IOPS** | **Write IOPS** | **Read Throughput** | **Write Throughput** | **Latency** |
|-----------------|--------------|---------------|---------------------|---------------------|------------|
| **Local NVMe (LVM)** | ~250,000 | ~200,000 | ~2.5GB/s | ~2.0GB/s | <0.5ms |
| **SMB/CIFS over 10GbE** | ~65,000 | ~45,000 | ~900MB/s | ~700MB/s | ~3-4ms |
| **S3 Gateway over 10GbE** | ~50,000 | ~35,000 | ~700MB/s | ~500MB/s | ~5-7ms |
| **MongoDB over 10GbE** | ~80,000 | ~40,000 | ~800MB/s | ~600MB/s | ~2-3ms |

---

## **7. VM Resource Distribution**

The lab implements a **structured approach to VM placement**, ensuring optimal resource utilization and performance:

### **7.1 Resource Allocation by Node**

| **Node** | **VMs Assigned** | **vCPU Used** | **RAM Used** | **VM Types** |
|---------|-----------------|--------------|--------------|-------------|
| **node01** | proj-k8sm01, proj-k8sw01, dc01, lab-soc1 | 16/16 | 58GB/64GB | Control plane, security services |
| **node02** | proj-k8sm02, proj-k8sw02, lab-dns01, lab-mon01, lab-ansible01, lab-apps01 | 18/16 | 66GB/64GB | Monitoring, automation services |
| **node03** | proj-k8sm03, proj-k8sw03, lab-db01, dc02, proj-dns01 | 16/16 | 64GB/64GB | Infrastructure services |
| **node04** | proj-k8sw04, proj-pg01, proj-pggis01, proj-pgts01, proj-rds01, proj-apps01, proj-fs01, lab-port01 | 28/32 | 86GB/128GB | Databases, file services, GPU workloads |
| **node05** | proj-k8sw05, proj-kasm01 | 14/16 | 56GB/128GB | Storage services, backup servers |

---

## **8. Management & Monitoring**

All Proxmox nodes are managed through a **comprehensive monitoring and management stack**:

| **Component** | **Purpose** | **Implementation** |
|--------------|------------|---------------------|
| **Proxmox Cluster Manager** | Node & VM administration | Web UI + REST API |
| **Prometheus** | Performance metrics collection | VM on lab-mon01 |
| **Grafana** | Visualization & dashboards | VM on lab-mon01 |
| **Wazuh** | Security monitoring | VM on lab-soc1 |
| **Ansible** | Configuration management | VM on lab-ansible01 |
| **Azure Arc** | Cloud-integrated management | Connected to all nodes |

---

## **9. Backup & Disaster Recovery**

The lab implements a **comprehensive backup strategy** for all Proxmox nodes:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|----------------|------------|--------------|---------------------|
| **Proxmox Backups** | Daily | 7 daily, 4 weekly, 3 monthly | Storage node |
| **Configuration Backups** | Daily | 30 days | Storage node + offsite |
| **Offsite Backups** | Weekly | 12 weeks | Wasabi S3 |
| **Bare-Metal Recovery** | N/A | Recovery media updated quarterly | Secure storage |

---

## **10. Compliance & Security**

All Proxmox nodes adhere to **strict security standards**:

| **Standard** | **Implementation** | **Verification** |
|--------------|-------------------|------------------|
| **CIS Benchmark** | Proxmox hardening | Automated scanning |
| **Network Security** | VLAN isolation, firewall | Traffic monitoring |
| **Access Control** | Role-based access | Audit logging |
| **Patch Management** | Automated updates | Compliance reporting |

---

## **11. Future Expansion**

The Proxmox cluster is designed for **scalable expansion**:

| **Expansion Area** | **Plan** | **Timeline** |
|-------------------|---------|--------------|
| **Additional Compute** | Add 2 more compute nodes | Q3 2025 |
| **Storage Expansion** | Increase storage capacity by 32TB | Q4 2025 |
| **GPU Capabilities** | Add second GPU to node04 | Q2 2025 |
| **Network Upgrade** | Upgrade all links to 10GbE | Q3 2025 |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial documentation | VintageDon |


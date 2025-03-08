# **Proxmox Astronomy Lab Infrastructure Overview**

## **📌 Overview**

The **Proxmox Astronomy Lab** infrastructure is a high-performance, scalable environment designed to support **Hydrogen Line Radio Astronomy, AI-driven SDR signal processing, and secure IT automation**. The infrastructure follows best practices in networking, compute, and storage to ensure efficiency, reproducibility, and optimal performance.

This document serves as the **top-level overview** of the lab's **physical hardware, networking, and storage architecture**. For detailed VM inventory, networking configurations, and other aspects, refer to the linked subpages.

---

## **🌐 Network Infrastructure**

The lab utilizes a **redundant, high-speed network** built for both **compute workloads and storage performance**.

### 🔹 **Core Network Topology**

- **Switching Backbone**: Dual-switch architecture with **LACP links** for redundancy and performance.
- **Primary Network Types**:
  - **1Gbps**: Management & general traffic.
  - **2.5Gbps**: Shared storage, VM migration, failover cluster.
  - **10Gbps (LACP)**: High-speed storage and AI workloads.
- **Segmentation**: VLAN-based separation for management, storage, and compute.
- **Border Firewall**: Fortigate 40F with **strict SNAT-only configuration**, meaning **no inbound open ports** and full traffic isolation within the lab network.
- **Switch Interconnect**: **Dual 10G LACP** for redundancy and high-speed data transfer.
- **Enterprise Features**: The switches have **near-enterprise-grade features**, including **VLANs, ACLs, storm control, and other managed switch functionalities**, ensuring **CISv8 compliance**.

### 🔹 **Switch Configuration**

| Switch Name  | Model  | Ports |
|-------------|-----------------|----------------------|
| **labswitch01** | Mokerlink 2G16210GSM | 16 × 2.5G RJ45, 2 × 10G SFP |
| **labswitch02** | Sodola SL-SWTG3C12F | 12 × 10G SFP + 1 × RJ45 Console Port |

### 🔹 **Network Connectivity**

| Node    | Connection Type | Purpose |
|---------|----------------|---------|
| **Nodes 1-3** | **1 × 1Gbps + 1 × 2.5Gbps** | Compute & VM migration |
| **Node04** | **1 × 1Gbps + 2 × 10G SFP (LACP)** | AI workloads & storage |
| **Node05** | **1Gbps + 2 × 10G SFP (LACP)** | High-speed storage |

📌 **For VLAN assignments and subnet details, see** [Networking Documentation](../networking.md).

---

## **🖥 Compute Infrastructure**

The compute cluster consists of multiple nodes optimized for different workloads.

### 🔹 **Mini PC Nodes (Nodes 1-3) – General Compute Backbone**

These nodes provide **general-purpose compute power**, handling **lightweight workloads, Kubernetes control plane, and containerized applications**. Their **dedicated NVMe storage** ensures **fast operations** without network bottlenecks.

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 5700U |
| **RAM** | 64GB DDR4 |
| **Storage** | 2TB NVMe (Samsung PM893 Enterprise) |
| **Networking** | 1Gbps + 2.5Gbps |

### 🔹 **High-Performance Node (Node04) – AI/ML & Database Workloads**

Node04 is optimized for **high-performance computing and AI/ML workloads**. It serves as the primary **database host**, ensuring **fast transaction processing on NVMe storage**. The **NVIDIA RTX A4000 GPU** is **exposed to the Kubernetes cluster** for **GPU-accelerated workloads**.

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 5950X |
| **RAM** | 128GB DDR4 |
| **Storage** | 4TB NVMe |
| **GPU** | NVIDIA RTX A4000 (16GB VRAM) |
| **Networking** | 1Gbps + 2 × 10G SFP (LACP) |

### 🔹 **Storage-Dedicated Node (Node05) – High-Speed ZFS Storage**

Node05 is dedicated to **storage workloads**, providing a **high-performance ZFS-backed storage system**. It **hosts only storage VMs**, allowing its **CPU and RAM to be optimized for ZFS ARC caching and SLOG acceleration**.

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 3700X |
| **RAM** | 64GB DDR4 |
| **Storage** | 8 × 8TB HDDs (ZFS RAID10) + NVMe SLOG |
| **Networking** | 1Gbps + 2 × 10G SFP (LACP) |

📌 **For VM inventory, see** [Virtual Machine Inventory](../virtual-machine-infrastructure-list.md).

---

## **💾 Storage Architecture**

### 🔹 **ZFS Storage Configuration (Node05)**

- **ZFS RAID10** for high performance and redundancy.
- **NVMe SLOG drive** for optimized write caching.
- **Dedicated RAM allocation for ZFS ARC** to enhance read speeds.
- **Workload separation**:
  - `fs01`: Windows Server 2025 for **Active Directory SMB shares**.
  - `fs02`: OpenMediaVault for **NFS & S3 storage to Kubernetes**.

### 🔹 **Performance Considerations**

✅ **All compute nodes use local NVMe storage for VMs**.
✅ **Network storage (NFS & S3) supports scalable container workloads**.
✅ **10Gbps storage networking prevents bottlenecks**.

📌 **For more details, see** [Storage Documentation](../storage.md).

---

## **🔎 Summary**

✅ **Nodes 1-3** handle **general compute workloads** with **local NVMe storage**.
✅ **Node04** is optimized for **AI/ML, databases, and GPU-accelerated workloads**.
✅ **Node05** is a **dedicated storage node**, ensuring **ZFS efficiency with RAM and SLOG tuning**.
✅ **Dual-switch architecture ensures high-speed connectivity**.
✅ **Network and storage workloads are properly segmented to optimize performance**.

---

### 📌 **Related Documentation**

- 📜 **[Virtual Machine Inventory](../virtual-machine-infrastructure-list.md)**
- 🌐 **[Networking Configuration](../networking.md)**
- 💾 **[Storage Details](../storage.md)**
- 🚀 **[Kubernetes Infrastructure](../k8s-rancher-rke2-setup.md)**

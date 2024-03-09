---
title: "Proxmox Astronomy Lab Infrastructure Overview"
description: "A detailed overview of the Proxmox Astronomy Lab's network, compute, and storage architecture, ensuring clarity, scalability, and reliability."
author: "VintageDon"
tags: ["Proxmox", "Network", "Compute", "Storage", "Infrastructure"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-02"
---

# **ðŸš€ Proxmox Astronomy Lab Infrastructure Overview**

## **1. Introduction**

This article provides a structured overview of the **Proxmox Astronomy Lab Infrastructure**, detailing its **network, compute, and storage architecture**. The infrastructure is designed for **high-performance, AI-enhanced research** in **Hydrogen Line Radio Astronomy**, **SDR signal processing**, and **IT automation**.

The hardware used is **commercial/prosumer**, but all **storage and add-on cards** are **enterprise-grade**, ensuring long-term reliability. Enterprise **NVMe drives**, even at 90%-100% life, provide superior endurance compared to consumer-grade drives, which would **not sustain the intended workloads**.

---

## **2. Scope**

| **Category**     | **Description** |
|-----------------|----------------|
| **In-Scope**    | Network architecture, compute nodes, storage infrastructure. |
| **Out-of-Scope** | Detailed software stack, AI/ML processing pipelines. |
| **Compliance Mapping** | CISv8, NIST 800-53, ISO 27001. |

---

## **3. Network Infrastructure**

A **high-performance, segmented network** ensures **fast, scalable connectivity** between compute and storage nodes. The **managed switches** provide **VLANs, Link Aggregation (LAG), Jumbo Frames, Port Security, and L3 Routing**.

### **3.1 Switches**

| Switch Name     | Model                   | Ports |
|----------------|------------------------|----------------------|
| **labswitch01** | Mokerlink 2G16210GSM   | 16 Ã— 2.5G RJ45, 2 Ã— 10G SFP |
| **labswitch02** | Sodola SL-SWTG3C12F    | 12 Ã— 10G SFP + 1 Ã— RJ45 Console |

âœ… **Interconnect:** **labswitch01 and labswitch02** are linked via **2 Ã— 10G SFP** patch cables in a **LAG group**.  
âœ… **10G links** handle **shared storage, VM migration, and failover cluster traffic**.

---

### **3.2 Fortigate Firewall & Network Segmentation**

- **Fortigate 40F** acts as the **primary firewall**.
- **Labswitch01 is connected to the Fortigate** for **SNAT outbound access only** (e.g., updates) â€“ **no external DNAT**.
- **External access is strictly limited** to **Entra Private Access** (zero open ports).
- **Outbound traffic is filtered** using **Technitium DNS blocklists**.
- **All cluster, storage, and VM traffic** remains **on switch**, ensuring full **segmentation and security**.

---

### **3.3 VLAN Structure**

| VLAN | Subnet          | Purpose |
|------|---------------|------------------------------|
| **10**  | 10.25.10.0/24 | Control Plane |
| **20**  | 10.25.20.0/24 | Primary Workload Traffic |
| **30**  | 10.25.30.0/24 | Future Expansion |
| **40**  | 10.25.40.0/24 | Provisioning / Onboarding |
| **50**  | 10.25.50.0/24 | Migration Traffic |
| **60**  | 10.25.60.0/24 | Backup Traffic |

âœ… **Each VLAN is isolated to prevent bottlenecks and ensure workload segmentation.**

---

### **3.4 Network Connectivity**

| Node      | Connection Type    | Purpose |
|-----------|------------------|---------|
| **Nodes 1-3** | **1 Ã— 1Gbps** | Management, Cluster Traffic |
| **Nodes 1-3** | **1 Ã— 2.5Gbps** | Shared Storage, VM Migration, Failover |
| **Node04** | **1 Ã— 1Gbps** | Management, Cluster Traffic |
| **Node04** | **2 Ã— 10G SFP (LACP)** | High-Speed Workloads |
| **Node05** | **1 Ã— 1Gbps** | Management, Cluster Traffic |
| **Node05** | **2 Ã— 10G SFP (LACP)** | High-Speed Storage Access |

---

## **4. Compute Infrastructure**

The **compute nodes** are optimized for **AI/ML, storage, and general compute workloads**.

### **4.1 Mini PC Nodes (Nodes 1-3)**

ðŸ’¡ **General Compute â€“ Handles day-to-day workloads.**

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 5700U |
| **RAM** | 64GB DDR4 |
| **Boot Drive** | 256GB SATA SSD (Crucial MX500) |
| **VM Storage** | 2TB NVMe (Samsung PM893 Enterprise) |
| **Networking** | 1Gbps (Management) + 2.5Gbps (Storage, VM traffic, Failover) |

---

### **4.2 High-Performance Compute Node (Node04)**

ðŸ’¡ **AI/ML Workloads & High-Performance Services â€“ Runs PostgreSQL, RDS, and intensive compute workloads.**

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 5950X |
| **RAM** | 128GB DDR4 |
| **Boot Drive** | 256GB SATA SSD (Crucial MX500) |
| **VM Storage** | 4TB NVMe (Samsung PM893 Enterprise) |
| **GPU** | NVIDIA RTX A4000 (16GB VRAM) |
| **Networking** | 1Gbps (Management) + 2 Ã— 10G SFP (LACP) |

---

### **4.3 Storage & Backup Node (Node05)**

ðŸ’¡ **Storage & Backup â€“ Primarily serves storage (fs01, fs02, backup server).**

| Component | Specification |
|-----------|--------------|
| **CPU** | AMD Ryzen 3700X |
| **RAM** | 128GB DDR4 |
| **Boot Drive** | 256GB SATA SSD (Crucial MX500) |
| **Cache Drives** | 2 Ã— 4TB NVMe (Samsung PM893 Enterprise) |
| **Main Storage** | 8 Ã— 8TB HDDs in ZFS mirrored vdev setup |
| **SLOG** | Enterprise NVMe for ZFS write cache |
| **Networking** | 1Gbps (Management) + 2 Ã— 10G SFP (LACP) |

---

## **5. Summary**

âœ… **Nodes 1-3** handle standard workloads with **efficient local NVMe storage**.  
âœ… **Node04** is optimized for **AI/ML and high-performance tasks**, with **dual 10G connectivity**.  
âœ… **Node05** acts as **the storage backbone**, ensuring **fast storage-to-cluster access**.  
âœ… **Backup01 (Proxmox Backup Server VM)** handles **snapshot retention and disaster recovery**.  
âœ… **Golden Template VMs** (9000 series) exist on **Node05**, with plans for **NFS-based deployment**.  
âœ… **All network traffic is segmented** to prevent bottlenecks and enhance security.  
âœ… **Scalability is built-in**, with support for **additional high-speed networking and future expansions**.

This infrastructure ensures **full clarity on the Proxmox Astronomy Lab Infrastructure**, providing a **secure, high-performance research environment** for **scientific computing and AI-powered radio astronomy**. ðŸš€

---

## **6. Documentation & Revision Control**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-02 | Initial KB version | VintageDon |



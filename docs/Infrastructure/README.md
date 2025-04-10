<!-- 
---
title: "Infrastructure Overview"
description: "Comprehensive documentation for the physical and virtual infrastructure components of the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["infrastructure", "proxmox", "networking", "hardware", "virtualization", "storage"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🏗️ **Infrastructure**

# 🔍 **1. Overview**

The infrastructure components form the foundation of the Proxmox Astronomy Lab, providing the compute, networking, storage, and physical resources necessary for both research operations and IT services. This section documents our purpose-built hybrid environment that balances high-performance computing needs with secure, structured IT operations.

Our infrastructure implementation follows enterprise design principles while accommodating the constraints of a small-form-factor lab environment, emphasizing modularity, security, and performance optimization for scientific workloads and radio astronomy applications.

---

# 💻 **2. Compute Resources**

## **2.1 Proxmox Virtualization**

The lab is built on a five-node Proxmox VE cluster that provides the virtualization layer for all services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Node01-03** | SFF Ryzen nodes (5700U, 64GB RAM) | [Node01](/infrastructure/proxmox/README.md) |
| **Node04** | GPU compute node (5950X, 128GB RAM, RTX A4000) | [Node04](/infrastructure/proxmox/README.md) |
| **Node05** | Storage-focused node (3700X, 128GB RAM, ZFS) | [Node05](/infrastructure/proxmox/README.md) |

## **2.2 Kubernetes Environment**

Our RKE2 Kubernetes cluster provides container orchestration for research workloads.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **K8s Management Nodes** | Control plane (3 nodes) | [Management Nodes](/infrastructure/kubernetes/README.md) |
| **K8s Worker Nodes** | Compute resources (5 nodes) | [Worker Nodes](/infrastructure/kubernetes/README.md) |
| **Storage Integration** | PVs and persistent storage | [K8s Storage](/infrastructure/kubernetes/README.md) |

---

# 🔌 **3. Networking**

## **3.1 Physical Network**

The physical network provides segmentation and security for all lab resources.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Edge Firewall** | FortiGate 40F security appliance | [FW1](/infrastructure/networking/fw1-fortigate40f-edge-firewall.md) |
| **Primary Switch** | Mokerlink 2G16210GSM (10G uplinks) | [Switch01](/infrastructure/networking/labswitch01-mokerlink-2g16210gsm.md) |
| **Secondary Switch** | Sodola SL-swtg3c12f (fiber uplinks) | [Switch02](/infrastructure/networking/labswitch02-sodola-SL-swtg3c12f.md) |

## **3.2 VLAN Segmentation**

Logical network separation provides security boundaries between different lab functions.

| **VLAN** | **Purpose** | **Documentation** |
|---------|------------|-------------------|
| **VLAN10** | Infrastructure and management | [Network Segregation](/infrastructure/networking/README.md) |
| **VLAN20** | Research and scientific workloads | [Network Segregation](/infrastructure/networking/README.md) |
| **VLAN30** | Storage network | [Network Segregation](/infrastructure/networking/README.md) |

---

# 📡 **4. Observatory Hardware**

## **4.1 Radio Astronomy Equipment**

The physical hardware used for astronomical observations forms the scientific core of the lab.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Hydrogen Line Feed** | 1.42 GHz reception chain | [H-Line Feed](/infrastructure/observatory-hardware/hydrogen-line-feed-chain.md) |
| **SDR Receivers** | Signal digitization hardware | [SDR Hardware](/infrastructure/observatory-hardware/components-specifications.md) |
| **Antenna Systems** | Signal collection apparatus | [Antenna Systems](/infrastructure/observatory-hardware/README.md) |

## **4.2 Edge Processing**

Hardware dedicated to initial signal processing before integration with the main infrastructure.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Edge Node** | Signal preprocessing | [Edge Processing](/infrastructure/observatory-hardware/components-specifications.md) |
| **GPSDO** | Precision timing for Doppler analysis | [Timing Systems](/infrastructure/observatory-hardware/components-specifications.md) |

---

# 🖥️ **5. Control Plane**

## **5.1 Identity & Management**

Core services that provide authentication, authorization, and management for the environment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Domain Controllers** | Windows Server 2025 AD | [DC01/DC02](/infrastructure/control-plane/README.md) |
| **DNS Filtering** | Secure DNS resolution | [DNS01/DNS02](/infrastructure/control-plane/README.md) |
| **Automation** | Ansible orchestration | [Ansible01](/infrastructure/control-plane/lab-ansible01-automation-master.md) |

## **5.2 Monitoring & Security**

Services that provide observability and security enforcement.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Monitoring Stack** | Prometheus, Grafana, Loki | [MON01](/infrastructure/control-plane/lab-mon01-prometheus-monitoring-logging-stack.md) |
| **Security** | Wazuh SIEM/XDR | [SOC01](/infrastructure/control-plane/lab-soc01-wazuh-seim-xdr.md) |
| **Container Management** | Portainer orchestration | [PORT01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |

---

# 💾 **6. Storage Architecture**

## **6.1 Primary Storage**

High-performance storage for active workloads and databases.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **NVMe Storage** | Local high-speed storage | [Storage Architecture](/infrastructure/storage/README.md) |
| **S3-Compatible** | Object storage for research data | [Object Storage](/infrastructure/storage/README.md) |
| **ZFS Pools** | Data protection and integrity | [ZFS Storage](/infrastructure/storage/README.md) |

## **6.2 Backup Systems**

Protection for critical data and services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox Backup Server** | VM and container backups | [PBS Configuration](/infrastructure/storage/README.md) |
| **Azure Blob Integration** | Offsite backup storage | [Cloud Backup](/infrastructure/storage/README.md) |

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **control-plane** | Core service VMs and infrastructure | [Control Plane](/infrastructure/control-plane/README.md) |
| **kubernetes** | K8s cluster documentation | [Kubernetes](/infrastructure/kubernetes/README.md) |
| **networking** | Network topology and configuration | [Networking](/infrastructure/networking/README.md) |
| **observatory-hardware** | Radio astronomy equipment | [Observatory Hardware](/infrastructure/observatory-hardware/README.md) |
| **projects** | Project-specific infrastructure | [Projects](/infrastructure/projects/README.md) |
| **proxmox** | Hypervisor configuration | [Proxmox](/infrastructure/proxmox/README.md) |
| **storage** | Storage architecture | [Storage](/infrastructure/storage/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Hardware Overview** | Physical infrastructure summary | [Hardware Overview](/infrastructure/proxmox-astronomy-lab-hardware-overview.md) |
| **H-Line Feed Chain** | Radio astronomy signal chain | [H-Line Documentation](/infrastructure/observatory-hardware/hydrogen-line-feed-chain.md) |
| **VM Infrastructure List** | Complete VM inventory | [VM Infrastructure List](/virtual-machine-infrastructure-list.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Entra Hybrid Cloud** | Identity and cloud integration | [Entra Documentation](/entra-hybrid-cloud/README.md) |
| **Monitoring** | Infrastructure observability | [Monitoring](/monitoring/README.md) |
| **Lab Services** | Application services | [Lab Services](/lab-services/README.md) |
| **ITIL Processes** | Operational procedures | [ITIL Documentation](/itil/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
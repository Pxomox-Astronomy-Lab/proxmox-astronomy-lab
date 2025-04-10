<!-- 
---
title: "Networking - Proxmox Astronomy Lab"
description: "Documentation of secure, high-performance network infrastructure for research workloads and observatory systems"
author: "VintageDon"
tags: ["networking", "infrastructure", "vlans", "firewall", "security", "switching"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Fortigate", "DNS Filtering", "Proxmox Network"]
implements_policies: ["Network Security Policy", "Segmentation Policy"]
phase: "phase-1"
---
-->

# 🌐 **Networking - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The networking infrastructure of the Proxmox Astronomy Lab provides secure, high-performance, and segmented connectivity for all research workloads, virtualized environments, and observatory systems. This infrastructure implements a carefully designed architecture that ensures scalability, security enforcement, and optimized traffic flow across both IT and scientific computing environments.

This section documents the comprehensive network topology, VLAN structure, security policies, and connectivity strategies that govern the lab's network operations, serving as the definitive reference for all network-related configurations and design decisions.

---

# 🔒 **2. Security & Segmentation**

## **2.1 Edge Security**

The lab's perimeter security implements comprehensive protection for all inbound and outbound traffic.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Fortigate 40F (fw1)** | Edge firewall with IPS, web filtering, and application control | [Edge Firewall Documentation](./fw1-fortigate40f-edge-firewall.md) |

## **2.2 DNS Filtering**

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **lab-dns01** | Primary DNS filtering server with security policies | [DNS01 Documentation](/infrastructure/control-plane/lab-dns01-dns-filtering.md) |
| **lab-dns02** | Secondary DNS filtering server for redundancy | [DNS02 Documentation](/infrastructure/control-plane/lab-dns02-dns-filtering.md) |

---

# 🔌 **3. Network Hardware**

## **3.1 Primary Switching Infrastructure**

The physical switching infrastructure provides the foundation for all network traffic within the lab.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **labswitch01** | MokerLink 2G16210GSM 10G/2.5G managed switch | [Primary Switch Documentation](./labswitch01-mokerlink-2g16210gsm.md) |
| **labswitch02** | Sodola SL-swtg3c12f managed switch | [Secondary Switch Documentation](./labswitch02-sodola-SL-swtg3c12f.md) |

---

# 🚦 **4. VLAN Structure**

## **4.1 VLAN Segmentation**

The lab network is structured into dedicated VLANs to ensure traffic separation, security enforcement, and optimized resource access.

| **VLAN ID** | **Segment** | **Purpose** |
|------------|------------|------------|
| **VLAN 5**  | **Management** | Proxmox, switches, firewalls, and core IT services |
| **VLAN 10** | **Control Plane** | Domain controllers, core databases, monitoring, and identity services |
| **VLAN 20** | **Production** | Research workloads, Kubernetes worker nodes, observatory data processing |
| **VLAN 30** | **Development** | Dev/test workloads requiring IP segmentation |
| **VLAN 40** | **Provisioning** | Temporary VLAN for setting up new VMs and nodes |
| **VLAN 50** | **Migration** | Dedicated Proxmox VM migration traffic |
| **VLAN 60** | **Cluster Failover** | Proxmox Corosync and HA failover communication |

---

# 🔄 **5. Remote Access**

## **5.1 Secure Remote Connectivity**

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Entra Private Access (EPA)** | Zero-trust remote access with MFA and conditional access | [EPA Documentation](/entra-hybrid-cloud/private/README.md) |

---

# 🔗 **6. Directory Contents**

This section provides direct navigation to all key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Edge Firewall** | Documentation for primary firewall | [fw1-fortigate40f-edge-firewall.md](./fw1-fortigate40f-edge-firewall.md) |
| **Primary Switch** | Documentation for labswitch01 | [labswitch01-mokerlink-2g16210gsm.md](./labswitch01-mokerlink-2g16210gsm.md) |
| **Secondary Switch** | Documentation for labswitch02 | [labswitch02-sodola-SL-swtg3c12f.md](./labswitch02-sodola-SL-swtg3c12f.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical and virtual infrastructure using this network | [Infrastructure Documentation](/infrastructure/README.md) |
| **Control Plane** | Core services relying on network segmentation | [Control Plane Documentation](/infrastructure/control-plane/README.md) |
| **Kubernetes** | Container networking integrated with VLANs | [Kubernetes Documentation](/infrastructure/kubernetes/README.md) |
| **Security & Compliance** | Network security policies and compliance | [Security Documentation](/docs/Compliance-Security/README.md) |
| **Monitoring** | Network performance monitoring | [Monitoring Documentation](/monitoring/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for networking directory | VintageDon |

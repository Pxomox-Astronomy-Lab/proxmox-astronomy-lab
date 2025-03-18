<!-- 
---
title: "Proxmox Astronomy Lab - Networking Infrastructure"
description: "Overview of the lab's networking architecture, segmentation strategy, and physical components"
author: "VintageDon"
tags: ["networking", "vlan", "firewall", "routing", "switching"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🌐 **Proxmox Astronomy Lab - Networking Infrastructure**

Our network infrastructure implements a security-focused, segmented architecture that separates control plane traffic from research workloads while providing appropriate performance characteristics for different traffic types.

## 🛡️ **1. Network Design Philosophy**

The lab's network design follows these core principles:

- **Security through segmentation** - Logical separation of traffic types
- **Defense in depth** - Layered security controls at multiple levels
- **Performance where needed** - Targeted 10G connectivity for data-intensive workloads
- **Practical implementation** - Balancing enterprise practices with lab constraints

This approach creates a secure, performance-optimized foundation for both infrastructure services and research operations.

## 🔀 **2. VLAN Architecture**

Our network uses VLAN segmentation to enforce traffic boundaries and control communication flows.

| **VLAN ID** | **Name** | **Purpose** | **IP Range** | **Default Gateway** |
|------------|---------|------------|------------|-------------------|
| **VLAN10** | Control Plane | Infrastructure management and security services | 10.25.10.0/24 | 10.25.10.1 |
| **VLAN20** | Research | Scientific workloads and applications | 10.25.20.0/24 | 10.25.20.1 |
| **VLAN30** | Storage | High-performance storage traffic | 10.25.30.0/24 | 10.25.30.1 |
| **VLAN40** | External | Edge services and external access | 10.25.40.0/24 | 10.25.40.1 |

VLANs are implemented consistently across all switches and hypervisors, with appropriate routing and firewall controls.

## 🔒 **3. Security Controls**

Network security is implemented through multiple complementary mechanisms:

### **3.1 Edge Firewall**

The [Fortigate 40F Edge Firewall](fw1-fortigate40f-edge-firewall.md) provides:

- **Stateful packet inspection** for all external traffic
- **IPS/IDS** with regular signature updates
- **Zero Trust Network Access** via Entra Private Access integration
- **Geofencing** with U.S.-only access restrictions
- **SSL inspection** for select traffic categories

### **3.2 Internal Segmentation**

- **VLAN-based ACLs** restrict cross-VLAN communication
- **Host-based firewalls** provide additional protection
- **Service-specific access controls** limit connections to authorized sources

## 🖧 **4. Physical Network Components**

Our physical network infrastructure consists of enterprise-grade components configured for reliability and performance.

| **Device** | **Model** | **Documentation** | **Primary Role** |
|-----------|----------|-------------------|-----------------|
| **fw1** | Fortigate 40F | [Details →](fw1-fortigate40f-edge-firewall.md) | Edge security, VPN, IPS |
| **labswitch01** | Mokerlink 2G16210GSM | [Details →](labswitch01-mokerlink-2g16210gsm.md) | Primary switch with 10G uplinks |
| **labswitch02** | Sodola SL-swtg3c12f | [Details →](labswitch02-sodola-SL-swtg3c12f.md) | Secondary switch, 10G inter-rack |

## 🔄 **5. Connectivity Architecture**

### **5.1 External Connectivity**

- **Primary Internet**: Fiber connection (1Gbps symmetric)
- **Backup Internet**: LTE failover via Fortigate 40F
- **External Access**: Exclusively through Entra Private Access (EPA)

### **5.2 Internal Architecture**

The internal network implements a modified spine-leaf topology:

![Network Topology Diagram](../assets/network-topology.png)

- **Core Layer**: Fortigate 40F providing inter-VLAN routing
- **Access Layer**: Mokerlink and Sodola switches with VLAN trunking
- **Node Connectivity**: 2.5G for general nodes, 10G for high-performance nodes

## 📡 **6. SDR Data Network**

A specialized network segment handles raw SDR data from our radio astronomy equipment:

- **Dedicated Interfaces**: Separate physical NICs for SDR data flow
- **Direct Connectivity**: Point-to-point links between SDR devices and processing nodes
- **Traffic Isolation**: SDR traffic isolated from general infrastructure traffic

For details on SDR hardware integration, see the [Observatory Hardware section](../observatory-hardware/README.md).

## 🔍 **7. Monitoring & Management**

Network monitoring utilizes multiple complementary approaches:

- **SNMP Monitoring**: All network devices report to Prometheus
- **Traffic Analysis**: NetFlow data collection and visualization
- **Performance Tracking**: Latency, bandwidth, and error monitoring
- **Configuration Backup**: Automated configuration archival

## 📝 **8. Documentation Resources**

Detailed network documentation is available for each component:

- [**Fortigate 40F Configuration**](fw1-fortigate40f-edge-firewall.md)
- [**Primary Switch Configuration**](labswitch01-mokerlink-2g16210gsm.md)
- [**Secondary Switch Configuration**](labswitch02-sodola-SL-swtg3c12f.md)
- [**VLAN Assignment Reference**](vlan-assignments.md)

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial networking README | VintageDon |
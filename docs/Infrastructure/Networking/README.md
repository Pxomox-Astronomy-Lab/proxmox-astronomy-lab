# 🌐 **Networking**

# 🔍 **1. Overview**

The networking infrastructure of the Proxmox Astronomy Lab implements a security-focused, segmented architecture that separates control plane traffic from research workloads while providing appropriate performance characteristics for different traffic types. Our design balances enterprise network principles with the practical constraints of a lab environment, creating a robust foundation that supports both infrastructure services and scientific research activities.

This section documents the network design, implementation, security controls, and physical components that comprise our networking infrastructure, providing a comprehensive reference for both operational management and architecture understanding.

---

# 🏗️ **2. Network Architecture**

## **2.1 Design Principles**

Our network architecture follows these core design principles:

| **Principle** | **Implementation Approach** | **Documentation** |
|--------------|---------------------------|-------------------|
| **Security Through Segmentation** | VLAN isolation of traffic types | [Segmentation Strategy](VLAN-Segmentation/segmentation-strategy.md) |
| **Defense in Depth** | Layered controls at multiple points | [Security Architecture](Firewalls/defense-in-depth.md) |
| **Performance Optimization** | Strategic 10G deployment | [Network Performance](performance-optimization.md) |
| **Simplified Management** | Centralized configuration | [Network Administration](network-administration.md) |

## **2.2 VLAN Segmentation**

Our network uses VLAN segmentation to enforce traffic boundaries and control communication flows.

| **VLAN ID** | **Name** | **Purpose** | **IP Range** | **Documentation** |
|------------|---------|------------|------------|-------------------|
| **VLAN10** | Control Plane | Infrastructure management | 10.25.10.0/24 | [VLAN10 Details](VLAN-Segmentation/vlan10-control-plane.md) |
| **VLAN20** | Research | Scientific workloads | 10.25.20.0/24 | [VLAN20 Details](VLAN-Segmentation/vlan20-research.md) |
| **VLAN30** | Storage | High-performance storage | 10.25.30.0/24 | [VLAN30 Details](VLAN-Segmentation/vlan30-storage.md) |
| **VLAN40** | External | Edge services | 10.25.40.0/24 | [VLAN40 Details](VLAN-Segmentation/vlan40-external.md) |

---

# 🔒 **3. Security Infrastructure**

## **3.1 Firewall Implementation**

Network security is implemented through multiple complementary mechanisms:

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Edge Firewall** | Perimeter security and VPN termination | [Fortigate 40F](Firewalls/fw1-fortigate40f-edge-firewall.md) |
| **Internal Segmentation** | Inter-VLAN access control | [Internal ACLs](Firewalls/internal-segmentation.md) |
| **Host-based Firewalls** | VM-level protection | [UFW Configuration](Firewalls/host-firewall-configuration.md) |

## **3.2 Traffic Inspection**

Deep packet inspection and traffic analysis protections:

| **Capability** | **Implementation** | **Documentation** |
|----------------|-------------------|-------------------|
| **IPS/IDS** | Signature and anomaly-based detection | [IPS Configuration](Firewalls/ips-configuration.md) |
| **SSL Inspection** | Selective decryption for sensitive traffic | [SSL Inspection](Firewalls/ssl-inspection.md) |
| **Traffic Analysis** | Flow monitoring and behavioral analysis | [Traffic Monitoring](Firewalls/traffic-analysis.md) |

---

# 🖧 **4. Physical Network Infrastructure**

## **4.1 Core Switching**

Primary switching infrastructure components:

| **Device** | **Model** | **Ports** | **Documentation** |
|-----------|----------|----------|-------------------|
| **labswitch01** | Mokerlink 2G16210GSM | 16x1G, 2x10G SFP+ | [labswitch01 Configuration](labswitch01-mokerlink-2g16210gsm.md) |
| **labswitch02** | Sodola SL-swtg3c12f | 8x2.5G, 4x10G SFP+ | [labswitch02 Configuration](labswitch02-sodola-SL-swtg3c12f.md) |

## **4.2 Edge Connectivity**

External connectivity components:

| **Device** | **Model** | **Function** | **Documentation** |
|-----------|----------|-------------|-------------------|
| **fw1** | Fortigate 40F | Edge security, routing | [fw1 Configuration](fw1-fortigate40f-edge-firewall.md) |
| **ISP Modem** | Fiber ONT | WAN connectivity | [WAN Configuration](wan-connectivity.md) |

---

# 📡 **5. Specialized Networks**

## **5.1 SDR Data Network**

Specialized network for radio astronomy data:

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **SDR Data VLAN** | Isolated SDR traffic flow | [SDR Network](sdr-data-network.md) |
| **Feed Processing** | Hydrogen Line data acquisition | [Feed Network](feed-processing-network.md) |

## **5.2 High-Performance Compute Network**

Dedicated network for compute-intensive workflows:

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **10G Backbone** | High-speed node interconnect | [10G Network](high-performance-networking.md) |
| **Node04-05 Connectivity** | Direct GPU-to-storage path | [Direct Connect](node-direct-connectivity.md) |

---

# 🔧 **6. Management & Configuration**

## **6.1 Network Services**

Core network services supporting the infrastructure:

| **Service** | **Implementation** | **Documentation** |
|------------|-------------------|-------------------|
| **DNS** | Redundant internal DNS servers | [DNS Configuration](DNS/dns-architecture.md) |
| **DHCP** | Centralized IP management | [DHCP Configuration](dhcp-configuration.md) |
| **NTP** | Time synchronization | [NTP Services](ntp-configuration.md) |

## **6.2 Network Monitoring**

Tools and approaches for network visibility:

| **Monitoring Tool** | **Purpose** | **Dashboard** |
|--------------------|------------|--------------|
| **Prometheus SNMP** | Device metrics collection | [SNMP Dashboard](../monitoring/network-monitoring-dashboard.md) |
| **NetFlow Analysis** | Traffic pattern analysis | [NetFlow Dashboard](../monitoring/netflow-analysis-dashboard.md) |
| **Interface Statistics** | Bandwidth and error tracking | [Interface Dashboard](../monitoring/interface-statistics-dashboard.md) |

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **DNS** | DNS server configuration and management | [DNS README](DNS/README.md) |
| **Firewalls** | Firewall configurations and security controls | [Firewalls README](Firewalls/README.md) |
| **VLAN-Segmentation** | VLAN architecture and implementation | [VLAN Segmentation README](VLAN-Segmentation/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Network Diagram** | Visual representation of network topology | [Network Diagram](network-topology-diagram.md) |
| **IP Address Scheme** | IP allocation and addressing strategy | [IP Addressing](ip-addressing-scheme.md) |
| **Firewall Rule Matrix** | Documentation of inter-VLAN access controls | [Firewall Rules](firewall-rule-matrix.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Parent directory for networking | [Infrastructure README](../README.md) |
| **Compute** | Network connectivity for compute resources | [Compute README](../Compute/README.md) |
| **Storage** | Network connectivity for storage services | [Storage README](../Storage/README.md) |
| **Observatory-Hardware** | Network connectivity for scientific equipment | [Observatory Hardware README](../Observatory-Hardware/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 2.0 | 2025-04-04 | Updated to standardized format with expanded sections | VintageDon |
| 1.0 | 2025-03-16 | Initial networking README | VintageDon |

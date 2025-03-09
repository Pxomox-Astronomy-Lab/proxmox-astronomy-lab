# **Networking - Proxmox Astronomy Lab**

## **1. Purpose**

The **Networking infrastructure** of the Proxmox Astronomy Lab is designed to provide **secure, high-performance, and segmented network access** for all research workloads, virtualized environments, and observatory systems. It ensures **scalability, security enforcement, and optimized traffic flow** across the lab's IT and scientific computing environment.

This document details the **network topology, VLAN structure, security policies, and connectivity strategies** that govern the lab’s network operations.

---

## **2. Scope**

The lab’s networking infrastructure **spans multiple VLANs, segmented traffic policies, and hybrid connectivity options**. This section documents:

- **VLAN architecture and segmentation** → Logical separation of control plane, research, and observatory traffic.
- **Firewall & Security Policies** → FortiGate-based edge security with Entra ID-integrated controls.
- **Monitoring & Logging** → SNMP-based network health tracking.
- **Interconnectivity & External Access** → Secure Entra Private Access (EPA) for remote connections.

This document **does not cover** internal workload networking within Kubernetes—those details are documented in the Kubernetes section.

---

## **3. Network Topology & VLAN Segmentation**

The lab network is structured into **dedicated VLANs** to ensure traffic separation, security enforcement, and optimized resource access.

| **VLAN ID** | **Segment** | **Purpose** |
|------------|------------|------------|
| **VLAN 5**  | **Management** | Proxmox, switches, firewalls, and core IT services. |
| **VLAN 10** | **Control Plane** | Domain controllers, core databases, monitoring, and identity services. |
| **VLAN 20** | **Production** | Research workloads, Kubernetes worker nodes, observatory data processing. |
| **VLAN 30** | **Development** | Dev/test workloads requiring IP segmentation. |
| **VLAN 40** | **Provisioning** | Temporary VLAN for setting up new VMs and nodes. |
| **VLAN 50** | **Migration** | Dedicated Proxmox VM migration traffic. |
| **VLAN 60** | **Cluster Failover** | Proxmox Corosync and HA failover communication. |

This structure ensures **strong segmentation** between **research, control, and infrastructure** services while allowing **high-speed, low-latency communication where required**.

---

## **4. IT Service Management (ITIL Alignment)**

Networking operations are structured using **ITIL-lite principles** to ensure **efficient change management, security enforcement, and network reliability**.

| **ITIL Process** | **Implementation in the Lab** |
|----------------|---------------------------|
| **Change Management** | Documented changes via **GLPI tickets** and structured firewall policies. |
| **Incident Management** | **SNMP-based monitoring**, FortiGate alerts, and Grafana dashboards. |
| **Configuration Management** | Managed via **Ansible playbooks for network devices**. |
| **Access & Security Management** | **Firewall ACLs, Entra ID policies, and network-level segmentation**. |

These processes ensure that network services **remain secure, monitored, and optimized for performance**.

---

## **5. Compliance & Security**

The networking layer aligns with **CIS benchmarks and best practices for network segmentation, access control, and secure remote connectivity**.

| **Compliance Standard** | **Implementation** |
|-----------------|-----------------|
| **CIS Network Security Controls** | VLAN segmentation, firewall rules, and encrypted traffic enforcement. |
| **Entra Private Access (EPA)** | Enforced MFA and conditional access for all remote access. |
| **Edge Security (FortiGate Firewall)** | Layered security model with **IPS, web filtering, and DNS filtering**. |
| **Zero Trust Enforcement** | No implicit trust; network segmentation applied at all levels. |
| **Network Logging & Monitoring** | FortiGate, SNMP exporters, and **Grafana network dashboards**. |

These controls ensure that **only authorized devices and users** can access the network while preventing **unauthorized data flows**.

---

## **6. Connectivity & External Access**

### **6.1 Remote Access via Entra Private Access (EPA)**

- **No VPN access** → All remote access is handled via **EPA with full Entra security policies applied**.
- **Granular Role-Based Access Control (RBAC)** → Only approved users can access specific VLANs or services.
- **Multi-Factor Authentication (MFA) Enforced** → No direct RDP or SSH access; authentication gated through Entra.

### **6.2 Internet Egress & Filtering**

- **Outbound traffic controlled via FortiGate policies**.
- **DNS filtering via Technitium** to block malicious domains.
- **Logging & alerting enabled** for anomalous network activity.

This ensures a **hardened, controlled approach** to all **internal and external network traffic**.

---

## **7. Summary & Next Steps**

The **networking infrastructure** in the Proxmox Astronomy Lab is designed for **performance, security, and segmentation**, ensuring **data integrity and optimized research workflows**.

Future enhancements will include:

- **Expanded traffic analysis and anomaly detection with AI-driven insights.**
- **Further automation of VLAN configurations via Ansible & FortiGate APIs.**
- **Enhancing network observability with NetFlow analysis and deeper SNMP integration.**

📌 **Refer to individual VLAN and firewall policy documentation for detailed configurations.**

---
title: "FortiGate 40F Firewall Service Documentation"
description: "Comprehensive ITIL-aligned documentation of the FortiGate 40F firewall, including network segmentation, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "firewall", "fortigate", "security"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-08"
---

# **FortiGate 40F Firewall Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

The **FortiGate 40F (fw01)** is the **primary firewall** for the Proxmox Astronomy Lab, providing **network segmentation, traffic control, and security enforcement**. This device is **unlicensed**, meaning it operates with **basic firewall functionality** without advanced Fortinet subscription-based features. It manages **inter-VLAN routing, security monitoring, and central SNAT** for all connected devices.

This firewall enforces **strict inter-VLAN policies, limiting cross-VLAN traffic**, ensuring **controlled access to infrastructure components** such as domain controllers, monitoring systems, and security logging.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | FW-01 |
| **Service Type**   | Perimeter Security & Routing |
| **Service Category** | Network Security Infrastructure |
| **Business Criticality** | High |
| **Service Owner**  | Lab Engineer |

### **1.3 Service Hours**  

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Best-effort during business hours |
| **Maintenance Windows** | As required, change-controlled |

---

## **2. Network Infrastructure**  

### **2.1 Interface & VLAN Configuration**  

| **Interface** | **IP Address** | **Alias** | **Role** | **Parent Interface** |
|--------------|--------------|-----------|---------|----------------|
| **WAN** | DHCP | Public Internet | External | N/A |
| **LAN** | 10.16.207.1/24 | Internal Network | Core LAN | N/A |
| **VLAN5** | 10.25.100.1/24 | Management | Secure Infrastructure | LAN |
| **VLAN10** | 10.25.10.1/24 | Tier 1 - Infrastructure | Core Services | LAN |
| **VLAN20** | 10.25.20.1/24 | Tier 2 - Research | Observatory Systems | LAN |
| **VLAN30** | 10.25.30.1/24 | Kubernetes | Containerized Workloads | LAN |
| **VLAN40** | 10.25.40.1/24 | Visualization | Data Processing | LAN |
| **VLAN50** | 10.25.50.1/24 | Services | Shared Lab Services | LAN |
| **VLAN60** | 10.25.60.1/24 | Cluster-Prime | High-Performance Computing | LAN |
| **VLAN160** | 10.25.160.1/24 | Trusted Devices | Secure Personal Workstations | LAN |

### **2.2 Firewall Policies & Traffic Control**  

- **Internet Access (SNAT)**
  - All VLANs have outbound internet access policies using central SNAT.

- **Inter-VLAN Routing**
  - **Limited inter-VLAN communication** with policies restricting access between tiers.
  - **Allowed Traffic:**
    - **Don-Desktop** (10.16.207.10) has access to VLAN10, VLAN20, VLAN60.
    - **VLAN20** can access Domain Controllers (DC01, DC02) and DNS servers in VLAN10.
    - **VLAN20** can communicate with **Wazuh (lab-soc1) for agent reporting**.
    - **Monitoring & Ansible nodes in VLAN10** can access VLAN20.

- **SSL Inspection**
  - Certificate inspection applied to VLAN20, VLAN30, VLAN40, VLAN50, VLAN60 traffic.

---

## **3. Security Services**  

### **3.1 DNS Configuration**  

- **Primary DNS**: 9.9.9.9 (Quad9)
- **Secondary DNS**: 149.112.112.112 (Quad9)
- **Protocol**: Standard & DNS over HTTPS (DoH)

### **3.2 Web Filtering & Threat Protection**  

- Default **web filtering** applied to block high-risk categories.
- Antivirus scanning configured for **HTTP, FTP, IMAP, POP3, SMTP**.
- **IPS enabled** to detect critical attacks.

### **3.3 VPN Services**  

- **Site-to-Site VPN**: IPsec VPN (IKEv2, AES256-SHA256) to remote site **69.30.200.19**.
- **SSL VPN**: Enabled on port 443 (10.212.134.200-210 IP pool).

---

## **4. Administrative & Logging**  

### **4.1 Admin Access**  

- Three admin accounts: **admin, crainbramp, labadmin8192**.
- HTTPS management via custom port 4443 with a custom certificate.
- SSH access enabled for local management.

### **4.2 Logging & Monitoring**  

- **Traffic Logging** enabled for key firewall policies.
- **DDNS Configured** for **crainbramp.float-zone.com**.
- Automation triggers for:
  - Security events (compromised hosts, IPS/AV detection)
  - System events (HA failover, high CPU, reboot)
  - Administrative events (config changes)

---

## **5. Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ⏱ Pending |

---

## **6. Change Log**  

| **Version** | **Date** | **Changes** |
|------------|---------|-------------|
| 1.0 | 2025-03-08 | Initial version, defines FortiGate 40F firewall configuration and security policies |

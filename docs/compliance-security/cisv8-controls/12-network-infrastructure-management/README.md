---
title: "README - CIS Control 12: Network Infrastructure Management"
description: "An overview of CIS Control 12 and its implementation within the Proxmox Astronomy Lab, ensuring secure deployment, monitoring, and maintenance of network infrastructure."
author: "VintageDon"
tags: ["CISv8.1", "Network Security", "Zero Trust", "Infrastructure Management", "Compliance"]
category: "Compliance"
kb_type: "README"
version: "1.0"
status: "Draft"
last_updated: "2025-03-04"
---

# **📜 README - CIS Control 12: Network Infrastructure Management**

## **1. Introduction**

Securing **network infrastructure** is essential for preventing **unauthorized access, enforcing Zero Trust, and maintaining operational integrity**. **CIS Control 12** mandates a structured approach to **network device configuration, traffic control, and monitoring** to ensure **secure and compliant network operations**.

The **Proxmox Astronomy Lab** employs a **Zero Trust architecture** with structured **network segmentation, monitoring, and access controls** to ensure compliance with **CISv8, NIST 800-53, and ISO 27001**.

| **Key Network Security Features** | **Implementation** |
|----------------------------------|------------------|
| **Firmware & Configuration Management** | Monthly reviews for switches and firewalls, all changes stored in Git. |
| **Zero Trust Architecture** | No DNAT to the lab, external access restricted via Entra Private Access (EPA) & MFA. |
| **Traffic Security & Encryption** | No legacy protocols; TLS, SSH, and VPN tunnels enforced. |
| **Network Logging & Monitoring** | FortiGate, Loki, Prometheus, and Alert Manager used for traffic analysis. |
| **Internal Segmentation & Privileged Access** | Jump boxes secured with EPA, MFA, and Just-In-Time (JIT) access. |

📌 **See also:**

- [Network Infrastructure Management Policy](../cisv81-controls/cisv81-12-network-infrastructure-management-policy.md)
- [Network Infrastructure Management Policy Template](../cisv81-policy-templates/cisv81-12-network-infrastructure-management-template.md)

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All network devices, firewalls, access control mechanisms, and monitoring systems. |
| **Out-of-Scope** | Temporary lab networks and isolated test environments. |
| **Compliance Mapping** | CIS Control 12, NIST 800-53 (SC-7), ISO/IEC 27001 (A.13.1). |

---

## **3. Network Security Implementation**

### **Firmware & Configuration Management**

Regular maintenance ensures **up-to-date and secure network configurations**.

| **Security Measure** | **Implementation** |
|----------------------|----------------|
| **Firmware Reviews** | Monthly updates for all switches and firewalls. |
| **Configuration Versioning** | All network changes tracked via Git. |
| **Change Approval Process** | Major changes require IT security review before deployment. |

### **Zero Trust & Edge Security**

A secure perimeter ensures **no direct inbound access** to internal lab assets.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **No DNAT to Lab** | No direct inbound traffic allowed to lab systems. |
| **Secure External Access** | Enforced via Entra Private Access (EPA) & MFA. |
| **Legacy Services Disabled** | No Telnet, SMBv1, or other insecure protocols allowed. |

### **Traffic & Protocol Security**

Network traffic is secured through **encryption, segmentation, and monitoring**.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Secure Internal Traffic** | No unsecured services, all legacy protocols disabled. |
| **DNS Security** | DNS traffic filtered through **Technitium DNS** servers. |
| **Full Network Encryption** | TLS, SSH, and encrypted VPN tunnels enforced. |

### **Network Logging & Monitoring**

All network activity is **logged and analyzed** for anomalies and unauthorized access.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Centralized Logging** | FortiGate logs sent to Loki for analysis. |
| **Network Anomaly Detection** | Prometheus & Alert Manager monitor network events. |
| **Hybrid Active Directory Logging** | All authentication logs aggregated for review. |

### **Privileged Access Security & Jump Box Controls**

Privileged network access is **strictly controlled and monitored**.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Jump Box Access** | Only accessible via EPA, MFA, and JIT approval. |
| **Role-Based Authentication** | Enforced via Entra ID and AD security policies. |
| **Session Logging & Review** | All administrative access sessions logged and reviewed. |

### **Network Segmentation & Least Privilege Enforcement**

Strict access controls limit network exposure and **enforce least privilege**.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Firewall Segmentation** | Enforced via FortiGate policies. |
| **No Open Ports** | All unused network ports disabled at the switch level. |
| **Internal System Segmentation** | Critical systems isolated from general user networks. |

---

## **4. Compliance Evidence**

| **Control** | **Implementation Details** | **Reference Document** |
|------------|----------------------|------------------|
| **12.1** | Secure network configuration and firmware management. | [CISv8 12.1 Implementation](./12.1.md) |
| **12.2** | Zero Trust network architecture and access controls. | [CISv8 12.2 Implementation](./12.2.md) |
| **12.3** | Network traffic encryption and secure protocol enforcement. | [CISv8 12.3 Implementation](./12.3.md) |
| **12.4** | Centralized logging and network monitoring. | [CISv8 12.4 Compliance](./12.4.md) |

📌 **Each sub-control has a dedicated document outlining its enforcement and validation.**

---

## **5. Summary**

✅ **CIS Control 12 is fully implemented in the Proxmox Astronomy Lab, ensuring structured and secure network operations.**  
✅ **Zero Trust architecture, access segmentation, and encrypted network traffic provide strong protection.**  
✅ **Regular firmware updates, monitoring, and privileged access controls maintain security.**  

---

## ✅ Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |

---

## 📜 Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |

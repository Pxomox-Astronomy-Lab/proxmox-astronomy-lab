<!-- 
---
title: "CIS Control 12: Network Infrastructure Management"
description: "An overview of CIS Control 12 and its implementation within the Proxmox Astronomy Lab, ensuring secure deployment, monitoring, and maintenance of network infrastructure."
author: "VintageDon"
tags: ["CISv8.1", "Network Security", "Zero Trust", "Infrastructure Management", "Compliance"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🌐 **CIS Control 12: Network Infrastructure Management**

## 🔍 **1. Introduction**

CIS Control 12 forms a critical component of our defense-in-depth strategy, establishing a Zero Trust network architecture that protects resources through comprehensive access controls, monitoring, and secure configuration management. This control ensures that all network communications remain secure and authenticated.

Securing **network infrastructure** is essential for preventing **unauthorized access, enforcing Zero Trust, and maintaining operational integrity**. **CIS Control 12** mandates a structured approach to **network device configuration, traffic control, and monitoring** to ensure **secure and compliant network operations**.

The **Proxmox Astronomy Lab** employs a **Zero Trust architecture** with structured **network segmentation, monitoring, and access controls** to ensure compliance with **CISv8, NIST 800-53, and ISO 27001**.

The following table outlines our key network security components and their implementation:

| **Key Network Security Features** | **Implementation** |
|----------------------------------|------------------|
| **Firmware & Configuration Management** | Monthly reviews for switches and firewalls, all changes stored in Git. |
| **Zero Trust Architecture** | No DNAT to the lab, external access restricted via Entra Private Access (EPA) & MFA. |
| **Traffic Security & Encryption** | No legacy protocols; TLS, SSH, and VPN tunnels enforced. |
| **Network Logging & Monitoring** | FortiGate, Loki, Prometheus, and Alert Manager used for traffic analysis. |
| **Internal Segmentation & Privileged Access** | Jump boxes secured with EPA, MFA, and Just-In-Time (JIT) access. |

This integrated approach ensures both network visibility and strict access control throughout our environment.

📌 **See also:**

- [Network Infrastructure Management Policy](../cisv81-controls/cisv81-12-network-infrastructure-management-policy.md)
- [Network Infrastructure Management Policy Template](../cisv81-policy-templates/cisv81-12-network-infrastructure-management-template.md)

---

## 🎯 **2. Scope**

This control applies to all network infrastructure within the Proxmox Astronomy Lab environment, establishing clear boundaries for implementing security controls while acknowledging practical limitations.

The following table outlines the scope boundaries for our network infrastructure management:

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All network devices, firewalls, access control mechanisms, and monitoring systems. |
| **Out-of-Scope** | Temporary lab networks and isolated test environments. |
| **Compliance Mapping** | CIS Control 12, NIST 800-53 (SC-7), ISO/IEC 27001 (A.13.1). |

This defined scope ensures that security resources are focused on protecting systems with the highest risk exposure while maintaining compliance with applicable frameworks.

---

## 🛡️ **3. Network Security Implementation**

### **3.1 Firmware & Configuration Management**

Regular maintenance of network infrastructure is essential for both security and operational stability. Our approach ensures that all network devices remain current with security updates and properly configured.

The following table details our firmware and configuration management implementation:

| **Security Measure** | **Implementation** |
|----------------------|----------------|
| **Firmware Reviews** | Monthly updates for all switches and firewalls. |
| **Configuration Versioning** | All network changes tracked via Git. |
| **Change Approval Process** | Major changes require IT security review before deployment. |

This structured approach ensures that network devices remain protected against known vulnerabilities while maintaining a documented history of all configuration changes.

### **3.2 Zero Trust & Edge Security**

A fundamental principle of our network security is that no internal resources should be directly accessible from external networks. This Zero Trust approach significantly reduces our attack surface.

The following table outlines our edge security implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **No DNAT to Lab** | No direct inbound traffic allowed to lab systems. |
| **Secure External Access** | Enforced via Entra Private Access (EPA) & MFA. |
| **Legacy Services Disabled** | No Telnet, SMBv1, or other insecure protocols allowed. |

These measures ensure that all external access to internal resources follows secure authentication and access control processes.

### **3.3 Traffic & Protocol Security**

Beyond access controls, we ensure that all network traffic uses secure protocols and is properly protected against interception or manipulation.

The following table outlines our traffic security implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Secure Internal Traffic** | No unsecured services, all legacy protocols disabled. |
| **DNS Security** | DNS traffic filtered through **Technitium DNS** servers. |
| **Full Network Encryption** | TLS, SSH, and encrypted VPN tunnels enforced. |

These protocol security measures provide protection for data in transit across both internal and external network boundaries.

### **3.4 Network Logging & Monitoring**

Visibility into network activity is essential for detecting and responding to potential security incidents. Our monitoring strategy provides comprehensive coverage of all network traffic.

The following table outlines our network monitoring implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Centralized Logging** | FortiGate logs sent to Loki for analysis. |
| **Network Anomaly Detection** | Prometheus & Alert Manager monitor network events. |
| **Hybrid Active Directory Logging** | All authentication logs aggregated for review. |

This monitoring infrastructure ensures that security events are promptly detected and investigated, reducing the potential impact of security incidents.

### **3.5 Privileged Access Security & Jump Box Controls**

Administrative access to network infrastructure represents a critical security boundary that requires additional protection measures.

The following table outlines our approach to privileged network access:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Jump Box Access** | Only accessible via EPA, MFA, and JIT approval. |
| **Role-Based Authentication** | Enforced via Entra ID and AD security policies. |
| **Session Logging & Review** | All administrative access sessions logged and reviewed. |

These controls ensure that administrative access is strictly limited to authorized personnel and all activities are properly documented.

### **3.6 Network Segmentation & Least Privilege Enforcement**

Internal network segmentation provides additional protection by limiting the potential impact of security breaches and enforcing the principle of least privilege.

The following table outlines our network segmentation strategy:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Firewall Segmentation** | Enforced via FortiGate policies. |
| **No Open Ports** | All unused network ports disabled at the switch level. |
| **Internal System Segmentation** | Critical systems isolated from general user networks. |

This segmentation approach contains potential security incidents and prevents lateral movement across the network.

---

## 📊 **4. Compliance Evidence**

Maintaining evidence of control implementation is essential for demonstrating compliance and ensuring continued effectiveness. Our documentation provides comprehensive coverage of each sub-control's implementation.

The following table maps CIS Control 12 sub-controls to our implementation documentation:

| **Control** | **Implementation Details** | **Reference Document** |
|------------|----------------------|------------------|
| **12.1** | Secure network configuration and firmware management. | [CISv8 12.1 Implementation](./12.1.md) |
| **12.2** | Zero Trust network architecture and access controls. | [CISv8 12.2 Implementation](./12.2.md) |
| **12.3** | Network traffic encryption and secure protocol enforcement. | [CISv8 12.3 Implementation](./12.3.md) |
| **12.4** | Centralized logging and network monitoring. | [CISv8 12.4 Compliance](./12.4.md) |

This structured documentation approach ensures that all aspects of the control are properly addressed and verified through regular assessment.

---

## 📈 **5. Summary**

CIS Control 12 provides a comprehensive framework for securing our network infrastructure through multiple integrated security layers. Our implementation ensures continuous protection while maintaining operational efficiency.

Key implementation achievements:

✅ **CIS Control 12 is fully implemented in the Proxmox Astronomy Lab, ensuring structured and secure network operations.**  
✅ **Zero Trust architecture, access segmentation, and encrypted network traffic provide strong protection.**  
✅ **Regular firmware updates, monitoring, and privileged access controls maintain security.**  

This defense-in-depth approach significantly reduces the risk of unauthorized network access while maintaining detection capabilities for advanced threats.

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |
| 1.1 | 2025-03-16 | Standardized formatting | VintageDon |

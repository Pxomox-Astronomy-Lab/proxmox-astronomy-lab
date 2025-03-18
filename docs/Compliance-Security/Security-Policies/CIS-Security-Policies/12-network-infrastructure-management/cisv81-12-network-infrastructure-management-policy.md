<!-- 
---
title: "CISv8-12 Network Infrastructure Management Policy"
description: "Defines the network infrastructure management policy for the Proxmox Astronomy Lab, ensuring secure deployment, monitoring, and maintenance of network assets and traffic controls."
author: "VintageDon"
tags: ["CISv8", "Network Security", "Infrastructure Management", "Compliance", "Zero Trust"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🌐 **CISv8-12 Network Infrastructure Management Policy**

## 🔍 **1. Overview**

This policy establishes the framework for securing the Proxmox Astronomy Lab's network infrastructure through a comprehensive Zero Trust approach. By implementing structured configuration management, strict access controls, and continuous monitoring, we maintain the integrity and security of all network communications.

### **1.1 Why This Policy Matters**

Securing network infrastructure is critical for **preventing unauthorized access, maintaining operational integrity, and enforcing Zero Trust architecture** within the **Proxmox Astronomy Lab**. This policy ensures that **all network devices, configurations, and access controls** are managed securely and consistently.

### **1.2 Key Objectives**

This policy enforces **secure network management** through multiple complementary mechanisms that work together to provide defense-in-depth:

| **Objective** | **Description** |
|--------------|----------------|
| **Firmware & Configuration Management** | Monthly firmware reviews for switches and firewalls. |
| **Edge Security** | FortiGate firewall as the edge router; no DNAT to the lab. |
| **Zero Trust & Access Controls** | External access restricted via Entra Private Access (EPA) and MFA. |
| **Change Management & Versioning** | All network configuration changes are stored in Git for version control. |
| **Centralized Monitoring & Logging** | Network activity logged and analyzed using Loki, Prometheus, and Alert Manager. |
| **Traffic Security** | No insecure network services or protocols, all legacy services disabled. |
| **Internal Segmentation & Access Control** | Jump boxes secured with EPA, MFA, and Just-In-Time (JIT) access. |

This integrated approach ensures that network security is maintained through layered controls that protect against both external and internal threats.

---

## 📊 **2. Compliance Mapping**

Our network infrastructure management strategy aligns with multiple industry frameworks to ensure comprehensive coverage and best practices implementation. These mappings help demonstrate our security posture to stakeholders and ensure regulatory compliance.

The following table shows how this policy maps to established security frameworks:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 12 – Network Infrastructure Management |
| **NIST 800-53** | SC-7 – Boundary Protection |
| **ISO 27001** | A.13.1 – Network Security Controls |

By aligning with these frameworks, we ensure our network security strategy meets industry standards while providing protection appropriate to our environment.

---

## 👥 **3. Responsibilities**

Effective network security requires clear role definition and accountability across the organization. Each role has specific responsibilities that contribute to our overall security posture.

The following table outlines the primary responsibilities for implementing and maintaining our network security controls:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Infrastructure Engineers (L2/L3)** | Maintain network devices, enforce Zero Trust, and monitor traffic logs. |
| **Administrators (L1/L2-Lite)** | Apply firewall rules, manage jump box access, and enforce secure configurations. |
| **Users** | Follow network access policies and report any unauthorized access attempts. |

This clear delineation of responsibilities ensures that network security remains a priority at all levels of the organization with appropriate oversight and execution.

---

## 🛠️ **4. Policy Implementation**

### **4.1 Firmware & Configuration Management**

Regular maintenance of network device firmware and configurations is essential for security and operational stability. Our approach ensures that all devices remain current with security updates and properly configured.

The following table outlines our firmware and configuration management requirements:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Monthly Firmware Reviews** | All switches and firewalls reviewed for updates. |
| **Configuration Version Control** | All network config changes tracked via Git. |
| **Change Approval Process** | Major changes require IT review before deployment. |

This structured approach ensures that network devices remain protected against known vulnerabilities while maintaining a documented history of all configuration changes.

---

### **4.2 Edge Security & Zero Trust Network Access (ZTNA)**

A fundamental principle of our network security is that no internal resources should be directly accessible from external networks. This Zero Trust approach significantly reduces our attack surface.

The following table outlines our edge security implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **No DNAT to Lab** | No direct inbound traffic allowed to lab systems. |
| **Secure External Access** | Enforced via Entra Private Access (EPA) & MFA. |
| **Legacy Services Disabled** | No Telnet, SMBv1, or other insecure protocols allowed. |

These measures ensure that all external access to internal resources follows secure authentication and access control processes.

---

### **4.3 Traffic & Protocol Security**

Beyond access controls, we must ensure that all network traffic uses secure protocols and is properly protected against interception or manipulation.

The following table outlines our traffic security requirements:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Secure Internal Traffic** | No unsecured services, all legacy protocols disabled. |
| **DNS Security** | DNS traffic filtered through **Technitium DNS** servers. |
| **Full Network Encryption** | TLS, SSH, and encrypted VPN tunnels enforced. |

These protocol security measures provide protection for data in transit across both internal and external network boundaries.

---

### **4.4 Network Logging & Monitoring**

Visibility into network activity is essential for detecting and responding to potential security incidents. Our monitoring strategy provides comprehensive coverage of all network traffic.

The following table outlines our network monitoring approach:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Centralized Logging** | FortiGate logs sent to Loki for analysis. |
| **Network Anomaly Detection** | Prometheus & Alert Manager monitor network events. |
| **Hybrid Active Directory Logging** | All authentication logs aggregated for review. |

This monitoring infrastructure ensures that security events are promptly detected and investigated, reducing the potential impact of security incidents.

---

### **4.5 Jump Box & Privileged Access Security**

Administrative access to network infrastructure represents a critical security boundary that requires additional protection measures.

The following table outlines our approach to privileged network access:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Jump Box Access** | Only accessible via EPA, MFA, and JIT approval. |
| **Role-Based Authentication** | Enforced via Entra ID and AD security policies. |
| **Session Logging & Review** | All administrative access sessions logged and reviewed. |

These controls ensure that administrative access is strictly limited to authorized personnel and all activities are properly documented.

---

### **4.6 Network Segmentation & Least Privilege**

Internal network segmentation provides additional protection by limiting the potential impact of security breaches and enforcing the principle of least privilege.

The following table outlines our network segmentation strategy:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Firewall Segmentation** | Enforced via FortiGate policies. |
| **No Open Ports** | All unused network ports disabled at the switch level. |
| **Internal System Segmentation** | Critical systems isolated from general user networks. |

This segmentation approach contains potential security incidents and prevents lateral movement across the network.

---

## ✅ **Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |  

---

## 📜 **Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |
| 1.1 | 2025-03-16 | Standardized formatting | VintageDon |

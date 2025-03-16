---
title: "CIS Control 5: Account Management in the Proxmox Astronomy Lab"
description: "Overview of CIS Control 5, ensuring all user, system, and service accounts follow strict access control policies with auditing, automation, and enforcement via Entra Identity Governance."
author: "VintageDon"
tags: ["CISv8.1", "Account Management", "Identity Security", "Compliance", "Entra", "AD", "Azure Arc"]
category: "Compliance"
kb_type: "Reference"
version: "1.2"
status: "Draft"
last_updated: "2025-03-04"
---

# **🔐 CIS Control 5: Account Management in the Proxmox Astronomy Lab**

## **1. Introduction**

Effective **account management** is critical to preventing **unauthorized access, privilege escalation, and credential abuse**. **CIS Control 5** enforces **identity governance, least privilege, and access auditing** to ensure **all accounts are properly managed and secured**.

The **Proxmox Astronomy Lab** enforces structured **identity and access management (IAM) practices** through automation, governance, and security controls.

| **Security Measure** | **Implementation** |
|---------------------|------------------|
| **Account Auditing** | Quarterly reviews for all user, service, and system accounts. |
| **Identity Governance** | Entra Access Packages & Reviews manage role-based access. |
| **Authentication Security** | Enforced MFA, risk-based sign-ins, and strong password policies. |
| **Lifecycle Management** | Automated detection and removal of inactive accounts. |
| **Least Privilege Enforcement** | No persistent admin access; Just-In-Time (JIT) privilege elevation. |

📌 **See also:**

- [Account & Credential Management Policy](../cisv81-controls/cisv81-05-account-and-credential-management-policy.md)
- [Account & Credential Management Policy Template](../cisv81-policy-templates/cisv81-05-account-and-credential-management-policy-template.md)

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All **user, system, and service accounts** (AD, Entra, and on-prem, including Azure Arc-managed assets). |
| **Out-of-Scope** | Temporary accounts outside compliance scope. |
| **Compliance Mapping** | CIS Control 5, NIST 800-53 (AC-2, IA-4), ISO/IEC 27001 (A.9.2.1, A.9.4.2). |

---

## **3. Sub-Control Implementation**

### **Account Inventory & Lifecycle Management**

All accounts are actively tracked, reviewed, and governed through automated processes.

| **Control** | **Implementation** |
|------------|--------------------|
| **Quarterly Account Audits** | AD and Entra accounts reviewed every 90 days. |
| **Automated Inactive Account Detection** | Ansible OSQuery scans disable inactive accounts. |
| **External Account Access Reviews** | Entra enforces periodic user verification for external users. |
| **Enforced Account Lifecycle Policies** | AD user status syncs with Entra for automated disablement. |

### **Authentication & Access Security**

Strict authentication policies enforce secure access across all user and system accounts.

| **Security Measure** | **Enforcement** |
|----------------------|----------------|
| **Password Policies** | 30+ character passphrases for service accounts; 16+ character user passwords. |
| **Multi-Factor Authentication (MFA)** | Enforced for all users (internal & external). |
| **Risk-Based Sign-In Detection** | Conditional Access enforces risk-based authentication restrictions. |
| **Blocked Legacy Authentication** | CA policies disable legacy authentication protocols. |

### **Privilege Management & Just-In-Time Access**

Role-based access control (RBAC) and Just-In-Time (JIT) access ensure least privilege enforcement.

| **Access Control** | **Implementation** |
|--------------------|------------------|
| **No Persistent Admin Accounts** | Admin access is separate from standard accounts. |
| **Just-In-Time (JIT) Access** | Privileged roles require JIT elevation via Entra. |
| **Access Packages in Entra** | Assigns access based on role and identity verification. |
| **Service Account Privilege Enforcement** | No excessive permissions; automated password rotation. |

---

## **4. Compliance Evidence**

| **Sub-Control** | **Implementation Details** | **Reference Document** |
|---------------|----------------------|------------------|
| **5.1** | Active account inventory tracking and review cycles. | [CISv8 5.1 Implementation](./5.1.md) |
| **5.2** | Authentication hardening and password policies. | [CISv8 5.2 Implementation](./5.2.md) |
| **5.3** | Inactive account detection and removal policies. | [CISv8 5.3 Implementation](./5.3.md) |
| **5.4** | Role-based access control and least privilege enforcement. | [CISv8 5.4 Implementation](./5.4.md) |
| **5.6** | Service account security and governance. | [CISv8 5.6 Compliance](./5.6.md) |

📌 **Each sub-control has a dedicated document outlining its enforcement and validation.**

---

## **5. Summary**

✅ **CIS Control 5 is fully implemented in the Proxmox Astronomy Lab, ensuring strict identity governance across all accounts.**  
✅ **Account lifecycle automation ensures continuous compliance and security.**  
✅ **Entra Identity Governance provides structured role-based access control.**  

---

## ✅ Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |

---

## 📜 Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.2 | 2025-03-04 | Standardized KBFormatv1 applied. Article interlinking. | VintageDon |

---
title: "Microsoft Entra ID Security & Compliance Mapping"
description: "Mapping of Microsoft Entra ID P1, P2, and Entra Suite capabilities to CISv8, NIST 800-53, and ISO 27001 controls."
author: "VintageDon"
tags: ["Entra ID", "Access Management", "Compliance", "CISv8", "NIST", "ISO 27001"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-03"
---

# **🔐 Microsoft Entra ID Security & Compliance Mapping**  

## **1. Introduction**  

Microsoft **Entra ID P1 + P2 + Entra Suite** provides **identity security, governance, and zero-trust access** to enforce compliance with security frameworks such as:  

- **CIS Critical Security Controls (CISv8)**
- **NIST 800-53 (AC-2, IA-2, AC-6, etc.)**
- **ISO/IEC 27001 (Annex A.9 – Access Control, A.12 – Security Operations, etc.)**  

This document maps **Entra ID capabilities** to **security controls**, ensuring alignment with **identity and access management best practices** in the **Proxmox Astronomy Lab**.

---

## **2. Microsoft Entra ID Compliance Mapping**  

### **2.1 Identity & Access Management (IAM)**  

| **Entra ID Feature** | **Description** | **CISv8 Control(s)** | **NIST 800-53 Control(s)** |
|----------------------|----------------|----------------------|---------------------------|
| **Conditional Access (CA)** | Enforces **granular access control** based on user/device risk, location, and session context. | **6.3, 6.4, 6.5, 6.7** | **AC-3, AC-6, IA-5** |
| **Privileged Identity Management (PIM)** | Implements **Just-In-Time (JIT) elevation**, approval workflows, and access reviews for **privileged accounts**. | **5.4, 5.5, 6.5** | **AC-2, AC-6, IA-4** |
| **Access Reviews** | Regularly **audits user access** to sensitive resources, enforcing **least privilege**. | **5.1, 6.1, 6.2** | **AC-2, AC-5, AC-6** |
| **Access Packages** | Defines **structured, time-bound access bundles** for users, enforcing governance. | **6.1, 6.8** | **AC-2, AC-3, AC-5** |
| **Group-Based Access Management** | Assigns **roles and permissions** based on **Azure AD groups**. | **6.8, 5.4** | **AC-2, AC-3, AC-6** |

---

### **2.2 Authentication & Multi-Factor Security**  

| **Entra ID Feature** | **Description** | **CISv8 Control(s)** | **NIST 800-53 Control(s)** |
|----------------------|----------------|----------------------|---------------------------|
| **Multi-Factor Authentication (MFA)** | Requires **phish-resistant authentication** for all users (FIDO2, Passkeys, Authenticator). | **6.3, 6.4, 6.5** | **IA-2, IA-5** |
| **Risk-Based Conditional Access** | **Blocks risky logins** using machine learning & identity protection signals. | **5.2, 6.3** | **IA-4, IA-5** |
| **Passwordless Authentication** | Enforces **FIDO2 keys, Passkeys, and Windows Hello** for passwordless sign-ins. | **6.5** | **IA-5** |

---

### **2.3 Zero Trust & Secure Access**  

| **Entra ID Feature** | **Description** | **CISv8 Control(s)** | **NIST 800-53 Control(s)** |
|----------------------|----------------|----------------------|---------------------------|
| **Entra Private Access (EPA)** | Replaces VPNs with **zero-trust remote access**, securing RDP, SSH, and web apps. | **6.4** | **AC-17, AC-19** |
| **Entra Internet Access (EIA)** | Provides **secure web access** with policy-based controls. | **6.3, 6.4** | **AC-3, AC-4** |

---

### **2.4 Identity Lifecycle & Governance**  

| **Entra ID Feature** | **Description** | **CISv8 Control(s)** | **NIST 800-53 Control(s)** |
|----------------------|----------------|----------------------|---------------------------|
| **Automated User Provisioning** | Syncs **user accounts** between on-prem and cloud environments. | **5.1, 5.3** | **IA-4, AC-2** |
| **Automated Account Deprovisioning** | **Disables/stales accounts automatically** upon termination. | **5.3, 6.2** | **AC-2, IA-4** |
| **Guest Access Reviews** | Regularly audits **external users’ permissions** in Entra. | **5.1, 6.1** | **AC-3, AC-6** |

---

### **2.5 Security Monitoring & Auditing**  

| **Entra ID Feature** | **Description** | **CISv8 Control(s)** | **NIST 800-53 Control(s)** |
|----------------------|----------------|----------------------|---------------------------|
| **Identity Protection** | Detects & remediates **compromised accounts** in real-time. | **5.2, 6.3** | **IA-4, AU-12** |
| **Log Correlation with Sentinel** | **Integrates identity logs** with Azure Sentinel for **SIEM analysis**. | **6.6, 5.5** | **AU-12, AC-6** |
| **Entra ID Sign-In Logs** | Provides **detailed authentication logs** for compliance. | **5.5, 6.6** | **AU-12, AC-6** |

---

## **3. Summary of Compliance Alignment**  

✅ **Entra ID P1, P2, and Entra Suite enable enforcement of key CIS, NIST, and ISO 27001 controls.**  
✅ **All user access is managed, monitored, and regularly reviewed via governance tools.**  
✅ **Zero-trust policies ensure all remote, privileged, and external access is secured.**  
✅ **Privileged accounts follow Just-In-Time (JIT) and Role-Based Access Control (RBAC).**  

**By fully integrating Entra ID governance, MFA, conditional access, and secure access policies, the Proxmox Astronomy Lab achieves compliance with leading identity security standards.**  

---

## **4. Compliance Evidence**  

To verify compliance, refer to the **implementation KBs**:

📜 **Related Documents:**  
📍 `docs/compliance-security/cisv8/05-account-management.md`  
📍 `docs/compliance-security/cisv8/06-access-control-management.md`  
📍 `docs/compliance-security/cisv8/04-secure-configuration-management.md`  

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ Approved |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

---

🚀 **This document ensures Microsoft Entra ID capabilities are mapped to compliance frameworks, supporting security and governance in the Proxmox Astronomy Lab.**
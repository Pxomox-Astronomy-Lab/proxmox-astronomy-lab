<!-- ---
title: "CISv8-06 Access Control Management Policy"
description: "Defines the access control management policy for the Proxmox Astronomy Lab, enforcing role-based access control (RBAC), multi-factor authentication (MFA), conditional access, and continuous monitoring to prevent unauthorized access."
author: "VintageDon"
tags: ["CISv8", "Access Control", "Security Policy", "Compliance", "RBAC"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---
 -->

# **📜 CISv8-06 Access Control Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Access control management ensures that **only authorized users, devices, and services** can access systems, applications, and data within the **Proxmox Astronomy Lab**. This policy enforces **role-based access control (RBAC), multi-factor authentication (MFA), conditional access, and continuous monitoring** to prevent **unauthorized access and privilege escalation**.

### **Key Objectives**

This policy enforces **secure access control** through:

| **Objective** | **Description** |
|--------------|----------------|
| **Identity Governance** | Managed via Entra ID with Access Reviews and Conditional Access. |
| **Zero-Trust Network Access (ZTNA)** | Enforced through Entra Private Access. |
| **Privileged Access Security** | FIDO keys & Just-In-Time (JIT) elevation required. |
| **Hybrid Identity Management** | Azure Arc ensures on-prem consistency with cloud security. |
| **Automated Account Deprovisioning** | Ansible & Entra enforce timely offboarding. |

This policy aligns with **CISv8, NIST 800-53, and ISO 27001**, ensuring **a consistent, auditable, and secure access control model across all hybrid and cloud-based assets**.

---

## **2. Compliance Mapping**

This policy aligns with **industry security frameworks** to maintain best practices:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 6 – Access Control Management |
| **NIST 800-53** | AC-6 – Least Privilege Enforcement |
| **ISO 27001** | A.9.1 – Access Control Policies |

---

## **3. Responsibilities**

Roles and responsibilities ensure **proper enforcement of access controls**:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Infrastructure Engineers (L2/L3)** | Implement and monitor access policies, enforce RBAC, and detect unauthorized access. |
| **Administrators (L1/L2-Lite)** | Manage user permissions, deprovision accounts, and enforce MFA policies. |
| **Users** | Follow MFA and access policies, report unauthorized access, and avoid credential sharing. |

---

## **4. Policy Implementation**

### **4.1 Access Granting & Role-Based Access Control (RBAC)**

Access is assigned through **structured, role-based permissions**:

| **Role Type** | **Access Scope** |
|--------------|------------------|
| **Standard Users** | Limited access to general research resources. |
| **Researchers** | Read/write access to data storage and analysis tools. |
| **Administrators** | JIT elevated access for maintenance tasks. |
| **Guests** | Temporary access with expiration controls. |

RBAC is enforced across **cloud, on-prem, and Kubernetes environments**:

| **System** | **Role Enforcement Method** |
|------------|----------------------------|
| Entra ID | Access Packages, Access Reviews |
| Active Directory | Group Policy, Role-Based Groups |
| Kubernetes | Namespace RBAC, Admission Controllers |
| Proxmox | LDAP Authentication, Role-Based Permissions |

---

### **4.2 Access Revocation & Offboarding**

Automated account deprovisioning prevents lingering access risks:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Immediate Account Disablement** | Ansible & Entra disable accounts upon termination. |
| **Active Sessions Revoked** | Enforced through Conditional Access. |
| **MFA Registration Reset** | Ensures former employees cannot reuse MFA. |
| **Inactive Account Lockout** | Accounts disabled after 45 days of inactivity. |
| **Guest Access Reviews** | Conducted every 90 days via Entra Identity Governance. |

---

### **4.3 Multi-Factor Authentication (MFA) & Authentication Security**

MFA is **mandatory for all externally accessible systems**:

| **System** | **MFA Enforcement Method** |
|------------|---------------------------|
| Entra ID | Conditional Access Policies |
| Active Directory | Smart Card/FIDO Key Authentication |
| Linux Systems | PAM Security Modules |
| Cloud Apps | Enforced via SAML/OAuth |

Legacy authentication methods (e.g., NTLM, basic auth) are **blocked**.

---

### **4.4 Remote Access Security**

Remote access requires **MFA, Just-In-Time elevation, and conditional policies**:

| **System** | **Access Control Method** |
|------------|-------------------------|
| RDP | Enforced via Entra Private Access |
| SSH | Enforced via Just-In-Time Access |
| Kubernetes | Enforced via Namespace RBAC |

---

### **4.5 Continuous Monitoring & Auditing**

Access events are **logged, reviewed, and analyzed for anomalies**:

| **Event Type** | **Detection Method** | **Response Action** |
|---------------|---------------------|---------------------|
| Unusual Login Location | Entra Identity Protection | Block sign-in, force MFA |
| Failed MFA Attempt | Wazuh SIEM | Generate security alert |
| Role Escalation Attempt | Azure Sentinel | Immediate log review & response |

---

### **4.6 Service & Resource Account Access Controls**

Service account access is **strictly controlled**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Service Accounts Tracked** | Managed in Entra & Active Directory. |
| **Password Rotation** | Enforced every 180 days. |
| **No Direct Login Access** | Authentication via API keys/tokens only. |
| **Hybrid Security Enforcement** | Azure Arc ensures parity between on-prem and cloud accounts. |

---

### **4.7 Account Termination & Emergency Lockdown**

Access revocation occurs **immediately upon termination**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Immediate Credential Revocation** | Enforced via Ansible workflows. |
| **Emergency Lockdown Procedures** | Activated for high-risk security incidents. |
| **No Self-Service Reset for Disabled Accounts** | Prevents reactivation by former users. |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ DRAFT |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

🚀 **This policy ensures that access control security remains a structured, actively enforced, and auditable process in the Proxmox Astronomy Lab.**



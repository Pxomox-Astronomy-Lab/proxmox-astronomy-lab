<!-- ---
title: "CISv8-05 Account and Credential Management Policy"
description: "Defines the account and credential management policy for the Proxmox Astronomy Lab, ensuring secure identity governance, access control, and credential lifecycle management in compliance with CISv8, NIST 800-53, and ISO 27001."
author: "VintageDon"
tags: ["CISv8", "Identity Management", "Security Policy", "Compliance", "Access Control"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---
 -->

# **📜 CISv8-05 Account and Credential Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Account and credential management ensures that **user, system, and service accounts** are **securely created, maintained, and deprovisioned** to prevent **unauthorized access, privilege abuse, and credential compromise**.

### **Key Objectives**

This policy enforces **strict identity governance** through:

| **Objective** | **Description** |
|--------------|----------------|
| **Identity & Access Management (IAM)** | Enforced via Entra ID & Active Directory. |
| **Mandatory MFA & Strong Authentication** | MFA is required for all privileged and externally accessible accounts. |
| **Automated Account Lifecycle Management** | Accounts are provisioned, modified, and removed automatically. |
| **Role-Based Access Control (RBAC) & JIT** | Just-In-Time (JIT) elevation ensures least privilege access. |
| **Routine Audits & Access Reviews** | Accounts are reviewed to detect inactive or unauthorized use. |

This policy applies to **on-prem, cloud, and hybrid environments** within the **Proxmox Astronomy Lab**.

---

## **2. Compliance Mapping**

This policy aligns with **industry standards** for identity and credential security:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 5 – Account & Credential Management |
| **NIST 800-53** | AC-2 – Account Management |
| **ISO 27001** | A.9.2 – User Access Management |

---

## **3. Responsibilities**

Defined roles ensure **account and credential security**:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Infrastructure Engineers (L2/L3)** | Enforce account lifecycle policies, monitor access logs, and manage privileged accounts. |
| **Administrators (L1/L2-Lite)** | Implement MFA, disable inactive accounts, and conduct periodic reviews. |
| **Users** | Follow security best practices, use MFA, and report security concerns. |

---

## **4. Policy Implementation**

### **4.1 Account Onboarding & Provisioning**

Account creation must follow a **documented approval process**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Approval Process** | All accounts must be created via an authorized request. |
| **RBAC Enforcement** | Users are assigned permissions based on role. |
| **Unique Privileged Accounts** | No shared administrator accounts allowed. |

All privileged accounts are managed through **Entra Identity Governance**.

---

### **4.2 Credential Creation & Security**

Strict password policies ensure **credential security**:

| **Account Type** | **Password Requirements** |
|--------------|------------------|
| **Service & System Accounts** | 30-character passphrase minimum. |
| **User Accounts** | 16-character minimum, mixed characters required. |
| **MFA-Enabled Accounts** | 16-character minimum. |
| **Non-MFA Accounts** | 16-character minimum, rotated every 90 days. |

Additional security policies include **password expiration, reuse prevention, and immediate change of default credentials**.

---

### **4.3 Account & Credential Usage**

Enforcing strong authentication prevents **unauthorized access**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Mandatory MFA** | Enforced for privileged, remote, and external access. |
| **Privileged Account Usage** | Admin accounts must only be used for administrative tasks. |
| **Access Reviews** | Conducted every 90 days via Entra Identity Governance. |
| **Just-In-Time (JIT) Privileges** | Users elevate privileges only when needed. |

---

### **4.4 Inactive Account & Access Monitoring**

Inactive accounts must be **detected and removed**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **45-Day Inactivity Policy** | User accounts disabled if inactive. |
| **Privileged Accounts Review** | Flagged for review if inactive. |
| **Extended Leave Policy** | Accounts temporarily disabled during absences. |
| **Automated Monitoring** | OSQuery & Wazuh detect inactive accounts. |

---

### **4.5 Role-Based Access Control (RBAC) & Least Privilege**

Access permissions are assigned via **structured roles**:

| **Role Type** | **Access Scope** |
|--------------|------------------|
| **Standard Users** | Minimal necessary access. |
| **Researchers** | Read/write data access. |
| **Administrators** | JIT elevated privileges only. |
| **Guests** | Temporary, limited access. |

Active Directory & Entra enforce **RBAC policies**.

---

### **4.6 Service & Resource Account Security**

Service accounts must follow **strict security policies**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Active Directory & Entra Tracking** | All service accounts must be cataloged. |
| **Password Rotation** | Service account passwords rotated every 180 days. |
| **No Direct Login** | Authentication occurs via API keys or tokens. |
| **Hybrid Security Enforcement** | Azure Arc ensures on-prem policies match cloud policies. |

---

### **4.7 Account Termination & Deprovisioning**

Account removal must be **immediate upon termination**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Revocation Policy** | Credentials revoked immediately upon separation. |
| **Account Disablement** | Terminated accounts are disabled within 24 hours. |
| **Self-Service Restrictions** | Password reset cannot reactivate disabled accounts. |

---

### **4.8 Logging & Monitoring**

All authentication events are **logged and reviewed**:

| **Monitoring Tool** | **Function** |
|-----------------|----------------|
| **Wazuh SIEM** | Logs failed login attempts and privilege escalations. |
| **OSQuery** | Monitors Active Directory for inactive accounts. |
| **Azure Sentinel** | Detects anomalous login behaviors. |
| **Access Reviews** | Conducted every 90 days for privileged accounts. |

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

🚀 **This policy ensures that account and credential security remains a structured, actively enforced, and auditable process in the Proxmox Astronomy Lab.**



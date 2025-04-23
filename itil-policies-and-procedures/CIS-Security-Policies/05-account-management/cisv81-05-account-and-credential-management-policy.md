<!-- ---
title: "CISv8-05 Account and Credential Management Policy"
description: "Defines the account and credential management policy for the Proxmox Astronomy Lab, ensuring secure identity governance, access control, and credential lifecycle management in compliance with CISv8, NIST 800-53, and ISO 27001."
author: "VintageDon"
tags: ["CISv8", "Identity Management", "Security Policy", "Compliance", "Access Control"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
 -->

# **📜 CISv8-05 Account and Credential Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Account and credential management ensures that **user, system, and service accounts** are **securely created, maintained, and deprovisioned** to prevent **unauthorized access, privilege abuse, and credential compromise** within the **Proxmox Astronomy Lab**.

### **Key Objectives**

This policy enforces **strict identity governance** through:

| **Objective** | **Description** |
|--------------|----------------|
| **Identity & Access Management (IAM)** | Enforced via Entra ID & Active Directory with structured governance. |
| **Mandatory MFA & Strong Authentication** | MFA required for all user accounts and privileged access. |
| **Automated Account Lifecycle Management** | Accounts are provisioned, reviewed, and removed through controlled processes. |
| **Role-Based Access Control (RBAC) & JIT** | Just-In-Time (JIT) elevation ensures least privilege access. |
| **Regular Access Reviews** | Accounts are reviewed quarterly to detect inactive or unauthorized use. |

This policy applies to **all account types** across **on-premises, cloud, and hybrid environments** within the **Proxmox Astronomy Lab**.

---

## **2. Compliance Mapping**

This policy aligns with **industry standards** for identity and credential security:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 5 – Account Management |
| **NIST 800-53** | AC-2, IA-2, IA-4 – Account Management, Identification and Authentication |
| **ISO 27001** | A.9.2, A.9.4 – User Access Management, System and Application Access Control |

---

## **3. Responsibilities**

Defined roles ensure **account and credential security**:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Lab Owner** | Policy approval, exception authorization, final approval for emergency access. |
| **Security Administrator** | Identity governance implementation, access reviews, authentication security. |
| **Systems Administrator** | Account provisioning, technical implementation, service account management. |
| **User Managers** | Access request approval, user responsibility, inactive account review. |
| **All Users** | Follow security practices, use MFA, protect credentials, report security concerns. |

---

## **4. Policy Implementation**

### **4.1 Account Inventory and Management**

A comprehensive inventory must be maintained for all account types:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Centralized Account Repository** | All accounts maintained in Entra ID, Active Directory, and GLPI. |
| **Account Classification** | Accounts categorized by risk level, privileges, and purpose. |
| **Regular Inventory Validation** | Quarterly reconciliation of account repositories. |
| **Documentation Requirements** | Owner, purpose, privileges, and lifecycle status tracked for all accounts. |

### **4.2 Account Provisioning and Authentication**

Account creation must follow a controlled process with secure authentication:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Formal Request Process** | Documented business need and approval for all accounts. |
| **Identity Verification** | Validation of identity before account creation. |
| **Principle of Least Privilege** | Minimum necessary access rights for job function. |
| **Role-Based Access Assignment** | Structured roles define permissions and access levels. |

### **4.3 Authentication Security Requirements**

The following authentication standards must be enforced:

| **Account Type** | **Password Requirements** | **MFA Requirements** | **Additional Controls** |
|-----------------|--------------------------|---------------------|------------------------|
| **Standard User** | 16+ characters, complexity | Required for all access | Risk-based authentication |
| **Privileged User** | 16+ characters, complexity | Required for all access | Just-in-time access, session monitoring |
| **Service Account** | 30+ character passphrase | Not applicable | Restricted permissions, automated rotation |
| **Emergency Access** | 30+ character passphrase | Required when possible | Break-glass procedures, audit logging |

### **4.4 Password Management Requirements**

All passwords must adhere to the following standards:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Password Complexity** | Minimum 16 characters for users, 30 for service accounts. |
| **Password Storage** | Secure storage using approved password managers or vaults. |
| **Default Credentials** | All default passwords must be changed before production use. |
| **Shared Accounts** | Prohibited except for documented exceptions with compensating controls. |

### **4.5 Multi-Factor Authentication (MFA)**

MFA must be implemented according to the following requirements:

| **System Access Type** | **MFA Requirement** | **Acceptable Methods** |
|------------------------|-------------------|------------------------|
| **Remote Access** | Mandatory | Entra Authenticator, FIDO2 Security Keys |
| **Privileged Access** | Mandatory | Entra Authenticator, FIDO2 Security Keys |
| **Local Network Access** | Mandatory | Entra Authenticator, FIDO2 Security Keys |
| **Service Accounts** | Exception-based | Managed identities where supported |

### **4.6 Privileged Access Management**

Privileged access must follow enhanced security controls:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Separate Admin Accounts** | Standard and privileged functions require separate accounts. |
| **Just-In-Time (JIT) Access** | Privileged access granted only when needed with time limitations. |
| **Enhanced Monitoring** | All privileged actions logged and monitored. |
| **Privilege Restriction** | Admin rights limited to specific tasks and systems. |

### **4.7 Service Account Management**

Service accounts must follow specialized security procedures:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Inventory and Tracking** | All service accounts documented with owner, purpose, and scope. |
| **Credential Security** | 30+ character random passphrases, secure storage. |
| **Regular Rotation** | Credentials rotated every 180 days maximum. |
| **Least Privilege** | Minimum necessary permissions to perform function. |
| **Monitoring** | All authentication attempts logged and reviewed. |

### **4.8 Account Lifecycle Management**

Accounts must be managed through their complete lifecycle:

| **Lifecycle Phase** | **Requirements** | **Responsible Role** |
|--------------------|----------------|----------------------|
| **Provisioning** | Documented request, verification, minimum access | Systems Administrator |
| **Maintenance** | Periodic review, privilege adjustment | Security Administrator |
| **Deactivation** | Immediate on separation, 45-day inactivity | Systems Administrator |
| **Termination** | Complete removal after deactivation period | Systems Administrator |

### **4.9 Inactive Account Management**

Inactive accounts must be detected and managed:

| **Account Type** | **Inactivity Threshold** | **Required Action** | **Exception Process** |
|-----------------|--------------------------|---------------------|----------------------|
| **User Accounts** | 45 days | Automatic disablement | Manager approval with justification |
| **Privileged Accounts** | 30 days | Review and disablement | Security Administrator approval |
| **Service Accounts** | 90 days | Review and assessment | Documented business need |
| **External Users** | 30 days | Automatic disablement | Sponsor reapproval |

### **4.10 Account Monitoring and Auditing**

Authentication events must be monitored to detect security issues:

| **Monitoring Activity** | **Implementation** | **Review Frequency** | **Response Requirements** |
|------------------------|-------------------|---------------------|---------------------------|
| **Failed Authentication** | Wazuh monitoring of authentication logs | Real-time alerts | Investigation of suspicious patterns |
| **Unusual Access Patterns** | Risk-based authentication detection | Real-time alerts | Investigation of anomalies |
| **Privilege Usage** | Logging of all privileged operations | Weekly review | Verification of authorized activities |
| **Account Changes** | Monitoring of account modifications | Weekly review | Validation of authorized changes |

---

## **5. Compliance Monitoring & Enforcement**

Regular verification ensures policy adherence:

| **Activity** | **Frequency** | **Responsible Role** | **Documentation** |
|--------------|--------------|----------------------|-------------------|
| **User Account Review** | Quarterly | Security Administrator | Access review reports |
| **Privileged Account Audit** | Quarterly | Security Administrator | Privilege audit reports |
| **Service Account Verification** | Quarterly | Systems Administrator | Service account inventory |
| **Password Policy Compliance** | Quarterly | Security Administrator | Password policy reports |
| **MFA Adoption Verification** | Quarterly | Security Administrator | MFA enforcement reports |

---

## **6. Exception Management**

Exceptions to this policy require formal approval:

| **Exception Type** | **Approval Requirements** | **Documentation Requirements** |
|-------------------|--------------------------|-------------------------------|
| **MFA Exception** | Lab Owner approval, risk assessment | Business justification, compensating controls |
| **Password Policy Exception** | Security Administrator approval | Technical limitations, alternative controls |
| **Shared Account Exception** | Lab Owner approval, security review | Business necessity, access monitoring |
| **Extended Inactivity Exception** | Manager approval | Business justification, review date |

All exceptions must be:

- Formally documented in the exception register
- Reviewed quarterly for continued necessity
- Associated with compensating controls
- Approved by the designated authority

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |

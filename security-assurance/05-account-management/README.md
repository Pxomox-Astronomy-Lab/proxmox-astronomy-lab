<!-- 
---
title: "CIS Control 5: Account Management - Proxmox Astronomy Lab"
description: "Implementation of CIS Control 5 for ensuring comprehensive account management, authentication security, and credential protection within the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["security", "compliance", "cisv8", "account-management", "authentication", "credential-protection"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔐 **CIS Control 5: Account Management**

## 🔍 **1. Overview**

CIS Control 5 establishes requirements for the **secure management of all account types** within the Proxmox Astronomy Lab. This control ensures that user, service, and system accounts are properly created, monitored, and decommissioned to prevent unauthorized access and credential abuse.

This documentation covers our implementation of CIS Control 5, including **identity governance, authentication security, access management**, and account lifecycle processes that protect our environment from identity-based attacks.

This implementation is based on the official CIS Control 5 policy templates published by the Center for Internet Security (CISSecurity.org), ensuring structural alignment with industry-standard compliance requirements.

---

## 🎯 **2. Control Objectives**

### **2.1 Primary Goals**

The implementation of CIS Control 5 achieves several key security objectives:

| **Objective** | **Description** | **Implementation Approach** |
|--------------|----------------|----------------------------|
| **Complete Account Inventory** | Maintain accurate inventory of all account types | Centralized identity management via Entra ID and Active Directory |
| **Secure Authentication** | Enforce strong authentication mechanisms | MFA requirements, strong password policies, risk-based access controls |
| **Account Lifecycle Management** | Control account creation through decommissioning | Automated provisioning, periodic reviews, and timely deactivation |
| **Privileged Access Security** | Protect high-privilege accounts | Just-in-time access, separation of duties, enhanced monitoring |
| **Service Account Protection** | Secure non-user accounts | Strict credential management, limited permissions, regular rotation |

### **2.2 Compliance Mapping**

This control satisfies requirements across multiple security frameworks:

| **Framework** | **Control Reference** | **Description** |
|--------------|----------------------|----------------|
| **CIS Controls v8.1** | Control 5 | Account Management |
| **NIST 800-53 Rev 5** | AC-2, IA-2, IA-4 | Account Management, Identification and Authentication |
| **ISO 27001:2022** | A.9.2, A.9.4 | User Access Management, System and Application Access Control |
| **MITRE ATT&CK** | Initial Access, Privilege Escalation | Mitigates credential-based attack vectors |

---

## 🛠️ **3. Implementation Details**

### **3.1 Identity Management Architecture**

The lab implements a hybrid identity model with centralized management:

| **System** | **Purpose** | **Account Types** | **Integration Points** |
|------------|------------|------------------|------------------------|
| **Entra ID** | Cloud identity, authentication and governance | User accounts, external access | Azure services, conditional access |
| **Active Directory** | On-premises identity and access control | Internal user and service accounts | Domain authentication, Group Policy |
| **Azure Arc** | Extension of Entra ID to on-premises resources | Managed identities, service principles | Hybrid resources, Kubernetes |
| **GLPI** | Identity inventory and tracking | System accounts, lifecycle management | Automation workflows, audit tracking |

### **3.2 Account Inventory and Classification**

All accounts are inventoried and classified according to risk and privilege level:

| **Account Type** | **Classification** | **Management Approach** | **Review Frequency** |
|-----------------|-------------------|------------------------|----------------------|
| **Regular User** | Standard Risk | Self-service with governance | Quarterly |
| **Privileged User** | High Risk | Just-in-time access, enhanced monitoring | Quarterly |
| **Service Account** | Varying Risk | Strict credential management, limited scope | Quarterly |
| **Emergency Access** | Critical | Break-glass procedures, secured credentials | Quarterly |
| **External/Guest** | Variable Risk | Limited access, expiration enforcement | Quarterly |

### **3.3 Authentication Security Implementation**

Multiple authentication security controls are enforced:

| **Security Mechanism** | **Implementation** | **User Impact** |
|------------------------|-------------------|----------------|
| **Password Policies** | 16+ character minimum for users, 30+ for services | Stronger initial passwords |
| **Multi-Factor Authentication** | Required for all user accounts | Additional login step |
| **Risk-Based Authentication** | Conditional Access policies detect suspicious logins | Additional verification for unusual access |
| **Single Sign-On (SSO)** | Centralized authentication for supported services | Simplified user experience |
| **Passwordless Options** | Supported where feasible | Improved security and usability |

### **3.4 Privileged Access Management**

Privileged access follows a just-in-time model with enhanced security:

| **Access Type** | **Security Controls** | **Duration** | **Approval Process** |
|----------------|----------------------|--------------|----------------------|
| **Admin Access** | MFA, Conditional Access, session recording | Time-limited (4 hours max) | Self-service with audit |
| **System Access** | Dedicated privileged accounts | Task-based | Standard change process |
| **Emergency Access** | Break-glass procedures | 24 hours max | Post-usage review |
| **Elevated Rights** | Limited to specific systems/scopes | Task-based | Manager approval |

### **3.5 Service Account Security**

Service accounts follow strict security practices:

| **Security Practice** | **Implementation** | **Verification Method** |
|----------------------|-------------------|------------------------|
| **Long, Complex Passwords** | 30+ character random strings | Password complexity validation |
| **Limited Permissions** | Least privilege access scope | Quarterly privilege review |
| **Regular Rotation** | 180-day maximum credential lifetime | Automated rotation tracking |
| **Enhanced Monitoring** | Logging of all authentication events | Wazuh SIEM integration |
| **Identity Governance** | Ownership and purpose documentation | Quarterly attestation |

### **3.6 Inactive Account Management**

Inactive accounts are detected and managed through automated processes:

| **Account Type** | **Inactivity Threshold** | **Action** | **Exception Process** |
|-----------------|--------------------------|-----------|------------------------|
| **User Accounts** | 45 days | Automatic disablement | Manager approval |
| **Privileged Accounts** | 30 days | Review and disablement | Security review |
| **Service Accounts** | 90 days | Review and assessment | Documented exception |
| **External Users** | 30 days | Automatic disablement | Sponsor approval |

---

## 📊 **4. Verification & Validation**

### **4.1 Compliance Metrics**

The following metrics are tracked to measure account management effectiveness:

| **Metric** | **Target** | **Measurement Method** | **Current Status** |
|------------|-----------|------------------------|-------------------|
| **MFA Adoption** | 100% | Entra ID reports | 100% |
| **Inactive Account Remediation** | <5 days from detection | Automated reporting | 2 days avg |
| **Privileged Account Review** | 100% quarterly | Access review completion | 100% |
| **Password Policy Compliance** | 100% | GPO and Conditional Access reports | 100% |

### **4.2 Validation Procedures**

Regular validation ensures the continued effectiveness of account controls:

| **Validation Activity** | **Frequency** | **Responsible Role** | **Documentation** |
|------------------------|--------------|----------------------|-------------------|
| **Account Inventory Audit** | Quarterly | Security Administrator | [Account Audit](../../security-monitoring/account-audit.md) |
| **Authentication Security Review** | Quarterly | Security Administrator | [Authentication Review](../../security-monitoring/authentication-review.md) |
| **Privileged Access Audit** | Quarterly | Security Administrator | [Privilege Audit](../../security-monitoring/privilege-audit.md) |
| **Service Account Review** | Quarterly | Systems Administrator | [Service Account Review](../../security-monitoring/service-account-review.md) |

---

## 🔄 **5. Operational Procedures**

### **5.1 Account Lifecycle Management**

The following procedures govern the complete account lifecycle:

| **Lifecycle Stage** | **Key Procedures** | **Documentation** |
|--------------------|-------------------|-------------------|
| **Request & Approval** | Identity verification, business justification | [Account Request](../../itil-processes/account-management/request-procedure.md) |
| **Provisioning** | Automated creation, role assignment | [Account Provisioning](../../itil-processes/account-management/provisioning-procedure.md) |
| **Maintenance** | Periodic review, privilege adjustment | [Account Maintenance](../../itil-processes/account-management/maintenance-procedure.md) |
| **Deprovisioning** | Prompt removal, access termination | [Account Termination](../../itil-processes/account-management/termination-procedure.md) |

### **5.2 Role Responsibilities**

Clear role assignments ensure accountability for account management:

| **Role** | **Primary Responsibilities** | **Secondary Responsibilities** |
|----------|----------------------------|-------------------------------|
| **Lab Owner** | Policy approval, exception authorization | Final approval for emergency access |
| **Security Administrator** | Identity governance, access reviews | Authentication security, privileged access management |
| **Systems Administrator** | Account provisioning, technical implementation | Service account management, group membership |
| **User Managers** | Access request approval, user responsibility | Inactive account review, termination initiation |

---

## 🚀 **6. Tools & Resources**

The following tools support the implementation of CIS Control 5:

| **Tool** | **Purpose** | **Documentation** |
|----------|------------|-------------------|
| **Entra ID** | Cloud identity management and governance | [Entra Configuration](../../entra-hybrid-cloud/identity-integration/entra-configuration.md) |
| **Active Directory** | On-premises identity management | [AD Configuration](../../control-plane/identity-management/active-directory/configuration.md) |
| **Azure Arc** | Hybrid identity extension | [Arc Identity](../../entra-hybrid-cloud/azure-services/arc-integration/identity-management.md) |
| **Wazuh** | Security monitoring for authentication events | [Wazuh Authentication Monitoring](../../security-monitoring/wazuh/authentication-monitoring.md) |
| **GLPI** | Account inventory and lifecycle tracking | [GLPI Identity Management](../../applications/glpi/identity-management.md) |

---

## 🔗 **7. Related Documentation**

| **Document** | **Description** | **Location** |
|--------------|----------------|-------------|
| **Account and Credential Management Policy** | Comprehensive policy document | [Account Management Policy](cisv81-05-account-and-credential-management-policy.md) |
| **CIS Controls Implementation Guide** | Overall compliance framework | [CIS Implementation](../README.md) |
| **Password Guidelines** | User-facing password requirements | [Password Guidelines](../../security-policies/authentication/password-guidelines.md) |
| **Privilege Management Process** | Procedures for elevated access | [Privilege Management](../../security-policies/access-control/privilege-management.md) |
| **CIS Security Policy Templates** | Official CIS policy templates | [CIS Policy Templates](https://www.cisecurity.org/insights/white-papers/cis-controls-v8-implementation-guide-for-small-medium-enterprises) |

---

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation of CIS Control 5 implementation | VintageDon |
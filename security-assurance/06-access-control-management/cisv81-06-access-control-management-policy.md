<!-- ---
title: "CISv8-06 Access Control Management Policy"
description: "Defines the access control management policy for the Proxmox Astronomy Lab, enforcing role-based access control (RBAC), multi-factor authentication (MFA), conditional access, and continuous monitoring to prevent unauthorized access."
author: "VintageDon"
tags: ["CISv8", "Access Control", "Security Policy", "Compliance", "RBAC"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
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
| **Formal Access Authorization** | Structured process for requesting, approving, and granting access rights |
| **Timely Access Revocation** | Prompt removal of access when no longer required or appropriate |
| **Multi-Factor Authentication** | Enhanced identity verification for critical systems and remote access |
| **Zero-Trust Network Access** | Identity and context-based access regardless of network location |
| **Least Privilege Enforcement** | Access limited to minimum necessary for role responsibilities |

This policy applies to **all systems, applications, and data** within the **Proxmox Astronomy Lab**, including on-premises, cloud, and hybrid resources.

---

## **2. Compliance Mapping**

This policy aligns with **industry security frameworks** to maintain best practices:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 6 – Access Control Management |
| **NIST 800-53** | AC-2, AC-3, AC-6 – Account Management, Access Enforcement, Least Privilege |
| **ISO 27001** | A.9.1, A.9.2, A.9.4 – Access Control Policy, User Access Management, System Access Control |

---

## **3. Responsibilities**

Roles and responsibilities ensure **proper implementation and maintenance** of access controls:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Lab Owner** | Policy approval, exception authorization, emergency access approval |
| **Security Administrator** | Access review oversight, security monitoring, policy enforcement |
| **Systems Administrator** | Technical implementation, access provisioning and removal |
| **Resource Owners** | Access approval for specific resources, requirement definition |
| **All Users** | Comply with access policies, protect authentication credentials, report security concerns |

---

## **4. Policy Implementation**

### **4.1 Access Authorization Process**

All access requests must follow a structured approval and provisioning process:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Formal Request Process** | Documented business justification and approval workflow |
| **Role-Based Approach** | Access based on predefined roles and responsibilities |
| **Principle of Least Privilege** | Minimum necessary access rights for job functions |
| **Documentation Requirements** | Record of all access requests, approvals, and implementations |

### **4.2 Access Assignment and Role-Based Controls**

Access is granted through structured role-based permissions:

| **Role Category** | **Access Scope** | **Approval Requirements** | **Review Frequency** |
|-------------------|----------------|---------------------------|----------------------|
| **Standard Users** | Basic data access, research tools | Manager approval | Quarterly |
| **Research Staff** | Research data, analysis tools | Research Lead approval | Quarterly |
| **IT Operations** | Maintenance access, monitoring | IT Manager approval | Quarterly |
| **Administrators** | Privileged system access | Security Administrator approval | Quarterly |
| **External Users** | Limited, specific resources | Sponsor approval | Quarterly |

### **4.3 Access Revocation and Termination**

Access removal must be timely and comprehensive:

| **Scenario** | **Timeframe** | **Verification Method** | **Responsible Role** |
|--------------|--------------|------------------------|----------------------|
| **Employment Termination** | Same business day | Access audit, system logs | Systems Administrator |
| **Role Change** | Within 7 days | Access review, entitlement check | Security Administrator |
| **Extended Leave** | Before leave begins | Access audit | Systems Administrator |
| **Contractor Completion** | Same business day | Access audit, system logs | Systems Administrator |
| **Security Violation** | Immediate | Access logs, incident report | Security Administrator |

### **4.4 Multi-Factor Authentication Requirements**

MFA must be implemented according to the following requirements:

| **System Type** | **MFA Requirement** | **Acceptable Methods** | **Exception Process** |
|----------------|---------------------|------------------------|----------------------|
| **External Applications** | Required for all access | Microsoft Authenticator, FIDO2 Keys | Documented exception with compensating controls |
| **Privileged Access** | Required with phish-resistant method | FIDO2 Keys only | No exceptions |
| **Remote Access** | Required for all access | Microsoft Authenticator, FIDO2 Keys | No exceptions |
| **Internal Applications** | Required for sensitive systems | Microsoft Authenticator, FIDO2 Keys | Documented exception with compensating controls |

### **4.5 Remote Access Security**

Remote access must follow zero-trust principles:

| **Access Method** | **Security Requirements** | **Authentication Method** | **Monitoring Requirements** |
|-------------------|--------------------------|---------------------------|----------------------------|
| **Entra Private Access** | Device compliance, risk assessment | MFA, conditional access | Session logging, anomaly detection |
| **Tailscale with SCIM** | Identity-based authorization | Entra ID authentication, MFA | Traffic logging, access monitoring |
| **RDP/SSH Access** | Jump host, session limits | MFA, time-limited access | Session recording, activity logging |
| **Application Access** | Data protection, encryption | Entra ID SSO, MFA | Activity monitoring, DLP integration |

### **4.6 Privileged Access Management**

Privileged access follows enhanced security controls:

| **Requirement** | **Implementation** | **Verification Method** |
|--------------|------------------|------------------------|
| **Separate Privileged Accounts** | Administrative functions require dedicated accounts | Account inventory audit |
| **Just-In-Time Access** | Temporary elevation for specific tasks | Privilege elevation logs |
| **Enhanced Monitoring** | All privileged actions are logged and reviewed | SIEM alerts, activity review |
| **Session Time Limits** | Administrative sessions expire after period of inactivity | Session configuration audit |
| **Privileged Access Workstations** | Secure endpoints for administrative access | Device compliance checking |

### **4.7 Access Control Monitoring and Audit**

Access activities must be continuously monitored:

| **Monitoring Activity** | **Implementation** | **Review Frequency** | **Responsible Role** |
|------------------------|-------------------|---------------------|----------------------|
| **Access Attempts** | Wazuh monitoring of authentication logs | Real-time alerts | Security Administrator |
| **Privilege Usage** | Tracking of administrative actions | Weekly review | Security Administrator |
| **Unusual Access Patterns** | Behavioral analysis of access patterns | Real-time alerts | Security Administrator |
| **Access Policy Violations** | Detection of policy non-compliance | Real-time alerts | Security Administrator |

---

## **5. Access Review and Certification**

Regular reviews validate continued appropriateness of access:

| **Review Type** | **Frequency** | **Scope** | **Responsible Role** |
|----------------|--------------|----------|----------------------|
| **User Access Review** | Quarterly | All standard user accounts | Security Administrator |
| **Privileged Access Review** | Quarterly | All privileged access | Security Administrator |
| **Service Account Review** | Quarterly | All service accounts | Systems Administrator |
| **External User Review** | Quarterly | All external/guest accounts | Security Administrator |
| **Emergency Access Review** | After each use | Break-glass and emergency access | Lab Owner |

### **5.1 Review Methodology**

Access reviews must follow a structured methodology:

1. **Inventory Collection** - Gather current access rights from all systems
2. **Business Need Validation** - Verify continued business requirement
3. **Excess Access Identification** - Identify permissions beyond current role needs
4. **Remediation** - Remove or adjust inappropriate access
5. **Documentation** - Record review findings and actions taken

---

## **6. Exception Management**

Exceptions to this policy require formal approval:

| **Exception Type** | **Approval Requirements** | **Documentation Requirements** | **Review Frequency** |
|-------------------|--------------------------|-------------------------------|----------------------|
| **MFA Exception** | Lab Owner approval, risk assessment | Business justification, compensating controls | Quarterly |
| **Access Control Exception** | Security Administrator, resource owner approval | Technical limitations, alternative controls | Quarterly |
| **Privileged Access Exception** | Lab Owner approval, security review | Business necessity, enhanced monitoring | Quarterly |
| **Emergency Access** | Lab Owner approval | Incident documentation, post-use review | After each use |

All exceptions must be:

- Formally documented in the exception register
- Reviewed quarterly for continued necessity
- Associated with compensating controls
- Approved by the designated authority

---

## **7. Compliance Monitoring & Enforcement**

Regular verification ensures policy adherence:

| **Monitoring Activity** | **Frequency** | **Method** | **Responsible Role** |
|------------------------|--------------|-----------|----------------------|
| **Access Control Audit** | Quarterly | Technical assessment, log review | Security Administrator |
| **MFA Compliance** | Quarterly | Entra ID reports, authentication logs | Security Administrator |
| **Privileged Access Audit** | Quarterly | Administrative account review | Security Administrator |
| **Exception Review** | Quarterly | Exception register validation | Security Administrator |

Non-compliance requires prompt remediation and may result in access restriction or removal.

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

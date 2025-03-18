<!-- 
---
title: "CIS Control 6: Access Control Management - Proxmox Astronomy Lab"
description: "Implementation of CIS Control 6 for ensuring comprehensive access control through role-based permissions, multi-factor authentication, and zero-trust principles within the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["security", "compliance", "cisv8", "access-control", "rbac", "mfa", "zero-trust"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔐 **CIS Control 6: Access Control Management**

## 🔍 **1. Overview**

CIS Control 6 establishes requirements for **managing access rights and permissions** within the Proxmox Astronomy Lab. This control ensures that access to systems and data is properly authorized, authenticated, and monitored to prevent unauthorized access and privilege escalation.

This documentation covers our implementation of CIS Control 6, including **identity governance, role-based access control, multi-factor authentication**, and zero-trust principles that protect our environment from unauthorized access.

This implementation is based on the official CIS Control 6 policy templates published by the Center for Internet Security (CISSecurity.org), ensuring structural alignment with industry-standard compliance requirements.

---

## 🎯 **2. Control Objectives**

### **2.1 Primary Goals**

The implementation of CIS Control 6 achieves several key security objectives:

| **Objective** | **Description** | **Implementation Approach** |
|--------------|----------------|----------------------------|
| **Controlled Access Assignment** | Ensure formal process for granting access rights | Entra Access Packages, structured role definition |
| **Timely Access Revocation** | Remove access when no longer required | Automated offboarding, access reviews |
| **Multi-Factor Authentication** | Require strong authentication for critical access | MFA enforcement, conditional access policies |
| **Secure Remote Access** | Control access from external networks | Zero-trust architecture, Entra Private Access |
| **Least Privilege Enforcement** | Limit access to minimum necessary | Role-based access control, just-in-time elevation |

### **2.2 Compliance Mapping**

This control satisfies requirements across multiple security frameworks:

| **Framework** | **Control Reference** | **Description** |
|--------------|----------------------|----------------|
| **CIS Controls v8.1** | Control 6 | Access Control Management |
| **NIST 800-53 Rev 5** | AC-2, AC-3, AC-6 | Account Management, Access Enforcement, Least Privilege |
| **ISO 27001:2022** | A.9.1, A.9.2, A.9.4 | Access Control Policy, User Access Management, System Access Control |
| **MITRE ATT&CK** | Privilege Escalation, Defense Evasion | Mitigates unauthorized privilege escalation |

---

## 🛠️ **3. Implementation Details**

### **3.1 Identity and Access Governance**

The lab implements a structured approach to identity governance:

| **Governance Component** | **Implementation** | **Coverage** | **Review Frequency** |
|-------------------------|-------------------|-------------|----------------------|
| **Access Packages** | Entra Identity Governance | All user access roles | Quarterly |
| **Access Reviews** | Entra Identity Governance | All user and privileged access | Quarterly |
| **Role Definitions** | Structured RBAC model | All systems and applications | Quarterly |
| **Entitlement Management** | Automated approval workflows | Resource access requests | Continuous |

### **3.2 Access Authorization Process**

All access follows a formal authorization process:

| **Access Type** | **Authorization Requirements** | **Approval Authority** | **Implementation Method** |
|----------------|-------------------------------|------------------------|---------------------------|
| **Standard Access** | Business justification, role-based | Manager | Entra Access Packages |
| **Privileged Access** | Business justification, least privilege | Security Administrator | Just-in-time access request |
| **Application Access** | Business justification, data classification | Application Owner | Access request workflow |
| **Emergency Access** | Documented emergency scenario | Lab Owner | Break-glass procedure |

### **3.3 Multi-Factor Authentication Implementation**

MFA is enforced across multiple access points:

| **System Type** | **MFA Requirement** | **Acceptable Methods** | **Exception Process** |
|----------------|---------------------|------------------------|----------------------|
| **External Applications** | Required for all access | Microsoft Authenticator, FIDO2 Keys | Documented exception with compensating controls |
| **Privileged Access** | Required with phish-resistant method | FIDO2 Keys only | No exceptions |
| **Remote Access** | Required for all access | Microsoft Authenticator, FIDO2 Keys | No exceptions |
| **Internal Applications** | Required for sensitive systems | Microsoft Authenticator, FIDO2 Keys | Documented exception with compensating controls |

### **3.4 Access Removal and Offboarding**

Access removal follows a swift, structured process:

| **Scenario** | **Timeline** | **Verification Method** | **Responsible Role** |
|--------------|------------|------------------------|----------------------|
| **Employment Termination** | Same business day | Access audit, system logs | Systems Administrator |
| **Role Change** | Within 7 days | Access review, entitlement check | Security Administrator |
| **Extended Leave** | Before leave begins | Access audit | Systems Administrator |
| **Contractor Completion** | Same business day | Access audit, system logs | Systems Administrator |

### **3.5 Zero-Trust Remote Access**

Remote access leverages zero-trust principles for enhanced security:

| **Access Method** | **Implementation** | **Authentication Requirements** | **Conditional Factors** |
|-------------------|-------------------|--------------------------------|------------------------|
| **Entra Private Access** | Identity-based network access | MFA, device compliance | Risk assessment, location |
| **Tailscale with SCIM** | Mesh VPN with Entra integration | MFA, device compliance | Network segmentation |
| **RDP Access** | Limited to secure channels | MFA, authorized devices only | Session monitoring |
| **SSH Access** | Certificate-based authentication | Key-based with passphrase | Session monitoring |

### **3.6 Role-Based Access Control Implementation**

RBAC provides structured access across all systems:

| **Role Category** | **Access Scope** | **Approval Requirements** | **Review Frequency** |
|-------------------|----------------|---------------------------|----------------------|
| **Standard Users** | Basic data access, research tools | Manager approval | Quarterly |
| **Research Staff** | Research data, analysis tools | Research Lead approval | Quarterly |
| **IT Operations** | Maintenance access, monitoring | IT Manager approval | Quarterly |
| **Administrators** | Privileged system access | Security Administrator approval | Quarterly |
| **External Users** | Limited, specific resources | Sponsor approval | Quarterly |

---

## 📊 **4. Verification & Validation**

### **4.1 Compliance Metrics**

The following metrics are tracked to measure access control effectiveness:

| **Metric** | **Target** | **Measurement Method** | **Current Status** |
|------------|-----------|------------------------|-------------------|
| **Access Review Completion** | 100% quarterly | Entra Governance reports | 100% |
| **MFA Enforcement** | 100% of eligible accounts | Identity Protection reports | 100% |
| **Offboarding Timeliness** | Same business day | Access removal audit | 100% |
| **Privileged Account Usage** | 100% JIT-based | Privileged access logs | 100% |

### **4.2 Validation Procedures**

Regular validation ensures the continued effectiveness of access controls:

| **Validation Activity** | **Frequency** | **Responsible Role** | **Documentation** |
|------------------------|--------------|----------------------|-------------------|
| **Access Control Audit** | Quarterly | Security Administrator | [Access Audit](../../security-monitoring/access-audit.md) |
| **MFA Coverage Review** | Quarterly | Security Administrator | [MFA Audit](../../security-monitoring/mfa-audit.md) |
| **Privilege Usage Analysis** | Quarterly | Security Administrator | [Privilege Audit](../../security-monitoring/privilege-audit.md) |
| **Remote Access Security Assessment** | Quarterly | Security Administrator | [Remote Access Review](../../security-monitoring/remote-access-review.md) |

---

## 🔄 **5. Operational Procedures**

### **5.1 Access Control Procedures**

The following procedures govern access control operations:

| **Procedure** | **Description** | **Documentation** |
|--------------|----------------|-------------------|
| **Access Request Process** | Workflow for requesting and approving access | [Access Request](../../itil-processes/access-management/request-procedure.md) |
| **Privilege Elevation Process** | Just-in-time privileged access | [Privilege Elevation](../../itil-processes/access-management/privilege-elevation.md) |
| **Access Review Process** | Periodic validation of access rights | [Access Review](../../itil-processes/access-management/review-procedure.md) |
| **Access Termination Process** | Removal of access rights | [Access Termination](../../itil-processes/access-management/termination-procedure.md) |

### **5.2 Role Responsibilities**

Clear role assignments ensure accountability for access control:

| **Role** | **Primary Responsibilities** | **Secondary Responsibilities** |
|----------|----------------------------|-------------------------------|
| **Lab Owner** | Access policy approval, exception authorization | Emergency access approval |
| **Security Administrator** | Access review oversight, security monitoring | Access policy development, enforcement |
| **Systems Administrator** | Technical implementation, access provisioning | Access removal, system configuration |
| **Resource Owners** | Access approval for specific resources | Access requirement definitions |

---

## 🚀 **6. Tools & Resources**

The following tools support the implementation of CIS Control 6:

| **Tool** | **Purpose** | **Documentation** |
|----------|------------|-------------------|
| **Entra ID** | Identity management and governance | [Entra Configuration](../../entra-hybrid-cloud/identity-integration/entra-configuration.md) |
| **Entra Private Access** | Zero-trust remote access | [EPA Configuration](../../entra-hybrid-cloud/private-access/epa-configuration/README.md) |
| **Tailscale** | Secure mesh networking with SCIM | [Tailscale Configuration](../../entra-hybrid-cloud/private-access/remote-access/tailscale.md) |
| **GLPI** | Access tracking and lifecycle management | [GLPI Access Management](../../applications/glpi/access-management.md) |
| **Wazuh** | Security monitoring for access events | [Wazuh Access Monitoring](../../security-monitoring/wazuh/access-monitoring.md) |

---

## 🔗 **7. Related Documentation**

| **Document** | **Description** | **Location** |
|--------------|----------------|-------------|
| **Access Control Management Policy** | Comprehensive policy document | [Access Control Policy](cisv81-06-access-control-management-policy.md) |
| **CIS Controls Implementation Guide** | Overall compliance framework | [CIS Implementation](../README.md) |
| **Identity Governance Framework** | Lab's approach to identity management | [Identity Framework](../../entra-hybrid-cloud/identity-integration/README.md) |
| **Zero-Trust Architecture** | Security architecture overview | [Zero-Trust Model](../../entra-hybrid-cloud/private-access/security-policies/zero-trust.md) |
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
| 1.0 | 2025-03-16 | Initial documentation of CIS Control 6 implementation | VintageDon |
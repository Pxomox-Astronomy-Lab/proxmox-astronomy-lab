<!--
---
title: "CIS05 Account Management Directory"
description: "Comprehensive Group Policy Object documentation for CIS Control 5 (Account and Credential Management) implementation, establishing systematic account security policies, password management, and credential protection across Windows Server 2025 Active Directory infrastructure"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)"
date: "2025-07-28"
version: "1.0"
status: "Published"
tags:
- type: directory-overview
- domain: security
- tech: windows-server-2025
- tech: group-policy
- compliance: cis-control-5
- phase: phase-2
related_documents:
- "[Security Assurance Directory](../README.md)"
- "[CIS Control 5 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-05-account-and-credential-management-policy-template.md)"
- "[Domain Infrastructure](../../../infrastructure/README.md)"
---
-->

# 🔐 **CIS05 Account Management Directory**

Comprehensive Group Policy Object documentation for CIS Control 5 (Account and Credential Management) implementation within the Proxmox Astronomy Lab enterprise environment. This directory contains systematic account security policies, password management requirements, and credential protection mechanisms that establish enterprise-grade authentication security across Windows Server 2025 Active Directory infrastructure.

## **Overview**

The CIS05 account management directory provides complete documentation for establishing comprehensive credential security across domain-joined Windows systems. These configurations implement CIS Controls v8 framework requirements for systematic password policy enforcement, account lockout protection, Security Account Manager (SAM) Remote Procedure Call (RPC) security controls, and local account restrictions essential for authentication security and credential attack surface reduction. The implementation follows enterprise security patterns that provide universal baseline controls combined with role-specific hardening for Domain Controllers and member servers.

This account management framework serves as a foundational security component that integrates with Azure AD OIDC authentication, domain infrastructure security, and centralized monitoring to provide comprehensive credential protection and systematic authentication security. The configurations establish enterprise-grade account security baseline that supports both compliance requirements and operational identity management across the astronomical computing infrastructure.

---

## **📂 Directory Contents**

This section provides systematic navigation to all Group Policy Object documentation within the CIS05 account management category.

### **Password Management Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS05-ACCT-COMP-PasswordPolicy-AllDomain-v1.0.md](CIS05-ACCT-COMP-PasswordPolicy-AllDomain-v1.0.md)** | Password complexity, history, length, and age requirements | All Domain Systems |

### **Account Lockout Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS05-ACCT-COMP-AccountLockout-AllDomain-v1.0.md](CIS05-ACCT-COMP-AccountLockout-AllDomain-v1.0.md)** | Account lockout duration, threshold, and reset policies | All Domain Systems |
| **[CIS05-ACCT-COMP-AccountLockout-Servers-v1.0.md](CIS05-ACCT-COMP-AccountLockout-Servers-v1.0.md)** | Administrator account lockout enforcement | Member Servers |

### **SAM RPC Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS05-ACCT-COMP-SAM-RPC-DCs-v1.0.md](CIS05-ACCT-COMP-SAM-RPC-DCs-v1.0.md)** | SAM RPC encryption enforcement for Domain Controllers | Domain Controllers |
| **[CIS05-ACCT-COMP-SAM-RPC-Servers-v1.0.md](CIS05-ACCT-COMP-SAM-RPC-Servers-v1.0.md)** | SAM RPC blocking for Member Servers | Member Servers |

### **Account Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS05-ACCT-COMP-AccountSettings-AllDomain-v1.0.md](CIS05-ACCT-COMP-AccountSettings-AllDomain-v1.0.md)** | Local account security and blank password restrictions | All Domain Systems |

### **Implementation Reference**

| **Document** | **Purpose** | **Link** |
|--------------|-------------|----------|
| **Implementation Log** | Complete deployment validation and configuration evidence | [cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md](cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md) |
| **Configuration Reference** | Technical specifications and control mappings | [cis-server2025-gpos-l1-dc-and-members.md](cis-server2025-gpos-l1-dc-and-members.md) |

---

## **📁 Repository Structure**

```markdown
cis05-account-management/
├── 🔑 CIS05-ACCT-COMP-PasswordPolicy-AllDomain-v1.0.md      # Password requirements
├── 🔒 CIS05-ACCT-COMP-AccountLockout-AllDomain-v1.0.md      # Domain lockout policies
├── 🔒 CIS05-ACCT-COMP-AccountLockout-Servers-v1.0.md        # Server admin lockout
├── 🛡️ CIS05-ACCT-COMP-SAM-RPC-DCs-v1.0.md                  # DC SAM RPC encryption
├── 🚫 CIS05-ACCT-COMP-SAM-RPC-Servers-v1.0.md              # Server SAM RPC blocking
├── ⚙️ CIS05-ACCT-COMP-AccountSettings-AllDomain-v1.0.md     # Account security settings
├── 📋 cis-server2025-gpos-l1-dc-and-members.md             # Technical reference
├── 📝 cis-server2025-gpos-IMPLEMENTATION-LOG.md            # Implementation evidence
└── 📄 README.md                                             # This file
```

### **Navigation Guide:**

- **[🔑 Password Policy](CIS05-ACCT-COMP-PasswordPolicy-AllDomain-v1.0.md)** - Start here for comprehensive password security requirements
- **[🔒 Account Lockout AllDomain](CIS05-ACCT-COMP-AccountLockout-AllDomain-v1.0.md)** - Universal account lockout protection
- **[🛡️ SAM RPC Security](CIS05-ACCT-COMP-SAM-RPC-DCs-v1.0.md)** - Critical credential operation protection
- **[⚙️ Account Settings](CIS05-ACCT-COMP-AccountSettings-AllDomain-v1.0.md)** - Local account security baseline
- **[🔒 Server Specializations](CIS05-ACCT-COMP-AccountLockout-Servers-v1.0.md)** - Role-specific administrator protections
- **[🚫 SAM RPC Hardening](CIS05-ACCT-COMP-SAM-RPC-Servers-v1.0.md)** - Member server credential isolation

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting CIS05 account management to related security domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Security Assurance](../README.md)** | Parent category containing all CIS Controls implementation | [../README.md](../README.md) |
| **[CIS Control 5 Policy](../../policies-and-procedures/cis-security-policy-templates/cisv81-05-account-and-credential-management-policy-template.md)** | Provides policy framework for account and credential management baseline | [cisv81-05-account-and-credential-management-policy-template.md](../../policies-and-procedures/cis-security-policy-templates/cisv81-05-account-and-credential-management-policy-template.md) |
| **[Domain Infrastructure](../../../infrastructure/README.md)** | Provides Windows Active Directory environment for policy deployment | [../../../infrastructure/README.md](../../../infrastructure/README.md) |
| **[CIS06 Access Control](../cis06-access-control-management/README.md)** | Integrates with access control and privilege management policies | [../cis06-access-control-management/README.md](../cis06-access-control-management/README.md) |
| **[CIS08 Audit Management](../cis08-audit-management/README.md)** | Depends on audit infrastructure for account management monitoring | [../cis08-audit-management/README.md](../cis08-audit-management/README.md) |

---

## **Getting Started**

For new users approaching CIS05 account management implementation:

1. **Start Here:** [Password Policy](CIS05-ACCT-COMP-PasswordPolicy-AllDomain-v1.0.md) - Establishes fundamental password security requirements
2. **Background Reading:** [CIS Control 5 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-05-account-and-credential-management-policy-template.md) - Understanding account management requirements
3. **Implementation:** [Account Lockout AllDomain](CIS05-ACCT-COMP-AccountLockout-AllDomain-v1.0.md) - Critical brute force protection
4. **Advanced Topics:** [SAM RPC Security](CIS05-ACCT-COMP-SAM-RPC-DCs-v1.0.md) - Advanced credential operation protection and role-specific configurations

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-28 |
| **Last Updated** | 2025-07-28 |
| **Version** | 1.0 |

---
Tags: security, group-policy, windows-server-2025, account-management, cis-control-5, compliance, credential-protection

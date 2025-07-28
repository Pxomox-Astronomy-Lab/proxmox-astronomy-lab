<!--
---
title: "CIS04 GPO Configuration Directory"
description: "Comprehensive Group Policy Object configurations implementing CIS Control 4 (Secure Configuration of Enterprise Assets and Software) for Windows Server 2025 domain infrastructure with Level 1 baseline hardening across domain controllers and member servers"
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
- compliance: cis-control-4
- phase: phase-2
related_documents:
- "[Security Assurance Directory](../README.md)"
- "[CIS Control 4 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md)"
- "[Domain Infrastructure](../../../infrastructure/README.md)"
---
-->

# 🔧 **CIS04 GPO Configuration Directory**

Comprehensive Group Policy Object (GPO) configurations implementing CIS Control 4 (Secure Configuration of Enterprise Assets and Software) for Windows Server 2025 domain infrastructure within the Proxmox Astronomy Lab enterprise environment. This directory contains systematic security hardening configurations that establish enterprise-grade security baseline through centralized policy management across domain controllers and member servers.

## **Overview**

The CIS04 GPO configuration directory provides complete documentation for establishing comprehensive security baseline hardening across domain-joined Windows systems. These configurations implement CIS Controls v8 framework requirements for systematic security hardening through application security controls, authentication management, system configuration hardening, and network security controls essential for enterprise-grade infrastructure protection. The implementation follows modular Group Policy design patterns that enable granular security control application based on server roles and organizational unit targeting.

This security baseline framework serves as the foundational hardening layer that integrates with domain infrastructure, monitoring systems, and compliance frameworks to provide comprehensive Windows security posture management. The configurations establish enterprise-grade security baseline that supports both regulatory compliance requirements and operational security management across the astronomical computing infrastructure while maintaining system functionality and administrative efficiency.

---

## **📂 Directory Contents**

This section provides systematic navigation to all Group Policy Object documentation within the CIS04 configuration category.

### **Application Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS04-CONF-COMP-AppInstaller-AllDomain-v1.0.md](CIS04-CONF-COMP-AppInstaller-AllDomain-v1.0.md)** | App Installer security and package management controls | All Domain Computers |
| **[CIS04-CONF-COMP-AppRuntime-AllDomain-v1.0.md](CIS04-CONF-COMP-AppRuntime-AllDomain-v1.0.md)** | Application runtime security and execution controls | All Domain Computers |

### **Authentication Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS04-CONF-COMP-UAC-AllDomain-v1.0.md](CIS04-CONF-COMP-UAC-AllDomain-v1.0.md)** | User Account Control security hardening | All Domain Computers |
| **[CIS04-CONF-COMP-LAPS-AllDomain-v1.0.md](CIS04-CONF-COMP-LAPS-AllDomain-v1.0.md)** | Local Administrator Password Solution configuration | All Domain Computers |
| **[CIS04-CONF-COMP-MSA-Logon-Servers-v1.0.md](CIS04-CONF-COMP-MSA-Logon-Servers-v1.0.md)** | Microsoft Account logon restrictions for servers | Member Servers |

### **System Hardening Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS04-CONF-COMP-DeviceInstall-AllDomain-v1.0.md](CIS04-CONF-COMP-DeviceInstall-AllDomain-v1.0.md)** | Device installation and metadata retrieval controls | All Domain Computers |
| **[CIS04-CONF-COMP-DataCollection-AllDomain-v1.0.md](CIS04-CONF-COMP-DataCollection-AllDomain-v1.0.md)** | System data collection and telemetry configuration | All Domain Computers |
| **[CIS04-CONF-COMP-ErrorReporting-AllDomain-v1.0.md](CIS04-CONF-COMP-ErrorReporting-AllDomain-v1.0.md)** | Windows Error Reporting security configuration | All Domain Computers |

### **Network Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS04-CONF-COMP-LSA-AllDomain-v1.0.md](CIS04-CONF-COMP-LSA-AllDomain-v1.0.md)** | Local Security Authority hardening configuration | All Domain Computers |
| **[CIS04-CONF-COMP-Logon-DCs-v1.0.md](CIS04-CONF-COMP-Logon-DCs-v1.0.md)** | Domain Controller logon security controls | Domain Controllers |
| **[CIS04-CONF-COMP-Logon-Servers-v1.0.md](CIS04-CONF-COMP-Logon-Servers-v1.0.md)** | Member server logon security hardening | Member Servers |

### **System Configuration Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS04-CONF-COMP-AutoPlay-AllDomain-v1.0.md](CIS04-CONF-COMP-AutoPlay-AllDomain-v1.0.md)** | AutoPlay and AutoRun security restrictions | All Domain Computers |
| **[CIS04-CONF-COMP-Biometrics-AllDomain-v1.0.md](CIS04-CONF-COMP-Biometrics-AllDomain-v1.0.md)** | Biometric authentication security configuration | All Domain Computers |
| **[CIS04-CONF-COMP-Camera-AllDomain-v1.0.md](CIS04-CONF-COMP-Camera-AllDomain-v1.0.md)** | Camera and privacy security controls | All Domain Computers |
| **[CIS04-CONF-COMP-EarlyLaunch-AllDomain-v1.0.md](CIS04-CONF-COMP-EarlyLaunch-AllDomain-v1.0.md)** | Early Launch Antimalware configuration | All Domain Computers |
| **[CIS04-CONF-COMP-Enumeration-AllDomain-v1.0.md](CIS04-CONF-COMP-Enumeration-AllDomain-v1.0.md)** | System enumeration and discovery restrictions | All Domain Computers |

### **Implementation Reference**

| **Document** | **Purpose** | **Link** |
|--------------|-------------|----------|
| **Implementation Log** | Complete deployment validation and configuration evidence | [cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md](cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md) |
| **Configuration Reference** | Technical specifications and control mappings | [cis-server2025-gpos-l1-dc-and-members.md](cis-server2025-gpos-l1-dc-and-members.md) |

---

## **📁 Repository Structure**

```markdown
cis04-gpo-configuration/
├── 📱 CIS04-CONF-COMP-AppInstaller-AllDomain-v1.0.md       # App security controls
├── 🏃 CIS04-CONF-COMP-AppRuntime-AllDomain-v1.0.md         # Runtime hardening
├── 🛡️ CIS04-CONF-COMP-UAC-AllDomain-v1.0.md                # UAC configuration
├── 🔑 CIS04-CONF-COMP-LAPS-AllDomain-v1.0.md               # LAPS implementation
├── 🚫 CIS04-CONF-COMP-MSA-Logon-Servers-v1.0.md           # MSA restrictions
├── 🔌 CIS04-CONF-COMP-DeviceInstall-AllDomain-v1.0.md      # Device controls
├── 📊 CIS04-CONF-COMP-DataCollection-AllDomain-v1.0.md     # Data collection
├── ⚠️ CIS04-CONF-COMP-ErrorReporting-AllDomain-v1.0.md     # Error reporting
├── 🔒 CIS04-CONF-COMP-LSA-AllDomain-v1.0.md                # LSA hardening
├── 🏛️ CIS04-CONF-COMP-Logon-DCs-v1.0.md                   # DC logon controls
├── 🖥️ CIS04-CONF-COMP-Logon-Servers-v1.0.md               # Server logon
├── ⏸️ CIS04-CONF-COMP-AutoPlay-AllDomain-v1.0.md           # AutoPlay controls
├── 👁️ CIS04-CONF-COMP-Biometrics-AllDomain-v1.0.md        # Biometric security
├── 📷 CIS04-CONF-COMP-Camera-AllDomain-v1.0.md             # Camera controls
├── 🚀 CIS04-CONF-COMP-EarlyLaunch-AllDomain-v1.0.md        # Early Launch AM
├── 🔍 CIS04-CONF-COMP-Enumeration-AllDomain-v1.0.md        # Enumeration limits
├── 📋 cis-server2025-gpos-l1-dc-and-members.md            # Technical reference
├── 📝 cis-server2025-gpos-IMPLEMENTATION-LOG.md           # Implementation evidence
└── 📄 README.md                                            # This file
```

### **Navigation Guide:**

- **[🛡️ UAC Configuration](CIS04-CONF-COMP-UAC-AllDomain-v1.0.md)** - Start here for fundamental authentication hardening
- **[🔑 LAPS Implementation](CIS04-CONF-COMP-LAPS-AllDomain-v1.0.md)** - Essential local administrator security
- **[🔒 LSA Hardening](CIS04-CONF-COMP-LSA-AllDomain-v1.0.md)** - Critical authentication subsystem protection
- **[📱 Application Security](CIS04-CONF-COMP-AppInstaller-AllDomain-v1.0.md)** - Software security baseline
- **[🔌 Device Controls](CIS04-CONF-COMP-DeviceInstall-AllDomain-v1.0.md)** - Hardware security restrictions
- **[🏛️ Role-Specific Controls](CIS04-CONF-COMP-Logon-DCs-v1.0.md)** - Specialized hardening for servers and DCs

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting CIS04 configuration management to related security domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Security Assurance](../README.md)** | Parent category containing all CIS Controls implementation | [../README.md](../README.md) |
| **[CIS Control 4 Policy](../../policies-and-procedures/cis-security-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md)** | Provides policy framework for secure configuration management baseline | [cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md](../../policies-and-procedures/cis-security-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md) |
| **[Domain Infrastructure](../../../infrastructure/README.md)** | Provides Windows Active Directory environment for GPO deployment | [../../../infrastructure/README.md](../../../infrastructure/README.md) |
| **[CIS05 Account Management](../cis05-account-and-credential-management/README.md)** | Integrates with credential and authentication security policies | [../cis05-account-and-credential-management/README.md](../cis05-account-and-credential-management/README.md) |
| **[CIS06 Access Control](../cis06-access-control-management/README.md)** | Coordinates with access control and privilege management | [../cis06-access-control-management/README.md](../cis06-access-control-management/README.md) |

---

## **Getting Started**

For new users approaching CIS04 configuration management implementation:

1. **Start Here:** [UAC Configuration](CIS04-CONF-COMP-UAC-AllDomain-v1.0.md) - Establishes fundamental authentication security hardening
2. **Background Reading:** [CIS Control 4 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md) - Understanding secure configuration requirements
3. **Implementation:** [LAPS Implementation](CIS04-CONF-COMP-LAPS-AllDomain-v1.0.md) - Critical local administrator security deployment
4. **Advanced Topics:** [Implementation Log](cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md) - Complete deployment validation and role-specific configurations

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-28 |
| **Last Updated** | 2025-07-28 |
| **Version** | 1.0 |

---
Tags: security, group-policy, windows-server-2025, secure-configuration, cis-control-4, compliance, system-hardening

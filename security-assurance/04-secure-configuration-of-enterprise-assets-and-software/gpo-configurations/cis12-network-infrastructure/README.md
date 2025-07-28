<!--
---
title: "CIS12 Network Infrastructure Directory"
description: "Comprehensive Group Policy Object documentation for CIS Control 12 (Network Infrastructure Management) implementation, establishing systematic network security controls, protocol hardening, and infrastructure protection across Windows Server 2025 domain environment"
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
- compliance: cis-control-12
- phase: phase-2
related_documents:
- "[Security Assurance Directory](../README.md)"
- "[CIS Control 12 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-12-network-infrastructure-management-policy-template.md)"
- "[Domain Infrastructure](../../../infrastructure/README.md)"
---
-->

# 🌐 **CIS12 Network Infrastructure Directory**

Comprehensive Group Policy Object documentation for CIS Control 12 (Network Infrastructure Management) implementation within the Proxmox Astronomy Lab enterprise environment. This directory contains systematic network security controls, protocol hardening configurations, and infrastructure protection mechanisms that establish enterprise-grade network security across Windows Server 2025 domain infrastructure through standardized Group Policy management.

## **Overview**

The CIS12 network infrastructure directory provides complete documentation for establishing comprehensive network security baseline across domain-joined Windows systems. These configurations implement CIS Controls v8 framework requirements for systematic network protocol hardening, secure communication enforcement, legacy protocol elimination, and network infrastructure protection essential for enterprise network security posture and attack surface reduction. The implementation follows defense-in-depth principles that provide layered network security controls covering SMB security, NetBIOS hardening, remote management protection, and firewall enforcement.

This network infrastructure framework serves as the foundational security layer that integrates with domain infrastructure, security monitoring systems, and network access controls to provide comprehensive network attack prevention and systematic infrastructure protection. The configurations establish enterprise-grade network security baseline that supports both regulatory compliance requirements and operational network security management across the astronomical computing infrastructure while maintaining network functionality and administrative efficiency.

---

## **📂 Directory Contents**

This section provides systematic navigation to all Group Policy Object documentation within the CIS12 network infrastructure category.

### **SMB Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS12-NET-COMP-LanmanServer-AllDomain-v1.0.md](CIS12-NET-COMP-LanmanServer-AllDomain-v1.0.md)** | SMB server security hardening with SMBv1 disable and signature enforcement | All Domain Computers |
| **[CIS12-NET-COMP-LanmanServer-Servers-v1.0.md](CIS12-NET-COMP-LanmanServer-Servers-v1.0.md)** | Server-specific SMB hardening with SPN target name validation | Member Servers |
| **[CIS12-NET-COMP-LanmanWorkstation-AllDomain-v1.0.md](CIS12-NET-COMP-LanmanWorkstation-AllDomain-v1.0.md)** | SMB client security configuration with insecure guest authentication disable | All Domain Computers |
| **[CIS12-NET-COMP-SMBv1-AllDomain-v1.0.md](CIS12-NET-COMP-SMBv1-AllDomain-v1.0.md)** | SMBv1 client driver disable for vulnerability elimination | All Domain Computers |

### **Network Protocol Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS12-NET-COMP-NetBT-AllDomain-v1.0.md](CIS12-NET-COMP-NetBT-AllDomain-v1.0.md)** | NetBIOS over TCP/IP security with P-node configuration and name release prevention | All Domain Computers |
| **[CIS12-NET-COMP-NetConnection-AllDomain-v1.0.md](CIS12-NET-COMP-NetConnection-AllDomain-v1.0.md)** | Network connection controls with bridge prevention and shared access restrictions | All Domain Computers |

### **Remote Management Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS12-NET-COMP-WinRM-Client-AllDomain-v1.0.md](CIS12-NET-COMP-WinRM-Client-AllDomain-v1.0.md)** | WinRM client security with authentication hardening and encryption enforcement | All Domain Computers |
| **[CIS12-NET-COMP-WinRM-Service-AllDomain-v1.0.md](CIS12-NET-COMP-WinRM-Service-AllDomain-v1.0.md)** | WinRM service security with authentication controls and RunAs disable | All Domain Computers |

### **Connection Management Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS12-NET-COMP-WinConnectionMgr-AllDomain-v1.0.md](CIS12-NET-COMP-WinConnectionMgr-AllDomain-v1.0.md)** | Windows Connection Manager security with dual-homing prevention | All Domain Computers |

### **Firewall Security Policies**

| **Document** | **Purpose** | **Target Systems** |
|--------------|-------------|-------------------|
| **[CIS12-NET-COMP-Firewall-AllDomain-v1.0.md](CIS12-NET-COMP-Firewall-AllDomain-v1.0.md)** | Windows Defender Firewall configuration with comprehensive profile enablement | All Domain Computers |

### **Implementation Reference**

| **Document** | **Purpose** | **Link** |
|--------------|-------------|----------|
| **Implementation Log** | Complete deployment validation and configuration evidence | [cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md](cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md) |
| **Configuration Reference** | Technical specifications and control mappings | [cis-server2025-gpos-l1-dc-and-members.md](cis-server2025-gpos-l1-dc-and-members.md) |

---

## **📁 Repository Structure**

```markdown
cis12-network-infrastructure/
├── 🔒 CIS12-NET-COMP-LanmanServer-AllDomain-v1.0.md        # SMB server hardening
├── 🔒 CIS12-NET-COMP-LanmanServer-Servers-v1.0.md          # Server SMB specialization
├── 🔒 CIS12-NET-COMP-LanmanWorkstation-AllDomain-v1.0.md   # SMB client security
├── 🚫 CIS12-NET-COMP-SMBv1-AllDomain-v1.0.md               # SMBv1 elimination
├── 🌐 CIS12-NET-COMP-NetBT-AllDomain-v1.0.md               # NetBIOS security
├── 🔗 CIS12-NET-COMP-NetConnection-AllDomain-v1.0.md       # Connection controls
├── 📡 CIS12-NET-COMP-WinRM-Client-AllDomain-v1.0.md        # WinRM client security
├── 📡 CIS12-NET-COMP-WinRM-Service-AllDomain-v1.0.md       # WinRM service security
├── 🔀 CIS12-NET-COMP-WinConnectionMgr-AllDomain-v1.0.md    # Connection management
├── 🛡️ CIS12-NET-COMP-Firewall-AllDomain-v1.0.md            # Firewall protection
├── 📋 cis-server2025-gpos-l1-dc-and-members.md            # Technical reference
├── 📝 cis-server2025-gpos-IMPLEMENTATION-LOG.md           # Implementation evidence
└── 📄 README.md                                            # This file
```

### **Navigation Guide:**

- **[🔒 SMB Server Security](CIS12-NET-COMP-LanmanServer-AllDomain-v1.0.md)** - Start here for comprehensive SMB protocol hardening
- **[🚫 SMBv1 Elimination](CIS12-NET-COMP-SMBv1-AllDomain-v1.0.md)** - Critical legacy protocol vulnerability mitigation
- **[🌐 NetBIOS Security](CIS12-NET-COMP-NetBT-AllDomain-v1.0.md)** - NetBIOS broadcast attack prevention
- **[📡 WinRM Security](CIS12-NET-COMP-WinRM-Client-AllDomain-v1.0.md)** - Remote management authentication protection
- **[🛡️ Firewall Protection](CIS12-NET-COMP-Firewall-AllDomain-v1.0.md)** - Comprehensive network perimeter defense
- **[🔗 Connection Controls](CIS12-NET-COMP-NetConnection-AllDomain-v1.0.md)** - Network bridging and segmentation protection

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting CIS12 network infrastructure to related security domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Security Assurance](../README.md)** | Parent category containing all CIS Controls implementation | [../README.md](../README.md) |
| **[CIS Control 12 Policy](../../policies-and-procedures/cis-security-policy-templates/cisv81-12-network-infrastructure-management-policy-template.md)** | Provides policy framework for network infrastructure management baseline | [cisv81-12-network-infrastructure-management-policy-template.md](../../policies-and-procedures/cis-security-policy-templates/cisv81-12-network-infrastructure-management-policy-template.md) |
| **[Domain Infrastructure](../../../infrastructure/README.md)** | Provides Windows Active Directory environment for network policy deployment | [../../../infrastructure/README.md](../../../infrastructure/README.md) |
| **[CIS04 Secure Configuration](../cis04-secure-configuration-of-enterprise-assets-and-software/README.md)** | Integrates with system hardening and security configuration policies | [../cis04-secure-configuration-of-enterprise-assets-and-software/README.md](../cis04-secure-configuration-of-enterprise-assets-and-software/README.md) |
| **[CIS08 Audit Management](../cis08-audit-management/README.md)** | Depends on audit infrastructure for network security event monitoring | [../cis08-audit-management/README.md](../cis08-audit-management/README.md) |

---

## **Getting Started**

For new users approaching CIS12 network infrastructure implementation:

1. **Start Here:** [SMB Server Security](CIS12-NET-COMP-LanmanServer-AllDomain-v1.0.md) - Establishes fundamental SMB protocol hardening and vulnerability elimination
2. **Background Reading:** [CIS Control 12 Policy Template](../../policies-and-procedures/cis-security-policy-templates/cisv81-12-network-infrastructure-management-policy-template.md) - Understanding network infrastructure management requirements
3. **Implementation:** [SMBv1 Elimination](CIS12-NET-COMP-SMBv1-AllDomain-v1.0.md) - Critical legacy protocol vulnerability mitigation
4. **Advanced Topics:** [Implementation Log](cis-server2025-gpos-l1-dc-and-members-IMPLEMENTATION-LOG.md) - Complete deployment validation and specialized network configurations

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-28 |
| **Last Updated** | 2025-07-28 |
| **Version** | 1.0 |

---
Tags: security, group-policy, windows-server-2025, network-infrastructure-management, cis-control-12, compliance, network-hardening

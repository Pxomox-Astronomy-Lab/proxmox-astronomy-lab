<!-- 
---
title: "Identity Provider Services - Proxmox Astronomy Lab"
description: "Documentation hub for all identity management services, including Microsoft Entra ID hybrid integration and Windows Active Directory."
author: "VintageDon"
tags: ["identity-provider", "entra-id", "active-directory", "authentication", "sso", "rbac", "directory-services", "mfa"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Entra Private Access", "Microsoft 365", "DNS", "DHCP", "Linux AD Integration"]
implements_policies: ["Identity Management Policy", "Access Control Policy", "Authentication Policy", "Zero Trust Policy"]
phase: "phase-1"
---
-->

# 🔐 **Identity Provider Services**

# 🔍 **1. Overview**

This documentation hub serves as the central reference for all identity provider services in the Proxmox Astronomy Lab. Our identity architecture follows a hybrid model, with Windows Server Active Directory providing on-premises identity services while Microsoft Entra ID extends these capabilities to the cloud. Together, these services create a unified identity foundation that enables secure authentication, role-based access control, and conditional security across both on-premises and cloud resources.

The identity services described here form the foundation for our Zero Trust security model, providing strong authentication, comprehensive identity lifecycle management, and context-based access decisions throughout the environment.

---

# 🏢 **2. Core Identity Services**

## **2.1 Windows Active Directory**

On-premises directory services providing foundational identity management for the infrastructure.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Domain Services** | Core identity store and authentication | [Active Directory Documentation](windows-active-directory/README.md) |
| **Security Groups** | Role-based access control framework | [Security Group Documentation](windows-active-directory/security-groups.md) |
| **Group Policy** | Centralized policy management | [Group Policy Documentation](windows-active-directory/group-policy.md) |
| **Linux Integration** | AD authentication for Linux systems | [Linux AD Integration](windows-active-directory/linux-integration.md) |

## **2.2 Microsoft Entra ID Hybrid**

Cloud identity services that extend on-premises directory and enable advanced security features.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Tenant Configuration** | Core cloud identity settings | [Entra ID Documentation](microsoft-entra-id-hybrid-service/README.md) |
| **Conditional Access** | Context-based security policies | [Conditional Access Policies](microsoft-entra-id-hybrid-service/conditional-access.md) |
| **Identity Protection** | Risk detection and mitigation | [Identity Protection](microsoft-entra-id-hybrid-service/identity-protection.md) |
| **Hybrid Identity** | AD Connect configuration | [Hybrid Identity Setup](microsoft-entra-id-hybrid-service/hybrid-identity.md) |

---

# 🔒 **3. Identity Security and Governance**

## **3.1 Authentication Methods**

Our identity services support multiple authentication methods with an emphasis on strong, phishing-resistant options.

| **Method** | **Use Cases** | **Documentation** |
|------------|--------------|-------------------|
| **Password + MFA** | Standard user authentication | [MFA Configuration](microsoft-entra-id-hybrid-service/mfa-setup.md) |
| **Windows Hello for Business** | Passwordless on Windows devices | [WHfB Implementation](microsoft-entra-id-hybrid-service/windows-hello.md) |
| **FIDO2 Security Keys** | Phishing-resistant authentication | [FIDO2 Configuration](microsoft-entra-id-hybrid-service/fido2-keys.md) |
| **Certificate-Based Auth** | Device authentication | [Certificate Authentication](microsoft-entra-id-hybrid-service/certificate-auth.md) |

## **3.2 Identity Governance**

Processes and tools for managing identities throughout their lifecycle.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Access Reviews** | Periodic privilege verification | [Access Review Process](microsoft-entra-id-hybrid-service/access-reviews.md) |
| **Entitlement Management** | Access package management | [Entitlement Management](microsoft-entra-id-hybrid-service/entitlement-management.md) |
| **PIM** | Just-in-time privileged access | [Privileged Identity Management](microsoft-entra-id-hybrid-service/pim.md) |
| **Lifecycle Workflows** | Automated provisioning/deprovisioning | [Identity Lifecycle](microsoft-entra-id-hybrid-service/lifecycle-workflows.md) |

---

# 🔗 **4. Core Integration Points**

## **4.1 Service Integrations**

Identity services integrate with multiple other infrastructure components.

| **Integration** | **Purpose** | **Documentation** |
|---------------|-----------|-------------------|
| **Entra Private Access** | Zero Trust Network Access | [EPA Integration](../remote-access/entra-private-access.md) |
| **Microsoft 365** | Productivity suite authentication | [M365 Identity Integration](microsoft-entra-id-hybrid-service/m365-integration.md) |
| **Kasm Workspaces** | Browser-based workspace authentication | [Kasm Authentication](../remote-access/kasm-identity-integration.md) |
| **RDS** | Remote Desktop authentication | [RDS Identity Configuration](../remote-access/rds-identity.md) |

## **4.2 Application Authentication**

Methods for securing application access through identity services.

| **Method** | **Use Cases** | **Documentation** |
|------------|--------------|-------------------|
| **SAML** | Enterprise application integration | [SAML Configuration](microsoft-entra-id-hybrid-service/saml-apps.md) |
| **OAuth/OIDC** | Modern application authentication | [OAuth Implementation](microsoft-entra-id-hybrid-service/oauth-oidc.md) |
| **Application Proxy** | Legacy application publishing | [App Proxy Setup](microsoft-entra-id-hybrid-service/app-proxy.md) |
| **Zitadel Integration** | Extended identity coverage | [Zitadel Configuration](microsoft-entra-id-hybrid-service/zitadel.md) |

---

# 🗂️ **5. Security & Compliance**

## **5.1 Security Controls**

Identity-specific security controls implemented in the environment.

| **Control** | **Implementation** | **Documentation** |
|------------|-------------------|-------------------|
| **Multi-Factor Authentication** | Required for all users | [MFA Policy](microsoft-entra-id-hybrid-service/mfa-policy.md) |
| **Conditional Access** | Context-based authentication | [CA Policies](microsoft-entra-id-hybrid-service/conditional-access.md) |
| **Risk-Based Authentication** | Identity Protection integration | [Risk Policies](microsoft-entra-id-hybrid-service/risk-policies.md) |
| **Privileged Access** | Just-in-time, time-limited | [Privileged Access](microsoft-entra-id-hybrid-service/privileged-access.md) |

## **5.2 Compliance Mapping**

Identity services support several compliance frameworks.

| **Framework** | **Controls Addressed** | **Documentation** |
|--------------|------------------------|-------------------|
| **CIS Controls** | 5.1, 5.2, 6.1-6.5, 16.1 | [CIS Compliance](./compliance/cis-identity-controls.md) |
| **ISO 27001** | A.9.2.1 - A.9.2.6 | [ISO Compliance](./compliance/iso27001-identity-controls.md) |
| **NIST 800-53** | AC-1, AC-2, AC-3, AC-6, IA-2, IA-4, IA-5 | [NIST Compliance](./compliance/nist-identity-controls.md) |

---

# 🔍 **6. Directory Contents**

This section provides direct navigation to all subdirectories and key documents:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **microsoft-entra-id-hybrid-service** | Cloud identity documentation | [Entra ID Documentation](microsoft-entra-id-hybrid-service/README.md) |
| **windows-active-directory** | On-premises directory documentation | [AD Documentation](windows-active-directory/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Hybrid Identity Architecture** | Overall identity design | [Architecture Overview](hybrid-identity-architecture.md) |
| **Security Group Reference** | RBAC implementation | [Security Groups](windows-active-directory/security-groups.md) |
| **Conditional Access Reference** | Security policy implementation | [CA Policies](microsoft-entra-id-hybrid-service/conditional-access.md) |
| **Identity Operations Guide** | Day-to-day management | [Operations Guide](identity-operations.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Security Services** | Leverages identity for access control | [Security Documentation](/docs/Security/README.md) |
| **Remote Access** | Authenticates through identity services | [Remote Access Documentation](/docs/Remote-Access/README.md) |
| **Infrastructure** | Hosts identity components | [Infrastructure Documentation](/docs/Infrastructure/README.md) |
| **Compliance** | Implements controls through identity | [Compliance Documentation](/docs/Compliance/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

<!-- 
---
title: "Entra Hybrid Cloud - Proxmox Astronomy Lab"
description: "Overview of the Entra ID and Azure integration with on-premises infrastructure for secure, seamless hybrid identity management"
author: "VintageDon"
tags: ["entra", "azure", "hybrid-identity", "security", "conditional-access", "azure-arc", "epa"]
category: "Identity & Access"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔐 **Entra Hybrid Cloud**

## 🔍 **1. Overview**

The **Entra Hybrid Cloud** integration within the Proxmox Astronomy Lab extends Azure's control plane to **on-premises infrastructure**, ensuring a **secure, seamless, and manageable hybrid identity environment**. This approach enables **full asset visibility, conditional access enforcement, and deep security integrations** across both cloud and on-prem resources.

The focus is on **practical hybrid identity and security**, leveraging **Azure Arc, Entra ID, and secure external access via Tailscale and Entra Private Access (EPA)**. This documentation explains how these cloud services integrate with and enhance our lab's on-premises infrastructure.

---

## 🏢 **2. Hybrid Identity Architecture**

### **2.1 Core Identity Domains & Licensing**

The lab operates under a structured identity framework, leveraging a hybrid identity model.

| **Domain** | **Description** | **Documentation** |
|-----------|----------------|-------------------|
| **Primary Domain** | `beardinthe.cloud` | [Domain Configuration](identity-integration/domain-configuration.md) |
| **Secondary Domain** | `radioastronomy.io` | [Domain Configuration](identity-integration/domain-configuration.md) |
| **License Level** | Business Premium, P1 + P2 + Entra Suite | [Licensing Details](identity-integration/licensing.md) |

### **2.2 Hybrid AD Synchronization & Management**

Identity synchronization extends across both on-prem and cloud environments, enforcing secure authentication and access control.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **On-Prem AD (DC01/DC02 - Server 2025)** | Core Active Directory domain controllers | [AD Configuration](../control-plane/services/domain-controllers/README.md) |
| **AD Connect Sync** | Synchronizes on-prem identities to Entra ID | [AD Connect Setup](identity-integration/ad-connect-sync.md) |
| **SSPR, Seamless SSO, Password Hash Sync** | Enables full hybrid identity experience | [Hybrid Identity Features](identity-integration/hybrid-identity-features.md) |
| **Security Groups → Entra Groups Mapping** | Ensures consistent role-based access | [Group Mappings](identity-integration/group-mappings/README.md) |
| **Ubuntu VMs AD-Joined** | Linux systems authenticated via Active Directory | [Linux AD Integration](identity-integration/linux-ad-integration.md) |

This integration allows on-prem systems **to be controlled via Entra ID-based security policies**, ensuring role-based access governance across all managed resources.

---

## 🌐 **3. Extending Azure Control Plane to On-Prem**

### **3.1 Azure Arc - 100% Asset Coverage**

Azure Arc is leveraged to ensure unified governance and policy enforcement across all infrastructure components.

| **Asset Type** | **Azure Arc Coverage** | **Documentation** |
|--------------|-------------------|--------------------|
| **Proxmox Nodes** | Fully onboarded to Azure Arc | [Proxmox Arc Integration](azure-services/arc-integration/proxmox-arc-integration.md) |
| **VMs (Linux & Windows)** | 100% onboarded to Azure Arc | [VM Arc Integration](azure-services/arc-integration/vm-arc-integration.md) |
| **On-Prem Windows Shares** | Planned integration, currently mapping | [Planned Arc Expansions](azure-services/arc-integration/planned-expansions.md) |

This extends capabilities like **policy compliance, audit logging, and monitoring** to on-prem infrastructure using free-tier Azure services.

### **3.2 Azure Services Integration**

| **Azure Service** | **Integration Purpose** | **Documentation** |
|-------------------|------------------------|--------------------|
| **Azure Monitor** | Centralized monitoring and alerting | [Azure Monitoring](azure-services/monitoring-integration.md) |
| **Azure Policy** | Governance and compliance enforcement | [Azure Policy](azure-services/policy-integration.md) |
| **Azure Defender for Cloud** | Security posture management | [Defender Integration](azure-services/defender-integration.md) |

---

## 🛡️ **4. Secure Remote Access Strategy**

### **4.1 Hybrid Access Solution**

The lab implements a **dual-layer approach** to secure remote access, combining **Entra Private Access (EPA)** for privileged operations and **Tailscale** for broader connectivity, both governed by Entra ID.

| **Solution** | **Use Case** | **Documentation** |
|--------------|-------------|--------------------|
| **Entra Private Access (EPA)** | Limited privileged access via Entra-joined devices | [EPA Configuration](private-access/epa-configuration/README.md) |
| **Tailscale with Entra SCIM** | Primary remote access method integrated with Entra ID | [Tailscale Integration](private-access/remote-access/tailscale.md) |
| **Entra Conditional Access** | Governs all authentication regardless of entry point | [Access Policies](identity-integration/conditional-access/README.md) |

### **4.2 Access Implementation**

Remote access is structured to ensure Entra ID remains the authentication authority without exposing public endpoints:

| **Component** | **Function** | **Documentation** |
|---------------|------------|--------------------|
| **N150 Mini PCs** | Entra-joined thin clients for EPA access to RDS01 or Kasm | [Thin Client Setup](private-access/epa-configuration/thin-clients.md) |
| **Tailscale ACLs** | Granular access control governed by Entra groups | [ACL Configuration](private-access/remote-access/tailscale-acls.md) |
| **Entra SCIM Integration** | Automatic user/group provisioning to Tailscale | [SCIM Configuration](private-access/remote-access/scim-integration.md) |
| **Zero Public Ports** | No direct internet-exposed services | [Zero Trust Architecture](private-access/security-policies/zero-trust.md) |

This implementation places **Entra ID authentication in front of all access paths**, ensuring consistent policy enforcement while maintaining flexibility for different access requirements.

---

## 🔒 **5. Conditional Access Policies**

Conditional access policies are the backbone of identity security in the lab. These policies enforce **strict authentication requirements** and **risk-based security measures**.

| **Policy Name** | **Purpose** | **Documentation** |
|---------------|------------|-------------------|
| **Baseline Access Geofencing** | Restricts access to U.S. locations only | [Geofencing Policy](identity-integration/conditional-access/geofencing.md) |
| **Baseline Block Legacy Authentication** | Prevents outdated authentication methods | [Legacy Auth Blocking](identity-integration/conditional-access/legacy-auth.md) |
| **Baseline MFA Requirement** | Enforces passwordless MFA for all logins | [MFA Policies](identity-integration/mfa-policies/README.md) |
| **Baseline Risk-Based Sign-In** | Requires MFA for high-risk sign-ins | [Risk-Based Policies](identity-integration/conditional-access/risk-based.md) |
| **Baseline Device Join & Registration** | MFA for device registration | [Device Management](identity-integration/conditional-access/device-mgmt.md) |
| **Baseline Security Info MFA** | MFA for security setting changes | [Security Settings](identity-integration/conditional-access/security-info.md) |

These policies collectively **prevent unauthorized access**, enforce **phishing-resistant authentication**, and ensure **only compliant devices and users can access resources**.

---

## 🔄 **6. Extending Entra ID to Non-Native Applications**

### **6.1 Zitadel - Entra Integration for GUI & Legacy Apps**

| **Component** | **Function** | **Documentation** |
|--------------|-------------|--------------------|
| **Zitadel Identity Provider** | OIDC/OAuth integration with Entra | [Zitadel Setup](identity-integration/zitadel-integration.md) |
| **Local Application Integration** | Authentication for internal applications | [App Registration](identity-integration/app-registration.md) |
| **Legacy App Support** | Authentication for applications without modern auth | [Legacy App Integration](identity-integration/legacy-integration.md) |

This allows **Entra-based authentication across all core applications** without unnecessary public exposure.

---

## 💻 **7. On-Prem VDI/RDS Deployment**

### **7.1 Windows RDS with Licensed Office Access**

The lab deploys **Windows Server 2025 RDS** as a Virtual Desktop Infrastructure (VDI) solution with built-in licensing support.

| **Component** | **Purpose** | **Documentation** |
|-------------|------------|-------------------|
| **RDS01** | Windows Server 2025 RDS host | [RDS Configuration](private-access/remote-access/rds-configuration.md) |
| **Office 2024 Pro LTSC** | Licensed productivity suite | [Office Deployment](private-access/remote-access/office-deployment.md) |
| **VDI Session Management** | Secure authentication via EPA | [Session Management](private-access/remote-access/session-management.md) |

This setup allows for **secure, compliant remote access** while ensuring **external users do not require additional licensing.**

---

## 🔑 **8. Storage, Vaults, and Cost Optimization**

### **8.1 Azure Key Vault & HashiCorp Vault Integration**

| **Component** | **Function** | **Documentation** |
|--------------|-------------|--------------------|
| **Azure Key Vault** | Cloud-based secrets management | [Key Vault Setup](azure-services/key-vault/setup.md) |
| **HashiCorp Vault** | On-premises secrets management | [Vault Integration](azure-services/key-vault/hashicorp-integration.md) |
| **Backup Strategy** | Azure Blob Storage backups | [Vault Backups](azure-services/storage-services/vault-backups.md) |

### **8.2 Azure Container Registry**

| **Feature** | **Purpose** | **Documentation** |
|------------|------------|-------------------|
| **ACR Integration** | Centralized container repository | [ACR Setup](azure-services/container-registry.md) |
| **RKE2 Integration** | Kubernetes image deployment | [K8s Registry Integration](../infrastructure/compute/kubernetes/deployments/registry-integration.md) |

---

## 🔗 **9. Related Documentation**

| **Section** | **Description** | **Link** |
|------------|----------------|---------|
| **Control Plane** | Core infrastructure services | [Control Plane Documentation](../control-plane/README.md) |
| **Security & Compliance** | Security frameworks and controls | [Security Documentation](../compliance-security/README.md) |
| **Infrastructure** | On-premises infrastructure | [Infrastructure Documentation](../infrastructure/README.md) |
| **Kubernetes** | Container orchestration platform | [Kubernetes Documentation](../infrastructure/compute/kubernetes/README.md) |

---

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Standardized Entra Hybrid Cloud README | VintageDon |

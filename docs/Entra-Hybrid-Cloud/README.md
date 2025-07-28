<!-- 
---
title: "Entra Hybrid Cloud Integration"
description: "Documentation for the Microsoft Entra Hybrid Cloud integration in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["azure", "entra", "hybrid-cloud", "identity", "zero-trust", "epa", "arc"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔐 **Entra Hybrid Cloud Integration**

# 🔍 **1. Overview**

The Entra Hybrid Cloud integration extends Microsoft Azure's control plane to our on-premises Proxmox infrastructure, creating a unified identity and security framework. This approach enables consistent access controls, advanced security policies, and comprehensive governance across our research environment without requiring full cloud migration of workloads.

Our implementation focuses on practical hybrid identity management, leveraging Entra ID (formerly Azure AD), Azure Arc, and Entra Private Access to create a seamless, secure environment that balances the benefits of cloud governance with the performance of on-premises computing resources for our research workloads.

---

# 🌐 **2. Hybrid Identity Architecture**

## **2.1 Core Identity Framework**

The hybrid identity system forms the foundation of our security architecture, bridging on-premises Active Directory with cloud-based Entra ID.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **AD Connect Sync** | Synchronizes on-premises identities to Entra ID | [AD Sync Configuration](/entra-hybrid-cloud/conditional-access-policies/README.md) |
| **SSPR & Seamless SSO** | Enables password resets and seamless sign-on | [SSO Configuration](/entra-hybrid-cloud/conditional-access-policies/baseline-mfa-require-globally.md) |
| **Security Group Mappings** | Maps on-prem groups to Entra groups | [Group Mappings](/entra-hybrid-cloud/conditional-access-policies/README.md) |

## **2.2 Zero Trust Implementation**

Our security model implements zero trust principles through Entra ID's conditional access capabilities.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Geofencing Policies** | Restricts access to U.S. locations | [Geofencing Policy](/entra-hybrid-cloud/private/baseline-access-geofencing-private.md) |
| **Legacy Auth Blocking** | Prevents insecure authentication methods | [Legacy Auth Policy](/entra-hybrid-cloud/private/baseline-block-legacy-auth.md) |
| **MFA Enforcement** | Requires multi-factor authentication | [MFA Policy](/entra-hybrid-cloud/private/baseline-mfa-require-globally.md) |
| **Risk-Based Policies** | Adapts security based on sign-in risk | [Risk Policies](/entra-hybrid-cloud/private/baseline-mfa-risky-signins.md) |

---

# 🔄 **3. Azure Arc Integration**

## **3.1 Resource Management**

Azure Arc extends Azure's management capabilities to our on-premises resources, enabling consistent governance.

| **Resource Type** | **Arc Implementation** | **Documentation** |
|-------------------|----------------------|-------------------|
| **Proxmox Nodes** | Fully onboarded to Azure Arc | [Node Arc Configuration](/entra-hybrid-cloud/azure-arc/README.md) |
| **Virtual Machines** | All VMs managed through Arc | [VM Arc Management](/entra-hybrid-cloud/azure-arc/README.md) |
| **Kubernetes Clusters** | RKE2 integrated with Arc | [K8s Arc Integration](/entra-hybrid-cloud/azure-arc/README.md) |

## **3.2 Compliance & Monitoring**

Azure Arc enables centralized compliance management and monitoring for all infrastructure components.

| **Capability** | **Implementation** | **Documentation** |
|----------------|-------------------|-------------------|
| **Policy Compliance** | CIS compliance assessment | [Arc Policies](/entra-hybrid-cloud/azure-arc/README.md) |
| **Log Analytics** | Centralized logging | [Arc Monitoring](/entra-hybrid-cloud/azure-arc/README.md) |
| **Security Center** | Threat detection | [Arc Security](/entra-hybrid-cloud/azure-arc/README.md) |

---

# 🚪 **4. Secure Access Framework**

## **4.1 Entra Private Access (EPA)**

EPA serves as our exclusive method for secure remote access, replacing traditional VPN solutions.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **EPA Configuration** | Secures remote connections | [EPA Setup](/entra-hybrid-cloud/private/README.md) |
| **Access Controls** | Role-based access to lab resources | [EPA Policies](/entra-hybrid-cloud/private/README.md) |
| **Kasm Workspaces Gateway** | Browser-based secure access | [Kasm Integration](/entra-hybrid-cloud/private/README.md) |

## **4.2 Remote Desktop Services**

Our Windows RDS deployment provides secure access to desktop environments through EPA.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **RDS01 Server** | Windows Server 2025 RDS host | [RDS Configuration](/entra-hybrid-cloud/private/README.md) |
| **Office Integration** | Licensed Office access | [Office Deployment](/entra-hybrid-cloud/private/README.md) |
| **Entra Authentication** | Secure access to VDI sessions | [RDS Authentication](/entra-hybrid-cloud/private/README.md) |

---

# 🔑 **5. Service Integrations**

## **5.1 Key Management Services**

Secure credential and secret management through integrated vault services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Azure Key Vault** | Cloud-based secret storage | [Key Vault Setup](/entra-hybrid-cloud/key-vaults/azure-key-vault-keyvault01.md) |
| **HashiCorp Vault** | On-premises secret management | [Vault Integration](/entra-hybrid-cloud/key-vaults/README.md) |
| **Certificate Management** | Automated certificate deployment | [Certificate Management](/entra-hybrid-cloud/key-vaults/README.md) |

## **5.2 Storage Services**

Cloud storage integration for backups and container images.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Azure Blob Storage** | Backup repository | [Blob Storage Configuration](/entra-hybrid-cloud/storage-services/azure-blob-keyvault01-backups.md) |
| **Azure Container Registry** | Container image repository | [ACR Integration](/entra-hybrid-cloud/storage-services/README.md) |
| **Storage Account Management** | Access control and lifecycle | [Storage Management](/entra-hybrid-cloud/storage-services/README.md) |

---

# 🗂️ **6. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **azure-arc** | Azure Arc integration documentation | [Azure Arc](/entra-hybrid-cloud/azure-arc/README.md) |
| **conditional-access-policies** | Entra conditional access configurations | [Conditional Access](/entra-hybrid-cloud/conditional-access-policies/README.md) |
| **key-vaults** | Azure Key Vault implementation | [Key Vaults](/entra-hybrid-cloud/key-vaults/README.md) |
| **private** | Entra Private Access configuration | [Private Access](/entra-hybrid-cloud/private/README.md) |
| **storage-services** | Azure storage integration | [Storage Services](/entra-hybrid-cloud/storage-services/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Azure Tagging Strategy** | Resource tagging standards | [Tagging Strategy](/entra-hybrid-cloud/azure-tagging-strategy.md) |
| **Key Vault Configuration** | Primary key vault setup | [Key Vault Configuration](/entra-hybrid-cloud/key-vaults/azure-key-vault-keyvault01.md) |
| **Blob Storage Configuration** | Backup storage setup | [Blob Storage](/entra-hybrid-cloud/storage-services/azure-blob-keyvault01-backups.md) |
| **MFA Policy** | Global MFA enforcement | [MFA Configuration](/entra-hybrid-cloud/private/baseline-mfa-require-globally.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Security & Compliance** | Security policy implementation | [Security Documentation](/docs/Compliance-Security/README.md) |
| **Identity Management** | Authentication and authorization | [Identity Management](/docs/Control-Plane/Identity-Management/README.md) |
| **Infrastructure** | Underlying hardware and virtualization | [Infrastructure](/infrastructure/README.md) |
| **Control Plane** | Core administrative services | [Control Plane](/docs/Control-Plane/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |

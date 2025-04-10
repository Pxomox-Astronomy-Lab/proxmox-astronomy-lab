You're right - I apologize for overlooking key elements from the template. Let me create a proper README following the readme-category-template.md style guide, including the front matter block.

<!-- 
---
title: "Key Vaults - Entra Hybrid Cloud"
description: "Documentation for the Key Vault services used in the Proxmox Astronomy Lab's hybrid cloud implementation"
author: "VintageDon"
tags: ["key-vault", "secrets-management", "azure", "security", "entra"]
kb_type: "Reference"
version: "1.0"
status: "Active"
last_updated: "2025-02-23"
---
-->

# 🔑 **Key Vaults**

# 🔍 **1. Overview**

The **Key Vaults** section of the **Entra Hybrid Cloud** documentation provides details on the **secrets management and encryption key storage** solutions used within the lab infrastructure. These key vaults ensure **secure storage, access control, and automated unlocking** for critical lab services.

This documentation covers the **Azure Key Vault (`azure-lab-keyvault01`)**, which serves as the **primary cloud-based secrets management solution** for auto-unlocking on-prem services, specifically **HashiCorp Vault**.

---

# 🛡️ **2. Key Vaults in the Lab**

## **2.1 Referenced Key Vaults**

The lab relies on **Azure Key Vault** to store and manage **sensitive credentials, encryption keys, and API secrets** while enforcing **RBAC-based access control**.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Azure Key Vault (`azure-lab-keyvault01`)** | Primary cloud key vault for **secure storage and automated unlocking of on-prem HashiCorp Vault** | [Azure Key Vault](azure-key-vault-keyvault01.md) |

## **2.2 Purpose & Role**

These key vault services fulfill critical security functions in our hybrid environment.

| **Function** | **Description** | **Documentation** |
|--------------|----------------|-------------------|
| **Auto-Unlock Services** | Stores **encrypted unseal keys** required for **automated unlocking of on-prem HashiCorp Vault** | [Auto-Unseal Process](azure-key-vault-keyvault01.md) |
| **Secret & Key Management** | Secures **sensitive credentials, encryption keys, and API secrets** for lab services | [Secret Management](azure-key-vault-keyvault01.md) |
| **Access Control & Auditing** | Implements **Azure Role-Based Access Control (RBAC)** to restrict and monitor access | [Access Controls](azure-key-vault-keyvault01.md) |
| **Backup & Redundancy** | Works alongside **Azure Blob Storage (`backupskyvault01`)** to ensure key backup and disaster recovery | [Backup Configuration](../storage-services/azure-blob-keyvault01-backups.md) |

---

# 🔒 **3. Security & Compliance Considerations**

Key security considerations for vault services in our environment.

| **Control** | **Implementation** | **Documentation** |
|------------|-------------------|-------------------|
| **Access Control** | All access is enforced using **Entra ID RBAC policies** | [RBAC Implementation](azure-key-vault-keyvault01.md) |
| **Key Rotation** | Keys must be rotated per **security best practices** | [Rotation Schedule](azure-key-vault-keyvault01.md) |
| **Logging & Monitoring** | All access attempts are logged for **audit and compliance tracking** | [Audit Configuration](azure-key-vault-keyvault01.md) |

---

# 🔗 **4. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Azure Key Vault (`azure-lab-keyvault01`)** | Primary cloud key vault documentation | [Azure Key Vault](azure-key-vault-keyvault01.md) |
| **Azure Blob Storage - Backup Key Vault** | Backup storage for vault content | [Backup Storage](../storage-services/azure-blob-keyvault01-backups.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Entra Hybrid Cloud** | Parent category for all Azure services | [Entra Hybrid Cloud](../README.md) |
| **Storage Services** | Provides backup storage for vault content | [Storage Services](../storage-services/README.md) |
| **Conditional Access** | Controls access to vault resources | [Conditional Access](../conditional-access-policies/README.md) |
| **Security Services** | Security architecture integration | [Security Services](../../docs/Control-Plane/Services/Security-Services/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-02-23 | Approved |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-02-23 | Initial version | VintageDon |

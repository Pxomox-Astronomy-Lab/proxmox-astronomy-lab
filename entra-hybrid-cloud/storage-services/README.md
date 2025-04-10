<!-- 
---
title: "Storage Services in Entra Hybrid Cloud"
description: "Documentation of cloud-based storage solutions supporting backup, data retention, and secure storage for the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["storage", "azure", "cloud", "backup", "blob-storage", "entra"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Key Vault", "Proxmox Backup", "Vault"]
implements_policies: ["Data Protection Policy", "Backup Policy"]
phase: "phase-3"
---
-->

# 🗄️ **Storage Services in Entra Hybrid Cloud**

# 🔍 **1. Overview**

This section documents the cloud-based storage solutions within our Entra Hybrid Cloud architecture that support backup, data retention, and secure storage capabilities for the Proxmox Astronomy Lab. These storage services provide critical functionality for maintaining data integrity, supporting disaster recovery operations, and enabling effective hybrid cloud integration across both on-premises and cloud environments.

Currently, our primary focus is on Azure Blob Storage (`backupskyvault01`), which serves as a secure repository for encrypted backups and auto-unseal keys for our on-premises HashiCorp Vault deployment.

---

# 🔐 **2. Primary Storage Services**

## **2.1 Backup and Security Storage**

This component group provides specialized storage for security-sensitive backup data and cryptographic materials.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Azure Blob Storage (`backupskyvault01`)** | Securely stores encrypted HashiCorp Vault unseal keys and critical backup data | [Azure Blob - Key Vault Backups](./azure-blob-keyvault01-backups.md) |
| **Azure Key Vault Integration** | Manages encryption keys and secrets for blob storage access | [Azure Key Vault Configuration](../key-vaults/azure-key-vault-keyvault01.md) |

---

# 🛣️ **3. Implementation Roadmap**

## **3.1 Future Storage Services**

The storage service portfolio will be expanded in upcoming phases to better support research and operational needs.

| **Planned Service** | **Intended Function** | **Implementation Timeline** |
|--------------------|----------------------|---------------------------|
| **General-purpose Blob Storage** | Store non-sensitive research artifacts and datasets | Phase 4 |
| **S3-compatible Object Storage** | Provide standardized interfaces for research applications | Phase 4 |
| **Cold/Archive Storage** | Long-term retention of completed research data | Phase 4 |

---

# 🔗 **4. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Azure Blob Storage (`backupskyvault01`)** | Configuration and operational details for Vault backup storage | [Azure Blob Storage](./azure-blob-keyvault01-backups.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Azure Key Vaults** | Provides encryption services for blob storage | [Key Vaults](../key-vaults/README.md) |
| **Infrastructure Storage** | On-premises storage that synchronizes with cloud storage | [Infrastructure Storage](/infrastructure/storage/README.md) |
| **Security & Compliance** | Governance requirements for data storage | [Security Policies](/docs/Compliance-Security/Security-Policies/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial structured README | VintageDon |

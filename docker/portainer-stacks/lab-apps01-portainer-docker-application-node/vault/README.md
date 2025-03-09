# **Vault Service - Secrets Management & Auto-Unlock**

## **1. Service Overview**

HashiCorp Vault is a **self-hosted secrets management solution** designed to **securely store and control access to sensitive credentials, encryption keys, and API secrets**. The **Vault service** is deployed within the **Proxmox Astronomy Lab** to provide **centralized, secure secrets storage** for lab infrastructure, applications, and automation workflows.

Vault operates in **high-availability mode**, leveraging an **auto-unlock mechanism** that integrates with **Azure Key Vault and Azure Blob Storage** for enhanced security and recoverability.

## **2. Purpose & Scope**

This service is responsible for **securely managing secrets and automating access control** in the lab. It provides:

- **Secrets Management:** Secure storage for **API keys, database credentials, encryption keys, and sensitive configurations**.
- **Auto-Unlock Mechanism:** Vault **automatically unseals** upon startup using keys stored in **Azure Key Vault (`azure-lab-keyvault01`)**.
- **High Availability & Disaster Recovery:** Backup and redundancy through **Azure Blob Storage (`backupskyvault01`)**.
- **Policy-Driven Access Control:** Implements **RBAC policies, audit logging, and granular access controls**.
- **Encryption-as-a-Service:** Enables applications to **encrypt and decrypt data** without exposing raw keys.

## **3. Service Architecture**

### **3.1. Vault Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Vault Deployment Mode**       | Self-hosted                     |
| **Storage Backend**             | Integrated Storage (RAFT)       |
| **Unseal Mechanism**            | Auto-unseal via Azure Key Vault |
| **Backup Storage**              | Azure Blob Storage (`backupskyvault01`) |
| **Access Control**              | RBAC via Entra ID               |
| **Audit Logging**               | Enabled                         |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Vault Service           |
|--------------------------------|---------------------------------|
| **[Azure Key Vault (`azure-lab-keyvault01`)](../key-vaults/azure-key-vault-keyvault01.md)** | Stores encrypted unseal keys for auto-unlock |
| **[Azure Blob Storage (`backupskyvault01`)](../storage-services/azure-blob-keyvault01-backups.md)** | Provides redundant key backups & disaster recovery |

## **4. Auto-Unlock Mechanism**

Vault **requires an unseal process** before it can be accessed. Instead of manually entering unseal keys, **Azure Key Vault (`azure-lab-keyvault01`)** is used to store **encrypted unseal keys** securely.

### **How Auto-Unlock Works:**

1. **Vault Starts Up** – The service initializes in a **sealed state**.
2. **Retrieves Unseal Keys** – Vault queries **Azure Key Vault** via API to access **encrypted unseal keys**.
3. **Unlocks Itself** – The retrieved keys **automatically unseal Vault**, making it operational.
4. **Backup Sync** – A copy of the keys is **securely stored in Azure Blob Storage (`backupskyvault01`)** for redundancy.

## **5. Security & Compliance Considerations**

- **RBAC policies strictly enforce access** to unseal keys and secrets.
- **Access logs are monitored** to detect unauthorized secret access attempts.
- **Keys are rotated periodically** to comply with security best practices.
- **All secrets are encrypted at rest and in transit.**

## **6. Change Management**

All modifications to this service (including access policies, key rotation, and storage configurations) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **7. Related Documentation**

- [Azure Key Vault (`azure-lab-keyvault01`)](../key-vaults/azure-key-vault-keyvault01.md)
- [Azure Blob Storage - Backup Key Vault (`backupskyvault01`)](../storage-services/azure-blob-keyvault01-backups.md)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

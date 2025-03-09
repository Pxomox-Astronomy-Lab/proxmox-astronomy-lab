# **Storage Services - Entra Hybrid Cloud**

## **Overview**

The **Storage Services** section of the **Entra Hybrid Cloud** documentation provides details on **cloud-based storage solutions** utilized for **backup, data retention, and secure storage** in the lab infrastructure. These services are critical for **data integrity, disaster recovery, and hybrid cloud integration**.

Currently, this section focuses on **Azure Blob Storage (`backupskyvault01`)**, which is dedicated to **securely storing encrypted backups and auto-unseal keys** for **on-prem HashiCorp Vault**.

## **Referenced Storage Services**

- **[Azure Blob Storage - Backup Key Vault (`backupskyvault01`)](./azure-blob-keyvault01-backups.md)** – Securely stores **encrypted HashiCorp Vault unseal keys** and **critical backup data**.

## **Purpose & Role**

- **Secure Backup Storage:** Provides **long-term, encrypted backup storage** for critical lab secrets and services.
- **Disaster Recovery:** Ensures **redundant, recoverable storage** to mitigate data loss risks.
- **Cost-Optimized Retention:** Utilizes **cold storage tiers** for cost-effective long-term retention.

## **Future Expansion**

- Additional storage services such as **general-purpose blob storage, S3-compatible object storage, and archival solutions** will be documented in future updates.

## **Related Documentation**

- [Azure Blob Storage - Backup Key Vault (`backupskyvault01`)](./azure-blob-keyvault01-backups.md)
- [Azure Key Vault (`azure-lab-keyvault01`)](../key-vaults/azure-key-vault-keyvault01.md)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

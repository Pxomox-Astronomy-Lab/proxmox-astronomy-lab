# **Key Vaults - Entra Hybrid Cloud**

## **Overview**

The **Key Vaults** section of the **Entra Hybrid Cloud** documentation provides details on the **secrets management and encryption key storage** solutions used within the lab infrastructure. These key vaults ensure **secure storage, access control, and automated unlocking** for critical lab services.

This documentation covers the **Azure Key Vault (`azure-lab-keyvault01`)**, which serves as the **primary cloud-based secrets management solution** for auto-unlocking on-prem services, specifically **HashiCorp Vault**.

## **Key Vaults in the Lab**

The lab relies on **Azure Key Vault** to store and manage **sensitive credentials, encryption keys, and API secrets** while enforcing **RBAC-based access control**.

### **Referenced Key Vaults**

- **[Azure Key Vault (`azure-lab-keyvault01`)](./azure-key-vault-keyvault01.md)** – Primary cloud key vault for **secure storage and automated unlocking of on-prem HashiCorp Vault**.

## **Purpose & Role**

- **Auto-Unlock Services:** Stores **encrypted unseal keys** required for **automated unlocking of on-prem HashiCorp Vault**.
- **Secret & Key Management:** Secures **sensitive credentials, encryption keys, and API secrets** for lab services.
- **Access Control & Auditing:** Implements **Azure Role-Based Access Control (RBAC)** to restrict and monitor access.
- **Backup & Redundancy:** Works alongside **Azure Blob Storage (`backupskyvault01`)** to ensure key backup and disaster recovery.

## **Security & Compliance Considerations**

- **Access Control:** All access is enforced using **Entra ID RBAC policies**.
- **Key Rotation:** Keys must be rotated per **security best practices**.
- **Logging & Monitoring:** All access attempts are logged for **audit and compliance tracking**.

## **Related Documentation**

- [Azure Key Vault (`azure-lab-keyvault01`)](./azure-key-vault-keyvault01.md)
- [Azure Blob Storage - Backup Key Vault](../azure-blob-storage-backup-keyvault.md)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

# **Azure Key Vault - Lab Vault Auto-Unlock Service**

## **1. Service Overview**

Azure Key Vault is a **cloud-based secrets management service** designed to **securely store and control access to encryption keys, credentials, and certificates**. The **Lab Key Vault (`azure-lab-keyvault01`)** is specifically deployed to **auto-unlock the on-prem HashiCorp Vault instance** by securely storing **encrypted unseal keys**.

## **2. Purpose & Scope**

This service is responsible for securely managing **sensitive credentials and encryption keys** for the **Proxmox Astronomy Lab's HashiCorp Vault**. It provides:

- **Automated Unlocking** – Stores **encrypted HashiCorp Vault unseal keys** for automated vault initialization.
- **Secure Secret Storage** – Maintains **encryption keys, API credentials, and other sensitive data**.
- **Controlled Access & Auditing** – Restricts access via **Azure Role-Based Access Control (RBAC)** and **monitored access logs**.
- **Disaster Recovery Integration** – Works in tandem with **Azure Blob Storage (`backupskyvault01`)** to ensure redundant key backups.
- **Tamper Protection** – Enforces **strict access policies** to mitigate unauthorized access risks.

## **3. Service Architecture**

### **3.1. Key Vault Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Key Vault Name**             | `azure-lab-keyvault01`          |
| **Resource Group**             | `HomeLab`                       |
| **Location**                   | `East US`                       |
| **SKU (Pricing Tier)**         | `Standard`                      |
| **Soft Delete**                | `Enabled`                       |
| **Purge Protection**           | `Disabled`                      |
| **Directory Name**             | `Beardinthe.Cloud`              |
| **Subscription ID**            | `fe7ff16f-c5b1-43fd-b348-4242729a04b6` |

### **3.2. Security & Networking**

| Security Feature                | Status                        |
|---------------------------------|--------------------------------|
| **Public Network Access**       | `Enabled`                      |
| **Firewall & Virtual Networks** | `Access allowed from all networks` |
| **Private Endpoint Connections** | `Not Configured`               |
| **Access Policies**             | `RBAC Enforced`                 |
| **Secrets & Keys Rotation**     | `Manual (Future Auto-Rotation Planned)` |

## **4. Key Management & Access Policies**

| Policy Type        | Configuration Details |
|--------------------|----------------------|
| **Access Control** | Restricted to HashiCorp Vault & Lab Services |
| **Authentication** | Entra ID & RBAC enforced |
| **Key Retention** | Soft delete enabled, purge protection disabled |
| **Backup Integration** | Keys are backed up to Azure Blob Storage (`backupskyvault01`) |

## **5. Integration with On-Prem HashiCorp Vault**

- **Azure Key Vault securely stores encrypted unseal keys** required for **automated unlocking of the HashiCorp Vault**.
- **Lab services interact with Key Vault via API**, retrieving decryption keys only when necessary.
- **Key backups are automatically synchronized** with **Azure Blob Storage (`backupskyvault01`)** to ensure disaster recovery readiness.
- **Access logs are monitored** to detect unauthorized attempts to retrieve sensitive secrets.

## **6. Compliance & Security Considerations**

- **Access logs must be regularly reviewed** to detect potential breaches.
- **Key rotation policies must be enforced** to maintain security best practices.
- **RBAC policies must be audited quarterly** to ensure only required services have access.

## **7. Change Management**

All modifications to this service (including access policies, key management, and networking rules) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **8. Related Documentation**

- [Azure Key Vault Documentation](https://learn.microsoft.com/en-us/azure/key-vault/)
- [Azure Blob Storage Documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

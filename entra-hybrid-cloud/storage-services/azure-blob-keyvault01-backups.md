# **Azure Blob Storage - Backup Key Vault Service**

## **1. Service Overview**

Azure Blob Storage is a **highly scalable, cloud-based object storage solution** designed for **unstructured data storage, backup, and archival**. The **Backup Key Vault Storage Account** (`backupskyvault01`) is deployed to ensure **secure storage of encryption keys, backup of critical lab secrets, and automated unlocking of the on-prem HashiCorp Vault**.

## **2. Purpose & Scope**

This service is responsible for securely storing **auto-unseal keys and encrypted backups** for the **Proxmox Astronomy Lab’s HashiCorp Vault**. It provides:

- **Automated Unlocking** – Stores **encrypted HashiCorp Vault unseal keys** for automated recovery.
- **Secure Backup Storage** – Maintains **critical encrypted backups** for disaster recovery.
- **Long-Term Retention** – Configured with **cold storage tiers** for cost-effective data preservation.
- **RBAC-Controlled Access** – Restricts access via **Azure Role-Based Access Control (RBAC)** and **Entra ID policies**.
- **Disaster Recovery Readiness** – Ensures resilient, redundant, and auditable backup solutions.

## **3. Service Architecture**

### **3.1. Storage Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Storage Account Name**       | `backupskyvault01`              |
| **Resource Group**             | `HomeLab`                       |
| **Location**                   | `East US`                       |
| **Replication**                | `Locally-Redundant Storage (LRS)` |
| **Access Tier**                | `Cold`                          |
| **Blob Soft Delete**           | `Enabled (7 days retention)`   |
| **Container Soft Delete**       | `Enabled (7 days retention)`   |
| **Change Feed & Versioning**    | `Enabled`                      |
| **Infrastructure Encryption**   | `Disabled (Handled at vault level)` |

### **3.2. Security & Networking**

| Security Feature                | Status                        |
|---------------------------------|--------------------------------|
| **Secure API Access**           | `Enabled` (TLS 1.2+)          |
| **Storage Account Key Access**  | `Enabled`                     |
| **Firewall Rules**              | `Selected Networks Only`       |
| **Private Endpoint Connections** | `None (Future Expansion)`     |
| **Access for Microsoft Services** | `Enabled`                     |

## **4. Backup & Access Policies**

| Policy Type        | Configuration Details |
|--------------------|----------------------|
| **Access Control** | Restricted to Azure Key Vault & HashiCorp Vault |
| **Authentication** | Entra ID & RBAC enforced |
| **Backup Retention** | Blob soft delete enabled (7-day recovery) |
| **Storage Tier** | Cold storage to optimize costs |

## **5. Integration with On-Prem HashiCorp Vault**

- **Azure Key Vault stores encrypted unseal keys** required for **automated unlocking of Vault**.
- **This Blob Storage account holds redundant key backups** in case the primary key vault is unavailable.
- **Backup policies ensure secure, auditable recovery** in disaster scenarios.

## **6. Compliance & Security Considerations**

- **Access logs must be monitored** for unauthorized access attempts.
- **Encryption keys must be rotated periodically** to align with security best practices.
- **RBAC policies must be reviewed quarterly** to ensure only authorized services have access.

## **7. Change Management**

All modifications to this service (including access policies, retention settings, and networking rules) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **8. Related Documentation**

- [Azure Blob Storage Documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/)
- [Azure Key Vault Documentation](https://learn.microsoft.com/en-us/azure/key-vault/)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

# **Nextcloud - On-Prem Collaboration & Research Data Platform**

## **1. Service Overview**

Nextcloud is an **on-premises collaboration and file-sharing platform** designed for **secure research data management and team collaboration**. It provides **self-hosted cloud storage, document editing, and seamless integration with research workflows**.

In **Proj-Apps01**, Nextcloud serves as the **centralized collaboration platform**, integrating with **NFS-backed storage, Windows file shares, and OnlyOffice for document editing**. Combined with **Kasm Workspaces**, it enables a **fully secured research environment** without exposing data externally.

## **2. Purpose & Scope**

This service provides **on-prem, self-hosted collaboration tools** for researchers and internal teams, ensuring:

- **Secure Research Data Collaboration** – Centralized **storage for research files**, accessible only within the lab environment.
- **NFS & Windows File Share Integration** – Nextcloud is backed by **bulk storage on NFS** and **file shares from Windows servers**.
- **OnlyOffice Integration** – Provides a **fully featured document editor**, similar to **Office 365**, without requiring external cloud services.
- **Seamless Kasm Workspaces Access** – Allows users to interact with **Nextcloud in a fully isolated, controlled virtual workspace**.
- **Data Exfiltration Protection** – With **copy-out disabled in Kasm Workspaces** and **Kasm only accessible via Entra Private Access (EPA)**, external guests cannot extract sensitive data.

## **3. Service Architecture**

### **3.1. Nextcloud Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Nextcloud Version**          | `27.1.2`                        |
| **Database Backend**           | `PostgreSQL (lab-db01)`         |
| **Storage Backend**            | `NFS & Windows File Shares`     |
| **OnlyOffice Integration**     | `Enabled (Local Instance)`      |
| **Access Control**             | `RBAC & EPA Restricted`         |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Nextcloud Service        |
|--------------------------------|---------------------------------|
| **PostgreSQL (`lab-db01`)**    | Stores Nextcloud metadata & settings |
| **NFS Bulk Storage**           | Provides primary research file storage |
| **Windows File Shares**        | Mounts internal research file shares |
| **OnlyOffice**                 | Enables document editing & collaboration |
| **Kasm Workspaces**            | Provides secure, isolated access |
| **Reverse Proxy (Nginx Proxy Manager)** | Manages SSL & secure access |

## **4. Security & Compliance Considerations**

- **EPA-Enforced Access Control:** Only accessible **inside Kasm Workspaces**, ensuring **zero direct exposure**.
- **Copy-Out Disabled in Kasm:** Prevents **data exfiltration by external users**.
- **Role-Based Access Control (RBAC):** Granular permissions for internal researchers.
- **Encrypted Data at Rest:** Ensures **secure storage of sensitive research data**.
- **Audit Logging & Monitoring:** Tracks file access, modifications, and downloads.

## **5. Change Management**

All modifications to this service (including storage integrations, access policies, and software updates) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **6. Related Documentation**

- [PostgreSQL (`lab-db01`)](../database/postgresql-lab-db01.md)
- [NFS Bulk Storage Configuration] (Internal KB Reference)
- [OnlyOffice Integration Guide] (Internal KB Reference)
- [Kasm Workspaces Security Policy] (Internal KB Reference)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

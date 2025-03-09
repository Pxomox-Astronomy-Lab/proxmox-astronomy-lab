# **Wiki.js - Internal Knowledge Base Platform**

## **1. Service Overview**

Wiki.js is a **lightweight, open-source knowledge base platform** designed for **structured documentation, collaboration, and version control**. It is used within the **Proxmox Astronomy Lab** to **manage internal documentation** and support **Infrastructure-as-Code (IaC) principles** through **Git-based versioning**.

This deployment of **Wiki.js** integrates with an **external PostgreSQL database (`lab-db01`)** for storage and utilizes the **Git sync plugin**, enabling **bi-directional synchronization** with a **GitHub repository**. This ensures that all documentation is stored as code and can be tracked, reviewed, and updated through **Git workflows**.

## **2. Purpose & Scope**

This service is responsible for managing **lab-wide documentation, procedures, and infrastructure records**. It provides:

- **Centralized Knowledge Management:** Stores all **internal documentation, procedures, and lab configurations**.
- **Git-based Versioning:** Synchronizes documentation with a **GitHub repository**, allowing **two-way synchronization**.
- **Role-Based Access Control (RBAC):** Implements **user authentication and granular permission control**.
- **Integration with Lab Services:** Supports **markdown, diagrams (PlantUML, Mermaid), and live API documentation**.
- **Collaboration & Change Tracking:** Enables **tracked, peer-reviewed changes** via **Git pull requests**.

## **3. Service Architecture**

### **3.1. Wiki.js Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Wiki.js Version**            | `2.5.300`                       |
| **Database Backend**           | `PostgreSQL (lab-db01)`         |
| **Storage Backend**            | `GitHub (Two-Way Sync)`         |
| **Authentication**             | `RBAC & Entra ID (Future Integration)` |
| **Containerization**           | `Docker on Portainer`          |
| **Networking**                 | `Behind Nginx Proxy Manager`   |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Wiki.js Service         |
|--------------------------------|---------------------------------|
| **[PostgreSQL (`lab-db01`)](../db-services/postgresql-stack.md)** | Stores all wiki content and metadata |
| **[Nginx Proxy Manager](../network-services/nginx-proxy-manager-stack.md)** | Provides HTTPS termination and reverse proxying |
| **[GitHub Repository](https://github.com/your-wiki-repo)** | Stores documentation as code for version control |

## **4. Git-Based Documentation-as-Code Workflow**

- **Two-Way Sync with GitHub:** Wiki.js **automatically pushes and pulls** changes from the repository.
- **Git Review Process:** Documentation changes can be **reviewed, commented, and merged via pull requests**.
- **Rollback & History Tracking:** Enables **version control, diffs, and rollback of documentation updates**.
- **Markdown & Code Support:** Fully supports **Markdown, PlantUML, Mermaid, and live API integrations**.

## **5. Security & Compliance Considerations**

- **RBAC Policies** must be applied to **control access and enforce user authentication**.
- **Backup Policies** ensure that **wiki data is backed up alongside PostgreSQL backups**.
- **Git Repository Permissions** must be **configured securely** to prevent unauthorized documentation changes.
- **Audit Logging** should be enabled to **track documentation modifications and access**.

## **6. Change Management**

All modifications to this service (including **database configurations, repository sync policies, and authentication settings**) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **7. Related Documentation**

- [PostgreSQL (`lab-db01`)](../db-services/postgresql-stack.md)
- [Nginx Proxy Manager](../network-services/nginx-proxy-manager-stack.md)
- [GitHub Repository (Wiki.js Docs)](https://github.com/your-wiki-repo)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

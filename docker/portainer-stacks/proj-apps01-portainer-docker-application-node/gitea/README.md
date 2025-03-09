# **Gitea - Project-Specific Source Control**

## **1. Service Overview**

Gitea is a **self-hosted Git service** that provides **source control, issue tracking, and repository management** for project-specific workloads. It serves as the **primary Git repository** for projects in **Proj-Apps01**, allowing for **collaborative development, version control, and GitOps workflows**.

Gitea is lightweight, efficient, and supports **CI/CD integrations, pull requests, and branch-based workflows**, making it ideal for managing project-specific repositories independently from lab-wide repositories.

## **2. Purpose & Scope**

This service is dedicated to **storing and managing repositories for research and development projects** within the **Proxmox Astronomy Lab**. It provides:

- **Project-Specific Git Repositories** – Separate from lab-wide repositories to maintain clean versioning and isolation.
- **Issue Tracking & Collaboration** – Supports **team discussions, pull requests, and issue tracking**.
- **GitOps-Driven Workflows** – Enables **declarative infrastructure management** and automated deployments.
- **Secure Repository Management** – Ensures **access control, authentication, and encrypted storage**.
- **Integration with CI/CD Pipelines** – Supports automation for **project builds and deployments**.

## **3. Service Architecture**

### **3.1. Gitea Configuration**

| Parameter                      | Value                           |
|--------------------------------|---------------------------------|
| **Gitea Version**              | `1.21.3`                        |
| **Database Backend**           | `PostgreSQL (lab-db01)`         |
| **Authentication**             | `Internal (Future Entra ID)`    |
| **Access Control**             | `Project-Specific`              |

### **3.2. Dependencies & Integration**

| Dependency                     | Role in Gitea Service           |
|--------------------------------|---------------------------------|
| **PostgreSQL (`lab-db01`)**    | Stores repository data & metadata |
| **CI/CD Pipelines**            | Automates builds & deployments |
| **Reverse Proxy (Nginx Proxy Manager)** | Secures external access |

## **4. Security & Compliance Considerations**

- **Project Isolation:** Gitea instances are dedicated to project-level repositories.
- **RBAC-Enabled Repository Access:** Permissions are enforced via **role-based access control**.
- **Repository Encryption:** All repository data is stored securely in **PostgreSQL**.
- **Audit Logging:** All repository actions and changes are logged for compliance.

## **5. Change Management**

All modifications to this service (including repository configurations, access controls, and deployment settings) must follow the **Proxmox Astronomy Lab Change Management Process** and be documented accordingly.

## **6. Related Documentation**

- [PostgreSQL (`lab-db01`)](../database/postgresql-lab-db01.md)
- [Nginx Proxy Manager](../networking/nginx-proxy-manager.md)
- [CI/CD Automation Guide] (Internal KB Reference)
- [Proxmox Astronomy Lab Security Policy] (Internal KB Reference)

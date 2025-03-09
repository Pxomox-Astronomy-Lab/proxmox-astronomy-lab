# **Portainer Stacks - Overview**

## **Introduction**

The **Portainer Stacks** directory serves as the centralized repository for managing all containerized applications deployed via Portainer across the Proxmox Astronomy Lab. This directory follows a structured **GitOps** methodology, ensuring consistent, version-controlled, and scalable deployments.

All Portainer stacks are stored under:

```
/docker/portainer-stacks/server/application/
```

Each **server** hosts its own applications within its respective directory.

For detailed documentation and style guidelines, refer to the **Portainer Stacks Lab Documentation and Style Guide**:
👉 **[Portainer Stacks Lab Documentation and Style Guide](../portainer-stacks-lab-documentation-and-style-guide.md)**

---

## **Portainer Stack Structure**

Each **server** has a dedicated directory within `/docker/portainer-stacks/`, structured as follows:

```
/docker/portainer-stacks/
│── server/
│   ├── lab-apps01/
│   │   ├── README.md  (Overview of lab-apps01)
│   │   ├── application1/
│   │   │   ├── README.md  (App-specific details)
│   │   │   ├── docker-compose.yml
│   │   │   ├── stack.env.example
│   ├── proj-apps01/
│   │   ├── README.md  (Overview of proj-apps01)
│   │   ├── application2/
│   │   │   ├── README.md  (App-specific details)
│   │   │   ├── docker-compose.yml
│   │   │   ├── stack.env.example
```

---

## **Server Overview**

### **1. Lab-Apps01 (Lab-Level Services)**

**Role:** `Lab-Apps01` serves as the primary Portainer-based service host for **lab-wide applications**. This node is responsible for managing core services such as:

- **Source Control** (e.g., Gitea)
- **Documentation & Knowledge Management** (e.g., Wiki.js)
- **Secrets & Access Management** (e.g., Zitadel, Vault)
- **Service Proxy & API Gateway** (e.g., NGINX Proxy Manager, Kong)

These services **support lab-wide operations** and provide essential infrastructure for application management.

📌 **See the full overview here:** [Lab-Apps01 README](lab-apps01/README.md)

---

### **2. Proj-Apps01 (Project-Specific Services)**

**Role:** `Proj-Apps01` is dedicated to **project-specific applications**, providing **isolated, containerized environments** for active research projects. This server manages:

- **Scientific Workflows & Data Processing**
- **Visualization & Dashboards** (e.g., Grafana, Dashy)
- **Collaboration & Storage** (e.g., Nextcloud, MinIO)

These services are tailored to individual research projects and are separate from lab-wide infrastructure services.

📌 **See the full overview here:** [Proj-Apps01 README](proj-apps01/README.md)

---

## **GitOps Workflow & Deployment**

All **stacks are deployed via Portainer using Git repositories** stored in **Gitea** under the `Portainer_Stacks` organization.

- Base URL for repositories:

  ```
  https://gitea.beardinthe.cloud/Portainer_Stacks/
  ```

- Git branch workflow:
  - `dev` (Development changes & testing)
  - `main` (Stable changes ready for use)
  - `production` (Live deployed version)

Portainer automatically pulls updates from the configured repository branch and redeploys the stack upon any changes.

---

## **Next Steps**

- Refer to individual **server-level READMEs** for more details.
- Follow the **Portainer Stacks Lab Documentation and Style Guide** for best practices.
- Ensure all new applications are properly structured under their respective servers.

🚀 **This documentation ensures a scalable, maintainable, and well-structured approach to containerized deployments in our research lab.**

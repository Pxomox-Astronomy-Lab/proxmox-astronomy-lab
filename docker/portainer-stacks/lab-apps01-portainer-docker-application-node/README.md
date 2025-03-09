# **Proj-Apps01 Portainer - Docker Application Node**

## **Overview**

The `proj-apps01` node serves as the **primary application hosting environment** for **project-specific services** in the Proxmox Astronomy Lab. Managed via **Portainer**, this node is dedicated to **isolated, research-driven workloads**, supporting active scientific and computational projects.

📌 **This directory contains multiple project-specific stacks, each with its own subdirectory.**

---

## **Role of Proj-Apps01 in the Lab**

`Proj-Apps01` is responsible for **hosting research and project-specific applications** that require dedicated environments separate from lab-wide infrastructure services. It provides:

- **Data Processing & Visualization** tools for research insights.
- **Collaboration & Storage Solutions** for project-specific workflows.
- **Application Environments** tailored to research needs.
- **Scientific & Computational Pipelines** designed for ongoing studies.

This node acts as a **dedicated resource for research teams**, ensuring project isolation while leveraging the broader lab infrastructure.

---

## **Stacks Deployed on Proj-Apps01**

Each research-driven service is deployed as a **stack within Portainer**, ensuring modularity and ease of management.

### **1. Gitea (Project-Specific Source Control)**

📂 **[Gitea Stack](gitea/README.md)**

- Hosts **project-specific repositories**.
- Used for **research code, workflows, and data management scripts**.

### **2. Grafana (Scientific Data Visualization)**

📂 **[Grafana Stack](grafana/README.md)**

- Provides **interactive dashboards** for real-time project data.
- Used for **monitoring scientific observations and analytics**.

### **3. Nextcloud (Collaboration & File Sharing)**

📂 **[Nextcloud Stack](nextcloud/README.md)**

- Secure **file storage and sharing platform**.
- Used for **storing research data, documents, and team collaboration**.

### **4. Dashy (Project Dashboards)**

📂 **[Dashy Stack](dashy/README.md)**

- Provides a **centralized dashboard** for research tools and links.
- Customized per project for **easy access to relevant resources**.

---

## **Deployment & Management**

- All project stacks are managed via **Portainer**.
- Updates and changes follow **GitOps workflows**.
- Repositories for stacks are stored under:

  ```
  https://gitea.beardinthe.cloud/Portainer_Stacks/
  ```

- Each stack follows the **structured folder format**:

  ```
  /docker/portainer-stacks/proj-apps01-portainer-docker-application-node/
  │── gitea/
  │   ├── README.md
  │   ├── docker-compose.yml
  │   ├── stack.env.example
  │── grafana/
  │   ├── README.md
  │── nextcloud/
  │   ├── README.md
  │── dashy/
  │   ├── README.md
  ```

---

## **Next Steps**

- Refer to individual **application stack READMEs** for setup details.
- Follow **GitOps workflows** for project stack management.
- Optimize **data storage and visualization strategies** for active research.

🚀 **Proj-Apps01 provides a scalable, project-focused environment, enabling cutting-edge research and scientific computing in the lab.**

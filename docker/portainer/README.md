I'll rewrite the README.md file following the repository's readme style, incorporating references to the related directories in the wiki tree.

# 🐳 **Portainer**

# 🔍 **1. Overview**

This section documents the Portainer Business Edition implementation in the Proxmox Astronomy Lab, providing centralized container management with role-based access control, GitOps workflows, and comprehensive monitoring capabilities. Portainer serves as the primary container orchestration platform for all dockerized infrastructure services across the lab environment.

Portainer follows a hub-and-spoke architecture with a central server (hub) on lab-port01 and remote agents (spokes) on application and database nodes, enabling centralized control with distributed container execution across purpose-specific nodes.

---

# 🏛️ **2. Portainer Architecture**

## **2.1 Deployment Model**

Portainer Business Edition (free tier) provides enterprise-grade container management for the lab environment.

| **Component** | **Implementation** | **Documentation** |
|--------------|-------------------|-------------------|
| **Portainer Server** | Centralized management interface on lab-port01 | [Portainer Control Node](lab-port01-portainer-master-control-node/README.md) |
| **Edge Agents** | Remote agents on app and database nodes | [Edge Agent Configuration](../portainer-stacks/README.md) |
| **Business Edition** | Free tier (≤5 nodes) with RBAC, GitOps, logging | [Licensing Details](lab-port01-portainer-master-control-node/README.md) |

## **2.2 Node Architecture**

The Portainer deployment spans multiple nodes, each serving a specific purpose in the container ecosystem.

| **Node** | **Purpose** | **Documentation** |
|----------|------------|-------------------|
| **lab-port01** | Primary control plane for container management | [Portainer Control Node](lab-port01-portainer-master-control-node/README.md) |
| **lab-apps01** | Application node for web-facing services | [App Node](lab-apps01-portainer-docker-application-node/README.md) |
| **lab-db01** | Database node for containerized data services | [DB Node](lab-db01-portainer-docker-database-node/README.md) |
| **proj-apps01** | Project-specific containerized applications | [Project Node](proj-apps01-portainer-docker-application-node/README.md) |

---

# 📦 **3. Container Stack Management**

## **3.1 Stack Deployment**

Portainer implements GitOps workflows for container deployment and management.

| **Repository** | **Purpose** | **Documentation** |
|---------------|-----------|-------------------|
| **Infrastructure Stacks** | Core infrastructure services | [Infrastructure Stacks](../portainer-stacks/lab-apps01-portainer-docker-application-node/README.md) |
| **Application Stacks** | Service-specific containers | [Application Stacks](../portainer-stacks/lab-apps01-portainer-docker-application-node/README.md) |
| **Database Stacks** | Data persistence services | [Database Stacks](../portainer-stacks/lab-db01-portainer-docker-database-node/README.md) |

## **3.2 Stack Documentation**

Comprehensive stack documentation is maintained for all containerized services.

| **Stack Category** | **Documentation** | **Templates** |
|-------------------|-----------------|---------------|
| **Applications** | Individual application stacks | [Application Stacks](../portainer-stacks/lab-apps01-portainer-docker-application-node/README.md) |
| **Databases** | Database container configurations | [Database Stacks](../portainer-stacks/lab-db01-portainer-docker-database-node/README.md) |
| **Project Services** | Project-specific application stacks | [Project Stacks](../portainer-stacks/proj-apps01-portainer-docker-application-node/README.md) |

---

# 🔐 **4. Security & Compliance**

## **4.1 Security Controls**

The Portainer implementation incorporates comprehensive security measures.

| **Security Aspect** | **Implementation** | **Documentation** |
|--------------------|-------------------|-------------------|
| **Access Control** | RBAC with Entra ID integration | [Security Configuration](lab-port01-portainer-master-control-node/README.md) |
| **Network Segmentation** | Isolated container networks | [Network Architecture](../portainer-stacks/portainer-stacks-lab-documentation-and-style-guide.md) |
| **Container Hardening** | Non-root users, readonly filesystems | [Container Security](../portainer-stacks/portainer-stacks-lab-documentation-and-style-guide.md) |

## **4.2 Compliance Mapping**

Portainer implementation aligns with relevant compliance frameworks.

| **Framework** | **Controls Satisfied** | **Documentation** |
|--------------|----------------------|-------------------|
| **CISv8** | 1.1, 1.2, 4.1, 4.2, 5.2, 6.8 | [Compliance Documentation](lab-port01-portainer-master-control-node/README.md) |
| **ISO 27001** | A.8.1, A.12.1, A.12.6 | [Security Controls](lab-port01-portainer-master-control-node/README.md) |

---

# 📂 **5. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **lab-port01-portainer-master-control-node** | Documentation for the primary Portainer server | [README](lab-port01-portainer-master-control-node/README.md) |
| **lab-apps01-portainer-docker-application-node** | Documentation for the application services node | [README](lab-apps01-portainer-docker-application-node/README.md) |
| **lab-db01-portainer-docker-database-node** | Documentation for the database services node | [README](lab-db01-portainer-docker-database-node/README.md) |
| **proj-apps01-portainer-docker-application-node** | Documentation for the project applications node | [README](proj-apps01-portainer-docker-application-node/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Portainer Stacks Documentation** | Guidelines for stack creation and management | [Document](../portainer-stacks/portainer-stacks-lab-documentation-and-style-guide.md) |

---

# 🔄 **6. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Docker** | Parent category for container technologies | [README](../README.md) |
| **Portainer Stacks** | Stack definitions for Portainer deployments | [README](../portainer-stacks/README.md) |
| **Infrastructure** | Physical and virtual hosting environment | [README](../../infrastructure/README.md) |
| **Applications & Services** | Services deployed via Portainer | [README](../../docs/Applications/README.md) |

---

# ✅ **7. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |

---

# 📜 **8. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial documentation | VintageDon |

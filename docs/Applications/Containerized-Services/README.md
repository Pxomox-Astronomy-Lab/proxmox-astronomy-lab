<!-- 
---
title: "Containerized Services - Proxmox Astronomy Lab"
description: "Documentation for container platforms, orchestration, and deployments in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["containers", "docker", "kubernetes", "portainer", "rke2", "orchestration"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🐳 **Containerized Services**

# 🔍 **1. Overview**

This section documents the containerization platforms that form the foundation for application deployment in the Proxmox Astronomy Lab. Our container strategy combines Docker-based deployments via Portainer for simpler workloads with a full Kubernetes cluster for scalable, resilient research applications.

Containerization provides consistent deployment, isolation, and resource management across our diverse application portfolio, supporting both operational infrastructure and scientific research workloads.

---

# 🖥️ **2. Docker Infrastructure**

This section covers the Docker deployment infrastructure that hosts containerized applications using Portainer for management and orchestration.

## **2.1 Docker Nodes**

This subsection documents the dedicated hosts for Docker-based containerized workloads, including their configuration and deployed applications.

| **Host** | **Function** | **Documentation** |
|----------|------------|-------------------|
| **lab-apps01** | Lab services and applications | [lab-apps01](Docker-Nodes/lab-apps01.md) |
| **lab-db01** | Database containers | [lab-db01 README](../../docker/portainer/lab-db01-portainer-docker-database-node/README.md) |
| **proj-apps01** | Project-specific applications | [proj-apps01 README](../../docker/portainer/proj-apps01-portainer-docker-application-node/README.md) |

These Docker hosts provide dedicated environments for various containerized workloads, each serving a specific functional domain within the lab infrastructure.

## **2.2 Portainer Management**

This subsection details the Portainer deployment used for centralized Docker management across the lab environment.

| **Component** | **Function** | **Documentation** |
|--------------|------------|-------------------|
| **lab-port01** | Portainer control node | [lab-port01](Portainer/lab-port01.md) |
| **Stack Templates** | Standardized application definitions | [Portainer Stacks](../../docker/portainer-stacks/README.md) |

The Portainer infrastructure provides a centralized management interface for Docker deployments, enabling consistent application management through standardized stack definitions.

---

# ☸️ **3. Kubernetes Infrastructure**

This section documents the Kubernetes cluster that hosts scalable, resilient containerized workloads in the lab environment.

## **3.1 RKE2 Cluster**

This subsection details the RKE2 Kubernetes implementation, including control plane and worker nodes.

| **Component** | **Function** | **Documentation** |
|--------------|------------|-------------------|
| **Control Plane** | Kubernetes management layer | [RKE2 Cluster](Kubernetes-Workloads/RKE2-Cluster.md) |
| **Worker Nodes** | Compute resources for workloads | [Worker Nodes](../../infrastructure/kubernetes/README.md) |
| **Storage Integration** | Persistent storage for workloads | [K8s Storage](Kubernetes-Workloads/RKE2-Cluster.md) |

The RKE2 Kubernetes cluster provides a robust, scalable platform for deploying more complex containerized workloads that require orchestration capabilities beyond what Docker alone can provide.

## **3.2 Kubernetes Components**

This subsection covers the key supporting components that enhance the Kubernetes platform capabilities.

| **Component** | **Function** | **Documentation** |
|--------------|------------|-------------------|
| **Traefik Ingress** | External access management | [Traefik Ingress](Kubernetes-Workloads/Traefik-Ingress.md) |
| **Cert Manager** | SSL certificate automation | [RKE2 Cluster](Kubernetes-Workloads/RKE2-Cluster.md) |
| **Prometheus Operator** | Monitoring infrastructure | [RKE2 Cluster](Kubernetes-Workloads/RKE2-Cluster.md) |

These Kubernetes components provide essential functionalities for routing, certificate management, and monitoring that support containerized application deployments.

---

# 📦 **4. Container Deployments**

This section documents the containerized applications deployed across the Docker and Kubernetes infrastructure.

## **4.1 Docker Application Stacks**

This subsection lists the primary Docker-based application stacks deployed in the environment.

| **Application Stack** | **Host** | **Documentation** |
|----------------------|----------|-------------------|
| **Gitea** | lab-apps01 | [Gitea Stack](../../docker/portainer-stacks/lab-apps01-portainer-docker-application-node/gitea/README.md) |
| **GLPI** | lab-apps01 | [GLPI Stack](../../docker/portainer-stacks/lab-apps01-portainer-docker-application-node/glpi/README.md) |
| **Vault** | lab-apps01 | [Vault Stack](../../docker/portainer-stacks/lab-apps01-portainer-docker-application-node/vault/README.md) |
| **PostgreSQL** | lab-db01 | [PostgreSQL Stack](../../docker/portainer-stacks/lab-db01-portainer-docker-database-node/postgresql/README.md) |

These Docker application stacks provide a variety of services, from version control to database platforms, supporting both infrastructure and research needs.

## **4.2 Kubernetes Workloads**

This subsection covers the primary applications deployed on the Kubernetes platform.

| **Workload** | **Type** | **Documentation** |
|--------------|----------|-------------------|
| **Milvus** | Vector Database | [AI Workloads](../AI-ML-Platforms/Vector-Databases/Milvus.md) |
| **TensorFlow Serving** | ML Model Serving | [Inference Engines](../AI-ML-Platforms/Inference-Engines/TensorFlow-Serving.md) |
| **Airflow** | Workflow Orchestration | [Workflow Configuration](../Data-Analysis/Apache-Airflow/Workflow-Configuration.md) |

These Kubernetes workloads represent more complex, scalable applications that benefit from Kubernetes orchestration capabilities for resilience and resource management.

---

# 🔐 **5. Security & Compliance**

This section documents how security controls are implemented and how compliance requirements are met for containerized services.

## **5.1 Container Security Controls**

This subsection documents specific security measures implemented for containerized workloads.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **Image Security** | Verified image sources, scanning | Image scan reports |
| **Network Policies** | Segmentation between workloads | Policy verification |
| **Secret Management** | Vault integration for credentials | Secret access audit |
| **Privilege Restrictions** | Non-root containers, security contexts | Configuration audit |

The security controls table above documents implemented safeguards for containerized workloads, providing evidence for security assessments and compliance audits.

## **5.2 Compliance Framework**

This subsection explicitly maps container security implementation to compliance frameworks.

| **Framework Control** | **Implementation** | **Evidence** |
|----------------------|-------------------|-------------|
| **CIS Docker Benchmark** | Hardened Docker daemon config | Configuration audit |
| **Kubernetes CIS Benchmark** | Secured API server, RBAC | CIS-CAT reports |
| **Data Protection (CIS 3)** | Encrypted volumes, network policies | Configuration validation |

The compliance mapping table above demonstrates how containerized service implementations satisfy specific requirements across security frameworks.

---

# 🔄 **6. Operations & Maintenance**

This section covers the operational procedures for maintaining containerized services in optimal condition.

## **6.1 Routine Procedures**

This subsection documents regular maintenance activities required to keep containerized services functioning properly.

| **Procedure** | **Frequency** | **Responsible Role** |
|---------------|--------------|----------------------|
| **Image Updates** | Monthly | Engineer |
| **Security Scanning** | Weekly | Security Admin |
| **Resource Monitoring** | Continuous | Operations |
| **Backup Verification** | Monthly | Operations |

The routine procedures ensure containerized services remain secure, up-to-date, and properly resourced through regular maintenance activities.

## **6.2 Troubleshooting Processes**

This subsection provides guidance for identifying and resolving common issues with containerized services.

| **Common Issue** | **Symptoms** | **Resolution Steps** |
|------------------|------------|---------------------|
| **Resource Exhaustion** | OOM errors, throttling | Resource limit adjustment |
| **Network Connectivity** | Connection timeouts | Network policy verification |
| **Storage Issues** | Volume mount failures | PV/PVC status check |
| **Image Pull Errors** | Container creation failure | Registry authentication check |

The troubleshooting processes provide structured approaches to resolving common container-related issues, minimizing downtime and service impact.

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category.

## **Subdirectories**

This subsection identifies the main subdirectories within the Containerized Services section, explaining their purpose and providing navigation links.

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Docker-Nodes** | Docker host documentation | [Docker-Nodes](Docker-Nodes/) |
| **Kubernetes-Workloads** | Kubernetes deployment docs | [Kubernetes-Workloads](Kubernetes-Workloads/) |
| **Portainer** | Portainer management platform | [Portainer](Portainer/) |

The subdirectories table above provides navigation to key sections of the Containerized Services documentation, helping users locate specific information.

## **Key Documents**

This subsection highlights important standalone documents within the Containerized Services section that provide significant information.

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **RKE2-Cluster.md** | Kubernetes cluster overview | [RKE2 Cluster](Kubernetes-Workloads/RKE2-Cluster.md) |
| **Traefik-Ingress.md** | Ingress controller configuration | [Traefik Ingress](Kubernetes-Workloads/Traefik-Ingress.md) |
| **lab-port01.md** | Portainer server documentation | [Portainer Control Node](Portainer/lab-port01.md) |

The key documents table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

---

# 🔄 **8. Related Categories**

This section identifies other documentation categories related to Containerized Services, establishing relationships between different knowledge areas.

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Physical hosts for containers | [Infrastructure README](../../Infrastructure/README.md) |
| **Databases** | Containerized database platforms | [Databases README](../Databases/README.md) |
| **AI-ML-Platforms** | ML workloads on Kubernetes | [AI-ML-Platforms README](../AI-ML-Platforms/README.md) |
| **Observability** | Container monitoring integration | [Observability README](../Observability/README.md) |

The related categories table above documents connections to other knowledge domains, helping users understand the broader context of containerized services.

---

# ✅ **9. Approval & Review**

This section documents the formal review and approval process for this document. It ensures accountability and tracks who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

---

# 📜 **10. Change Log**

This section tracks the document's revision history. It provides transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Containerized Services README | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.

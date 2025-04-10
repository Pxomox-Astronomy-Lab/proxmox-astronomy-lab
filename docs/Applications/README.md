<!-- 
---
title: "Applications & Services - Proxmox Astronomy Lab"
description: "Documentation hub for all applications and services running within the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["applications", "services", "documentation", "overview"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🖥️ **Applications & Services**

# 🔍 **1. Overview**

The Applications & Services section documents all deployed software systems within the Proxmox Astronomy Lab environment. This includes containerized applications, databases, supporting services, and research tools that collectively enable the lab's IT operations and scientific research capabilities.

Each application is documented with a consistent approach covering technical architecture, configuration details, access management, and operational procedures to ensure proper maintenance and support throughout its lifecycle.

---

# 📊 **2. Application Categories**

This section organizes the lab's applications into functional categories that reflect their purpose and technical characteristics, providing a structured way to navigate the application ecosystem.

## **2.1 AI & ML Platforms**

This subsection covers machine learning and artificial intelligence capabilities that support research and automation within the lab.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **TensorFlow Serving** | ML model deployment | [TensorFlow Serving](AI-ML-Platforms/Inference-Engines/TensorFlow-Serving.md) |
| **Milvus** | Vector database for knowledge retrieval | [Milvus](AI-ML-Platforms/Vector-Databases/Milvus.md) |
| **Jupyter Notebook** | Interactive data analysis | [Jupyter Notebook](AI-ML-Platforms/Model-Training/Jupyter-Notebook.md) |
| **MLflow** | ML experiment tracking | [MLflow](AI-ML-Platforms/Model-Training/MLflow.md) |

The AI and ML platforms listed above form the foundation for data analysis, machine learning, and knowledge retrieval capabilities in the lab environment.

## **2.2 Container Platforms**

This subsection documents the container orchestration and management systems that enable scalable application deployment.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Docker Nodes** | Container hosts | [Docker Nodes](Containerized-Services/Docker-Nodes/lab-apps01.md) |
| **Kubernetes Cluster** | Container orchestration | [RKE2 Cluster](Containerized-Services/Kubernetes-Workloads/RKE2-Cluster.md) |
| **Portainer** | Container management UI | [Portainer](Containerized-Services/Portainer/lab-port01.md) |
| **Traefik** | Container ingress controller | [Traefik Ingress](Containerized-Services/Kubernetes-Workloads/Traefik-Ingress.md) |

The container platforms above provide the deployment infrastructure for scalable, resilient application workloads throughout the lab environment.

## **2.3 Database Systems**

This subsection covers the database platforms that provide structured and time-series data storage for applications and research data.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **PostgreSQL** | Relational database | [PostgreSQL Server](Databases/PostgreSQL/PostgreSQL-Server.md) |
| **TimescaleDB** | Time-series data | [TimescaleDB Server](Databases/TimescaleDB/TimescaleDB-Server.md) |
| **PostGIS** | Geospatial data storage | [PostGIS](Databases/GIS-Extensions/PostGIS.md) |
| **MongoDB** | Document database | [MongoDB Server](Databases/MongoDB/MongoDB-Server.md) |
| **Redis** | In-memory data store | [Redis Server](Databases/Redis/Redis-Server.md) |
| **MariaDB** | Relational database | [MariaDB Server](Databases/MariaDB/MariaDB-Server.md) |

The database systems listed above provide specialized data storage services for different application requirements and research data types.

## **2.4 Scientific Applications**

This subsection documents the specialized scientific applications used for radio astronomy research and data analysis.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **GNU Radio** | Signal processing | [GNU Radio](Radio-Astronomy/SDR-Applications/GNU-Radio.md) |
| **SDR++** | Software-defined radio | [SDR++](Radio-Astronomy/SDR-Applications/SDR-Plus-Plus.md) |
| **SigDigger** | Signal analysis | [SigDigger](Radio-Astronomy/SDR-Applications/SigDigger.md) |
| **CASA/Miriad** | Astronomy data analysis | [CASA-Miriad](Radio-Astronomy/Analysis-Tools/CASA-Miriad.md) |
| **Presto** | Pulsar search and analysis | [Presto](Radio-Astronomy/Analysis-Tools/Presto.md) |

The scientific applications above provide specialized tools for radio astronomy signal processing, analysis, and research workflow management.

---

# 🔧 **3. Deployment Architecture**

This section documents how applications are deployed, managed, and maintained across the lab environment.

## **3.1 Deployment Strategy**

This subsection explains the structured deployment approach that ensures all applications are properly containerized, monitored, and secured.

| **Approach** | **Implementation** | **Documentation** |
|--------------|-------------------|-------------------|
| **Containerization** | Docker and Kubernetes packaging | [Container Standards](../ITIL-Processes/Change-Management/RFC-Templates/README.md) |
| **Configuration as Code** | Git-managed application configs | [GitOps Workflows](../ITIL-Processes/Change-Management/README.md) |
| **Standardized Monitoring** | Prometheus and Loki integration | [Monitoring Integration](../Observability/Prometheus/README.md) |
| **Security Baselines** | CISv8-aligned application security | [Application Security](../Compliance-Security/Security-Policies/CIS-Security-Policies/16-application-software-security/README.md) |

The deployment strategy ensures consistent, secure, and maintainable application deployments across the lab environment.

## **3.2 Application Hosts**

This subsection documents the primary hosts where applications are deployed throughout the environment.

| **Host** | **Purpose** | **Primary Applications** |
|----------|------------|-------------------------|
| **lab-apps01** | Lab-wide applications | Gitea, Nextcloud, Vaultwarden |
| **lab-db01** | Database systems | PostgreSQL, TimescaleDB, MariaDB, Redis |
| **lab-port01** | Container management | Portainer |
| **proj-apps01** | Project-specific applications | Apache Superset, MLflow, Airflow |
| **Kubernetes cluster** | Scalable workloads | Milvus, TensorFlow, processing pipelines |
| **proj-rds02** | Radio astronomy workstation | GNU Radio, SigDigger, SDR++ |

The application hosts table above maps which systems host specific applications, providing context for infrastructure dependencies.

---

# 🔐 **5. Security & Compliance**

This section documents how security controls are implemented across applications and how compliance requirements are met.

## **5.1 Access Control**

This subsection documents the consistent approach to application access control implemented throughout the environment.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **Centralized Authentication** | Zitadel for identity management | Authentication logs, access review |
| **Role-Based Access** | Permissions assigned by user role | Permission audit, group membership |
| **Multi-Factor Authentication** | Required for administrative access | MFA enforcement reports |
| **Access Reviews** | Quarterly access validation | Access review documentation |

The access control table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## **5.2 Security Monitoring**

This subsection details how applications are monitored for security events and compliance with security baselines.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **SIEM Integration** | Wazuh agents on all application hosts | Alert verification, log completeness |
| **Log Analysis** | Centralized logging in Loki | Log retention, security alerting |
| **Vulnerability Scanning** | Regular assessment cycle | Scan reports, remediation tracking |
| **Configuration Compliance** | Automated baseline verification | Compliance reports, drift detection |

The security monitoring controls ensure continuous visibility into the security posture of all applications and early detection of potential security issues.

---

# 🔄 **6. Application Lifecycle Management**

This section covers the processes for deploying, maintaining, and retiring applications throughout their lifecycle.

## **6.1 Deployment Process**

This subsection documents the structured process for deploying new applications in the lab environment.

| **Phase** | **Activities** | **Documentation** |
|-----------|---------------|-------------------|
| **Containerization** | Package in Docker containers | [Container Standards](../ITIL-Processes/Change-Management/RFC-Templates/README.md) |
| **Review & Testing** | Security and functionality testing | [Application Testing](../ITIL-Processes/Change-Management/README.md) |
| **Deployment** | Managed via Portainer or Kubernetes | [Deployment Procedures](../ITIL-Processes/Change-Management/Application-Onboarding.md) |
| **Monitoring Integration** | Exporters and logging configuration | [Monitoring Setup](../Observability/Prometheus/README.md) |
| **Documentation** | Service documentation creation | [Documentation Standards](../Documentation-Standards/Documentation-Templates/README.md) |

The deployment process ensures consistent, secure application onboarding that integrates with the lab's operational practices.

## **6.2 Maintenance Activities**

This subsection outlines the routine maintenance activities performed to keep applications secure and up-to-date.

| **Activity** | **Frequency** | **Responsibility** | **Documentation** |
|--------------|--------------|-------------------|-------------------|
| **Security Patching** | Monthly or as required | Engineer | [Patch Management](../ITIL-Processes/Change-Management/Patch-Management.md) |
| **Version Upgrades** | As needed | Engineer | [Application Upgrades](../ITIL-Processes/Change-Management/Application-Upgrades.md) |
| **Configuration Reviews** | Quarterly | Operations | [Configuration Reviews](../ITIL-Processes/Problem-Management/Configuration-Reviews.md) |
| **Backup Verification** | Monthly | Operations | [Backup Verification](../ITIL-Processes/Service-Catalog/Backup-Verification.md) |

The maintenance activities ensure applications remain secure, performant, and aligned with operational requirements throughout their lifecycle.

---

# 🔗 **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category.

## **Subdirectories**

This subsection identifies the main subdirectories within the Applications section, explaining their purpose and providing navigation links.

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **AI-ML-Platforms** | Artificial intelligence and machine learning | [AI-ML-Platforms README](AI-ML-Platforms/README.md) |
| **Containerized-Services** | Container orchestration and management | [Containerized-Services README](Containerized-Services/README.md) |
| **Databases** | Database platforms and management | [Databases README](Databases/README.md) |
| **Data-Analysis** | Data processing and visualization | [Data-Analysis README](Data-Analysis/README.md) |
| **File-Storage** | File management and sharing | [File-Storage README](File-Storage/README.md) |
| **Identity** | Authentication and authorization | [Identity README](Identity/README.md) |
| **Observability** | Monitoring, logging, and alerting | [Observability README](Observability/README.md) |
| **Radio-Astronomy** | Scientific research applications | [Radio-Astronomy README](Radio-Astronomy/README.md) |
| **Security** | Security monitoring and protection | [Security README](Security/README.md) |
| **Version-Control** | Code and configuration management | [Version-Control README](Version-Control/README.md) |

The subdirectories table above provides navigation to key sections of the Applications documentation, helping users locate specific information.

## **Key Documents**

This subsection highlights important standalone documents within the Applications section that provide significant information.

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Milvus.md** | Vector database configuration | [Milvus Documentation](AI-ML-Platforms/Vector-Databases/Milvus.md) |
| **RKE2-Cluster.md** | Kubernetes cluster overview | [RKE2 Cluster Documentation](Containerized-Services/Kubernetes-Workloads/RKE2-Cluster.md) |
| **PostgreSQL-Server.md** | Database configuration details | [PostgreSQL Documentation](Databases/PostgreSQL/PostgreSQL-Server.md) |

The key documents table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

---

# 🔄 **8. Related Categories**

This section identifies other documentation categories related to Applications, establishing relationships between different knowledge areas.

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Hosting platform for applications | [Infrastructure README](../Infrastructure/README.md) |
| **Control-Plane** | Core services for applications | [Control-Plane README](../Control-Plane/README.md) |
| **ITIL-Processes** | Application lifecycle management | [ITIL-Processes README](../ITIL-Processes/README.md) |
| **Compliance-Security** | Application security requirements | [Compliance-Security README](../Compliance-Security/README.md) |

The related categories table above documents connections to other knowledge domains, helping users understand the broader context of the Applications section.

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
| 1.0 | 2025-03-16 | Initial Applications README | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.

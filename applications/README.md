<!-- 
---
title: "Proxmox Astronomy Lab - Applications Documentation Hub"
description: "Central documentation for all applications, services, and research tools in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["applications", "services", "databases", "astronomy", "research", "infrastructure", "ai-ml", "documentation"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
---
-->

# 🚀 **Proxmox Astronomy Lab Applications Documentation**

# 🔍 **1. Overview**

This documentation hub serves as the central reference for all applications, services, and research tools deployed in the Proxmox Astronomy Lab. The application ecosystem spans infrastructure management, databases, observability, security, AI/ML workloads, and specialized astronomy research tools. All applications are deployed following structured ITIL practices, with consistent security hardening and documentation standards.

The lab's applications portfolio is designed to support both general IT infrastructure requirements and specialized scientific research needs, with an emphasis on automation, security, and reproducibility.

---

# 💾 **2. Database Services**

## **2.1 Relational Databases**

Our relational database fleet supports both infrastructure and research needs with high-performance storage and transactional guarantees.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **PostgreSQL** | General-purpose ACID-compliant RDBMS | [PostgreSQL Documentation](Databases/PostgreSQL/README.md) |
| **TimescaleDB** | Time-series specialized PostgreSQL | [TimescaleDB Documentation](Databases/TimescaleDB/README.md) |
| **PostgreSQL with PostGIS** | Spatial data extension for PostgreSQL | [PostGIS Documentation](Databases/PostGIS/README.md) |
| **MariaDB/MySQL** | Open-source RDBMS for traditional workloads | [MariaDB Documentation](Databases/MariaDB/README.md) |

## **2.2 NoSQL Datastores**

Non-relational databases supporting various data models for specialized research and application needs.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **MongoDB** | Document-oriented NoSQL database | [MongoDB Documentation](Databases/MongoDB/README.md) |
| **Neo4j** | Graph database for relationship modeling | [Neo4j Documentation](Databases/Neo4j/README.md) |
| **Redis** | In-memory key-value store for caching & messaging | [Redis Documentation](Databases/Redis/README.md) |
| **InfluxDB** | Time-series database for metrics & measurements | [InfluxDB Documentation](Databases/InfluxDB/README.md) |

## **2.3 Vector & ML-Optimized Databases**

Specialized databases for AI/ML and knowledge retrieval workloads.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Milvus** | Vector database for embeddings & semantic search | [Milvus Documentation](Databases/Milvus/README.md) |

---

# 🖥️ **3. Infrastructure Management**

## **3.1 Core Management Services**

Foundational services for cluster, virtualization, and resource management.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox VE** | Virtualization platform for infrastructure | [Proxmox Documentation](Infrastructure-Management/Proxmox/README.md) |
| **Proxmox Backup Server** | Backup solution for VMs and containers | [PBS Documentation](Infrastructure-Management/PBS/README.md) |
| **RKE2 Kubernetes** | Container orchestration platform | [RKE2 Documentation](Infrastructure-Management/RKE2/README.md) |
| **Portainer** | Container management UI | [Portainer Documentation](Infrastructure-Management/Portainer/README.md) |
| **Veeam Community Edition** | Advanced VM backup and replication | [Veeam Documentation](Infrastructure-Management/Veeam/README.md) |

## **3.2 GitOps & Workflow Management**

Services for infrastructure as code, GitOps, and collaborative workflows.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Gitea** | Self-hosted Git service | [Gitea Documentation](Infrastructure-Management/Gitea/README.md) |
| **ArgoCD** | Declarative GitOps CD for Kubernetes | [ArgoCD Documentation](Infrastructure-Management/ArgoCD/README.md) |
| **Ansible/AWX** | Configuration management & automation | [Ansible Documentation](Infrastructure-Management/Ansible/README.md) |
| **GLPI** | IT Service Management platform | [GLPI Documentation](Infrastructure-Management/GLPI/README.md) |

## **3.3 Storage Services**

Specialized storage solutions for various workload types.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **MinIO** | S3-compatible object storage | [MinIO Documentation](Infrastructure-Management/MinIO/README.md) |
| **Windows File Server** | SMB3 file sharing with multichannel | [SMB Documentation](Infrastructure-Management/WindowsFS/README.md) |
| **Linux File Server** | NFSv4 with multipath support | [NFS Documentation](Infrastructure-Management/LinuxFS/README.md) |
| **ZFS Storage** | Advanced filesystem for data integrity | [ZFS Documentation](Infrastructure-Management/ZFS/README.md) |

---

# 🔐 **4. Security Services**

## **4.1 Identity & Access Management**

Services for authentication, authorization, and identity governance.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Windows Server AD** | On-premises directory services | [AD Documentation](Security/WindowsAD/README.md) |
| **Entra ID Hybrid** | Cloud identity with on-prem integration | [Entra Documentation](Security/Entra/README.md) |
| **TailScale** | Zero Trust Network Access | [Tailscale Documentation](Security/Tailscale/README.md) |
| **HashiCorp Vault** | Secrets management with Azure Key Vault integration | [Vault Documentation](Security/Vault/README.md) |

## **4.2 Monitoring & Security Operations**

Security monitoring, detection, and response capabilities.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Wazuh SIEM/XDR** | Security information & event management | [Wazuh Documentation](Security/Wazuh/README.md) |
| **Azure Sentinel** | Cloud-native SIEM and SOAR | [Sentinel Documentation](Security/Sentinel/README.md) |
| **Lynis** | Security auditing tool | [Lynis Documentation](Security/Lynis/README.md) |
| **RKHunter/CHKRoot** | Rootkit detection tools | [RKHunter Documentation](Security/RKHunter/README.md) |

---

# 📊 **5. Observability Stack**

## **5.1 Monitoring & Metrics**

Services for health monitoring, alerts, and performance metrics.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Prometheus** | Metrics collection & storage | [Prometheus Documentation](Observability/Prometheus/README.md) |
| **Grafana** | Data visualization & dashboards | [Grafana Documentation](Observability/Grafana/README.md) |
| **AlertManager** | Alert routing & notification | [AlertManager Documentation](Observability/AlertManager/README.md) |
| **Loki** | Log aggregation solution | [Loki Documentation](Observability/Loki/README.md) |

## **5.2 Exporters & Agents**

Specialized collectors for various data sources and system metrics.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Node Exporter** | System metrics for Linux/Unix nodes | [Node Exporter Documentation](Observability/NodeExporter/README.md) |
| **SNMP Exporter** | Network device monitoring | [SNMP Exporter Documentation](Observability/SNMPExporter/README.md) |
| **cAdvisor** | Container resource usage metrics | [cAdvisor Documentation](Observability/cAdvisor/README.md) |
| **Database Exporters** | DB-specific metric collection | [DB Exporters Documentation](Observability/DatabaseExporters/README.md) |

---

# 🧠 **6. AI & ML Platform**

## **6.1 LLM Infrastructure**

Large Language Model hosting and interfaces for knowledge assistance.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Ollama** | Self-hosted LLM serving | [Ollama Documentation](AI-ML/Ollama/README.md) |
| **OpenWebUI** | User interface for LLM interaction | [OpenWebUI Documentation](AI-ML/OpenWebUI/README.md) |
| **RAGGraph** | Graph-based knowledge retrieval | [RAGGraph Documentation](AI-ML/RAGGraph/README.md) |

## **6.2 Model Serving & Training**

Infrastructure for ML model training, tuning, and serving.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **TensorFlow Serving** | ML model serving platform | [TF Serving Documentation](AI-ML/TFServing/README.md) |
| **JupyterHub** | Multi-user notebook environment | [JupyterHub Documentation](AI-ML/JupyterHub/README.md) |

---

# 📡 **7. Radio Astronomy Tools**

## **7.1 SDR Processing Pipeline**

Software-defined radio tools for capturing and processing astronomy signals.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **GNU Radio** | Signal processing framework | [GNU Radio Documentation](Astronomy/GNURadio/README.md) |
| **Airspy SDR** | SDR hardware integration | [Airspy Documentation](Astronomy/Airspy/README.md) |
| **SDR++** | SDR software interface | [SDR++ Documentation](Astronomy/SDRpp/README.md) |
| **SigDigger** | Signal analysis tool | [SigDigger Documentation](Astronomy/SigDigger/README.md) |

## **7.2 Astronomy Analysis Tools**

Specialized software for astronomical data analysis and research.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **CASA/Miriad** | Radio astronomy data analysis | [CASA Documentation](Astronomy/CASA/README.md) |
| **Presto** | Pulsar search and analysis | [Presto Documentation](Astronomy/Presto/README.md) |
| **Hydrogen Line Pipeline** | Custom H-line signal processing | [H-Line Documentation](Astronomy/HydrogenLine/README.md) |

---

# 🔄 **8. Data Pipeline & Workflow**

## **8.1 Data Processing Tools**

Tools for orchestrating and processing research data flows.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Apache Airflow** | Workflow orchestration platform | [Airflow Documentation](DataPipeline/Airflow/README.md) |
| **Luigi** | Python-based task orchestration | [Luigi Documentation](DataPipeline/Luigi/README.md) |
| **RabbitMQ** | Message broker for event-driven architectures | [RabbitMQ Documentation](DataPipeline/RabbitMQ/README.md) |
| **N8N** | Workflow automation platform | [N8N Documentation](DataPipeline/N8N/README.md) |

---

# 🖲️ **9. Remote Access Services**

## **9.1 Secure Remote Work Environments**

Platforms for secure remote access and collaboration.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Kasm Workspaces** | Browser-based VDI environment | [Kasm Documentation](RemoteAccess/Kasm/README.md) |
| **RDS Server** | Windows Remote Desktop Services | [RDS Documentation](RemoteAccess/RDS/README.md) |
| **Tailscale** | Mesh VPN with Entra ID integration | [Tailscale Documentation](RemoteAccess/Tailscale/README.md) |

---

# 🗂️ **10. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in the Applications category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Databases** | Database service documentation | [Databases Documentation](Databases/README.md) |
| **Infrastructure-Management** | Infrastructure management tools | [Infrastructure Documentation](Infrastructure-Management/README.md) |
| **Security** | Security services and tools | [Security Documentation](Security/README.md) |
| **Observability** | Monitoring and observability stack | [Observability Documentation](Observability/README.md) |
| **AI-ML** | AI and ML platforms | [AI-ML Documentation](AI-ML/README.md) |
| **Astronomy** | Radio astronomy tools | [Astronomy Documentation](Astronomy/README.md) |
| **DataPipeline** | Data processing workflows | [DataPipeline Documentation](DataPipeline/README.md) |
| **RemoteAccess** | Remote access services | [RemoteAccess Documentation](RemoteAccess/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Service Map** | Application dependencies and relationships | [Service Map](service-map.md) |
| **Deployment Matrix** | Node assignments and resource allocation | [Deployment Matrix](deployment-matrix.md) |
| **Backup Strategy** | Application backup procedures and schedules | [Backup Strategy](backup-strategy.md) |

---

# 🔄 **11. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Hosts application workloads | [Infrastructure Documentation](/docs/Infrastructure/README.md) |
| **Security-Compliance** | Secures application access | [Security Documentation](/docs/Compliance-Security/README.md) |
| **Control-Plane** | Manages application lifecycle | [Control Plane Documentation](/docs/Control-Plane/README.md) |
| **Research-Projects** | Consumes application services | [Research Documentation](/docs/Research-Projects/README.md) |

---

# ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |

---

# 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial documentation framework | VintageDon |

<!-- 
---
title: "Applications Documentation"
description: "Detailed documentation for applications and services running in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["applications", "services", "documentation", "software"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🖥️ **Applications**

# 🔍 **1. Overview**

The Applications section provides comprehensive documentation for all software systems deployed within the Proxmox Astronomy Lab. This includes everything from containerized services and databases to specialized research applications and monitoring tools, documenting their technical configuration, operational parameters, and usage guidelines.

Each application is documented according to standardized templates that ensure consistent coverage of architecture, dependencies, security controls, and management procedures across the entire software ecosystem.

---

# 🧠 **2. AI/ML Platforms**

## **2.1 Inference Engines**

Machine learning inference systems for model deployment and execution.

| **Application** | **Purpose** | **Documentation** |
|----------------|------------|-------------------|
| **TensorFlow Serving** | ML model serving platform | [TensorFlow Serving](/docs/Applications/AI-ML-Platforms/Inference-Engines/TensorFlow-Serving.md) |

## **2.2 Model Training**

Environments for developing and training machine learning models.

| **Application** | **Purpose** | **Documentation** |
|----------------|------------|-------------------|
| **Jupyter Notebook** | Interactive development | [Jupyter Notebook](/docs/Applications/AI-ML-Platforms/Model-Training/Jupyter-Notebook.md) |
| **MLflow** | ML lifecycle management | [MLflow](/docs/Applications/AI-ML-Platforms/Model-Training/MLflow.md) |

## **2.3 Vector Databases**

Storage systems optimized for embedding vectors and similarity search.

| **Application** | **Purpose** | **Documentation** |
|----------------|------------|-------------------|
| **Milvus** | Vector database | [Milvus](/docs/Applications/AI-ML-Platforms/Vector-Databases/Milvus.md) |

---

# 🐳 **3. Containerized Services**

## **3.1 Docker Nodes**

Physical nodes running Docker containers for application services.

| **Node** | **Purpose** | **Documentation** |
|----------|------------|-------------------|
| **lab-apps01** | Lab-wide application node | [lab-apps01](/docs/Applications/Containerized-Services/Docker-Nodes/lab-apps01.md) |

## **3.2 Kubernetes Workloads**

Applications running on the RKE2 Kubernetes cluster.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **RKE2 Cluster** | Kubernetes orchestration | [RKE2 Cluster](/docs/Applications/Containerized-Services/Kubernetes-Workloads/RKE2-Cluster.md) |
| **Traefik Ingress** | Kubernetes ingress controller | [Traefik Ingress](/docs/Applications/Containerized-Services/Kubernetes-Workloads/Traefik-Ingress.md) |

## **3.3 Portainer**

Container management and orchestration platform.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **lab-port01** | Portainer control node | [lab-port01](/docs/Applications/Containerized-Services/Portainer/lab-port01.md) |

---

# 📊 **4. Data Analysis**

## **4.1 Apache Airflow**

Workflow orchestration platform for data processing.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **Workflow Configuration** | Pipeline definition | [Workflow Configuration](/docs/Applications/Data-Analysis/Apache-Airflow/Workflow-Configuration.md) |

## **4.2 Apache Superset**

Business intelligence and data visualization platform.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **Dashboard Configuration** | Visualization setup | [Dashboard Configuration](/docs/Applications/Data-Analysis/Apache-Superset/Dashboard-Configuration.md) |

---

# 💾 **5. Databases**

## **5.1 GIS Extensions**

Geospatial capabilities for database systems.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **PostGIS** | PostgreSQL spatial extension | [PostGIS](/docs/Applications/Databases/GIS-Extensions/PostGIS.md) |

## **5.2 MariaDB**

MySQL-compatible relational database system.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **MariaDB Server** | RDBMS implementation | [MariaDB Server](/docs/Applications/Databases/MariaDB/MariaDB-Server.md) |
| **phpMyAdmin** | Web-based administration | [phpMyAdmin](/docs/Applications/Databases/MariaDB/phpMyAdmin.md) |

## **5.3 MongoDB**

Document-oriented NoSQL database.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **MongoDB Server** | Document database | [MongoDB Server](/docs/Applications/Databases/MongoDB/MongoDB-Server.md) |

## **5.4 PostgreSQL**

Advanced open-source relational database.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **PostgreSQL Server** | RDBMS implementation | [PostgreSQL Server](/docs/Applications/Databases/PostgreSQL/PostgreSQL-Server.md) |
| **PGAdmin** | Administration interface | [PGAdmin](/docs/Applications/Databases/PostgreSQL/PGAdmin.md) |

## **5.5 Redis**

In-memory data structure store.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **Redis Server** | Key-value database | [Redis Server](/docs/Applications/Databases/Redis/Redis-Server.md) |
| **Redis Commander** | Web interface | [Redis Commander](/docs/Applications/Databases/Redis/Redis-Commander.md) |

## **5.6 TimescaleDB**

Time-series database built on PostgreSQL.

| **Component** | **Purpose** | **Documentation** |
|--------------|------------|-------------------|
| **TimescaleDB Server** | Time-series database | [TimescaleDB Server](/docs/Applications/Databases/TimescaleDB/TimescaleDB-Server.md) |

---

# 🗂️ **6. Directory Contents**

This section provides direct navigation to all subdirectories in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **AI-ML-Platforms** | Machine learning infrastructure | [AI/ML Platforms](/docs/Applications/AI-ML-Platforms/README.md) |
| **Containerized-Services** | Container orchestration | [Containerized Services](/docs/Applications/Containerized-Services/README.md) |
| **Data-Analysis** | Analytics platforms | [Data Analysis](/docs/Applications/Data-Analysis/README.md) |
| **Databases** | Database systems | [Databases](/docs/Applications/Databases/README.md) |
| **File-Storage** | File management systems | [File Storage](/docs/Applications/File-Storage/README.md) |
| **Identity** | Authentication services | [Identity](/docs/Applications/Identity/README.md) |
| **Observability** | Monitoring stack | [Observability](/docs/Applications/Observability/README.md) |
| **Radio-Astronomy** | Scientific applications | [Radio Astronomy](/docs/Applications/Radio-Astronomy/README.md) |
| **Security** | Security services | [Security](/docs/Applications/Security/README.md) |
| **Version-Control** | Code repositories | [Version Control](/docs/Applications/Version-Control/README.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Underlying platform | [Infrastructure](/docs/Infrastructure/README.md) |
| **Control Plane** | Core services | [Control Plane](/docs/Control-Plane/README.md) |
| **Docker** | Container platform | [Docker](/docker/README.md) |
| **Monitoring** | Application monitoring | [Monitoring](/monitoring/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |

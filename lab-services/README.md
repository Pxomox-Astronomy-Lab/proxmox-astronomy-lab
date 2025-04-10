<!-- 
---
title: "Lab Services Overview"
description: "Documentation for persistent lab-wide services and management interfaces in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["lab-services", "databases", "monitoring", "management", "guis"]
category: "Services"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🧰 **Lab Services**

# 🔍 **1. Overview**

Lab Services encompasses the persistent, shared management interfaces and administrative tools that provide essential functionality across the Proxmox Astronomy Lab environment. Unlike application-specific services, these components deliver core capabilities that support multiple aspects of the infrastructure and research operations.

These services are designed for reliability and accessibility, with standardized deployment patterns, consistent access methods, and integrated authentication to ensure secure, role-appropriate access for lab administrators and researchers.

---

# 💾 **2. Database Management Interfaces**

## **2.1 Database GUIs**

Web-based interfaces for managing the lab's various database platforms.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **pgAdmin** | PostgreSQL management interface | [pgAdmin](/lab-services/database-guis/pgadmin/README.md) |
| **phpMyAdmin** | MariaDB/MySQL administration | [phpMyAdmin](/lab-services/database-guis/phpmyadmin/README.md) |
| **Redis Commander** | Redis key-value store visualization | [Redis Commander](/lab-services/database-guis/redis-commander/README.md) |
| **Milvus Attu** | Vector database management | [Milvus Attu](/lab-services/database-guis/milvus-attu/README.md) |

---

# 🔍 **3. Monitoring & Observability Tools**

## **3.1 Monitoring Interfaces**

Tools for observing and analyzing system and application performance.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Grafana** | Metrics visualization dashboards | [Grafana](/lab-services/monitoring/grafana/README.md) |
| **Prometheus UI** | Direct metrics query interface | [Prometheus](/lab-services/monitoring/prometheus/README.md) |
| **Alertmanager** | Alert management console | [Alertmanager](/lab-services/monitoring/alertmanager/README.md) |
| **Loki Explorer** | Log query and exploration | [Loki](/lab-services/monitoring/loki/README.md) |

---

# 📦 **4. Container Management**

## **4.1 Container Platforms**

Interfaces for managing containerized applications.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Portainer** | Docker container management | [Portainer](/lab-services/containers/portainer/README.md) |
| **Rancher Dashboard** | Kubernetes cluster management | [Rancher](/lab-services/containers/rancher/README.md) |
| **Harbor Registry** | Container image repository | [Harbor](/lab-services/containers/harbor/README.md) |

---

# 🔒 **5. Security & Access Management**

## **5.1 Authentication Services**

Centralized authentication and authorization services.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Keycloak** | Identity provider | [Keycloak](/lab-services/security/keycloak/README.md) |
| **Vault UI** | Secret management interface | [Vault](/lab-services/security/vault/README.md) |
| **GLPI** | Asset and service management | [GLPI](/lab-services/security/glpi/README.md) |

---

# 📊 **6. Data Processing Tools**

## **6.1 Analysis Platforms**

Interfaces for data processing and analysis.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Jupyter Hub** | Interactive Python notebooks | [Jupyter](/lab-services/data-processing/jupyter/README.md) |
| **Airflow UI** | Workflow orchestration | [Airflow](/lab-services/data-processing/airflow/README.md) |
| **MinIO Console** | Object storage management | [MinIO](/lab-services/data-processing/minio/README.md) |

---

# 🗂️ **7. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **database-guis** | Database management interfaces | [Database GUIs](/lab-services/database-guis/README.md) |
| **monitoring** | Observability tools | [Monitoring](/lab-services/monitoring/README.md) |
| **containers** | Container management | [Containers](/lab-services/containers/README.md) |
| **security** | Security services | [Security](/lab-services/security/README.md) |
| **data-processing** | Analysis platforms | [Data Processing](/lab-services/data-processing/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Service Deployment Guide** | Standard deployment patterns | [Deployment Guide](/lab-services/service-deployment-guide.md) |
| **Authentication Integration** | Identity management integration | [Auth Integration](/lab-services/authentication-integration.md) |
| **Access URLs** | Standard service URL patterns | [URL Reference](/lab-services/access-urls.md) |

---

# 🔄 **8. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Applications** | Services supported by these tools | [Applications](/docs/Applications/README.md) |
| **Infrastructure** | Underlying platform | [Infrastructure](/infrastructure/README.md) |
| **ITIL Processes** | Service management framework | [ITIL](/itil/README.md) |
| **Control Plane** | Core infrastructure services | [Control Plane](/docs/Control-Plane/README.md) |

---

# ✅ **9. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

# 📜 **10. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation | VintageDon |
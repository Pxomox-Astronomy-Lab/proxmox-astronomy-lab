<!-- 
---
title: "Portainer Stacks - Proj-Apps01 Application Node"
description: "Documentation for the application stacks deployed on the proj-apps01 Portainer Docker worker node in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["portainer", "docker", "stacks", "applications", "research"]
category: "Docker"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

# 📱 **Portainer Stacks - Proj-Apps01 Application Node**

# 🔍 **1. Overview**

This directory contains the **Portainer stack definitions** for the proj-apps01 node, which serves as the **research application host** for the Proxmox Astronomy Lab. Unlike the lab-apps01 node that focuses on infrastructure services, these stacks provide specialized applications that directly support research workflows, data visualization, and scientific collaboration.

Each application stack is deployed with its own configuration, persistent storage, and networking settings, allowing for modular management while ensuring proper integration with research databases and data processing pipelines.

---

# 🐳 **2. Stack Deployment Process**

## **2.1 Deployment Infrastructure**

These stacks are deployed through the lab's GitOps workflow using Portainer's Git integration capabilities.

| **Component** | **Purpose** |
|--------------|-------------|
| **Portainer Master** | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) manages all stack deployments |
| **Worker Node** | [proj-apps01](/infrastructure/projects/proj-apps01-docker-application-node.md) hosts the deployed containers |
| **Git Repository** | Stack definitions stored in Gitea with version control |
| **Environment Files** | Secrets managed through `.env` files stored in HashiCorp Vault |
| **Deployment Pipeline** | Changes trigger automatic validation and deployment |

## **2.2 Common Stack Structure**

Each application stack follows a standardized structure for consistency and maintainability.

| **File** | **Purpose** |
|----------|------------|
| **README.md** | Documentation for the specific application stack |
| **docker-compose.yml** | Stack definition with services, networks, and volumes |
| **stack.env** | Environment variables for container configuration (vault-managed) |
| **stack.env.example** | Example environment file with placeholder values |
| **config/** | Application-specific configuration files |
| **data/** | Optional mountable data directory for small datasets |

## **2.3 Deployment Workflow**

The standardized process for deploying and updating application stacks ensures consistency and reliability.

1. Edit stack definition in Git repository
2. Submit pull request with changes
3. Automated validation checks run (syntax, security scanning)
4. Code review and approval by research team
5. Merge triggers deployment to proj-apps01 via Portainer webhook
6. Post-deployment health checks verify successful deployment

---

# 📂 **3. Research Application Stacks**

## **3.1 Gitea Stack**

The Gitea stack provides a lightweight, self-hosted Git service dedicated to research projects and scientific code.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [gitea/](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/gitea/) |
| **Image** | gitea/gitea:1.21 |
| **Exposed Ports** | 3000 (HTTP), 22 (SSH) |
| **Persistent Storage** | Docker volumes for repositories, data |
| **Database** | PostgreSQL (on proj-pg01) |
| **Special Features** | Entra ID integration, CI/CD pipelines, issue tracking |

## **3.2 Grafana Stack**

The Grafana stack provides data visualization specifically for research metrics and time-series observations.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [grafana/](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/grafana/) |
| **Image** | grafana/grafana:10.2.3 |
| **Exposed Port** | 3001 (HTTP) |
| **Persistent Storage** | Docker volume for dashboards, plugins |
| **Database** | SQLite (local), TimescaleDB (on proj-pgts01) for data sources |
| **Special Features** | Custom plugins for astronomy visualization, alerting |

## **3.3 Nextcloud Stack**

The Nextcloud stack provides secure file sharing and collaboration capabilities for research teams.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [nextcloud/](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/nextcloud/) |
| **Image** | nextcloud:27-apache |
| **Exposed Port** | 8080 (HTTP) |
| **Persistent Storage** | Docker volumes for application data, user files |
| **Database** | PostgreSQL (on proj-pg01) |
| **Special Features** | Office document editing, collaborative annotation |

## **3.4 Jupyter Stack**

The Jupyter stack provides interactive data analysis notebooks for researchers to process astronomical data.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [jupyter/](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/jupyter/) |
| **Image** | jupyter/scipy-notebook:latest |
| **Exposed Port** | 8888 (HTTP) |
| **Persistent Storage** | Docker volume for notebooks, datasets |
| **Database** | Connects to PostgreSQL (on proj-pggis01) |
| **Special Features** | Specialized astronomy libraries, GPU acceleration |

## **3.5 Dashy Stack**

The Dashy stack provides a central dashboard for accessing research tools and visualizing project status.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [dashy/](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/dashy/) |
| **Image** | lissy93/dashy:latest |
| **Exposed Port** | 4000 (HTTP) |
| **Persistent Storage** | Docker volume for configuration |
| **Database** | N/A (Static configuration) |
| **Special Features** | Custom widgets for research metrics, project tracking |

## **3.6 Network Configuration**

Docker networks are segmented to isolate different application components while enabling appropriate interconnectivity.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **proj-frontend** | 172.21.0.0/24 | User-facing web interfaces |
| **proj-backend** | 172.21.1.0/24 | Application-to-database connections |
| **proj-storage** | 172.21.2.0/24 | File storage and sharing services |

---

# 🔐 **4. Security & Access Controls**

## **4.1 Authentication Integration**

All research applications implement standardized authentication methods to ensure secure, streamlined access.

| **Application** | **Authentication Method** | **User Provisioning** |
|----------------|---------------------------|----------------------|
| **Gitea** | OAuth 2.0 with Entra ID | AD group synchronization |
| **Grafana** | OAuth 2.0 with Entra ID | JIT user provisioning |
| **Nextcloud** | SAML with Entra ID | Group-based provisioning |
| **Jupyter** | OAuth 2.0 with Entra ID | Manual user creation |
| **Dashy** | Basic auth with shared credentials | Static configuration |

## **4.2 Authorization Model**

Access to research applications follows a role-based model aligned with research team structures.

| **Role** | **Description** | **Access Level** |
|----------|----------------|-----------------|
| **Research Lead** | Principal investigators | Full administrative access |
| **Research Associate** | Active researchers | Read/write to assigned projects |
| **Data Analyst** | Analytical support | Read-only to data, read/write to analysis |
| **External Collaborator** | Partner institutions | Project-specific limited access |
| **Observer** | Stakeholders | Read-only dashboard access |

## **4.3 Data Protection**

Research data receives appropriate protection based on classification and sensitivity.

| **Data Category** | **Protection Measures** | **Access Restrictions** |
|-------------------|----------------------|------------------------|
| **Raw Observation Data** | Encryption at rest, versioning | Research team only |
| **Processed Datasets** | Checksums, audit logging | Research team + analysts |
| **Analysis Results** | Backup, versioning | All authorized users |
| **Published Materials** | Public repository, DOI assignment | Public access |

---

# 💾 **5. Backup & Recovery**

## **5.1 Backup Strategy**

Each application stack implements its own backup mechanism appropriate to the data it manages.

| **Application** | **Backup Method** | **Schedule** | **Retention** |
|----------------|-------------------|-------------|--------------|
| **Gitea** | Repository bundling to S3 | Hourly | 30 days |
| **Grafana** | Dashboard JSON export | Daily | 90 days |
| **Nextcloud** | File system snapshots + DB dump | Daily | 30 days |
| **Jupyter** | Notebook export to Git | On save | Version controlled |
| **Dashy** | Configuration backup | Weekly | 12 weeks |

## **5.2 Recovery Procedures**

Standardized recovery procedures ensure quick restoration when needed.

| **Scenario** | **Recovery Method** | **RTO** | **Procedure Documentation** |
|--------------|-------------------|--------|----------------------------|
| **Container Failure** | Re-deploy container | 5 min | [Container Recovery](/docs/infrastructure/troubleshooting/container-recovery.md) |
| **Data Corruption** | Restore from backup | 30 min | [Application Restore](/docs/infrastructure/troubleshooting/application-restore.md) |
| **Volume Loss** | Restore from backup | 1 hour | [Volume Recovery](/docs/infrastructure/troubleshooting/volume-recovery.md) |
| **Complete Failure** | Re-deploy stack and restore | 2 hours | [Stack Recovery](/docs/infrastructure/troubleshooting/stack-recovery.md) |

---

# 📊 **6. Monitoring & Metrics**

## **6.1 Application Monitoring**

Research applications are monitored through specialized exporters and health checks to ensure availability and performance.

| **Application** | **Monitoring Method** | **Dashboard** |
|----------------|----------------------|--------------|
| **Gitea** | Built-in Prometheus metrics | [Gitea Dashboard](/monitoring/grafana/dashboards/gitea-repository-dashboard-screenshot.png) |
| **Grafana** | Self-monitoring | [Grafana Internal Dashboard](/docs/applications/observability/grafana-self-monitoring.md) |
| **Nextcloud** | Prometheus exporter | [Nextcloud Dashboard](/docs/applications/observability/nextcloud-monitoring.md) |
| **Jupyter** | Custom metrics endpoint | [Jupyter Dashboard](/docs/applications/observability/jupyter-metrics.md) |
| **Dashy** | HTTP endpoint checks | [Application Health Dashboard](/docs/applications/observability/application-health.md) |

## **6.2 Alert Thresholds**

Critical application metrics are monitored with appropriate alerting thresholds.

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| **Response Time** | >2 seconds | >5 seconds | [Performance Troubleshooting](/docs/applications/performance-troubleshooting.md) |
| **Error Rate** | >1% | >5% | [Error Investigation](/docs/applications/error-investigation.md) |
| **Disk Usage** | 75% | 90% | [Storage Expansion](/docs/applications/storage-expansion.md) |
| **Memory Usage** | 80% | 90% | [Memory Optimization](/docs/applications/memory-optimization.md) |
| **Authentication Failures** | >5 in 15 minutes | >10 in 5 minutes | [Auth Troubleshooting](/docs/security/authentication-troubleshooting.md) |

---

# 🔄 **7. Application Integration**

## **7.1 Research Workflow Integration**

Applications are integrated to support end-to-end research workflows for astronomical data processing.

| **Workflow Stage** | **Primary Application** | **Secondary Applications** |
|-------------------|------------------------|---------------------------|
| **Data Collection** | SDR applications (K8s) | Grafana (monitoring) |
| **Data Storage** | TimescaleDB (proj-pgts01) | PostgreSQL (proj-pg01) |
| **Data Processing** | Jupyter notebooks | Python scripts in Gitea |
| **Visualization** | Grafana dashboards | Custom web apps |
| **Collaboration** | Nextcloud file sharing | Gitea pull requests |
| **Publication** | Gitea repositories | Nextcloud shared links |

## **7.2 Database Integration**

Applications connect to specialized database services tailored to their specific needs.

| **Application** | **Database Service** | **Connection Type** |
|----------------|----------------------|-------------------|
| **Gitea** | proj-pg01 (PostgreSQL) | Direct TCP connection |
| **Grafana** | proj-pgts01 (TimescaleDB) | PostgreSQL protocol |
| **Nextcloud** | proj-pg01 (PostgreSQL) | Direct TCP connection |
| **Jupyter** | proj-pggis01 (PostGIS) | Python database connectors |
| **Dashy** | N/A | Static configuration |

---

# 🔄 **8. Maintenance Procedures**

## **8.1 Update Strategy**

Application updates follow a structured approach to minimize disruption to research activities.

| **Update Type** | **Approach** | **Testing Requirements** | **Rollback Procedure** |
|----------------|-------------|--------------------------|------------------------|
| **Minor Updates** | Rolling update | Basic functionality check | Container replacement |
| **Major Upgrades** | Blue-green deployment | Full workflow validation | DNS switch |
| **Configuration Changes** | Live reload when possible | Change validation | Configuration rollback |
| **Database Schema Changes** | Scheduled maintenance | Application compatibility test | Schema rollback script |

## **8.2 Maintenance Schedule**

Research applications follow a maintenance schedule aligned with research activities.

| **Maintenance Type** | **Schedule** | **Notification** | **Downtime Expected** |
|----------------------|-------------|-----------------|----------------------|
| **Security Updates** | As needed | 24 hours notice | 0-15 minutes |
| **Minor Version Updates** | Monthly (3rd Saturday) | 1 week notice | 15-30 minutes |
| **Major Version Upgrades** | Quarterly | 2 weeks notice | 30-60 minutes |
| **Configuration Changes** | Bi-weekly (Friday evening) | 3 days notice | 0-15 minutes |

---

# 🔗 **9. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **9.1 Stack Directories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Gitea** | Research code repositories | [Gitea Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/gitea/README.md) |
| **Grafana** | Research data visualization | [Grafana Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/grafana/README.md) |
| **Nextcloud** | File sharing and collaboration | [Nextcloud Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/nextcloud/README.md) |
| **Jupyter** | Interactive data analysis | [Jupyter Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/jupyter/README.md) |
| **Dashy** | Research dashboard | [Dashy Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/dashy/README.md) |

## **9.2 Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Stack Style Guide** | Documentation standards | [Stack Documentation Style Guide](/docker/portainer-stacks/portainer-stacks-lab-documentation-and-style-guide.md) |
| **Research Application Standards** | Configuration guidance | [Research Application Standards](/docs/research-projects/application-standards.md) |
| **Troubleshooting Guide** | Common issue resolution | [Research Stack Troubleshooting](/docs/research-projects/stack-troubleshooting.md) |

---

# 🔄 **10. Related Resources**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Host VM Documentation** | Host for these stacks | [proj-apps01](/infrastructure/projects/proj-apps01-docker-application-node.md) |
| **Portainer Master** | Controls these stacks | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **Database Infrastructure** | Stores application data | [PostgreSQL Databases](/infrastructure/projects/proj-pg01-postgresql.md) |
| **Research Workflows** | Uses these applications | [Research Workflows](/docs/research-projects/workflows/README.md) |
| **Monitoring Configuration** | Monitors these applications | [Application Monitoring](/docs/applications/observability/application-monitoring.md) |

---

# ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

# 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

<!-- 
---
title: "Grafana - Visualization & Dashboarding Platform"
description: "Documentation for the Grafana visualization platform, dashboard structure, data sources, and integration with the monitoring stack"
author: "VintageDon"
tags: ["grafana", "monitoring", "dashboards", "visualization", "prometheus", "loki", "influxdb"]
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-04-04"
related_services: ["Prometheus", "AlertManager", "Loki", "InfluxDB"]
implements_policies: ["Monitoring Policy", "Observability Policy"]
phase: "phase-2"
---
-->

# 📊 **Grafana - Visualization & Dashboarding Platform**

# 🔍 **1. Overview**

Grafana serves as the primary visualization and dashboarding layer for the Proxmox Astronomy Lab's monitoring stack, providing an intuitive interface for analyzing and interpreting data from multiple sources. It delivers real-time and historical insights into infrastructure health, application performance, research workloads, and security events through a comprehensive set of customized dashboards.

The Grafana deployment integrates with multiple data sources including Prometheus time-series data, Loki logs, InfluxDB historical metrics, and PostgreSQL relational data to create a unified observability experience across all lab components and scientific research activities.

---

# 🔌 **2. Data Sources & Integration**

## **2.1 Primary Data Sources**

Grafana aggregates data from multiple sources to provide comprehensive visibility.

| **Data Source** | **Type** | **Purpose** | **Integration Status** |
|---------------|---------|------------|----------------------|
| **Prometheus** | Time-series DB | System & service metrics | ✅ Complete |
| **Loki** | Log aggregation | Log-based insights | ✅ Complete |
| **InfluxDB** | Time-series DB | Historical storage for long-term trends | ✅ Complete |
| **PostgreSQL** | SQL database | Querying structured research data | ✅ Complete |
| **TimescaleDB** | Time-series DB | Research time-series data | ✅ Complete |

## **2.2 Technical Integration Details**

| **Integration Aspect** | **Implementation Details** |
|-----------------------|----------------------------|
| **Deployment Type** | Docker container on `lab-mon01` |
| **Authentication** | LDAP integrated with Active Directory |
| **Data Source Refreshes** | 10s for critical metrics, 30s standard, 5m historical |
| **Internal URL** | `https://mon.beardinthe.cloud` |
| **External Access** | Secured via Entra Private Access with MFA |

---

# 📑 **3. Dashboard Organization**

## **3.1 Dashboard Structure**

Dashboards are organized into functional categories aligned with infrastructure components and research functions.

| **Category** | **Purpose** | **Primary Audience** |
|-------------|------------|----------------------|
| **Infrastructure Overview** | High-level health status | Operations Team |
| **Proxmox Cluster** | Virtualization platform metrics | Infrastructure Team |
| **Kubernetes Monitoring** | Container orchestration health | Research Engineers |
| **Network Monitoring** | Network performance and security | Network Team |
| **Database Monitoring** | Database health and performance | Database Administrators |
| **Application Monitoring** | Service-specific metrics | Application Owners |
| **Research Workloads** | Scientific processing metrics | Research Team |
| **Security Insights** | Security events and monitoring | Security Team |

## **3.2 Key Dashboards**

The monitoring stack includes several essential dashboards for different operational areas.

| **Dashboard** | **Purpose** | **Data Source** |
|--------------|------------|----------------|
| **Proxmox Cluster - Flux** | Virtualization infrastructure health | Prometheus |
| **Node Exporter Full** | Linux host detailed metrics | Prometheus |
| **Kubernetes Overview** | K8s cluster health and workloads | Prometheus |
| **PostgreSQL Databases** | Database performance metrics | Prometheus, PostgreSQL |
| **NVIDIA GPU Metrics** | GPU utilization for AI/ML workloads | Prometheus |
| **Network SNMP Overview** | Network device performance | Prometheus |
| **Wazuh Security Events** | Security monitoring integration | Loki, Elasticsearch |
| **SDR Telescope Metrics** | Radio telescope performance | InfluxDB, TimescaleDB |

---

# 📈 **4. Dashboard Sources**

## **4.1 Dashboard Acquisition Strategy**

Grafana dashboards are sourced through multiple approaches.

| **Source Type** | **Percentage** | **Examples** |
|---------------|--------------|--------------------|
| **Official Grafana Dashboards** | 45% | Node Exporter Full, PostgreSQL Stats |
| **Modified Public Dashboards** | 35% | Customized cAdvisor, SNMP Exporter |
| **Custom-Built Dashboards** | 20% | Proxmox Cluster Flux, Research Pipelines |

## **4.2 Dashboard Versioning**

| **Management Approach** | **Implementation Details** |
|------------------------|----------------------------|
| **Source Control** | Dashboard JSON definitions in Git repository |
| **Automated Provisioning** | Terraform + Grafana Provisioning API |
| **Configuration Path** | `/monitoring/grafana/dashboards/` |
| **Backup Strategy** | Daily export to JSON in version control |

---

# 🔐 **5. Access Control & Permissions**

## **5.1 Access Model**

Grafana implements a structured access control model aligned with organizational roles.

| **Role** | **Permissions** | **Scope** |
|---------|---------------|-----------|
| **Admin** | Full administrative access | Global |
| **Editor** | Dashboard creation & editing | Assigned folders |
| **Viewer** | Read-only dashboard access | Assigned folders |
| **Research** | Special mixed permissions | Research dashboards |

## **5.2 Team-Based Access**

Access is managed via Active Directory groups for streamlined authorization.

| **Team** | **AD Group** | **Dashboard Access** |
|---------|-------------|---------------------|
| **Infrastructure** | `lab-infra-team` | Infrastructure, Proxmox, Network |
| **Research** | `lab-research-team` | Research Workloads, K8s Monitoring |
| **Security** | `lab-security-team` | Security Insights, Audit Logs |
| **Management** | `lab-management` | Overview dashboards, SLA monitoring |

---

# 🖼️ **6. Dashboard Showcase**

## **6.1 Featured Dashboards**

Highlighted dashboards that demonstrate key monitoring capabilities.

| **Dashboard** | **Screenshot** | **Features** |
|--------------|---------------|------------|
| **Proxmox Cluster Flux** | [Screenshot](/assets/images/dashboards/promox-cluster-flux-graphical-dashboard-screenshot.png) | Animated node visualization, resource graphs |
| **Node Exporter Full** | [Screenshot](/assets/images/dashboards/node-exporter-full-dashboard-screenshot.png) | Comprehensive system metrics, alerts integration |
| **NVIDIA GPU** | [Screenshot](/assets/images/dashboards/nvdia-gpu-dashboard-screenshot.png) | CUDA metrics, temperature monitoring, utilization |
| **PostgreSQL** | [Screenshot](/assets/images/dashboards/postgresql-dashboard-screenshot.png) | Query performance, connection tracking, index stats |

---

# 🔄 **7. Implementation Status**

Current status and next steps for the Grafana implementation.

| **Component** | **Status** | **Next Steps** |
|--------------|-----------|----------------|
| **Core Platform** | ✅ Complete | Upgrade to latest version |
| **Dashboard Provisioning** | ✅ Complete | Expand Terraform automation |
| **LDAP Integration** | ✅ Complete | Add group membership sync |
| **Alerting Integration** | 🚧 In Progress | Complete AlertManager coupling |
| **Research Data Visualizations** | 🚧 In Progress | Build SDR analysis dashboards |
| **Public Dashboard Access** | ⏳ Planned | Enable for Phase 4 |

---

# 🔗 **8. Directory Contents**

This section provides direct navigation to key related documents:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Grafana Configuration** | Technical configuration details | [Grafana Configuration](/monitoring/grafana/configuration.yml) |
| **Dashboard Templates** | Standard dashboard JSON templates | [Dashboard Templates](/monitoring/grafana/dashboards/README.md) |
| **Provisioning Scripts** | Automation for dashboard deployment | [Provisioning Scripts](/monitoring/grafana/provisioning/README.md) |

---

# 🔄 **9. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Prometheus** | Primary metrics source | [Prometheus Documentation](/monitoring/prometheus/README.md) |
| **AlertManager** | Alerting integration | [AlertManager Documentation](/monitoring/alertmanager/README.md) |
| **Loki** | Log visualization source | [Loki Documentation](/monitoring/loki/README.md) |
| **Infrastructure** | Monitored systems | [Infrastructure Documentation](/infrastructure/README.md) |
| **ITIL Processes** | Operational monitoring | [ITIL Documentation](/docs/ITIL-Processes/README.md) |

---

# ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ⏳ In Progress |

---

# 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for Grafana | VintageDon |

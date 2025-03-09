---
title: "Grafana Visualization Layer - Proxmox Astronomy Lab"
description: "Documentation for the Grafana visualization layer, including dashboard structure and integrations."
author: "VintageDon"
tags: ["grafana", "monitoring", "dashboards", "visualization"]
category: "Services"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---

# **Grafana Visualization Layer**

## **1. Overview**

### **1.1 Purpose**

Grafana serves as the **visualization layer** for the **Proxmox Astronomy Lab's monitoring stack**, providing an intuitive interface for analyzing and interpreting **Prometheus-collected data**. It integrates with multiple data sources and supports both **real-time and historical monitoring** of lab infrastructure, applications, and research workloads.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| Dashboard creation & modification | Data collection (handled by Prometheus) |
| Integration with Prometheus, Loki, InfluxDB | Alerting rules (handled in AlertManager) |
| Public, modified, and custom dashboards | External cloud service monitoring |

---

## **2. Architecture & Data Sources**

Grafana aggregates data from multiple sources to provide a **single-pane-of-glass** monitoring experience:

| **Data Source** | **Integration Type** | **Purpose** |
|---------------|-----------------|-----------|
| **Prometheus** | Time-series database | System & service metrics |
| **Loki** | Log aggregation | Log-based insights |
| **InfluxDB** | Time-series database | Historical storage for long-term trends |
| **PostgreSQL** | SQL database | Querying structured data |

Grafana runs as a **Docker container** on `lab-mon01` and is accessed via:

- **Internal URL**: `https://mon.beardinthe.cloud`
- **Public access**: **No public exposure** (only accessible via VPN/SSO)

---

## **3. Dashboard Structure & Organization**

| **Category** | **Dashboards** |
|-------------|---------------|
| **Application Monitoring** | Gitea Repository Dashboard |
| **Databases** | PostgreSQL Databases |
| **Docker & Containers** | cAdvisor: Compute Resources, cAdvisor: Docker Insights, cAdvisor: Performance Dashboard |
| **GPU Monitoring** | NVIDIA GPU Metrics |
| **Logging & Security** | SSH Logs: By Machine, SSH Logs: Global View |
| **Network Monitoring** | DNS Filtering, SNMP Device Summary, SNMP Exporter, SNMP Interface Detail |
| **Proxmox Cluster** | Proxmox Cluster, Graphical (Flux), Proxmox Cluster, Numeric (Flux), Proxmox Cluster, Alt (Flux) |
| **VM Monitoring** | Linux: Top Processes, Node Exporter Full |

---

## **4. Dashboard Sources**

Grafana dashboards are sourced from a mix of:

| **Source Type** | **Description** |
|---------------|----------------|
| **Official Public Dashboards** | Downloaded from the **Grafana Dashboard Repository** and adapted for lab use. |
| **Modified Public Dashboards** | Tweaked versions of public dashboards to match lab-specific needs. |
| **Fully Custom Dashboards** | Built from scratch for specialized monitoring requirements. |

Dashboard JSON configurations are stored in the repository under:

```
/monitoring/grafana/dashboards/
```

---

## **5. Next Steps**

✅ **Grafana fully deployed & operational.**  
✅ **Dashboards structured & categorized.**  
📌 **Next: Automate dashboard provisioning using Terraform/Grafana API.**  
📌 **Future Enhancements: Centralized RBAC, additional ML-driven analytics.**  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

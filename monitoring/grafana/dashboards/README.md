<!-- ---
title: "Grafana Dashboards - Proxmox Astronomy Lab"
description: "Documentation for Grafana dashboards, including their purpose, sources, and associated screenshots."
author: "VintageDon"
tags: ["grafana", "monitoring", "dashboards", "visualization"]
category: "Services"
kb_type: "Dashboard Reference Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Grafana Dashboards**

## **1. Overview**

### **1.1 Purpose**

This document provides an overview of all **Grafana dashboards** used in the **Proxmox Astronomy Lab** monitoring stack. Each dashboard includes:

- **Purpose**: What it monitors.
- **Source Data**: Prometheus, Loki, InfluxDB, or other sources.
- **Screenshot Reference**: Stored in `/assets/images/`.

### **1.2 Screenshot Naming Convention**

All screenshots are stored in `/assets/images/` using the naming format:

```
[dashboard-name]-screenshot.png
```

Example: `gitea-repository-screenshot.png`

---

## **2. Dashboards Overview**

### **2.1 Application Monitoring**

#### **Gitea Repository Dashboard**

- **Purpose**: Tracks repository activity, commits, and users.
- **Data Source**: Prometheus
- **Screenshot:**  
  ![gitea-repository-dashboard-screenshot](/assets/images/dashboards/gitea-repository-dashboard-screenshot.png)

### **2.2 Databases**

#### **PostgreSQL Databases**

- **Purpose**: Monitors query performance and DB health.
- **Data Source**: PostgreSQL Exporter
- **Screenshot:**  
  ![postgresql-dashboard-screenshot](/assets/images/dashboards/postgresql-dashboard-screenshot.png)

### **2.3 Docker & Containers**

#### **cAdvisor: Compute Resources**

- **Purpose**: Per-container CPU and memory usage.
- **Data Source**: cAdvisor
- **Screenshot:**  
  ![cadvisor-compute-resources-dashboard-screenshot](/assets/images/dashboards/cadvisor-compute-resources-dashboard-screenshot.png)

#### **cAdvisor: Docker Insights**

- **Purpose**: Live monitoring of containerized workloads.
- **Data Source**: cAdvisor
- **Screenshot:**  
  ![cadvisor-docker-insights-dashboard-screenshot](/assets/images/dashboards/cadvisor-docker-insights-dashboard-screenshot.png)

#### **cAdvisor: Performance Dashboard**

- **Purpose**: Disk I/O and network performance per container.
- **Data Source**: cAdvisor
- **Screenshot:**  
  ![cadvisor-performance-dashboard-screenshot](/assets/images/dashboards/cadvisor-performance-dashboard-screenshot.png)

### **2.4 GPU Monitoring**

#### **NVIDIA GPU Metrics**

- **Purpose**: GPU load, temperature, and VRAM usage.
- **Data Source**: GPU Exporter
- **Screenshot:**  
  ![dashboards/nvdia-gpu-dashboard-screenshot](/assets/images/dashboards/nvdia-gpu-dashboard-screenshot.png)

### **2.5 Logging & Security**

#### **SSH Logs: By Machine**

- **Purpose**: Per-machine SSH login attempts.
- **Data Source**: Loki

#### **SSH Logs: Global View**

- **Purpose**: Cluster-wide SSH access tracking.
- **Data Source**: Loki

### **2.6 Network Monitoring**

#### **DNS Filtering**

- **Purpose**: Query logs and filter efficiency.
- **Data Source**: Prometheus
- **Screenshot:**  
  ![dns-filtering-dashboard-screenshot](/assets/images/dashboards/dns-filtering-dashboard-screenshot.png)

#### **SNMP Device Summary**

- **Purpose**: General SNMP statistics from switches.
- **Data Source**: SNMP Exporter
- **Screenshot:**  
  ![network-snmp-device-smmary-dashboard-screenshot](/assets/images/dashboards/network-snmp-device-smmary-dashboard-screenshot.png)

#### **SNMP Exporter**

- **Purpose**: Tracks network device metrics.
- **Data Source**: SNMP Exporter
- **Screenshot:**  
  ![network-snmp-exporter-dashboard-screenshot](/assets/images/dashboards/network-snmp-exporter-dashboard-screenshot.png)

#### **SNMP Interface Detail**

- **Purpose**: Interface-level network usage and errors.
- **Data Source**: SNMP Exporter
- **Screenshot:**  
  ![network-snmp-exporter-interface-detail-dashboard-screenshot](/assets/images/dashboards/network-snmp-exporter-interface-detail-dashboard-screenshot.png)

### **2.7 Proxmox Cluster**

#### **Proxmox Cluster, Graphical (Flux)**

- **Purpose**: Node resource usage visualization.
- **Data Source**: Prometheus
- **Screenshot:**  
  ![promox-cluster-flux-graphical-dashboard-screenshot](/assets/images/dashboards/promox-cluster-flux-graphical-dashboard-screenshot.png)

#### **Proxmox Cluster, Numeric (Flux)**

- **Purpose**: Cluster-wide performance in numerical format.
- **Data Source**: Prometheus
- **Screenshot:**  
  ![promox-cluster-flux-numerical-dashboard-screenshot](/assets/images/dashboards/promox-cluster-flux-numerical-dashboard-screenshot.png)

#### **Proxmox Cluster, Alt (Flux)**

- **Purpose**: Alternative cluster monitoring layout.
- **Data Source**: Prometheus

### **2.8 VM Monitoring**

#### **Linux: Top Processes**

- **Purpose**: Shows highest CPU/memory-consuming processes.
- **Data Source**: Process Exporter

#### **Node Exporter Full**

- **Purpose**: Full system metrics per VM.
- **Data Source**: Node Exporter
- **Screenshot:**  
  ![node-exporter-full-dashboard-screenshot](/assets/images/dashboards/node-exporter-full-dashboard-screenshot.png)

---

## **3. Screenshot Management & Updates**

- **Updating Screenshots**: Replace existing images in `/assets/images/` with updated versions, maintaining the same naming format.
- **Adding a New Dashboard**: Update this document with a new entry and create a corresponding screenshot.

---

## **4. Next Steps**

✅ **Dashboards fully documented and categorized.**  
📌 **Next: Automate screenshot updates using Grafana API.**  
📌 **Future Enhancements: Tag-based dashboard search and filtering.**  

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


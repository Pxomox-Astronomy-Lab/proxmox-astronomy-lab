<!-- ---
title: "Proxmox Cluster Monitoring - Proxmox Astronomy Lab"
description: "Documentation for Proxmox cluster-level monitoring using InfluxDB and Grafana."
author: "VintageDon"
tags: ["proxmox", "monitoring", "influxdb", "grafana", "metrics"]
category: "Monitoring"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Proxmox Cluster Monitoring**

## **1. Overview**

### **1.1 Purpose**

The **Proxmox metrics server** provides a **native, low-overhead** method for collecting high-level cluster and node metrics. These metrics are **pushed directly to InfluxDB** and visualized in **Grafana**, offering a **more reliable** source of cluster-wide health data compared to scraped exporters.

This setup does **not replace Node Exporter**, but rather **complements it**:

- **Proxmox Metrics → Best for Cluster-Wide Monitoring** (high-level, built-in, reliable).  
- **Node Exporter → Best for Deep-Dive System Analysis** (per-node, granular, detailed).  

By integrating both, we get **the best of both worlds**: a **trustworthy cluster view** with **detailed system telemetry** when needed.

---

## **2. Architecture & Data Flow**

The Proxmox cluster monitoring stack consists of:

| **Component** | **Role** |
|-------------|--------|
| **Proxmox Metrics Server** | Natively pushes cluster and VM stats to InfluxDB |
| **InfluxDB (mon01)** | Stores Proxmox’s metrics (running as a container) |
| **Grafana (mon01)** | Visualizes cluster performance data |
| **AlertManager** | Uses Proxmox’s direct metrics for more accurate alerting |

📌 **InfluxDB Configuration Screenshot:**  
![proxmox-metrics-server-settings](/assets/images/proxmox-metrics-server-settings.png)

---

## **3. Benefits of Proxmox Metrics Over Scraped Data**

### ✅ **Proxmox’s Metrics Are the "Source of Truth"**

Instead of relying on logs or external scrapers, **Proxmox natively knows** when a node or VM is online, making its metrics the most **reliable alerting source.**

### ✅ **Low Overhead vs. Prometheus Scrapers**

- **Prometheus scrapers (Node Exporter, cAdvisor)** constantly query nodes, adding system load.
- **Proxmox pushes metrics to InfluxDB**, eliminating polling overhead.

### ✅ **Cluster-Level Metrics Not Available in Node Exporter**

- **Cluster-wide CPU/memory stats**
- **Storage I/O trends**
- **VM performance aggregated at a node level**
- **Actual Proxmox status values** (e.g., is a VM paused or shut down?)

📌 **Proxmox Cluster Dashboard Screenshot:**  
![proxmox-cluster-flux-graphical-dashboard-screenshot](/assets/images/dashboards/proxmox-cluster-flux-graphical-dashboard-screenshot.png)

---

## **4. What Node Exporter Still Provides**

While Proxmox’s metrics are **better for big-picture monitoring**, **Node Exporter remains essential**:

| **Metric** | **Proxmox Metrics Server** | **Node Exporter** |
|-----------|------------------|---------------|
| Cluster-wide CPU/memory | ✅ Yes | ❌ No |
| VM I/O and network usage | ✅ Yes | ❌ No |
| Node CPU temperature | ❌ No | ✅ Yes |
| Per-core CPU usage | ❌ No | ✅ Yes |
| Per-node disk I/O & partitions | ❌ No | ✅ Yes |
| Process-level monitoring | ❌ No | ✅ Yes |

🚀 **Every node still runs Node Exporter** for deep analysis when needed!

---

## **5. Next Steps**

✅ **Proxmox Metrics → InfluxDB pipeline is fully operational.**  
✅ **Grafana dashboards structured for optimal cluster visibility.**  
📌 **Next: Expand alerting to prioritize Proxmox-based metrics over log-based alerts.**  
📌 **Future Enhancements: Automate dashboard deployment & integrate additional Proxmox metadata.**  

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


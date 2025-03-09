---
title: "Prometheus Event Management & Alerting Overview"
description: "ITIL-aligned documentation of all Prometheus monitoring targets, including exporters, key metrics, and alerting structure."
author: "VintageDon"
tags: ["prometheus", "monitoring", "ITIL", "alerting", "power automate"]
category: "Services"
kb_type: "Service Configuration Document"
version: "1.1"
status: "Draft"
last_updated: "2025-03-09"
---

# **Prometheus Event Management & Alerting Overview**

## **1. Overview**

### **1.1 Purpose**

This document serves as both an **ITIL-aligned Service Configuration Document (SACM)** and a **practical reference for operations and troubleshooting**. It outlines:

- All **Prometheus monitoring targets**, organized by **exporter type**.
- **Key metrics collected** for each exporter.
- **Alerting structure and response expectations**.
- **Current email-based alerting and transition to Teams Adaptive Cards**.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| All configured Prometheus monitoring jobs | Future advanced alert correlation & storm control |
| Exporters and data sources | Anomaly detection (future) |
| Alert routing and response expectations | Full escalation workflows (future) |

---

## **2. Prometheus Monitored Targets**

Each Prometheus **scrape job** collects metrics from a specific type of target. Below is a breakdown of **exporters, their purpose, key metrics, and monitored instances**.

### **2.1 Node Exporter**  

**Purpose:** Collects system-level metrics from all **Linux-based servers**, including **Proxmox nodes, Kubernetes nodes, application servers, and infrastructure VMs**. These metrics provide insights into **CPU load, memory usage, disk I/O, and network performance**.  

**Key Metrics Collected:**  

- **CPU Metrics**: Load average, CPU utilization per core, context switches.  
- **Memory Metrics**: Used/available memory, swap usage, page faults.  
- **Disk Metrics**: Read/write throughput, disk latency, filesystem usage.  
- **Network Metrics**: Interface throughput, packet errors, dropped packets.  

#### **Monitored Instances (Full List from prometheus.yml)**  

| **Instance Name**   | **IP Address**    | **Scrape Interval** |  
|---------------------|------------------|---------------------|  
| `proxmox-node01`   | 10.16.207.201:9100 | 15s |  
| `proxmox-node02`   | 10.16.207.202:9100 | 15s |  
| `proxmox-node03`   | 10.16.207.203:9100 | 15s |  
| `proxmox-node04`   | 10.16.207.204:9100 | 15s |  
| `proj-k8sm01`      | 10.25.20.4:9100   | 15s |  
| `proj-k8sm02`      | 10.25.20.5:9100   | 15s |  
| `proj-k8sm03`      | 10.25.20.6:9100   | 15s |  
| `proj-k8sw01`      | 10.25.20.7:9100   | 15s |  
| `proj-k8sw02`      | 10.25.20.8:9100   | 15s |  
| `proj-k8sw03`      | 10.25.20.9:9100   | 15s |  
| `proj-k8sw04`      | 10.25.20.10:9100  | 15s |  
| `proj-k8sw05`      | 10.25.20.11:9100  | 15s |  
| `proj-kasm01`      | 10.25.20.12:9100  | 15s |  
| `lab-dns01`        | 10.25.10.3:9100   | 15s |  
| `lab-dns02`        | 10.25.20.3:9100   | 15s |  
| `lab-mon01`        | 10.25.10.13:9100  | 15s |  
| `lab-soc1`         | 10.25.10.14:9100  | 15s |  
| `lab-ansible01`    | 10.25.10.15:9100  | 15s |  
| `lab-port01`       | 10.25.10.16:9100  | 15s |  
| `proj-pgts01`      | 10.25.20.13:9100  | 15s |  
| `proj-pg01`        | 10.25.20.14:9100  | 15s |  
| `proj-pggis01`     | 10.25.20.15:9100  | 15s |  
| `proj-apps01`      | 10.25.20.21:9100  | 15s |  
| `lab-db01`         | 10.25.10.17:9100  | 15s |  
| `lab-apps01`       | 10.25.10.18:9100  | 15s |  

✅ **Total Targets Monitored:** 27  
✅ **Retention Policy:** Metrics stored for **90 days** before compaction.  
✅ **Integration:** Node Exporter data is **visualized in Grafana dashboards** for performance monitoring.  

### **2.2 Process Exporter**  

**Purpose:** Tracks system-level **process metrics** for Linux-based servers, providing insights into **running processes, CPU/memory consumption per process, and process lifecycle events**. This exporter is crucial for identifying **resource-hungry processes, zombie processes, and service anomalies**.  

**Key Metrics Collected:**  

- **Process Count**: Total running processes per system.  
- **CPU Utilization**: Per-process CPU consumption.  
- **Memory Consumption**: Memory footprint of individual processes.  
- **Process State Tracking**: Counts of running, sleeping, zombie, and stopped processes.  
- **FD & Thread Counts**: Number of open file descriptors and active threads.  

#### **Monitored Instances (Full List from prometheus.yml)**  

| **Instance Name**   | **IP Address**    | **Scrape Interval** |  
|---------------------|------------------|---------------------|  
| `proj-k8sm01`      | 10.25.20.4:9256   | 15s |  
| `proj-k8sm02`      | 10.25.20.5:9256   | 15s |  
| `proj-k8sm03`      | 10.25.20.6:9256   | 15s |  
| `proj-k8sw01`      | 10.25.20.7:9256   | 15s |  
| `proj-k8sw02`      | 10.25.20.8:9256   | 15s |  
| `proj-k8sw03`      | 10.25.20.9:9256   | 15s |  
| `proj-k8sw04`      | 10.25.20.10:9256  | 15s |  
| `proj-k8sw05`      | 10.25.20.11:9256  | 15s |  
| `proj-kasm01`      | 10.25.20.12:9256  | 15s |  
| `lab-dns01`        | 10.25.10.3:9256   | 15s |  
| `lab-dns02`        | 10.25.20.3:9256   | 15s |  
| `lab-mon01`        | 10.25.10.13:9256  | 15s |  
| `lab-soc1`         | 10.25.10.14:9256  | 15s |  
| `lab-ansible01`    | 10.25.10.15:9256  | 15s |  
| `lab-port01`       | 10.25.10.16:9256  | 15s |  
| `proj-pgts01`      | 10.25.20.13:9256  | 15s |  
| `proj-pg01`        | 10.25.20.14:9256  | 15s |  
| `proj-pggis01`     | 10.25.20.15:9256  | 15s |  
| `proj-apps01`      | 10.25.20.21:9256  | 15s |  
| `lab-db01`         | 10.25.10.17:9256  | 15s |  
| `lab-apps01`       | 10.25.10.18:9256  | 15s |  

✅ **Total Targets Monitored:** 22  
✅ **Retention Policy:** Metrics stored for **90 days** before compaction.  
✅ **Integration:** Process Exporter data is **visualized in Grafana dashboards** for **process tracking and anomaly detection**.  

### **2.3 PostgreSQL Exporter**

- **Purpose**: Collects **database performance metrics** from PostgreSQL servers.
- **Key Metrics**:
  - Active connections, slow queries.
  - Query cache efficiency.
  - Replication lag and WAL write metrics.
- **Monitored Instances**:

  | **Instance** | **IP** | **Scrape Interval** |
  |-------------|--------|-----------------|
  | `proj-pgts01` | 10.25.20.13 | 15s |
  | `proj-pg01` | 10.25.20.14 | 15s |
  | `proj-pggis01` | 10.25.20.15 | 15s |

### **2.4 Blackbox Exporter**  

**Purpose:** Blackbox Exporter is used for **external service availability monitoring**, primarily focusing on **HTTPS/TCP reachability** of web-based interfaces and reverse proxies. This ensures that **critical web GUIs, monitoring dashboards, and management tools remain accessible**.  

**Key Metrics Collected:**  

- **HTTP Status Codes**: Ensures services return **200 OK** responses.  
- **SSL Certificate Expiry**: Tracks **TLS expiration dates**.  
- **Response Time**: Measures latency from Prometheus to each endpoint.  
- **DNS Resolution**: Ensures **internal DNS (dns01/dns02) resolves correctly**.  

#### **Monitored Instances (Full List from prometheus.yml & Local DNS Structure)**  

| **Service Name**      | **Monitored Endpoint**               | **Check Type** |
|----------------------|---------------------------------|----------------|
| **Prometheus**       | `https://prom.beardinthe.cloud` | HTTP (Port 9090) |
| **AlertManager**     | `https://alertm.beardinthe.cloud` | HTTP |
| **Grafana (lab-mon01)** | `https://mon.beardinthe.cloud` | HTTP |
| **Grafana (proj-apps01)** | `https://vis01.beardinthe.cloud` | HTTP |
| **Portainer**        | `https://port.beardinthe.cloud` | HTTP |
| **Gitea (Lab)**      | `https://gitea01.beardinthe.cloud` | HTTP |
| **Gitea (Project)**  | `https://gitea02.beardinthe.cloud` | HTTP |
| **InfluxDB GUI**     | `https://influx01.beardinthe.cloud` | HTTP |
| **Proxmox Backup Server (PBS)** | `https://backup01.beardinthe.cloud` | HTTP |
| **Helpdesk (GLPI)**  | `https://helpdesk.beardinthe.cloud` | HTTP |
| **Vault**            | `https://vault01.beardinthe.cloud` | HTTP |
| **Wiki.js**          | `https://wiki.beardinthe.cloud` | HTTP |
| **Wazuh SIEM**       | `https://wazuh.beardinthe.cloud` | HTTP |
| **Nextcloud**        | `https://nc.beardinthe.cloud` | HTTP |
| **Zitadel (IAM)**    | `https://zitidel.beardinthe.cloud` | HTTP |
| **Labswitch01**      | `https://labswitch01.beardinthe.cloud` | HTTP |
| **Labswitch02**      | `https://labswitch02.beardinthe.cloud` | HTTP |
| **DNS Resolver 1**   | `https://dns01.beardinthe.cloud` | HTTP |
| **DNS Resolver 2**   | `https://dns02.beardinthe.cloud` | HTTP |

✅ **Total Targets Monitored:** 20  
✅ **Alerting Rules:** If a service is unreachable for **5 minutes**, an **alert is sent via AlertManager**.  
✅ **Retention Policy:** Metrics stored for **30 days** to track uptime trends.  

### **2.5 SNMP Exporter**

- **Purpose**: Monitors **network devices** via SNMP.
- **Key Metrics**:
  - Interface throughput.
  - Packet errors and drops.
  - CPU/memory usage on network appliances.
- **Monitored Devices**:

  | **Device** | **IP** | **Scrape Interval** |
  |---------------|-------------|-----------------|
  | `labswitch01` | 10.16.207.200 | 30s |
  | `labswitch02` | 10.16.207.207 | 30s |

---

### **2.6 GPU Exporter**  

**Purpose:** The **GPU Exporter** collects **real-time performance metrics** from the **NVIDIA RTX A4000 GPU** on `proj-k8sw04`. This data is essential for **monitoring AI/ML workloads, video encoding, and scientific computations**, ensuring optimal GPU performance and availability.  

**Key Metrics Collected:**  

- **GPU Utilization**: Percentage of compute resources in use.  
- **Memory Usage**: VRAM consumption vs. total available.  
- **Power Consumption**: Current power draw in watts.  
- **Temperature**: GPU core temperature monitoring.  
- **Fan Speed**: Ensuring adequate cooling for sustained workloads.

---

### **2.7 Gitea Exporter**  

**Purpose:** The **Gitea Exporter** collects **repository, user, and system-level metrics** from both **lab and project Gitea instances**. This ensures **availability, performance tracking, and issue monitoring** for **source control and code management** in the lab.  

**Key Metrics Collected:**  

- **Repository Statistics**: Number of repos, commits, and pull requests.  
- **User Activity**: Active users, failed login attempts, authentication latency.  
- **System Performance**: CPU usage, memory consumption, and request response times.  
- **HTTP Request Rates**: Tracks API and UI request loads over time.  

#### **Monitored Instances (From prometheus.yml)**  

| **Instance Name** | **IP Address**    | **Scrape Interval** |  
|------------------|------------------|---------------------|  
| `lab-gitea01`   | 10.25.10.18:3000  | 15s |  
| `proj-gitea02`  | 10.25.20.22:3000  | 15s |  

✅ **Total Gitea Targets Monitored:** 2  
✅ **Retention Policy:** Metrics stored for **90 days**.  
✅ **Integration:** Data visualized in **Grafana dashboards for repository health**, with alerts triggering if:  

- **Authentication failures exceed threshold** (potential brute-force).  
- **Repo push/pull latencies increase beyond 2s avg**.  
- **Instance is unreachable for 5+ minutes**.  

---

#### **Monitored Instances (From prometheus.yml)**  

| **Instance Name** | **IP Address**    | **Scrape Interval** |  
|------------------|------------------|---------------------|  
| `proj-k8sw04`   | 10.25.20.10:9835  | 15s |  

✅ **Total GPU Targets Monitored:** 1  
✅ **Retention Policy:** GPU metrics stored for **90 days**.  
✅ **Integration:** Data is visualized in **Grafana GPU dashboards**, and alerts trigger if:  

- **Utilization remains above 95% for 30+ minutes**.  
- **Temperature exceeds 85°C**.  
- **Fan speed is consistently low despite high temps**.  

---

### **2.8 cAdvisor Exporter**  

**Purpose:** The **cAdvisor (Container Advisor) Exporter** collects **container-level performance metrics** from **Docker and Kubernetes environments**. It provides real-time insights into **CPU, memory, disk I/O, and network usage** for all running containers.  

This is critical for **monitoring Portainer-managed nodes, Kubernetes workloads, and InfluxDB performance on lab-mon01** to ensure resource efficiency and detect container issues.  

**Key Metrics Collected:**  

- **Container Resource Usage**: CPU, memory, and disk I/O per container.  
- **Network Performance**: Bandwidth usage and dropped packets.  
- **Container Lifecycle Tracking**: Start/stop events and uptime.  
- **Filesystem Metrics**: Per-container storage usage and read/write latency.  

#### **Monitored Instances (From prometheus.yml)**  

| **Instance Name** | **IP Address**    | **Scrape Interval** |  
|------------------|------------------|---------------------|  
| `lab-mon01`     | 10.25.10.13:8080  | 15s |  
| `lab-apps01`    | 10.25.10.18:8080  | 15s |  
| `proj-apps01`   | 10.25.20.21:8080  | 15s |  
| `lab-db01`      | 10.25.10.17:8080  | 15s |  

✅ **Total cAdvisor Targets Monitored:** 4  
✅ **Retention Policy:** Metrics stored for **90 days**.  
✅ **Integration:** Data visualized in **Grafana dashboards for container health**, with alerts triggering if:  

- **Container memory usage exceeds 90% consistently for 10m**.  
- **High CPU spikes (>85%) sustain for 15m**.  
- **Filesystem usage exceeds defined thresholds**.  

---

## **3. Alerting Overview**

### **3.1 Current Alerting Structure**

- **Delivery Method**: Email-based alerts via AlertManager.
- **Alert Types**:
  - **Infrastructure health** (server uptime, resource utilization).
  - **Service availability** (web UI, database connectivity, application state).
  - **System errors** (critical log events, high system load, network issues).

### **3.2 Planned Teams Integration (Adaptive Cards via Power Automate)**

Prometheus alerts will transition from email to **Teams Adaptive Cards** using **Power Automate**.

#### **Integration Plan**

- **Power Automate listens for AlertManager webhook events**.
- **Alerts are parsed and transformed into Adaptive Cards**.
- **Cards are posted to Teams monitoring channels** (based on severity and category).
- **Acknowledgment buttons** enable quick triage (assign, escalate, resolve).

#### **Teams Monitoring Channel Structure**

| **Channel Name** | **Purpose** |
|----------------|------------|
| **Apps** | Application alerts |
| **Cluster** | Proxmox cluster alerts |
| **Logs** | Log aggregation alerts |
| **Misc** | Uncategorized alerts |
| **Pipelines** | Data pipeline monitoring |
| **Security** | Security and SEIM alerts |
| **VMs** | Virtual machine alerts |

---

## **4. Next Steps**

✅ **Email alerting is live.**  
✅ **Teams Adaptive Cards tested and validated.**  
📌 **Next: Full migration of alerts to Teams + Power Automate.**  
📌 **Future Enhancements: Escalation workflows, alert correlation, and storm control.**  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.1 | 2025-03-09 | Full exporter breakdown, ITIL alignment | VintageDon |

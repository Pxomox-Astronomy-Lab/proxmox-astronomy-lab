<!-- ---
title: "Prometheus Target Configuration & Event Management"
description: "ITIL-aligned documentation of all Prometheus monitoring targets, including exporters, key metrics, and alerting structure."
author: "VintageDon"
tags: ["prometheus", "monitoring", "ITIL", "alerting", "power automate"]
category: "Services"
kb_type: "Service Configuration Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Prometheus Target Configuration & Event Management**

## **1. Overview**

### **1.1 Purpose**

This document serves as an **ITIL-aligned Service Configuration Document (SACM)** that:

- Provides a **structured reference for all Prometheus monitoring targets**.
- Defines **key metrics collected per exporter**.
- Describes **alerting policies and event management workflows**.
- Supports **troubleshooting and service impact analysis**.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| Prometheus monitoring targets | Advanced anomaly detection (future) |
| Exporters and collected metrics | AI/ML-based alert correlation (future) |
| Alert routing and response expectations | Full incident resolution workflows (future) |

---

## **2. Prometheus Monitored Targets**

### **2.1 Node Exporter**

- **Purpose**: Collects system-level metrics from Linux-based servers.
- **Key Metrics**: CPU load, memory usage, disk I/O, network traffic.
- **Monitored Instances**:
  - `proxmox-node01`, `proxmox-node02`, `proxmox-node03`, `proxmox-node04`
  - `proj-k8sm01`, `proj-k8sm02`, `proj-k8sm03`
  - `proj-k8sw01`, `proj-k8sw02`, `proj-k8sw03`, `proj-k8sw04`, `proj-k8sw05`
  - `lab-dns01`, `lab-dns02`, `lab-mon01`, `lab-soc1`, `lab-ansible01`
  - `proj-pgts01`, `proj-pg01`, `proj-pggis01`, `proj-apps01`, `lab-db01`, `lab-apps01`

### **2.2 Process Exporter**

- **Purpose**: Tracks per-process CPU/memory usage and running states.
- **Key Metrics**: Active processes, zombie processes, resource-hungry tasks.
- **Monitored Instances**: Same as Node Exporter.

### **2.3 PostgreSQL Exporter**

- **Purpose**: Monitors PostgreSQL database health.
- **Key Metrics**: Active connections, query performance, replication lag.
- **Monitored Instances**: `proj-pgts01`, `proj-pg01`, `proj-pggis01`

### **2.4 Blackbox Exporter**

- **Purpose**: Performs HTTP/TCP health checks for critical web services.
- **Monitored Endpoints**:
  - `prom.beardinthe.cloud`, `alertm.beardinthe.cloud`, `mon.beardinthe.cloud`
  - `port.beardinthe.cloud`, `gitea01.beardinthe.cloud`, `gitea02.beardinthe.cloud`
  - `influx01.beardinthe.cloud`, `backup01.beardinthe.cloud`, `helpdesk.beardinthe.cloud`
  - `vault01.beardinthe.cloud`, `wiki.beardinthe.cloud`, `wazuh.beardinthe.cloud`
  - `nc.beardinthe.cloud`, `zitidel.beardinthe.cloud`, `labswitch01.beardinthe.cloud`, `labswitch02.beardinthe.cloud`

### **2.5 SNMP Exporter**

- **Purpose**: Monitors network devices via SNMP.
- **Monitored Devices**: `labswitch01`, `labswitch02`

### **2.6 GPU Exporter**

- **Purpose**: Collects performance data from the RTX A4000 GPU.
- **Monitored Instance**: `proj-k8sw04`

### **2.7 Gitea Exporter**

- **Purpose**: Monitors Gitea repositories and user activity.
- **Monitored Instances**: `lab-gitea01`, `proj-gitea02`

### **2.8 cAdvisor Exporter**

- **Purpose**: Collects container metrics for Docker & Kubernetes workloads.
- **Monitored Instances**: `lab-mon01`, `lab-apps01`, `proj-apps01`, `lab-db01`

---

## **3. Alerting & Event Management**

### **3.1 Alerting Rules & Notification Flow**

| **Alert Type** | **Source** | **Severity** | **Notification** |
|--------------|----------|------------|----------------|
| Node Down | Node Exporter | Critical | Teams + Email |
| Service Unreachable | Blackbox Exporter | High | Email |
| High CPU Load | Node/Process Exporter | Medium | Email |
| High Disk Usage | Node Exporter | Medium | Email |
| Database Query Lag | PostgreSQL Exporter | High | Email |
| High GPU Utilization | GPU Exporter | Medium | Teams + Email |

### **3.2 Incident Response Workflow**

1. **Alert Triggered** → AlertManager routes to **Teams & Email**.
2. **Incident Logged** → GLPI ticket auto-created for P1 & P2 alerts.
3. **Triage & Diagnosis** → Engineer assesses issue severity.
4. **Resolution & Verification** → Service restored, postmortem documented.

### **3.3 Teams Adaptive Cards Integration (Planned)**

- **Alerts will transition from Email to Teams Adaptive Cards** via Power Automate.
- **Integration Plan**:
  - Power Automate listens for **AlertManager Webhook events**.
  - Alerts transformed into **Adaptive Cards**.
  - Cards posted in **Teams monitoring channels**.
  - **Acknowledge/Resolve buttons** for structured triage.

#### **Teams Monitoring Channels**

| **Channel** | **Purpose** |
|------------|------------|
| **Apps** | Application alerts |
| **Cluster** | Proxmox cluster alerts |
| **Logs** | Log aggregation alerts |
| **Security** | Security monitoring & SIEM alerts |
| **VMs** | Virtual machine health |

---

## **4. Summary & Next Steps**

✅ **Prometheus target configuration is fully documented.**  
✅ **Alerting pipeline structured with ITIL-aligned event management.**  
📌 **Next: Implement Teams Adaptive Cards integration.**  
📌 **Future Enhancements: Escalation workflows, AI-driven alert correlation.**  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial document, full target & event management breakdown | VintageDon |



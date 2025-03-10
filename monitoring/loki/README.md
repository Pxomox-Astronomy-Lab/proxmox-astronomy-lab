<!-- ---
title: "Loki Logging System - Proxmox Astronomy Lab"
description: "Documentation for Loki, including configuration and logging structure."
author: "VintageDon"
tags: ["loki", "logging", "monitoring", "observability"]
category: "Services"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
---
 -->

# **Loki Logging System**

## **1. Overview**

### **1.1 Purpose**

Loki serves as the **centralized logging solution** for the **Proxmox Astronomy Lab**, aggregating logs from key infrastructure components. Unlike traditional log aggregation systems, Loki is **efficient and index-free**, designed to work seamlessly with **Promtail** and **Grafana** for log visualization.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| Aggregation of system logs | Advanced log correlation & AI analysis (future) |
| Promtail log scraping | Long-term log retention beyond 30 days |
| Integration with Grafana | SIEM-level security auditing |

Loki is deployed on `lab-mon01` and ingests logs from **various system components**, including authentication, kernel, syslog, and security tools like Fail2Ban.

---

## **2. Configuration Overview**

Loki is configured to **listen on port 9080** and receives logs via **Promtail**, which is installed on key infrastructure nodes.

```yaml
### **Loki Configuration with Structured Comment Blocks & Compliance Context**  
# ──────────────────────────────────────────────────────────────────────────
# LOKI CONFIGURATION - PROXMOX ASTRONOMY LAB
# Centralized log aggregation using Loki.
# - Logs system, authentication, security, and package management events.
# - Retains logs for 30 days before compaction.
# - Integrated with Promtail for log collection.
# - Supports Grafana for log visualization.
# ──────────────────────────────────────────────────────────────────────────

server:
  # Loki's internal HTTP server for API access and log ingestion.
  http_listen_port: 9080

positions:
  # Stores the last read positions of logs to prevent duplication.
  filename: /tmp/positions.yaml

clients:
# Loki client configuration - sending logs to Loki's API endpoint on lab-mon01.
- url: http://10.25.10.13:3100/loki/api/v1/push

scrape_configs:

# ──────────────────────────────────────────────────────────────────────────
# SYSTEM LOGS
# Captures general system-wide events from journalctl.
# 🔹 **Compliance Context**: Provides a complete system event audit trail.
#    - CIS v8: Section 6.2 (Audit Logs)
#    - NIST 800-53: AU-3 (Content of Audit Records)
# ──────────────────────────────────────────────────────────────────────────
- job_name: system
  journal:
    max_age: "24h" # Retains logs for the last 24 hours.
    labels:
      job: system
      hostname: lab-mon01 # Hostname label for identifying logs.

# ──────────────────────────────────────────────────────────────────────────
# AUTHENTICATION LOGS
# Captures all login attempts, sudo commands, and authentication-related events.
# 🔹 **Compliance Context**: Required for tracking authentication activity.
#    - CIS v8: Section 6.2.1 (Log Authentication Events)
#    - NIST 800-53: AC-7 (Unsuccessful Login Attempts)
# ──────────────────────────────────────────────────────────────────────────
- job_name: auth
  static_configs:
  - targets: [ "localhost" ]
    labels:
      job: auth
      __path__: /var/log/auth.log
      hostname: lab-mon01

# ──────────────────────────────────────────────────────────────────────────
# KERNEL LOGS
# Captures kernel messages, warnings, and critical system errors.
# 🔹 **Compliance Context**: Helps detect kernel anomalies and system compromises.
#    - CIS v8: Section 6.2.3 (Monitor Kernel Logs)
#    - NIST 800-53: SI-4 (System Monitoring)
# ──────────────────────────────────────────────────────────────────────────
- job_name: kern
  static_configs:
  - targets: [ "localhost" ]
    labels:
      job: kern
      __path__: /var/log/kern.log
      hostname: lab-mon01

# ──────────────────────────────────────────────────────────────────────────
# GENERAL SYSTEM LOGS
# Captures logs from syslog, covering general system events.
# 🔹 **Compliance Context**: Essential for tracking system-wide events.
#    - CIS v8: Section 6.2.2 (Monitor System Logs)
#    - NIST 800-53: AU-3 (Audit Record Content)
# ──────────────────────────────────────────────────────────────────────────
- job_name: syslog
  static_configs:
  - targets: [ "localhost" ]
    labels:
      job: syslog
      __path__: /var/log/syslog
      hostname: lab-mon01

# ──────────────────────────────────────────────────────────────────────────
# PACKAGE MANAGEMENT LOGS
# Captures logs related to software installations and updates.
# 🔹 **Compliance Context**: Tracks package installations for security auditing.
#    - CIS v8: Section 6.2.4 (Log Software Installations)
#    - NIST 800-53: CM-6 (Configuration Change Control)
# ──────────────────────────────────────────────────────────────────────────
- job_name: dpkg
  static_configs:
  - targets: [ "localhost" ]
    labels:
      job: dpkg
      __path__: /var/log/dpkg.log
      hostname: lab-mon01

# ──────────────────────────────────────────────────────────────────────────
# SECURITY MONITORING (Fail2Ban)
# Monitors intrusion attempts, including failed SSH login attempts.
# 🔹 **Compliance Context**: Helps prevent brute-force attacks and unauthorized access.
#    - CIS v8: Section 6.4 (Log Security Events)
#    - NIST 800-53: SI-4 (System Monitoring), AC-7 (Account Lockout)
# ──────────────────────────────────────────────────────────────────────────
- job_name: fail2ban
  static_configs:
  - targets: [ "localhost" ]
    labels:
      job: fail2ban
      __path__: /var/log/fail2ban.log
      hostname: lab-mon01
```

---

## **3. Log Sources & Job Breakdown**

Loki scrapes logs using **Promtail**, which is configured to collect logs from various sources:

| **Job Name** | **Log Path** | **Purpose** |
|-------------|-------------|------------|
| `system` | `journalctl` | Captures general system events. |
| `auth` | `/var/log/auth.log` | Authentication events, SSH logins. |
| `kern` | `/var/log/kern.log` | Kernel messages and warnings. |
| `syslog` | `/var/log/syslog` | General system logs. |
| `dpkg` | `/var/log/dpkg.log` | Package installation logs. |
| `fail2ban` | `/var/log/fail2ban.log` | Banned IPs and intrusion attempts. |

Loki retains logs for **30 days** before automatic compaction and removal.

---

## **4. Integration with Grafana**

Loki logs are **visualized in Grafana**, allowing for **real-time querying** using LogQL.

- **Grafana Data Source**: `Loki (http://10.25.10.13:3100)`
- **Log Querying**: LogQL supports filtering based on labels (e.g., `job="auth"` to view authentication logs).
- **Dashboards Available**:
  - **SSH Logs: By Machine**
  - **SSH Logs: Global View**
  - **System Log Events**
  - **Fail2Ban Activity**

---

## **5. Next Steps**

✅ **Loki deployed & operational.**  
✅ **Logs aggregated from core system components.**  
📌 **Next: Expand log ingestion to Kubernetes workloads.**  
📌 **Future Enhancements: Add alerting for critical log events.**  

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


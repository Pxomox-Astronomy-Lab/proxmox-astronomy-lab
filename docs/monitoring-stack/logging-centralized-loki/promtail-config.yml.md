---

title: "Promtail Log Shipping for Linux Servers"
description: "Comprehensive guide on configuring Promtail for log shipping across Linux servers, including security mappings and compliance considerations."
author: "VintageDon"
tags: ["Monitoring", "Security", "Log Management", "Promtail", "Loki"]
category: "Monitoring"
kb\_type: "Implementation"
version: "1.0"
status: "Published"
last\_updated: "2025-03-02"
---------------------------

# **🔍 Promtail Log Shipping for Linux Servers**

## **1. Introduction and Purpose**

Promtail is the log collection agent used in the lab for **shipping system logs to Loki**, the centralized log aggregation system. These logs provide essential **security, operational, and forensic visibility** across all nodes. Logs are retained for **90 days**, meeting the **minimum CISv8 compliance requirements** and ensuring a reliable history for **incident response, auditing, and troubleshooting**.

The monitoring stack in the lab consists of **Prometheus for metrics**, **Loki for log aggregation**, **Alertmanager for alerting**, and **Grafana for visualization**. This system captures **infrastructure-wide events, Proxmox cluster metrics, security logs, and service health status**, ensuring that anomalies are detected and logged for review.

Capturing these logs ensures **operational visibility, security monitoring, and compliance with CISv8**. This documentation provides a structured overview of the Promtail configuration, ensuring logs are **collected, formatted, and securely transmitted to Loki** while aligning with **CISv8 security controls**.

---

## **2. Scope**

| **Category**           | **Description**                                                              |
| ---------------------- | ---------------------------------------------------------------------------- |
| **In-Scope**           | Log shipping via Promtail to Loki, security mappings, compliance with CISv8. |
| **Out-of-Scope**       | Loki configuration, external SIEM integration.                               |
| **Compliance Mapping** | Primary: CISv8. Reference: NIST 800-53, ISO 27001.                           |

---

## **3. Promtail Configuration Overview**

The following configuration defines **essential log collection** from **system**, **authentication**, **kernel**, **syslog**, **package management**, and **intrusion detection** sources.

Application specific logging, such as databases, are added to this configuration as needed.

```yaml
server:
  http_listen_port: 9080

positions:
  filename: /tmp/positions.yaml

clients:
  - url: https://<loki-server>:3100/loki/api/v1/push
    basic_auth:
      username: "promtail"
      password: "<secure-password>"

scrape_configs:
- job_name: system
  journal:
    max_age: "24h"
    labels:
      job: system
      hostname: ${HOSTNAME}  # Automatically resolved

- job_name: auth
  static_configs:
  - targets: ["localhost"]
    labels:
      job: auth
      __path__: /var/log/auth.log
      hostname: ${HOSTNAME}

- job_name: kern
  static_configs:
  - targets: ["localhost"]
    labels:
      job: kern
      __path__: /var/log/kern.log
      hostname: ${HOSTNAME}

- job_name: syslog
  static_configs:
  - targets: ["localhost"]
    labels:
      job: syslog
      __path__: /var/log/syslog
      hostname: ${HOSTNAME}

- job_name: dpkg
  static_configs:
  - targets: ["localhost"]
    labels:
      job: dpkg
      __path__: /var/log/dpkg.log
      hostname: ${HOSTNAME}

- job_name: fail2ban
  static_configs:
  - targets: ["localhost"]
    labels:
      job: fail2ban
      __path__: /var/log/fail2ban.log
      hostname: ${HOSTNAME}
```

✅ **Sanitized Configuration**: Server names are automatically set using `$HOSTNAME` for standardization.

---

## **4. Why These Logs Are Collected**

Each log file serves a distinct **security and compliance purpose**:

| **Log Type**                | **File**                | **Purpose**                                                    | **Compliance Mapping** |
| --------------------------- | ----------------------- | -------------------------------------------------------------- | ---------------------- |
| **System Logs**             | `journalctl`            | Captures overall system events, crashes, and service failures. | CIS 3.14               |
| **Authentication Logs**     | `/var/log/auth.log`     | Tracks SSH logins, sudo usage, and PAM authentication.         | CIS 5.2                |
| **Kernel Logs**             | `/var/log/kern.log`     | Monitors kernel-level events, potential hardware failures.     | CIS 3.4                |
| **Syslog**                  | `/var/log/syslog`       | General system events, including security-related logs.        | CIS 3.14               |
| **Package Management Logs** | `/var/log/dpkg.log`     | Tracks software installations, updates, and package changes.   | CIS 2.1                |
| **Intrusion Prevention**    | `/var/log/fail2ban.log` | Logs brute-force attack mitigation attempts via Fail2Ban.      | CIS 5.3                |

> **Key Takeaway:** These logs are **critical for forensic investigation, compliance audits, and security monitoring**.

---

## **5. Security & Compliance Considerations**

### **5.1 Secure Transport**

✅ **Loki is secured using TLS**, ensuring log integrity during transmission.

### **5.2 Log Retention & Access Control**

- **Access to logs is role-based (RBAC)** via AD/Entra in Grafana to prevent unauthorized viewing and/or modification.
- **Retention policy set to 90 days** to meet **CISv8 compliance requirements**.

### **5.3 Compliance Mapping**

| **Framework** | **Requirement**                    | **Implementation**                                   |
| ------------- | ---------------------------------- | ---------------------------------------------------- |
| CIS 3.14      | Ensure centralized logging         | Promtail ships logs to a remote Loki instance        |
| CIS 3.4       | Kernel logging required            | Captures all kernel-level system events              |
| CIS 5.2       | Monitor authentication events      | Logs all login attempts and privilege escalations    |
| CIS 5.3       | Monitor intrusion detection events | Captures Fail2Ban logs to track brute-force attempts |

---

## **6. Summary**

✅ **Promtail is a lightweight, secure log shipper for Linux servers.**\
✅ **Captured logs are aligned with CISv8 compliance requirements.**\
✅ **Logs are centralized in Loki for monitoring, security auditing, and compliance reporting.**\
✅ **TLS encryption, RBAC, and a 90-day retention policy are enforced for security.**

📌 **This KB article is also referenced under the Compliance section for logging standards.** 🚀

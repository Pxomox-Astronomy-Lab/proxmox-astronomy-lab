---
title: "CIS Control 3.14: Log Sensitive Data Access in the Proxmox Astronomy Lab"
description: "Detailed implementation of CIS Control 3.14 in the Proxmox Astronomy Lab, ensuring access to sensitive data is logged and meets compliance requirements."
author: "VintageDon"
tags: ["CISv8", "Logging", "Security", "Compliance", "Proxmox", "Monitoring"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Draft"
last_updated: "2025-03-02"
---

# **🔍 CIS Control 3.14: Log Sensitive Data Access in the Proxmox Astronomy Lab**

## **1. Introduction**

Logging access to sensitive data is a fundamental security control that provides visibility into potential **unauthorized access, data exfiltration, and forensic investigations**. **CIS Control 3.14** mandates that all access to sensitive data **must be logged**, retained for at least **90 days**, and **monitored for anomalous activity**.

In the **Proxmox Astronomy Lab**, logging is **centralized via Promtail and Loki**, with logs being **encrypted at rest and protected via role-based access controls (RBAC)**. These logs feed into **Grafana for visualization** and **Alertmanager for security notifications**, ensuring **real-time monitoring and compliance**.

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | Logging of sensitive data access across all lab environments (Proxmox, Kubernetes, databases, and Linux hosts). |
| **Out-of-Scope** | Third-party services that do not fall under lab-managed infrastructure. |
| **Compliance Mapping** | CIS Control 3.14, NIST 800-53 (AU-2, AU-12), ISO/IEC 27001 (A.12.4.1, A.12.4.3). |

---

## **3. Implementation in the Lab**

### **3.1 Logging Framework**

All log data is **aggregated via Promtail and shipped to Loki**, ensuring **structured, indexed, and searchable** log retention.

#### **Log Sources:**

| **Log Type** | **Purpose** |
|-------------|------------|
| **Auth Logs** (`/var/log/auth.log`) | Tracks **SSH logins, sudo actions, authentication events**. |
| **Kernel Logs** (`/var/log/kern.log`) | Captures **security-related kernel events**, including process escalations. |
| **System Logs** (`/var/log/syslog`) | Provides a general overview of **system events** and **service activity**. |
| **Fail2Ban Logs** (`/var/log/fail2ban.log`) | Detects and **logs brute-force attempts** to block attackers. |
| **Package Logs** (`/var/log/dpkg.log`) | Tracks **software installations and updates** that may introduce security risks. |

---

### **3.2 Secure Log Storage**

✅ **Loki is secured using TLS**, ensuring encrypted transmission of logs.  
✅ **Logs are retained for 90 days**, meeting **CISv8 compliance**.  
✅ **Role-Based Access Control (RBAC) is enforced**, restricting who can view logs.  
✅ **Log volumes are encrypted using LUKS with TPM auto-unlock**, ensuring **encryption at rest**.  

---

### **3.3 Access Monitoring & Alerting**

| **Monitoring Tool** | **Function** |
|--------------------|-------------|
| **Grafana Dashboards** | Real-time visualization of log data and trends. |
| **Alertmanager** | Sends **immediate alerts** on security anomalies (e.g., multiple failed logins). |
| **Wazuh SIEM/XDR** | Centralized **threat detection and log analysis**. |

---

### **4. Compliance Evidence**

To verify compliance, refer to the **implementation KB**:

📜 **File:** `03-14-log-sensitive-data-access.md`  
📍 **Location:** `docs/compliance-security/cisv8/3/3.14/`

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-02 | ✅ Approved |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-02 | Initial version | VintageDon |

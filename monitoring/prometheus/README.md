---
title: "Prometheus Monitoring Service - Proxmox Astronomy Lab"
description: "Documentation of Prometheus monitoring service for infrastructure and research observability in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["prometheus", "monitoring", "observability", "metrics", "alerting"]
category: "Services"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---

# **Prometheus Monitoring Service**

## **1. Service Overview**

### **1.1 Service Description**

Prometheus is the core time-series metrics collection and monitoring service in the **Proxmox Astronomy Lab**. It provides real-time observability into infrastructure components, scientific workloads, and operational health. By collecting and storing metrics from various exporters and services, Prometheus enables proactive monitoring, alerting, and historical analysis for both IT and research applications.

### **1.2 Service Classification**

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-PROM01 |
| **Service Type** | Core Monitoring |
| **Service Category** | Infrastructure |
| **Business Criticality** | High |
| **Service Owner** | Lab Operations |

### **1.3 Service Hours**

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 Monitoring |
| **Support Hours** | Best effort, critical alerts responded to within 15 minutes |
| **Maintenance Windows** | Scheduled Sunday 02:00-03:00 UTC |

---

## **2. Service Level Agreements (SLAs)**

### **2.1 Service Level Targets**

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Uptime monitoring |
| **Scrape Interval** | 15s | Configured in `prometheus.yml` |
| **Alert Response Time** | <15 minutes (P1), <30 minutes (P2) | AlertManager integration |

### **2.2 Monitoring and Reporting**

- **Prometheus stores all time-series data for a rolling 90-day window.**
- **Long-term storage is handled via InfluxDB for historical analytics.**
- **Automated alerts are sent to AlertManager, triggering notifications to Teams and email.**

---

## **3. Technical Documentation**

### **3.1 Architecture Overview**

Prometheus runs as a **systemd service** on `lab-mon01`, scraping metrics from various exporters and endpoints. The architecture integrates with **Loki (logs), InfluxDB (historical metrics), and AlertManager (alerting)**.

### **3.2 Infrastructure Components**

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Prometheus Server** | Core metrics collection service | MON-PROM01 |
| **AlertManager** | Alert routing and notification | MON-AM01 |
| **Node Exporters** | System metrics from Linux servers | MON-EXP-LINUX |
| **Windows Exporters** | System metrics from Windows servers | MON-EXP-WIN |
| **SNMP Exporter** | Network monitoring | MON-EXP-NET |
| **Proxmox Exporter** | Proxmox hypervisor metrics | MON-EXP-PROX |

### **3.3 Dependencies**

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | `AlertManager` | No alerting functionality |
| **Requires** | `Node Exporter` | No host metrics |
| **Required By** | `Grafana` | No visual dashboards |
| **Required By** | `Loki` | Log correlation loses context |

### **3.4 Backup and Recovery**

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily snapshot of Prometheus database |
| **Backup Method** | Stored on S3-compatible storage |
| **Recovery Time Objective (RTO)** | 30 minutes |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | Restore from latest snapshot |

---

## **4. Service Management**

### **4.1 Access Management**

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Admin | Full configuration access | SSH access to `lab-mon01` |
| Operator | Read-only dashboard access | Entra ID SSO |
| Viewer | View metrics and alerts | Grafana integration |

### **4.2 Incident Management**

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| Prometheus Down | No metric collection | P1 | 15 min | 1 hour |
| Exporter Down | Partial data loss | P2 | 30 min | 2 hours |
| Alerting Failure | No notifications | P1 | 15 min | 1 hour |
| High Latency | Slow dashboard queries | P3 | 1 hour | 4 hours |

### **4.3 Change Management**

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| Standard | No | Documented in Git | Sunday 02:00-03:00 UTC |
| Emergency | Yes | Approval via Teams | ASAP |

---

## **5. Operating Procedures**

### **5.1 Routine Procedures**

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Verify Metrics Collection | Daily | Operator | `docs/monitoring/prometheus-verification.md` |
| Review Alerts | Weekly | Admin | `docs/monitoring/alertmanager.md` |
| Update Configurations | Monthly | Engineer | `docs/monitoring/prometheus-config.md` |

### **5.2 Troubleshooting**

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Missing Metrics | Gaps in dashboard | Restart exporter service | KEDB-PROM01 |
| High CPU Load | Prometheus slow | Adjust scrape interval | KEDB-PROM02 |
| Alert Flood | Too many alerts | Adjust AlertManager rules | KEDB-PROM03 |

---

## **6. Security and Compliance**

### **6.1 Security Controls**

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Authentication | Entra ID SSO for dashboards | Manual audit |
| Encryption | TLS for all endpoints | Config validation |
| Data Retention | 90-day local, 1-year InfluxDB | Log review |

### **6.2 Compliance Requirements**

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| Logging | CISv8 | Audit logs in Loki |
| Monitoring | NIST 800-53 | Prometheus metrics |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

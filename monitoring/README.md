<!-- ---
title: "Monitoring Architecture - Proxmox Astronomy Lab"
description: "Comprehensive overview of the monitoring and observability stack in the Proxmox Astronomy Lab, including Prometheus, Grafana, Loki, and Wazuh SIEM."
author: "VintageDon"
tags: ["monitoring", "observability", "prometheus", "grafana", "loki", "wazuh", "alertmanager"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---
 -->

# **Monitoring Architecture - Proxmox Astronomy Lab**

## **1. Overview**

The Proxmox Astronomy Lab implements a **comprehensive monitoring and observability** architecture to ensure system reliability, performance optimization, and security compliance. This multi-layered approach combines infrastructure monitoring, log aggregation, visualization, alerting, and security event management into an integrated observability platform.

Our monitoring stack is designed to provide **holistic visibility** into all lab components while generating **actionable alerts** that follow structured incident management workflows. This architecture supports both **day-to-day operations** and **long-term capacity planning** for the lab's infrastructure.

### **1.1 Monitoring Philosophy**

The monitoring architecture follows key principles:

✅ **Complete Coverage** - All infrastructure components and services are monitored  
✅ **Actionable Alerting** - Alerts provide clear remediation paths  
✅ **Centralized Visualization** - Single-pane-of-glass dashboard approach  
✅ **Historical Analysis** - Long-term metric storage enables trend analysis  
✅ **Security Integration** - Security monitoring is fully integrated with operational monitoring  
✅ **Automation Support** - Monitoring feeds into automated remediation where possible

---

## **2. Monitoring Infrastructure**

### **2.1 Core Monitoring Host**

The monitoring infrastructure is primarily hosted on **lab-mon01**, a dedicated VM with resources allocated specifically for observability functions:

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-mon01.beardinthe.cloud |
| **CPU** | 2 vCPUs |
| **RAM** | 4GB |
| **Storage** | 32GB system disk, 750GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 Level 2 Hardened) |
| **Network** | VLAN10 (Control Plane) |
| **Host Node** | node02 |

### **2.2 Service Deployment**

The monitoring stack consists of directly installed services on lab-mon01, with only InfluxDB running in a container:

| **Service** | **Implementation** | **Resource Allocation** |
|------------|-------------------|------------------------|
| **Prometheus** | Native service | 1GB RAM reserved |
| **Grafana** | Native service | 1GB RAM reserved |
| **Loki** | Native service | 1GB RAM reserved |
| **AlertManager** | Native service | 256MB RAM reserved |
| **InfluxDB** | Containerized | 512MB RAM reserved |

### **2.3 Security Monitoring Infrastructure**

Security monitoring is handled by **lab-soc1**, a dedicated VM for Wazuh SIEM:

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-soc1.beardinthe.cloud |
| **CPU** | 4 vCPUs |
| **RAM** | 12GB |
| **Storage** | 100GB system/data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 Level 2 Hardened) |
| **Network** | VLAN10 (Control Plane) |
| **Host Node** | node01 |

---

## **3. Monitoring Components**

The monitoring architecture consists of several key components working together:

### **3.1 Metrics Collection & Storage**

| **Component** | **Purpose** | **Implementation Details** |
|--------------|------------|----------------------------|
| **Prometheus** | Time-series metrics database | v2.48.0, retention: 90 days |
| **InfluxDB** | Long-term metric storage | Containerized, 365-day retention |
| **Node Exporter** | Host-level metrics collection | Deployed on all Ubuntu VMs |
| **SNMP Exporter** | Network device monitoring | Monitors switches, firewall |
| **Windows Exporter** | Windows VM metrics | Deployed on all Windows servers |
| **Custom Exporters** | Specialized metrics collection | Radio telescope data, environmental metrics |

### **3.2 Visualization**

| **Component** | **Purpose** | **Implementation Details** |
|--------------|------------|----------------------------|
| **Grafana** | Dashboards and visualization | v10.2.3, SSO integration with Entra ID |
| **Dashboard Organization** | Structured dashboard categories | Infrastructure, Services, Research, Security |
| **Alert Visualization** | Visual alert indicators | Color-coded severity, temporal patterns |

### **3.3 Log Management**

| **Component** | **Purpose** | **Implementation Details** |
|--------------|------------|----------------------------|
| **Loki** | Log aggregation and querying | v2.9.2, retention: 30 days |
| **Promtail** | Log collection agents | Deployed on all VMs |
| **Log Processing** | Parsing and structuring logs | JSON formatting, field extraction |

### **3.4 Alerting**

| **Component** | **Purpose** | **Implementation Details** |
|--------------|------------|----------------------------|
| **AlertManager** | Alert routing and management | v0.26.0, integration with notification channels |
| **Alert Routing** | Directing alerts to appropriate recipients | Based on service ownership, time of day |
| **Alert Suppression** | Preventing alert storms | Grouping, inhibition rules |

### **3.5 Security Monitoring**

| **Component** | **Purpose** | **Implementation Details** |
|--------------|------------|----------------------------|
| **Wazuh SIEM** | Security event monitoring | v4.7.1, agents on all VMs |
| **File Integrity Monitoring** | Detecting unauthorized changes | Critical system files, configuration files |
| **Security Scanning** | Vulnerability detection | Daily CIS compliance checks |
| **Security Events** | Detection of security incidents | Integration with alerting workflow |

---

## **4. Monitoring Coverage**

The monitoring architecture provides comprehensive coverage across all lab components:

### **4.1 Infrastructure Monitoring**

| **Component** | **Metrics Collected** | **Alert Thresholds** |
|--------------|----------------------|---------------------|
| **Proxmox Nodes** | CPU, memory, disk, network, temperature | Node-specific thresholds based on workload patterns |
| **Virtual Machines** | vCPU, vRAM, disk IO, network traffic | Service-tier based thresholds |
| **Network Devices** | Interface traffic, errors, drops, temperature | Utilization >80%, error rate >0.1% |
| **Storage Systems** | Capacity, IOPS, throughput, latency | Capacity >85%, latency >5ms |

### **4.2 Service Monitoring**

| **Service Type** | **Metrics Collected** | **Alert Thresholds** |
|-----------------|----------------------|---------------------|
| **Kubernetes** | Pod status, container metrics, API server | API latency >200ms, pod restart count |
| **Databases** | Query performance, connections, replication lag | Query time >500ms, lag >30s |
| **Web Services** | Request rate, latency, error rate, availability | Latency >300ms, availability <99.9% |
| **Domain Services** | Auth success/failure, replication status | Auth failures, replication delays |

### **4.3 Research Infrastructure Monitoring**

| **Component** | **Metrics Collected** | **Alert Thresholds** |
|--------------|----------------------|---------------------|
| **SDR Processing** | Signal strength, noise floor, processing latency | Signal-to-noise ratio, latency >5s |
| **Data Pipelines** | Throughput, error rate, processing time | Pipeline stalls, error spikes |
| **Storage Utilization** | Research data growth, access patterns | Capacity planning thresholds |

---

## **5. Alerting & Incident Response**

### **5.1 Alert Routing & Notification**

Alerts are routed based on severity, service, and time of day:

| **Severity** | **Notification Method** | **Expected Response Time** |
|-------------|------------------------|---------------------------|
| **Critical (P1)** | SMS + Email + Teams | Immediate (15 minutes) |
| **High (P2)** | Email + Teams | 30 minutes |
| **Medium (P3)** | Email | 4 hours |
| **Low (P4)** | Dashboard only | Next business day |

### **5.2 Alert Workflow Integration**

Alerts are integrated with the ITIL-aligned incident management process:

1. **Alert Triggered** - Initial detection in Prometheus/Wazuh
2. **Alert Routing** - AlertManager determines notification path
3. **Incident Creation** - Critical alerts auto-create GLPI incidents
4. **Remediation** - Structured response following incident procedures
5. **Resolution** - Closure and documentation of resolution steps

### **5.3 Common Alert Types**

| **Alert Category** | **Examples** | **Typical Causes** |
|-------------------|------------|-------------------|
| **Resource Saturation** | High CPU, memory, disk | Workload spikes, resource leaks |
| **Service Degradation** | High latency, error rates | Configuration issues, dependencies |
| **Availability** | Service down, unreachable | Application crashes, network issues |
| **Security** | Auth failures, integrity violations | Unauthorized access attempts, changes |
| **Performance** | Slow queries, response times | Inefficient code, missing indices |

---

## **6. Visualization & Dashboards**

### **6.1 Dashboard Structure**

Grafana dashboards are organized in a hierarchical structure:

| **Dashboard Level** | **Purpose** | **Target Audience** |
|--------------------|------------|-------------------|
| **Overview** | High-level health status | All users |
| **Domain-Specific** | Focused views (Network, Compute, Storage) | Domain specialists |
| **Service-Specific** | Detailed service metrics | Service owners |
| **Troubleshooting** | Diagnostic views | Engineers |

### **6.2 Key Dashboards**

| **Dashboard** | **Purpose** | **Location** |
|--------------|------------|-------------|
| **Infrastructure Overview** | Health status of all physical and virtual infrastructure | [grafana/dashboards/infrastructure-overview.json](grafana/dashboards/infrastructure-overview.json) |
| **Node Performance** | Detailed Proxmox node metrics | [grafana/dashboards/node-performance.json](grafana/dashboards/node-performance.json) |
| **Network Operations** | Switch, firewall, and traffic analytics | [grafana/dashboards/network-operations.json](grafana/dashboards/network-operations.json) |
| **Kubernetes Cluster** | K8s control plane and workload metrics | [grafana/dashboards/kubernetes-cluster.json](grafana/dashboards/kubernetes-cluster.json) |
| **Database Performance** | PostgreSQL, TimescaleDB, and MongoDB metrics | [grafana/dashboards/database-performance.json](grafana/dashboards/database-performance.json) |
| **Security Operations** | Security events, compliance status | [grafana/dashboards/security-operations.json](grafana/dashboards/security-operations.json) |
| **SDR Processing** | Radio telescope signal processing metrics | [grafana/dashboards/sdr-processing.json](grafana/dashboards/sdr-processing.json) |

---

## **7. Security Monitoring**

### **7.1 Wazuh SIEM Implementation**

The Wazuh implementation provides security-focused monitoring:

| **Capability** | **Implementation Details** |
|---------------|---------------------------|
| **Agents** | Installed on all VMs and Proxmox hosts |
| **File Integrity Monitoring** | Critical system and configuration files |
| **Log Analysis** | Security events, authentication, system logs |
| **Vulnerability Assessment** | Regular scans against security databases |
| **Compliance Monitoring** | CIS benchmark checks, policy validation |

### **7.2 Security Dashboards**

Dedicated security dashboards provide visibility into security posture:

| **Dashboard** | **Purpose** |
|--------------|------------|
| **Security Overview** | High-level security posture across all systems |
| **Authentication Activity** | Login attempts, failures, access patterns |
| **File Integrity** | Changes to monitored files and directories |
| **Compliance Status** | CIS compliance scores and trends |
| **Vulnerability Tracking** | Discovered vulnerabilities and remediation status |

### **7.3 Security Alerting**

Security-specific alerting follows a specialized workflow:

| **Alert Type** | **Severity** | **Response Procedure** |
|---------------|------------|------------------------|
| **Potential Intrusion** | Critical | Immediate isolation and investigation |
| **Authentication Anomalies** | High | Account lockdown and verification |
| **Compliance Drift** | Medium | Remediation within 48 hours |
| **Vulnerability Detected** | Varies | Risk-based remediation timeline |

---

## **8. Data Retention & Performance**

### **8.1 Metric Storage & Retention**

| **Data Type** | **Retention Period** | **Storage Allocation** |
|--------------|---------------------|----------------------|
| **High-Resolution Metrics** | 30 days | 250GB (Prometheus) |
| **Long-term Metrics** | 1 year | 200GB (InfluxDB) |
| **Logs** | 30 days | 200GB (Loki) |
| **Security Events** | 1 year | 150GB (Wazuh) |

### **8.2 Performance Considerations**

The monitoring stack is optimized for performance:

| **Optimization** | **Implementation** |
|-----------------|-------------------|
| **Prometheus Scrape Intervals** | Tailored by metric importance (15s to 5m) |
| **Query Optimization** | Pre-recorded rules for common queries |
| **Data Compaction** | Automated downsampling for long-term storage |
| **Resource Isolation** | Dedicated resources for critical monitoring components |

---

## **9. Implementation Details**

### **9.1 Deployment Method**

The monitoring stack is deployed using native services with systemd:

| **Component** | **Version** | **Deployment Method** |
|--------------|------------|---------------------|
| **Prometheus** | v2.48.0 | Native service (systemd) |
| **Grafana** | v10.2.3 | Native service (systemd) |
| **Loki** | v2.9.2 | Native service (systemd) |
| **AlertManager** | v0.26.0 | Native service (systemd) |
| **InfluxDB** | v2.7.3 | Docker container |
| **Node Exporter** | v1.6.1 | Native service (systemd) |
| **Wazuh** | v4.7.1 | Native service (systemd) |

### **9.2 Backup & Recovery**

The monitoring infrastructure includes backup mechanisms:

| **Component** | **Backup Method** | **Recovery Time Objective** |
|--------------|------------------|---------------------------|
| **Prometheus Data** | Daily snapshots to S3 storage | 1 hour |
| **Grafana Dashboards** | Git-versioned configuration | 30 minutes |
| **Loki Logs** | Not backed up (temporal data) | N/A |
| **AlertManager Configuration** | Git-versioned configuration | 15 minutes |
| **Wazuh Database** | Daily snapshots to S3 storage | 2 hours |

---

## **10. Future Enhancements**

Planned improvements to the monitoring infrastructure:

| **Enhancement** | **Description** | **Timeline** |
|----------------|----------------|-------------|
| **ML-based Anomaly Detection** | Implement machine learning for anomaly detection | Q2 2025 |
| **Expanded Tracing** | Add distributed tracing with Tempo | Q3 2025 |
| **Synthetic Monitoring** | Implement end-to-end service checks | Q1 2025 |
| **Unified Alerting** | Migrate to Grafana Alerting for unified experience | Q2 2025 |
| **Enhanced Security Analytics** | Implement security analytics platform | Q4 2025 |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial documentation | VintageDon |


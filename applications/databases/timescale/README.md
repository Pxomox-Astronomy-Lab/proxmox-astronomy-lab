<!-- 
---
title: "TimescaleDB Service Documentation"
description: "Comprehensive documentation for TimescaleDB time-series database services in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["timescaledb", "postgresql", "time-series", "database", "infrastructure", "service", "astronomy"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "InfluxDB", "Prometheus", "Grafana", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# ⏱️ **TimescaleDB Service**

This document provides comprehensive information about the TimescaleDB time-series database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the TimescaleDB service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of TimescaleDB in the Proxmox Astronomy Lab environment, particularly focused on its specialized time-series data capabilities.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| TimescaleDB instances and configuration | Application code interacting with TimescaleDB |
| Hypertable design and management | Business logic implementation |
| Continuous aggregates and data retention | Data migration processes |
| Time-series optimization techniques | End-user application support |
| Monitoring, backup, and recovery | Non-time-series data management |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Operations and Support Personnel
- Radio Astronomy Researchers
- Data Scientists

## 🔍 **2. Service Overview**

### **2.1 Service Description**

TimescaleDB extends PostgreSQL with specialized time-series functionality, providing high-performance data storage and analysis capabilities for astronomical observations, sensor data, monitoring metrics, and other time-series workloads. It enables efficient storage, querying, and analysis of massive datasets ordered by time while maintaining full SQL compatibility.

### **2.2 Service Classification**

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-TS-001 |
| **Service Type** | Core |
| **Service Category** | Database |
| **Business Criticality** | High |
| **Service Owner** | Database Administration Team |

### **2.3 Service Hours**

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 (Always available) |
| **Support Hours** | Monday-Friday, 08:00-17:00 EST |
| **Maintenance Windows** | Fridays, 10:00-11:00 EST |

## 📊 **3. Technical Architecture**

### **3.1 Deployment Overview**

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-pgts01** | Dedicated VM | Primary time-series data for astronomy observations | 4 vCPU, 16GB RAM, 500GB storage |
| **proj-pgts02dev** | Container on lab-db01 | Development and testing workloads | 2 vCPU, 8GB RAM, 250GB storage |

### **3.2 Infrastructure Components**

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|-------------|
| TimescaleDB Server (proj-pgts01) | Primary time-series database VM | CMDB-VM-PGTS01 |
| TimescaleDB Container (proj-pgts02dev) | Development database container | CMDB-CNT-PGTS02 |
| PostgreSQL Exporter | Prometheus metrics collector | CMDB-MON-PGTSEXP |
| Iperius Backup Agent | Backup automation for databases | CMDB-BKP-IPRAG-TS |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|------------------------|
| proj-pgts01 | 10.25.20.13 | VLAN20 | pgts01-prod |
| proj-pgts02dev | 10.25.10.53 | VLAN10 | pgts02-dev |

### **3.4 Dependencies**

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|------------------------|----------------------------|
| **Requires** | PostgreSQL | Complete service outage (TimescaleDB extends PostgreSQL) |
| **Requires** | Proxmox VE | Complete service outage for proj-pgts01 |
| **Requires** | Portainer | Container management for proj-pgts02dev |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | Hydrogen Line Pipeline | Time-series storage for observation data unavailable |
| **Required By** | Monitoring Stack | Historical metrics storage impacted |
| **Required By** | SDR Processing Pipeline | Signal data storage unavailable |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|----------------|----------------------|-------------------------|
| Hypertable Maintenance | Daily (automated) | System | [TS-MAINT-001](../ITIL-Processes/Monitoring/TS-MAINT-001.md) |
| Continuous Aggregate Refresh | Daily (automated) | System | [TS-MAINT-002](../ITIL-Processes/Monitoring/TS-MAINT-002.md) |
| Compression Policy Execution | Weekly | DBA | [TS-MAINT-003](../ITIL-Processes/Monitoring/TS-MAINT-003.md) |
| Data Retention Enforcement | Monthly | DBA | [TS-MAINT-004](../ITIL-Processes/Monitoring/TS-MAINT-004.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [SYS-PATCH-001](../ITIL-Processes/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Chunks per Hypertable | >500 | >1000 | [TS-RESP-001](../ITIL-Processes/Monitoring/TS-RESP-001.md) |
| Compression Ratio | <3:1 | <2:1 | [TS-RESP-002](../ITIL-Processes/Monitoring/TS-RESP-002.md) |
| Query Latency | >1s | >5s | [TS-RESP-003](../ITIL-Processes/Monitoring/TS-RESP-003.md) |
| Database Size | >80% capacity | >90% capacity | [TS-RESP-004](../ITIL-Processes/Monitoring/TS-RESP-004.md) |

### **4.3 Troubleshooting**

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|-------------|----------------------|-------------|
| Slow Hypertable Queries | High query latency, high CPU | Adjust chunk time interval, review indexes | KEDB-TS-001 |
| Failed Compression | Compression jobs not completing | Check compression policies, ensure enough resources | KEDB-TS-002 |
| Continuous Aggregate Errors | Missing data in aggregates | Refresh materialized view manually, check policies | KEDB-TS-003 |
| Disk Space Growth | Rapid storage consumption | Review retention policies, compress older chunks | KEDB-TS-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|------------------|-----------|----------------------|
| Administrative Access | Role-based with password + Entra MFA | [SEC-AUTH-001](../ITIL-Processes/Access-Management/SEC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [SEC-AUTH-002](../ITIL-Processes/Access-Management/SEC-AUTH-002.md) |
| Remote Access | SSL/TLS encrypted connections only | [SEC-CONN-001](../ITIL-Processes/Access-Management/SEC-CONN-001.md) |

### **5.2 Security Controls**

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|--------------------|--------------------------|
| Access Control | Role-based authentication, minimal privileges | Quarterly access review |
| Network Security | Host-based firewall, VLAN segmentation | Monthly Lynis scans |
| Data Encryption | TLS for connections, encrypted backups | Weekly CIS-CAT scans |
| Audit Logging | Comprehensive DB activity logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|--------------------|------------------------|------------------------|
| CIS.8.2 | Entra ID with MFA required for admin access | Entra Sign-in Logs | Compliant |
| CIS.8.3 | AD group-based access with automated provisioning/deprovisioning | GLPI Change Records | Compliant |
| CIS.10.1 | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 | Azure Update Manager performs weekly patching | Azure Arc Logs | Compliant |

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|------------------|-------------|---------------|------------------------|
| Full Database Dump | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |
| Continuous Aggregates Only | Daily at 14:00 EST | 30 days | proj-pgts01 local storage |

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------------|----------------------|
| Single Hypertable Corruption | 2 hours | 24 hours | [DR-TS-001](../DR/DR-TS-001.md) | DBA |
| Instance Failure | 4 hours | 24 hours | [DR-TS-002](../DR/DR-TS-002.md) | Systems Administrator |
| Complete Host Failure | 6 hours | 24 hours | [DR-TS-003](../DR/DR-TS-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-TS-004](../DR/DR-TS-004.md) | DR Team |

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|--------------|------------------|
| Technical Guide | TimescaleDB Tuning Guide | [docs/TS-Tuning-Guide.md](../Guides/TS-Tuning-Guide.md) | Performance optimization |
| Procedure | Hypertable Design Best Practices | [docs/Hypertable-Design.md](../Procedures/Hypertable-Design.md) | Schema design |
| Architecture | Time-Series Data Architecture | [docs/TS-Architecture.md](../Architecture/TS-Architecture.md) | Overall context |
| Security | TimescaleDB Security Baseline | [docs/TS-Security-Baseline.md](../Security/TS-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|---------------|---------|--------------------|--------------------|
| TimescaleDB Documentation | <https://docs.timescale.com/> | [Local Copy](../References/TimescaleDB-Docs.pdf) | 2025-04-01 |
| Chunk Management Guide | <https://docs.timescale.com/timescaledb/latest/how-to-guides/hypertables/manage-chunks/> | [Local Copy](../References/Chunk-Management.pdf) | 2025-04-01 |
| Continuous Aggregates | <https://docs.timescale.com/timescaledb/latest/how-to-guides/continuous-aggregates/> | [Local Copy](../References/Continuous-Aggregates.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|---------------|-----------------|--------------------------|---------------|
| CR-TS-2025-001 | TimescaleDB 2.x Upgrade | 2025-01-20 | [GLPI-CR-TS-001](https://glpi.lab.local/CR-TS-2025-001) |
| CR-TS-2025-002 | Hypertable Optimization | 2025-02-15 | [GLPI-CR-TS-002](https://glpi.lab.local/CR-TS-2025-002) |
| CR-TS-2025-003 | Compression Policy Update | 2025-03-05 | [GLPI-CR-TS-003](https://glpi.lab.local/CR-TS-2025-003) |

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|--------------|----------|-------------------|-------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|-------------|----------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

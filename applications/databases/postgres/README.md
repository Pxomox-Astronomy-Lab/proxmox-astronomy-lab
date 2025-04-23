<!-- 
---
title: "PostgreSQL Service Documentation"
description: "Comprehensive documentation for PostgreSQL database services in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["postgresql", "database", "rdbms", "infrastructure", "service"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["TimescaleDB", "PostGIS", "Prometheus", "Iperius Backup", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🐘 **PostgreSQL Database Service**

This document provides comprehensive information about the PostgreSQL database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the PostgreSQL database service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of PostgreSQL in the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| PostgreSQL instances and configuration | Application code interacting with PostgreSQL |
| Monitoring and performance tuning | Database schema design |
| Backup and recovery procedures | Data migration processes |
| Security hardening and compliance | Business logic implementation |
| High availability setup | End-user application support |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Operations and Support Personnel
- Security and Compliance Teams
- Research System Administrators

## 🔍 **2. Service Overview**

### **2.1 Service Description**

PostgreSQL provides reliable, high-performance relational database services for infrastructure components and research applications throughout the lab environment. It serves as the primary datastore for structured data, offering ACID compliance, robust transaction support, and advanced data types.

### **2.2 Service Classification**

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-PG-001 |
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
| **proj-pg01** | Dedicated VM | Primary production workloads | 4 vCPU, 16GB RAM, 500GB storage |
| **proj-pg02** | Container on lab-db01 | Development and secondary workloads | 2 vCPU, 8GB RAM, 250GB storage |

### **3.2 Infrastructure Components**

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|-------------|
| PostgreSQL Server (proj-pg01) | Primary database VM | CMDB-VM-PG01 |
| PostgreSQL Container (proj-pg02) | Secondary database container | CMDB-CNT-PG02 |
| PostgreSQL Exporter | Prometheus metrics collector | CMDB-MON-PGEXP |
| Iperius Backup Agent | Backup automation for databases | CMDB-BKP-IPRAG |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|------------------------|
| proj-pg01 | 10.25.20.14 | VLAN20 | pg01-prod |
| proj-pg02 | 10.25.10.52 | VLAN10 | pg02-dev |

### **3.4 Dependencies**

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|------------------------|----------------------------|
| **Requires** | Proxmox VE | Complete service outage for proj-pg01 |
| **Requires** | Portainer | Container management for proj-pg02 |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | TimescaleDB | Unable to operate (TimescaleDB extends PostgreSQL) |
| **Required By** | Research Applications | Data storage functionality impacted |
| **Required By** | GLPI | ITSM platform database unavailable |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|----------------|----------------------|-------------------------|
| Database Vacuum | Daily (automated) | System | [DB-MAINT-001](../ITIL-Processes/Monitoring/DB-MAINT-001.md) |
| Index Maintenance | Weekly | DBA | [DB-MAINT-002](../ITIL-Processes/Monitoring/DB-MAINT-002.md) |
| Performance Review | Monthly | DBA | [DB-MAINT-003](../ITIL-Processes/Monitoring/DB-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [SYS-PATCH-001](../ITIL-Processes/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|------------------------|--------------------------|--------------------------|
| Connection Count | >75% max | >90% max | [DB-RESP-001](../ITIL-Processes/Monitoring/DB-RESP-001.md) |
| Transaction Latency | >500ms | >1000ms | [DB-RESP-002](../ITIL-Processes/Monitoring/DB-RESP-002.md) |
| Database Size | >80% capacity | >90% capacity | [DB-RESP-003](../ITIL-Processes/Monitoring/DB-RESP-003.md) |
| Replication Lag | >60 seconds | >300 seconds | [DB-RESP-004](../ITIL-Processes/Monitoring/DB-RESP-004.md) |

### **4.3 Troubleshooting**

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|-------------|----------------------|-------------|
| Connection Pool Exhaustion | Applications unable to connect, high wait time metrics | Restart problematic application, check for connection leaks | KEDB-PG-001 |
| Slow Query Performance | High CPU usage, long-running queries | Identify and optimize problematic queries, review indexes | KEDB-PG-002 |
| Disk Space Pressure | Alerts from monitoring system | Clear logs, vacuum databases, extend storage if needed | KEDB-PG-003 |
| Failed Replication | Increasing lag metrics | Check network connectivity, restart replication if needed | KEDB-PG-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|------------------|------------|----------------------|
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
|------------------|--------------|---------------|------------------------|
| Full Database Dump | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |
| Large Static DB Backup | Once upon creation | 6 months | AWS Deep Glacier |

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------------|------------------------|
| Single Database Corruption | 1 hour | 24 hours | [DR-DB-001](../DR/DR-DB-001.md) | DBA |
| Instance Failure | 2 hours | 24 hours | [DR-DB-002](../DR/DR-DB-002.md) | Systems Administrator |
| Complete Host Failure | 4 hours | 24 hours | [DR-DB-003](../DR/DR-DB-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-DB-004](../DR/DR-DB-004.md) | DR Team |

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|--------------------|--------------|------------------|
| Technical Guide | PostgreSQL Tuning Guide | [docs/Tuning-Guide.md](../Guides/PostgreSQL-Tuning-Guide.md) | Performance optimization |
| Procedure | Database Backup Verification | [docs/Backup-Verification.md](../Procedures/Backup-Verification.md) | Regular testing |
| Architecture | Database Architecture Overview | [docs/DB-Architecture.md](../Architecture/DB-Architecture.md) | Overall context |
| Security | Database Security Baseline | [docs/Security-Baseline.md](../Security/Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|----------------|--------|--------------------|--------------------|
| PostgreSQL Documentation | <https://www.postgresql.org/docs/> | [Local Copy](../References/PostgreSQL-Docs-16.pdf) | 2025-04-01 |
| PostgreSQL Security Wiki | <https://wiki.postgresql.org/wiki/Security> | [Local Copy](../References/PostgreSQL-Security.pdf) | 2025-04-01 |
| CIS PostgreSQL Benchmark | <https://www.cisecurity.org/benchmark/postgresql> | [Local Copy](../References/CIS-PostgreSQL-16.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|----------------|------------------|---------------------------|----------------|
| CR-DB-2025-001 | PostgreSQL 16 Upgrade | 2025-01-15 | [GLPI-CR-001](https://glpi.lab.local/CR-DB-2025-001) |
| CR-DB-2025-002 | Monitoring Enhancement | 2025-02-20 | [GLPI-CR-002](https://glpi.lab.local/CR-DB-2025-002) |
| CR-DB-2025-003 | Backup Strategy Update | 2025-03-10 | [GLPI-CR-003](https://glpi.lab.local/CR-DB-2025-003) |

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|--------------|----------|-------------------|-------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| DBAdmin | Database Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|-------------|----------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

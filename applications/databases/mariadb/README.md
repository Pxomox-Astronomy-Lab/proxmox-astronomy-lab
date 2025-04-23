<!-- 
---
title: "MariaDB/MySQL Service Documentation"
description: "Comprehensive documentation for MariaDB/MySQL database services in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["mariadb", "mysql", "database", "infrastructure", "service", "compatibility"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "MongoDB", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🐬 **MariaDB/MySQL Service**

This document provides comprehensive information about the MariaDB/MySQL database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the MariaDB/MySQL service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of MariaDB/MySQL in the Proxmox Astronomy Lab environment, focusing on its role in supporting applications that require MySQL-compatible databases.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| MariaDB/MySQL instances and configuration | Application code interacting with MariaDB/MySQL |
| Storage engine optimization and tuning | Business logic implementation |
| Replication and high availability | Data migration processes |
| Performance monitoring and tuning | End-user application support |
| Security hardening and backup strategies | Custom plugin development |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Operations and Support Personnel
- Application Developers
- Migration Specialists

## 🔍 **2. Service Overview**

### **2.1 Service Description**

MariaDB/MySQL provides a MySQL-compatible relational database service specifically for applications that require MySQL compatibility or cannot use PostgreSQL due to dependencies or architectural constraints. It serves as a secondary RDBMS platform, ensuring compatibility with third-party applications, legacy systems, and specialized software that depends on MySQL-specific features.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-MARIA-001 |
| **Service Type** | Supporting |
| **Service Category** | Database |
| **Business Criticality** | Medium |
| **Service Owner** | Database Administration Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 (Always available) |
| **Support Hours** | Monday-Friday, 08:00-17:00 EST |
| **Maintenance Windows** | Fridays, 10:00-11:00 EST |

## 📊 **3. Technical Architecture**

### **3.1 Deployment Overview**

MariaDB/MySQL is deployed across two instances to separate production and development workloads:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-mariadb01** | Dedicated VM | Primary MariaDB for MySQL-dependent applications | 2 vCPU, 8GB RAM, 250GB storage |
| **proj-mariadb02dev** | Container on lab-db01 | Development and testing workloads | 1 vCPU, 4GB RAM, 100GB storage |

Both instances run MariaDB 10.11.x (with MySQL 8.0 compatibility mode) and are deployed on Ubuntu 24.04 LTS with CISv8 Level 2 hardening.

### **3.2 Infrastructure Components**

The following components comprise the MariaDB/MySQL service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| MariaDB Server (proj-mariadb01) | Primary MariaDB VM | CMDB-VM-MARIADB01 |
| MariaDB Container (proj-mariadb02dev) | Development database container | CMDB-CNT-MARIADB02 |
| MySQL Exporter | Prometheus metrics collector | CMDB-MON-MYSQLEXP |
| Iperius Backup Agent | Backup automation for databases | CMDB-BKP-IPRAG-MYSQL |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|----------------------|
| proj-mariadb01 | 10.25.20.16 | VLAN20 | mariadb01-prod |
| proj-mariadb02dev | 10.25.10.55 | VLAN10 | mariadb02-dev |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox VE | Complete service outage for proj-mariadb01 |
| **Requires** | Portainer | Container management for proj-mariadb02dev |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | GLPI | ITSM platform database unavailable |
| **Required By** | Wiki.js | Knowledge base unavailable |
| **Required By** | Legacy Applications | MySQL-dependent applications unavailable |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Table Optimization | Weekly | DBA | [MYSQL-MAINT-001](../Procedures/MYSQL-MAINT-001.md) |
| InnoDB Buffer Pool Tuning | Monthly | DBA | [MYSQL-MAINT-002](../Procedures/MYSQL-MAINT-002.md) |
| Binary Log Purging | Weekly | System | [MYSQL-MAINT-003](../Procedures/MYSQL-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [SYS-PATCH-001](../Procedures/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

MariaDB/MySQL instances are monitored through Prometheus using the MySQL exporter:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Connection Count | >75% max | >90% max | [MYSQL-RESP-001](../Procedures/MYSQL-RESP-001.md) |
| Query Response Time | >500ms | >1000ms | [MYSQL-RESP-002](../Procedures/MYSQL-RESP-002.md) |
| InnoDB Buffer Pool Hit Ratio | <95% | <90% | [MYSQL-RESP-003](../Procedures/MYSQL-RESP-003.md) |
| Database Size | >80% capacity | >90% capacity | [MYSQL-RESP-004](../Procedures/MYSQL-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01.

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Connection Pool Exhaustion | Applications unable to connect, high connection count | Check for connection leaks, adjust max_connections | KEDB-MYSQL-001 |
| Slow Query Performance | High CPU, long-running queries | Identify problem queries, optimize indexes | KEDB-MYSQL-002 |
| InnoDB Buffer Pool Issues | High disk I/O, low cache hit ratio | Resize buffer pool, optimize memory allocation | KEDB-MYSQL-003 |
| Replication Lag | Increasing replication delay | Check for long-running queries on primary, optimize network | KEDB-MYSQL-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Role-based with password + Entra MFA | [SEC-AUTH-001](../Security/SEC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [SEC-AUTH-002](../Security/SEC-AUTH-002.md) |
| Remote Access | SSL/TLS encrypted connections only | [SEC-CONN-001](../Security/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the MariaDB/MySQL service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based authentication, minimal privileges | Quarterly access review |
| Network Security | Host-based firewall, VLAN segmentation | Monthly Lynis scans |
| Data Encryption | TLS for connections, encrypted backups | Weekly CIS-CAT scans |
| Audit Logging | Comprehensive DB activity logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | Entra ID with MFA required for admin access | Entra Sign-in Logs | Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | AD group-based access with automated provisioning/deprovisioning | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Azure Update Manager performs weekly patching | Azure Arc Logs | Compliant |

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| Full Database Dump | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |
| Binary Log Backup | Every 6 hours | 7 days | proj-mariadb01 local storage |

For regularly changing databases, these are backed up daily by Iperius backup with 14-day retention and synced to AWS Deep Glacier with 6-month retention. Static databases are backed up once upon creation.

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Single Database Corruption | 1 hour | 6 hours | [DR-MYSQL-001](../DR/DR-MYSQL-001.md) | DBA |
| Instance Failure | 2 hours | 6 hours | [DR-MYSQL-002](../DR/DR-MYSQL-002.md) | Systems Administrator |
| Complete Host Failure | 4 hours | 24 hours | [DR-MYSQL-003](../DR/DR-MYSQL-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-MYSQL-004](../DR/DR-MYSQL-004.md) | DR Team |

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | MariaDB Tuning Guide | [docs/MYSQL-Tuning-Guide.md](../Guides/MYSQL-Tuning-Guide.md) | Performance optimization |
| Procedure | InnoDB Optimization | [docs/InnoDB-Optimization.md](../Procedures/InnoDB-Optimization.md) | Storage engine tuning |
| Architecture | Database Architecture Overview | [docs/DB-Architecture.md](../Architecture/DB-Architecture.md) | Overall context |
| Security | MariaDB Security Baseline | [docs/MYSQL-Security-Baseline.md](../Security/MYSQL-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| MariaDB Documentation | <https://mariadb.com/kb/en/documentation/> | [Local Copy](../References/MariaDB-Docs.pdf) | 2025-04-01 |
| MariaDB Security | <https://mariadb.com/kb/en/securing-mariadb/> | [Local Copy](../References/MariaDB-Security.pdf) | 2025-04-01 |
| CIS MariaDB Benchmark | <https://www.cisecurity.org/benchmark/mariadb> | [Local Copy](../References/CIS-MariaDB.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-MYSQL-2025-001 | MariaDB 10.11 Upgrade | 2025-01-30 | [GLPI-CR-MYSQL-001](https://glpi.lab.local/CR-MYSQL-2025-001) |
| CR-MYSQL-2025-002 | InnoDB Buffer Pool Optimization | 2025-02-25 | [GLPI-CR-MYSQL-002](https://glpi.lab.local/CR-MYSQL-2025-002) |
| CR-MYSQL-2025-003 | Backup Strategy Update | 2025-03-20 | [GLPI-CR-MYSQL-003](https://glpi.lab.local/CR-MYSQL-2025-003) |

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| DBAdmin | Database Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

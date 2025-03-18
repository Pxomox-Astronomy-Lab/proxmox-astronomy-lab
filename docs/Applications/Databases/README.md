<!-- 
---
title: "Databases - Proxmox Astronomy Lab"
description: "Documentation for database systems and data storage platforms in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["databases", "postgresql", "timescaledb", "mongodb", "redis", "data-storage", "mariadb"]
category: "Applications"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 💾 **Databases**

The Databases section documents the relational, time-series, and NoSQL database systems that provide structured data storage throughout the Proxmox Astronomy Lab. These systems form the foundation for application data persistence, research datasets, and operational metrics that enable both IT services and scientific research.

## 🔍 **1. Overview**

This overview provides context for the lab's database infrastructure, covering both general-purpose and specialized database systems.

### **1.1 Purpose**

This section documents the **database systems and data storage platforms** deployed within the Proxmox Astronomy Lab. It serves as a reference for the **architecture, configuration, and operational aspects** of these critical systems that support research data storage, application persistence, and time-series analysis.

### **1.2 Scope**

The following table defines what is included and excluded from this documentation to help readers understand its boundaries.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Database server deployment and configuration | Application-specific data schemas |
| Management interfaces and monitoring setup | Detailed query optimization |
| Backup and recovery procedures | Research-specific data analysis |
| High availability configuration | Database development methodologies |

### **1.3 Target Audience**

Engineers, operators, and application developers who need to deploy, manage, or integrate with the lab's database infrastructure.

---

## 📊 **2. Database Platforms**

Our lab employs several database technologies, each selected to address specific data storage requirements and workloads.

The following table outlines our primary database platforms and their documentation:

| **Database** | **Purpose** | **Key Documentation** |
|--------------|------------|----------------------|
| [**PostgreSQL**](PostgreSQL/index.md) | Relational data storage for applications | Installation, configuration, management |
| [**TimescaleDB**](TimescaleDB/index.md) | Time-series data for research observations | Setup, hypertables, retention policies |
| [**MongoDB**](MongoDB/index.md) | Document storage for unstructured data | Configuration, sharding, backup |
| [**Redis**](Redis/index.md) | In-memory cache and message broker | Sentinel setup, persistence config |
| [**GIS-Extensions**](GIS-Extensions/index.md) | Spatial data capabilities | PostGIS installation and usage |
| [**MariaDB**](MariaDB/index.md) | Relational data for web applications | Installation, replication, tuning |

---

## 🏗️ **3. Technical Documentation**

This section covers the technical implementation details of our database infrastructure, including architectural design and deployment strategies.

### **3.1 Architecture Overview**

The database infrastructure follows a containerized deployment model with specific considerations for data persistence, performance, and reliability:

- **Docker-based deployment** using Portainer for management
- **Dedicated volumes** for data persistence
- **Automated backup** to NAS and cloud storage
- **Performance tuning** for different workload types
- **High availability** for critical database services

### **3.2 Infrastructure Components**

The following table details the key infrastructure components that make up our database environment:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| Primary Database Server | Containerized database host | lab-db01 |
| Database Storage Volume | Dedicated 2TB NVMe storage | db01-data-volume |
| Database Backup Server | Backup storage and management | lab-backup01 |
| Database Management Tools | phpMyAdmin, pgAdmin, Redis Commander | lab-dbadmin |
| TimescaleDB Server | Specialized time-series database | lab-timescale01 |
| PostGIS Server | Geospatial-enabled PostgreSQL | lab-postgis01 |

### **3.3 Dependencies**

The following table outlines the dependencies and relationships between our database systems and other infrastructure components:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Docker Container Runtime | Database services unavailable |
| **Requires** | Dedicated Storage | Data persistence affected |
| **Requires** | Backup System | Backup failures, recovery risk |
| **Required By** | Web Applications | Application functionality degraded |
| **Required By** | Research Analysis Tools | Research data inaccessible |
| **Required By** | Authentication Services | User login failures |
| **Required By** | Monitoring Systems | Metrics and alert history lost |

---

## 📈 **4. Service Management**

This section describes how database services are managed, including access control and monitoring approaches.

### **4.1 Access Management**

The following table outlines the access management approach for database services:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| Database Administrator | Full administration | Approved by Lab Owner via Zitadel |
| Application Owner | Database-specific access | Approved by Engineer via RBAC |
| Developer | Read/write to specific schemas | Approved by Application Owner |
| Analyst | Read-only to specific datasets | Approved by Application Owner |
| Monitoring System | Metrics collection | Service account with read-only access |

### **4.2 Monitoring & Alerting**

The following table details the key metrics monitored for database systems and their associated alert thresholds:

| **Metric** | **Threshold** | **Alert Severity** |
|------------|--------------|-------------------|
| Database CPU Usage | >80% for >5 min | Warning |
| Database Memory Usage | >90% | Critical |
| Free Disk Space | <15% | Critical |
| Connection Count | >80% of max connections | Warning |
| Replication Lag | >60 seconds | Warning |
| Query Execution Time | >10s average | Warning |
| Failed Transactions | >5% of total | Critical |

---

## 🔄 **5. Operational Procedures**

This section covers routine procedures and troubleshooting approaches for database management.

### **5.1 Routine Procedures**

The following table outlines standard operational procedures for database management:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Database Backup | Daily | Operations | [Database Backup](../File-Storage/Restic/Database-Backup.md) |
| Index Maintenance | Weekly | Database Administrator | [Index Optimization](PostgreSQL/Index-Optimization.md) |
| Performance Review | Monthly | Engineer | [Performance Tuning](PostgreSQL/Performance-Tuning.md) |
| Capacity Planning | Quarterly | Engineer | [Capacity Management](../ITIL-Processes/Service-Design/Capacity-Management.md) |
| Security Audit | Quarterly | Security Administrator | [Database Security Audit](../Compliance-Security/Security-Policies/Database-Security-Audit.md) |

### **5.2 Troubleshooting**

The following table provides guidance for addressing common database-related issues:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Connection Pooling Exhaustion | Connection timeout errors | Reset connection pools, check for leaks | KEDB-DB-001 |
| Slow Query Performance | Increased latency, timeouts | Identify and optimize problematic queries | KEDB-DB-002 |
| Database Lock Contention | Transaction blocks, timeouts | Identify blocking queries, adjust transaction isolation | KEDB-DB-003 |
| Disk Space Exhaustion | Write failures, service crashes | Clean logs, archive data, add capacity | KEDB-DB-004 |
| Replication Failures | Replication lag, synchronization errors | Check network, verify replication slots | KEDB-DB-005 |

---

## 🔐 **6. Security Considerations**

This section outlines the security measures implemented to protect database systems and data.

The following table highlights key security aspects:

| **Security Aspect** | **Implementation** | **Documentation** |
|--------------------|-------------------|--------------------|
| Authentication | RBAC with password policy enforcement | [Database Authentication](PostgreSQL/Authentication.md) |
| Network Security | VLAN isolation, TLS encryption | [Database Network Security](../Compliance-Security/Security-Policies/Database-Network-Security.md) |
| Data Encryption | TDE for sensitive data, encrypted backups | [Data Encryption](../Compliance-Security/Security-Policies/Data-Encryption.md) |
| Vulnerability Management | Regular patching, security scanning | [Database Patching](../ITIL-Processes/Change-Management/Database-Patching.md) |
| Audit Logging | Comprehensive query and access logging | [Database Auditing](../Compliance-Security/Security-Policies/Database-Auditing.md) |

---

## 🔄 **7. Process Integration**

This section explains how database systems relate to established ITIL processes and organizational roles.

### **7.1 ITIL Process Relationship**

This documentation relates to the following ITIL processes:

- **Change Management** - Database upgrades, schema changes, configuration updates
- **Incident Management** - Database outages, performance issues, data corruption
- **Problem Management** - Root cause analysis for database-related issues
- **Service Level Management** - Performance metrics and availability targets
- **Capacity Management** - Resource planning for database growth
- **Availability Management** - High availability configuration and monitoring
- **IT Service Continuity** - Backup strategy and disaster recovery

### **7.2 Role Responsibilities**

The following table outlines role-specific responsibilities related to database management:

| **Role** | **Responsibility Related to Databases** |
|----------|--------------------------------------------|
| Engineer | Architecture design, capacity planning, HA configuration |
| Database Administrator | Day-to-day management, user access, performance tuning |
| Operations | Monitoring, incident response, backup verification |
| Security Administrator | Security policy enforcement, vulnerability assessment |
| Application Owner | Schema design, data architecture, application integration |

---

## 🔗 **8. Related Documentation**

The following table provides links to related documentation resources:

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| Architecture Document | Database Architecture | [Architecture Documentation](../Infrastructure/Storage/Database-Architecture.md) |
| User Guide | Database Access Request | [Service Catalog](../ITIL-Processes/Service-Catalog/Database-Access-Request.md) |
| Security Policy | Database Security Standards | [Security Policies](../Compliance-Security/Security-Policies/Database-Security-Standards.md) |
| Backup Documentation | Database Backup & Recovery | [Backup Strategy](../File-Storage/Restic/Database-Backup-Strategy.md) |
| Performance Guide | Query Optimization | [Performance Documentation](PostgreSQL/Query-Optimization.md) |

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial Databases documentation | VintageDon |

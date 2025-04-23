<!-- 
---
title: "MongoDB Document Database Service Documentation"
description: "Comprehensive documentation for MongoDB document database service in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["mongodb", "nosql", "document-database", "database", "infrastructure", "service"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 📄 **MongoDB Document Database Service**

This document provides comprehensive information about the MongoDB document database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the MongoDB service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of MongoDB in the Proxmox Astronomy Lab environment, focusing on its role in providing flexible, schema-less document storage for applications that require document-oriented data models.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| MongoDB instance and configuration | Application code interacting with MongoDB |
| Document schema design principles | Business logic implementation |
| Query optimization and indexing | Data migration processes |
| Performance tuning and monitoring | End-user application support |
| Security hardening and backup strategies | Custom plugin development |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Operations and Support Personnel
- Application Developers
- DevOps Engineers

## 🔍 **2. Service Overview**

### **2.1 Service Description**

MongoDB provides a flexible, document-oriented NoSQL database that supports dynamic schemas, rich queries, and horizontal scaling. In the Proxmox Astronomy Lab, it serves applications that require schema flexibility, JSON-like document storage, and capability to handle semi-structured or unstructured data not well-suited for relational databases.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-MONGO-001 |
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

MongoDB is deployed as a single instance containerized solution:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-mongo01** | Container on lab-db01 | Document storage for flexible-schema applications | 2 vCPU, 8GB RAM, 250GB storage |

The instance runs MongoDB 7.x and is deployed as a Docker container on lab-db01 running Ubuntu 24.04 LTS with CISv8 Level 2 hardening.

### **3.2 Infrastructure Components**

The following components comprise the MongoDB service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| MongoDB Container (proj-mongo01) | Primary document database container | CMDB-CNT-MONGO01 |
| MongoDB Exporter | Prometheus metrics collector | CMDB-MON-MONGOEXP |
| MongoDB Tools | Backup and management utilities | CMDB-TOOLS-MONGO |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|----------------------|
| proj-mongo01 | 10.25.10.58 | VLAN10 | mongo01 |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Portainer | Container management |
| **Requires** | lab-db01 | Host platform |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | Wiki.js | Content storage unavailable |
| **Required By** | Custom Web Applications | Document storage unavailable |
| **Required By** | Data Collection Pipeline | Unstructured data capture impacted |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Index Optimization | Monthly | DBA | [MONGO-MAINT-001](../Procedures/MONGO-MAINT-001.md) |
| Database Compaction | Quarterly | DBA | [MONGO-MAINT-002](../Procedures/MONGO-MAINT-002.md) |
| Performance Analysis | Monthly | DBA | [MONGO-MAINT-003](../Procedures/MONGO-MAINT-003.md) |
| Container Updates | Weekly (Friday 10:00-11:00 EST) | Infrastructure Team | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

MongoDB is monitored through Prometheus using the MongoDB exporter:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Connections | >50 | >100 | [MONGO-RESP-001](../Procedures/MONGO-RESP-001.md) |
| Memory Usage | >75% max | >90% max | [MONGO-RESP-002](../Procedures/MONGO-RESP-002.md) |
| Query Performance | >100ms avg | >1000ms avg | [MONGO-RESP-003](../Procedures/MONGO-RESP-003.md) |
| Database Size | >80% capacity | >90% capacity | [MONGO-RESP-004](../Procedures/MONGO-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Memory Pressure | High memory usage, slow responses | Review working set size, optimize indexes | KEDB-MONGO-001 |
| Slow Queries | High latency, timeouts | Create indexes, review query patterns | KEDB-MONGO-002 |
| Connection Issues | Connection refused errors | Check network, restart container if needed | KEDB-MONGO-003 |
| Storage Exhaustion | Disk space warnings | Clean up old data, add storage, compact | KEDB-MONGO-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | SCRAM authentication with password | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| Remote Access | TLS encrypted connections only | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the MongoDB service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based authentication, SCRAM authentication | Quarterly access review |
| Network Security | Host-based firewall, container network isolation | Monthly Lynis scans |
| Data Encryption | TLS for connections, encrypted storage | Weekly CIS-CAT scans |
| Auditing | Operation and authentication logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | Network-based access restrictions (MongoDB doesn't support native MFA) | Security Scan Reports | Partially Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | Service account management via change process | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Host-level Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Container image updates via CI/CD pipeline | Pipeline Logs | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| Full Database Dump | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Collection Corruption | 1 hour | 24 hours | [DR-MONGO-001](../DR/DR-MONGO-001.md) | DBA |
| Container Failure | 2 hours | 24 hours | [DR-MONGO-002](../DR/DR-MONGO-002.md) | Systems Administrator |
| Host Failure | 4 hours | 24 hours | [DR-MONGO-003](../DR/DR-MONGO-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-MONGO-004](../DR/DR-MONGO-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | MongoDB Tuning Guide | [docs/MONGO-Tuning-Guide.md](../Guides/MONGO-Tuning-Guide.md) | Performance optimization |
| Procedure | Index Strategy | [docs/MONGO-Index-Strategy.md](../Procedures/MONGO-Index-Strategy.md) | Query performance |
| Architecture | NoSQL Database Architecture | [docs/NoSQL-Architecture.md](../Architecture/NoSQL-Architecture.md) | Overall context |
| Security | MongoDB Security Baseline | [docs/MONGO-Security-Baseline.md](../Security/MONGO-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| MongoDB Documentation | <https://www.mongodb.com/docs/> | [Local Copy](../References/MongoDB-Docs.pdf) | 2025-04-01 |
| MongoDB Security Checklist | <https://www.mongodb.com/docs/manual/administration/security-checklist/> | [Local Copy](../References/MongoDB-Security.pdf) | 2025-04-01 |
| MongoDB Performance Best Practices | <https://www.mongodb.com/docs/manual/core/query-optimization/> | [Local Copy](../References/MongoDB-Performance.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-MONGO-2025-001 | MongoDB 7.x Upgrade | 2025-02-15 | [GLPI-CR-MONGO-001](https://glpi.lab.local/CR-MONGO-2025-001) |
| CR-MONGO-2025-002 | Index Optimization | 2025-03-20 | [GLPI-CR-MONGO-002](https://glpi.lab.local/CR-MONGO-2025-002) |
| CR-MONGO-2025-003 | Storage Expansion | 2025-04-10 | [GLPI-CR-MONGO-003](https://glpi.lab.local/CR-MONGO-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| DBAdmin | Database Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

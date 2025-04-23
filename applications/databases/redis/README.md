<!-- 
---
title: "Redis Service Documentation"
description: "Comprehensive documentation for Redis in-memory data structure store in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["redis", "cache", "in-memory", "database", "messaging", "infrastructure", "service"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "RabbitMQ", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🔄 **Redis Service**

This document provides comprehensive information about the Redis in-memory data structure store deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the Redis service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of Redis in the Proxmox Astronomy Lab environment, focusing on its role in providing high-performance caching, messaging, and data structure services.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Redis instances and configuration | Application code interacting with Redis |
| Caching strategy and implementation | Business logic implementation |
| Pub/Sub messaging capabilities | Data migration processes |
| Memory management and optimization | End-user application support |
| Persistence configuration | Custom module development |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Operations and Support Personnel
- Application Developers
- DevOps Engineers

## 🔍 **2. Service Overview**

### **2.1 Service Description**

Redis provides a high-performance in-memory data structure store that serves multiple functions across the lab environment including caching, messaging broker, session store, and real-time data structure operations. Its sub-millisecond response times and versatile data structures enable performance optimization for various applications within the lab's infrastructure.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-REDIS-001 |
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

Redis is deployed across two instances to separate production and development workloads:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-redis01** | Dedicated VM | Primary Redis for production caching and messaging | 2 vCPU, 8GB RAM, 50GB storage |
| **proj-redis02dev** | Container on lab-db01 | Development and testing workloads | 1 vCPU, 4GB RAM, 20GB storage |

Both instances run Redis 7.2.x and are deployed on Ubuntu 24.04 LTS with CISv8 Level 2 hardening.

### **3.2 Infrastructure Components**

The following components comprise the Redis service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| Redis Server (proj-redis01) | Primary Redis VM | CMDB-VM-REDIS01 |
| Redis Container (proj-redis02dev) | Development Redis container | CMDB-CNT-REDIS02 |
| Redis Exporter | Prometheus metrics collector | CMDB-MON-REDISEXP |
| Redis Sentinel | High availability monitoring | CMDB-REDIS-SENT |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|----------------------|
| proj-redis01 | 10.25.20.17 | VLAN20 | redis01-prod |
| proj-redis02dev | 10.25.10.56 | VLAN10 | redis02-dev |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox VE | Complete service outage for proj-redis01 |
| **Requires** | Portainer | Container management for proj-redis02dev |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | Observatory Pipeline | Cache unavailable, performance degradation |
| **Required By** | Web Applications | Session management impacted |
| **Required By** | Data Processing Pipeline | Inter-service messaging delayed |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Memory Usage Analysis | Weekly | DBA | [Redis-MAINT-001](../Procedures/Redis-MAINT-001.md) |
| Key Expiration Audit | Monthly | DBA | [Redis-MAINT-002](../Procedures/Redis-MAINT-002.md) |
| RDB Persistence Check | Weekly | System | [Redis-MAINT-003](../Procedures/Redis-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

Redis instances are monitored through Prometheus using the Redis exporter:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Memory Usage | >75% max | >90% max | [Redis-RESP-001](../Procedures/Redis-RESP-001.md) |
| Connected Clients | >500 | >1000 | [Redis-RESP-002](../Procedures/Redis-RESP-002.md) |
| Command Latency | >1ms | >5ms | [Redis-RESP-003](../Procedures/Redis-RESP-003.md) |
| Evicted Keys | >100/minute | >1000/minute | [Redis-RESP-004](../Procedures/Redis-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Memory Exhaustion | OOM errors, service termination | Clear unnecessary keys, adjust maxmemory setting | KEDB-REDIS-001 |
| Slow Commands | High latency metrics, slow responses | Identify expensive operations, optimize or disable | KEDB-REDIS-002 |
| Replication Issues | Replication lag, sync failures | Check network connectivity, reset replication | KEDB-REDIS-003 |
| Persistence Failures | RDB/AOF write errors | Check disk space, verify permissions | KEDB-REDIS-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Password authentication + ACL | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| Remote Access | TLS encrypted connections only | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the Redis service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Password authentication, ACL-based access | Quarterly access review |
| Network Security | Protected by firewall, no direct public access | Monthly Lynis scans |
| Data Encryption | TLS for connections, encrypted persistence files | Weekly CIS-CAT scans |
| Command Auditing | Command logging for sensitive operations | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | Password + network segmentation (Redis doesn't support native MFA) | Security Scan Reports | Partially Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | ACL management via change process | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Azure Update Manager performs weekly patching | Azure Arc Logs | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| RDB Snapshots | Hourly | 24 hours | Local storage |
| Complete Backup | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Cache Corruption | 30 minutes | 1 hour | [DR-REDIS-001](../DR/DR-REDIS-001.md) | DBA |
| Instance Failure | 1 hour | 1 hour | [DR-REDIS-002](../DR/DR-REDIS-002.md) | Systems Administrator |
| Complete Host Failure | 2 hours | 1 hour | [DR-REDIS-003](../DR/DR-REDIS-003.md) | Infrastructure Team |
| Datacenter Failure | 12 hours | 24 hours | [DR-REDIS-004](../DR/DR-REDIS-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | Redis Tuning Guide | [docs/Redis-Tuning-Guide.md](../Guides/Redis-Tuning-Guide.md) | Performance optimization |
| Procedure | Memory Management | [docs/Redis-Memory-Management.md](../Procedures/Redis-Memory-Management.md) | Resource optimization |
| Architecture | Caching Architecture Overview | [docs/Cache-Architecture.md](../Architecture/Cache-Architecture.md) | Overall context |
| Security | Redis Security Baseline | [docs/Redis-Security-Baseline.md](../Security/Redis-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Redis Documentation | <https://redis.io/documentation> | [Local Copy](../References/Redis-Docs.pdf) | 2025-04-01 |
| Redis Security | <https://redis.io/topics/security> | [Local Copy](../References/Redis-Security.pdf) | 2025-04-01 |
| Redis Persistence | <https://redis.io/topics/persistence> | [Local Copy](../References/Redis-Persistence.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-REDIS-2025-001 | Redis 7.2 Upgrade | 2025-02-05 | [GLPI-CR-REDIS-001](https://glpi.lab.local/CR-REDIS-2025-001) |
| CR-REDIS-2025-002 | Memory Optimization | 2025-03-10 | [GLPI-CR-REDIS-002](https://glpi.lab.local/CR-REDIS-2025-002) |
| CR-REDIS-2025-003 | Security Hardening | 2025-04-01 | [GLPI-CR-REDIS-003](https://glpi.lab.local/CR-REDIS-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| DBAdmin | Database Administrator | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

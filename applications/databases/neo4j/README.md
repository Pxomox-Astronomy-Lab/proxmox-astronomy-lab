<!-- 
---
title: "Neo4j Graph Database Service Documentation"
description: "Comprehensive documentation for Neo4j graph database service in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["neo4j", "graph-database", "database", "cypher", "relationships", "infrastructure", "service"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "RAGGraph", "Milvus", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🔄 **Neo4j Graph Database Service**

This document provides comprehensive information about the Neo4j graph database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the Neo4j graph database service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of Neo4j in the Proxmox Astronomy Lab environment, focusing on its role in providing relationship-centric data modeling and querying capabilities.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Neo4j instances and configuration | Application code interacting with Neo4j |
| Graph data modeling and schemas | Business logic implementation |
| Cypher query optimization | Data migration processes |
| Relationship-based data access | End-user application support |
| Integration with RAGGraph | Custom plugin development |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- Knowledge Graph Engineers
- Data Scientists
- AI/ML Engineers

## 🔍 **2. Service Overview**

### **2.1 Service Description**

Neo4j provides a native graph database platform designed for storing, querying, and visualizing highly connected data. In the Proxmox Astronomy Lab, it serves as the backbone for relationship modeling, particularly for the RAGGraph knowledge system, document relationship mapping, and spatial/temporal relationship analysis of astronomical observations.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-NEO4J-001 |
| **Service Type** | Supporting |
| **Service Category** | Database |
| **Business Criticality** | High |
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

Neo4j is deployed across one instance:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-neo4j01** | Container on lab-db01 | Primary graph database for knowledge relationships | 4 vCPU, 16GB RAM, 250GB storage |

Both instances run Neo4j 5.x and are deployed on Ubuntu 24.04 LTS with CISv8 Level 2 hardening.

### **3.2 Infrastructure Components**

The following components comprise the Neo4j service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| Neo4j Server (proj-neo4j01) | Primary graph database VM | CMDB-VM-NEO4J01 |
| Neo4j Exporter | Prometheus metrics collector | CMDB-MON-NEO4JEXP |
| Neo4j Browser | Web-based interface for Cypher queries | CMDB-APP-NEO4JBROWSER |
| Neo4j Bloom | Graph visualization platform | CMDB-APP-NEO4JBLOOM |
| APOC Library | Extended procedures and functions | CMDB-LIB-NEO4JAPOC |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|----------------------|
| proj-neo4j01 | 10.25.20.18 | VLAN20 | neo4j01-prod |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Proxmox VE | Complete service outage for proj-neo4j01 |
| **Requires** | Portainer | Container management for proj-neo4j01dev |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | RAGGraph | Knowledge graph functionality unavailable |
| **Required By** | Document Management System | Document relationships unavailable |
| **Required By** | AI Knowledge Retrieval | Context-aware query results impacted |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Index Optimization | Weekly | DBA | [NEO4J-MAINT-001](../Procedures/NEO4J-MAINT-001.md) |
| Relationship Analysis | Monthly | DBA | [NEO4J-MAINT-002](../Procedures/NEO4J-MAINT-002.md) |
| Query Performance Review | Monthly | DBA | [NEO4J-MAINT-003](../Procedures/NEO4J-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md](../../../../itil-policies-and-procedures/Patch-Management/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

Neo4j instances are monitored through Prometheus using the Neo4j exporter:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Heap Usage | >75% max | >90% max | [NEO4J-RESP-001](../Procedures/NEO4J-RESP-001.md) |
| Page Cache Hit Ratio | <90% | <80% | [NEO4J-RESP-002](../Procedures/NEO4J-RESP-002.md) |
| GC Pause Time | >200ms | >500ms | [NEO4J-RESP-003](../Procedures/NEO4J-RESP-003.md) |
| Active Transactions | >50 | >100 | [NEO4J-RESP-004](../Procedures/NEO4J-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01, following procedures defined in [itil-policies-and-procedures/Monitoring/MON-PROC-001.md](../../../../itil-policies-and-procedures/Monitoring/MON-PROC-001.md).

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Memory Exhaustion | OOM errors, service termination | Review heap settings, optimize queries | KEDB-NEO4J-001 |
| Slow Cypher Queries | High latency, timeouts | Review query plans, optimize indexes | KEDB-NEO4J-002 |
| Connection Issues | Connection refused errors | Check network, restart service if needed | KEDB-NEO4J-003 |
| Index Problems | Missing nodes in results | Rebuild indexes, verify constraints | KEDB-NEO4J-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Role-based with password + Entra MFA | [itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md](../../../../itil-policies-and-procedures/Access-Management/ACC-AUTH-002.md) |
| Remote Access | SSL/TLS encrypted connections only | [itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md](../../../../itil-policies-and-procedures/Security-Policies/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the Neo4j service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| Access Control | Role-based authentication, procedure restrictions | Quarterly access review |
| Network Security | Host-based firewall, TLS encryption | Monthly Lynis scans |
| Data Encryption | TLS for connections, encrypted storage | Weekly CIS-CAT scans |
| Audit Logging | Comprehensive query and admin logging | Weekly log review, Wazuh alerts |

### **5.3 Compliance Mapping**

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 (Ensure remote access requires MFA) | Entra ID with MFA required for admin access | Entra Sign-in Logs | Compliant |
| CIS.8.3 (Ensure access is revoked upon termination) | AD group-based access with automated provisioning/deprovisioning | GLPI Change Records | Compliant |
| CIS.10.1 (Deploy and maintain anti-malware) | Wazuh agent with active scanning | Wazuh Dashboard | Compliant |
| CIS.10.2 (Configure automatic updates) | Azure Update Manager performs weekly patching | Azure Arc Logs | Compliant |

The compliance mapping follows guidelines outlined in [itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md](../../../../itil-policies-and-procedures/CIS-Security-Policies/CISV8-Mapping.md).

## 💾 **6. Backup & Recovery**

### **6.1 Backup Strategy**

The following backup strategy ensures data protection and recoverability:

| **Backup Type** | **Schedule** | **Retention** | **Storage Location** |
|-----------------|-------------|--------------|----------------------|
| Full Database Dump | Daily at 09:00 EST | 14 days | Proxmox Backup Server (backup01) |
| Transaction Logs | Every 6 hours | 7 days | Local storage |
| Weekly Backup | Sundays at 01:00 EST | 4 weeks | PBS + AWS Deep Glacier |
| Monthly Backup | First Sunday of month | 6 months | PBS + AWS Deep Glacier |

The backup strategy follows the principles defined in [itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md](../../../../itil-policies-and-procedures/Backup-Management/BKP-STRAT-001.md).

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Database Corruption | 2 hours | 6 hours | [DR-NEO4J-001](../DR/DR-NEO4J-001.md) | DBA |
| Instance Failure | 4 hours | 6 hours | [DR-NEO4J-002](../DR/DR-NEO4J-002.md) | Systems Administrator |
| Complete Host Failure | 6 hours | 24 hours | [DR-NEO4J-003](../DR/DR-NEO4J-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-NEO4J-004](../DR/DR-NEO4J-004.md) | DR Team |

The recovery procedures align with the incident management process defined in [itil-policies-and-procedures/Incident-Management/INC-PROC-001.md](../../../../itil-policies-and-procedures/Incident-Management/INC-PROC-001.md).

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | Neo4j Tuning Guide | [docs/NEO4J-Tuning-Guide.md](../Guides/NEO4J-Tuning-Guide.md) | Performance optimization |
| Procedure | Cypher Query Optimization | [docs/Cypher-Optimization.md](../Procedures/Cypher-Optimization.md) | Query performance |
| Architecture | Graph Database Architecture | [docs/Graph-Architecture.md](../Architecture/Graph-Architecture.md) | Overall context |
| Security | Neo4j Security Baseline | [docs/NEO4J-Security-Baseline.md](../Security/NEO4J-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Neo4j Documentation | <https://neo4j.com/docs/> | [Local Copy](../References/Neo4j-Docs.pdf) | 2025-04-01 |
| Cypher Query Language | <https://neo4j.com/developer/cypher/> | [Local Copy](../References/Cypher-Reference.pdf) | 2025-04-01 |
| Neo4j Operations Manual | <https://neo4j.com/docs/operations-manual/5/> | [Local Copy](../References/Neo4j-Operations.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-NEO4J-2025-001 | Neo4j 5.x Upgrade | 2025-02-10 | [GLPI-CR-NEO4J-001](https://glpi.lab.local/CR-NEO4J-2025-001) |
| CR-NEO4J-2025-002 | Memory Optimization | 2025-03-15 | [GLPI-CR-NEO4J-002](https://glpi.lab.local/CR-NEO4J-2025-002) |
| CR-NEO4J-2025-003 | RAGGraph Integration | 2025-04-05 | [GLPI-CR-NEO4J-003](https://glpi.lab.local/CR-NEO4J-2025-003) |

All changes follow the process defined in [itil-policies-and-procedures/Change-Management/CHG-PROC-001.md](../../../../itil-policies-and-procedures/Change-Management/CHG-PROC-001.md).

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

<!-- 
---
title: "PostgreSQL with PostGIS Service Documentation"
description: "Comprehensive documentation for the PostgreSQL with PostGIS spatial database service in the Proxmox Astronomy Lab environment"
author: "VintageDon"
tags: ["postgresql", "postgis", "spatial", "gis", "database", "infrastructure", "service", "astronomy"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-22"
related_services: ["PostgreSQL", "TimescaleDB", "Neo4j", "Prometheus", "Proxmox Backup Server"]
implements_policies: ["Data Protection Policy", "Backup Policy", "Monitoring Policy", "Patch Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.3", "CIS.10.1", "CIS.10.2"]
iso27001_controls: ["A.12.3.1", "A.12.4.1", "A.14.2.5"]
nist_controls: ["CP-9", "SI-2", "AU-4", "CM-6"]
---
-->

# 🌎 **PostgreSQL with PostGIS Service**

This document provides comprehensive information about the PostgreSQL with PostGIS spatial database service deployed in the Proxmox Astronomy Lab, including its architecture, configurations, operations, and compliance mapping.

## 📋 **1. Overview**

### **1.1 Purpose**

This document defines the PostgreSQL with PostGIS service, its deployment architecture, operational parameters, and management procedures. It serves as the definitive reference for all aspects of spatial data handling in the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| PostGIS instances and configuration | Application code interacting with PostGIS |
| Spatial data indexing and optimization | Business logic implementation |
| GeoJSON and spatial data formats | Data migration processes |
| Vector and raster spatial data handling | End-user application support |
| Radio frequency mapping capabilities | Non-spatial data management |

### **1.3 Target Audience**

This document is intended for:

- Database Administrators
- System Administrators
- GIS Specialists
- Radio Astronomy Researchers
- Spatial Data Analysts

## 🔍 **2. Service Overview**

### **2.1 Service Description**

PostgreSQL with PostGIS provides advanced spatial data capabilities, enabling the storage, indexing, and analysis of geographic and spatial information for astronomical research, radio frequency mapping, and observatory positioning. It extends PostgreSQL with specialized data types, functions, and spatial indexing to efficiently handle location-based queries and spatial analytics.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | DB-GIS-001 |
| **Service Type** | Core |
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

PostgreSQL with PostGIS is deployed across two instances to separate production and development workloads:

| **Instance** | **Host** | **Purpose** | **Resources** |
|-------------|----------|------------|---------------|
| **proj-pggis01** | Dedicated VM | Primary spatial data for radio astronomy mapping | 4 vCPU, 16GB RAM, 500GB storage |
| **proj-pggis02dev** | Container on lab-db01 | Development and testing workloads | 2 vCPU, 8GB RAM, 250GB storage |

Both instances run PostgreSQL 16.x with PostGIS 3.4.x extension and are deployed on Ubuntu 24.04 LTS with CISv8 Level 2 hardening.

### **3.2 Infrastructure Components**

The following components comprise the PostGIS service infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| PostGIS Server (proj-pggis01) | Primary spatial database VM | CMDB-VM-PGGIS01 |
| PostGIS Container (proj-pggis02dev) | Development database container | CMDB-CNT-PGGIS02 |
| PostgreSQL Exporter | Prometheus metrics collector | CMDB-MON-PGGISEXP |
| Iperius Backup Agent | Backup automation for databases | CMDB-BKP-IPRAG-GIS |
| GDAL Library | Geospatial data abstraction library | CMDB-LIB-GDAL |

### **3.3 Network Configuration**

| **Instance** | **IP Address** | **Network Segment** | **Firewall Rule Set** |
|--------------|----------------|---------------------|----------------------|
| proj-pggis01 | 10.25.20.15 | VLAN20 | pggis01-prod |
| proj-pggis02dev | 10.25.10.54 | VLAN10 | pggis02-dev |

### **3.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | PostgreSQL | Complete service outage (PostGIS is a PostgreSQL extension) |
| **Requires** | Proxmox VE | Complete service outage for proj-pggis01 |
| **Requires** | Portainer | Container management for proj-pggis02dev |
| **Requires** | Prometheus | Loss of monitoring capability |
| **Required By** | RF Monitoring Pipeline | RF spatial mapping unavailable |
| **Required By** | Radio Astronomy Visualization | Spatial representation of data unavailable |
| **Required By** | High-Velocity Clouds Tracking | Location-based analysis impacted |

## 🔧 **4. Management & Operations**

### **4.1 Regular Maintenance**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| Spatial Index Vacuum | Weekly | DBA | [GIS-MAINT-001](../Procedures/GIS-MAINT-001.md) |
| PostGIS Extension Update | Quarterly | DBA | [GIS-MAINT-002](../Procedures/GIS-MAINT-002.md) |
| GIST Index Optimization | Monthly | DBA | [GIS-MAINT-003](../Procedures/GIS-MAINT-003.md) |
| System Updates | Weekly (Friday 10:00-11:00 EST) | Azure Update Manager | [SYS-PATCH-001](../Procedures/SYS-PATCH-001.md) |

### **4.2 Monitoring Configuration**

PostGIS instances are monitored through Prometheus using the PostgreSQL exporter with custom PostGIS-specific queries:

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| Spatial Index Size | >10GB | >20GB | [GIS-RESP-001](../Procedures/GIS-RESP-001.md) |
| Spatial Query Latency | >2s | >5s | [GIS-RESP-002](../Procedures/GIS-RESP-002.md) |
| GIST Index Bloat | >20% | >40% | [GIS-RESP-003](../Procedures/GIS-RESP-003.md) |
| Database Size | >80% capacity | >90% capacity | [GIS-RESP-004](../Procedures/GIS-RESP-004.md) |

All metrics are exposed to Prometheus via exporters and visualized through dedicated Grafana dashboards on lab-mon01.

### **4.3 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| Slow Spatial Queries | High query latency, high CPU | Review GIST indexes, run EXPLAIN ANALYZE, optimize query | KEDB-GIS-001 |
| PostGIS Extension Issues | Function errors, version mismatch | Verify extension version, reinstall if necessary | KEDB-GIS-002 |
| Large Dataset Import Failures | Timeout errors, memory issues | Use COPY command with batching, increase work_mem | KEDB-GIS-003 |
| Projection Transformation Errors | Invalid geometry errors | Verify SRID consistency, check datum transformations | KEDB-GIS-004 |

## 🔐 **5. Security & Compliance**

### **5.1 Authentication & Authorization**

| **Access Type** | **Method** | **Policy Document** |
|----------------|------------|---------------------|
| Administrative Access | Role-based with password + Entra MFA | [SEC-AUTH-001](../Security/SEC-AUTH-001.md) |
| Application Access | Service accounts with minimal privileges | [SEC-AUTH-002](../Security/SEC-AUTH-002.md) |
| Remote Access | SSL/TLS encrypted connections only | [SEC-CONN-001](../Security/SEC-CONN-001.md) |

### **5.2 Security Controls**

The following controls protect the PostGIS service:

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
| Shapefile Export | Monthly | 12 months | proj-fs03 (NFS storage) |

For regularly changing spatial datasets, these are backed up daily by Iperius backup with 14-day retention and synced to AWS Deep Glacier with 6-month retention. Large static reference datasets (e.g., baseline geographic data) are backed up once upon creation.

### **6.2 Recovery Procedures**

| **Scenario** | **RTO** | **RPO** | **Recovery Procedure** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Spatial Table Corruption | 2 hours | 24 hours | [DR-GIS-001](../DR/DR-GIS-001.md) | DBA |
| Instance Failure | 4 hours | 24 hours | [DR-GIS-002](../DR/DR-GIS-002.md) | Systems Administrator |
| Complete Host Failure | 6 hours | 24 hours | [DR-GIS-003](../DR/DR-GIS-003.md) | Infrastructure Team |
| Datacenter Failure | 24 hours | 48 hours | [DR-GIS-004](../DR/DR-GIS-004.md) | DR Team |

## 📚 **7. References & Related Resources**

### **7.1 Internal Documentation**

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Technical Guide | PostGIS Tuning Guide | [docs/GIS-Tuning-Guide.md](../Guides/GIS-Tuning-Guide.md) | Performance optimization |
| Procedure | Spatial Index Optimization | [docs/Spatial-Index-Optimization.md](../Procedures/Spatial-Index-Optimization.md) | Index management |
| Architecture | Spatial Data Architecture | [docs/GIS-Architecture.md](../Architecture/GIS-Architecture.md) | Overall context |
| Security | PostGIS Security Baseline | [docs/GIS-Security-Baseline.md](../Security/GIS-Security-Baseline.md) | Security standards |

### **7.2 External References**

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| PostGIS Documentation | <https://postgis.net/documentation/> | [Local Copy](../References/PostGIS-Docs.pdf) | 2025-04-01 |
| PostgreSQL Spatial Tutorial | <https://postgis.net/workshops/postgis-intro/> | [Local Copy](../References/PostGIS-Tutorial.pdf) | 2025-04-01 |
| GIST Index Management | <https://postgis.net/docs/using_postgis_dbmanagement.html> | [Local Copy](../References/GIST-Management.pdf) | 2025-04-01 |

### **7.3 Change Request References**

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-GIS-2025-001 | PostGIS 3.4 Upgrade | 2025-01-25 | [GLPI-CR-GIS-001](https://glpi.lab.local/CR-GIS-2025-001) |
| CR-GIS-2025-002 | RF Mapping Schema Update | 2025-02-10 | [GLPI-CR-GIS-002](https://glpi.lab.local/CR-GIS-2025-002) |
| CR-GIS-2025-003 | Spatial Index Optimization | 2025-03-15 | [GLPI-CR-GIS-003](https://glpi.lab.local/CR-GIS-2025-003) |

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-22 | ✅ Approved |
| DBAdmin | Database Administrator | 2025-04-22 | ✅ Approved |
| SpatialAnalyst | GIS Specialist | 2025-04-22 | ✅ Approved |

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-22 | Initial version | VintageDon |

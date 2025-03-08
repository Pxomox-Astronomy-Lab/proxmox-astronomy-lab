---
title: "Proj-PGGIS01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-PGGIS01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "database", "postgresql", "gis"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Proj-PGGIS01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-PGGIS01 is the **primary PostgreSQL + PostGIS database server** for the Proxmox Astronomy Lab. It runs **PostgreSQL 16 with PostGIS 3.4** on **Ubuntu 24.04**, providing **geospatial data storage and processing** for lab research, mapping, and analysis workflows.

This database server is optimized for **high-performance geospatial queries, spatial indexing, and raster/vector data handling**, with **role-based access controls and secure replication mechanisms**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | PG-GIS01 |
| **Service Type**   | GIS Database Infrastructure |
| **Service Category** | Geospatial Data Management |
| **Business Criticality** | High |
| **Service Owner**  | Lab Engineer |

### **1.3 Service Hours**  

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7 |
| **Support Hours** | Best-effort during business hours |
| **Maintenance Windows** | As required, change-controlled |

---

## **2. Service Level Agreements**  

### **2.1 Service Level Targets**  

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Database Uptime** | 99.99% | Prometheus monitoring |
| **Spatial Query Response Time** | ≤ 100ms | Grafana query analysis |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Database performance & health monitoring |
| **Grafana** | Query execution and spatial processing visualization |
| **Loki** | Log aggregation for database events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Database snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-PGGIS01 is a **PostgreSQL 16-based database server with PostGIS 3.4**, designed for **geospatial data processing, mapping, and spatial analysis**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-pggis01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Database Storage) |
| **Networking** | VLAN20 (Production) |
| **Database Engine** | PostgreSQL 16 + PostGIS 3.4 |
| **Replication** | WAL-based streaming replication |

### **3.3 Database Configuration**  

| **Parameter** | **Value** |
|--------------|----------|
| **max_connections** | 200 |
| **shared_buffers** | 4GB |
| **work_mem** | 128MB |
| **maintenance_work_mem** | 512MB |
| **wal_level** | replica |
| **checkpoint_timeout** | 15min |
| **archive_mode** | on |
| **archive_command** | rsync to remote storage |

### **3.4 GIS Features & Optimization**  

- **Geospatial Indexing:** GiST, SP-GiST, and BRIN indexes for spatial data
- **Raster Data Handling:** Optimized for processing large-scale maps
- **Vector Data Storage:** Efficient storage of point, line, and polygon datasets
- **Spatial Queries:** Optimized for distance calculations, topology validation, and geographic joins

### **3.5 Access Control & Authentication**  

- **Authentication:** Entra ID-integrated authentication (No local accounts)
- **Access Control:** PostgreSQL role-based access control (RBAC)
- **Replication Users:** Encrypted connections only
- **Encryption:** Data at rest (LUKS) and in transit (TLS)

### **3.6 Backup and Recovery**  

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily (PBS), Weekly (Wasabi S3) |
| **Backup Method** | PostgreSQL Dump + WAL Archiving |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 day |

---

## **4. Service Management**  

### **4.1 Access Management**  

| **User Role** | **Access Level** | **Authorization Process** |
|--------------|----------------|---------------------------|
| **Lab Engineer** | Full Admin | PostgreSQL Superuser Role |
| **GIS Analyst** | Read & Query Execution | Role-Based Access |
| **Infrastructure Ops** | Database Management | Role-Based Access |
| **Service Desk** | Read-Only | Ticket-Only Access |
| **Change Manager** | Approves schema changes | ITIL CAB Process |

### **4.2 Incident Management**  

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Database Server Down** | High | P1 | 15 min | 4 hours |
| **Query Performance Issues** | Medium | P2 | 30 min | 6 hours |
| **Unauthorized Data Access** | Critical | P1 | Immediate | Investigation & Lockdown |

---

## **5. Security and Compliance**  

### **5.1 Security Controls**  

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | PostgreSQL RBAC, Entra ID Authentication |
| **Logging & Auditing** | Wazuh + Loki + PostgreSQL Logs |
| **Database Hardening** | CIS-recommended policies enforced |
| **Encryption** | TLS for data in transit, LUKS for storage |

### **5.2 Compliance Requirements**  

| **Requirement** | **Standard/Framework** |
|----------------|----------------------|
| **Hardened Configuration** | CIS PostgreSQL Benchmark Compliance |
| **Security Monitoring** | NIST 800-53 |
| **Data Encryption & Protection** | ISO 27001 |

---

## **6. Related Documentation**  

| **Document Type** | **Document Name** |
|-------------------|-------------------|
| **GIS Data Schema Documentation** | PostGIS Table Structures |
| **Backup & Recovery Plan** | Disaster Recovery Guidelines |
| **Spatial Query Optimization Guide** | Performance Tuning Policies |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

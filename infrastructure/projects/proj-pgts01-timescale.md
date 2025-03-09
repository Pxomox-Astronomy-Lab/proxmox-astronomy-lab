---
title: "Proj-PGTS01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-PGTS01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "database", "timescaledb", "postgresql"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---

# **Proj-PGTS01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-PGTS01 is the **primary TimescaleDB server** for the Proxmox Astronomy Lab, running **PostgreSQL 16 with TimescaleDB 2.11** on **Ubuntu 24.04**. It is designed for **high-performance time-series data storage and analytics**, supporting research data ingestion, processing, and long-term archival.

The server is optimized for **handling large-scale time-series data**, utilizing **continuous aggregation, compression, and parallel query execution** for efficient performance. It integrates with **PostgreSQL for relational workloads and supports hybrid queries combining structured and time-series data.**

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | PG-TS01 |
| **Service Type**   | Time-Series Database Infrastructure |
| **Service Category** | Data Processing & Analytics |
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
| **Query Response Time** | ≤ 100ms | Grafana query analysis |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Database performance & health monitoring |
| **Grafana** | Time-series query execution and visualization |
| **Loki** | Log aggregation for database events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Database snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-PGTS01 is a **PostgreSQL 16-based database server with TimescaleDB 2.11**, optimized for **efficient storage and analysis of high-frequency time-series data**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-pgts01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Time-Series Database Storage) |
| **Networking** | VLAN20 (Production) |
| **Database Engine** | PostgreSQL 16 + TimescaleDB 2.11 |
| **Replication** | WAL-based streaming replication |

### **3.3 Time-Series Data Configuration**  

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
| **timescaledb.compress** | Enabled |
| **timescaledb.retention_policy** | 365 days |
| **continuous_aggregates** | Enabled |

### **3.4 Data Ingestion & Processing Optimization**  

- **Data Partitioning:** Automatic hypertable creation for efficient time-based storage
- **Compression Policies:** Configured for long-term storage efficiency
- **Continuous Aggregation:** Precomputed summaries for fast query responses
- **Parallel Query Execution:** Optimized for real-time analytics

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
| **Data Scientist** | Read & Query Execution | Role-Based Access |
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
| **Time-Series Data Schema Documentation** | TimescaleDB Table Structures |
| **Backup & Recovery Plan** | Disaster Recovery Guidelines |
| **Query Optimization Guide** | Performance Tuning Policies |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |

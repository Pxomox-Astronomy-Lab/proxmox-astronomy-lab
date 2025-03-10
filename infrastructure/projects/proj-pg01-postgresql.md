<!-- ---
title: "Proj-PG01 Service Documentation"
description: "Comprehensive ITIL-aligned documentation of Proj-PG01, including infrastructure, security policies, and service management details."
author: "VintageDon"
tags: ["service-documentation", "infrastructure", "database", "postgresql", "storage"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-07"
---
 -->

# **Proj-PG01 Service**  

## **1. Service Overview**  

### **1.1 Service Description**  

Proj-PG01 is the **primary PostgreSQL database server** for the Proxmox Astronomy Lab. It runs **PostgreSQL 16** on **Ubuntu 24.04**, providing structured data storage and transactional support for lab operations, research datasets, and system configurations.

This database server is optimized for **high availability, performance, and security**, utilizing **tuned configurations, regular backups, and role-based access controls**.

### **1.2 Service Classification**  

| **Attribute**       | **Value** |
|---------------------|-----------|
| **Service ID**     | PG-01 |
| **Service Type**   | Database Infrastructure |
| **Service Category** | Structured Data Management |
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
| **Query Response Time** | ≤ 50ms | Grafana query analysis |
| **Backup Sync Interval** | ≤ 1 day | Proxmox Backup Server logs |
| **Recovery Time** | RTO: 4 hours | Restore test validation |

### **2.2 Monitoring and Reporting**  

| **Monitoring Tool** | **Purpose** |
|---------------------|------------|
| **Prometheus** | Database performance & health monitoring |
| **Grafana** | Query execution and latency visualization |
| **Loki** | Log aggregation for database events |
| **Wazuh** | Security monitoring and anomaly detection |
| **Proxmox Backup Server** | Database snapshot verification |

---

## **3. Technical Documentation**  

### **3.1 Architecture Overview**  

Proj-PG01 is a **PostgreSQL 16-based database server**, built for **high-performance transactional workloads**.

### **3.2 Infrastructure Components**  

| **Component** | **Description** |
|--------------|----------------|
| **Hostname** | proj-pg01.beardinthe.cloud |
| **OS** | Ubuntu 24.04 |
| **CPU** | 4 vCPUs |
| **RAM** | 16GB |
| **Storage** | 32GB C:\ (OS) + 500GB D:\ (Database Storage) |
| **Networking** | VLAN20 (Production) |
| **Database Engine** | PostgreSQL 16 |
| **Replication** | WAL-based streaming replication |

### **3.3 Database Configuration**  

| **Parameter** | **Value** |
|--------------|----------|
| **max_connections** | 200 |
| **shared_buffers** | 4GB |
| **work_mem** | 64MB |
| **maintenance_work_mem** | 512MB |
| **wal_level** | replica |
| **checkpoint_timeout** | 15min |
| **archive_mode** | on |
| **archive_command** | rsync to remote storage |

### **3.4 Access Control & Authentication**  

- **Authentication:** Entra ID-integrated authentication (No local accounts)
- **Access Control:** PostgreSQL role-based access control (RBAC)
- **Replication Users:** Encrypted connections only
- **Encryption:** Data at rest (LUKS) and in transit (TLS)

### **3.5 Backup and Recovery**  

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
| **Database Schema Documentation** | PostgreSQL Table Structures |
| **Backup & Recovery Plan** | Disaster Recovery Guidelines |
| **Query Optimization Guide** | Performance Tuning Policies |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-07 | ⏱ Pending |



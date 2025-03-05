---
title: "pg01: Primary Relational Database Service Asset"
description: "Overview of the pg01 database service, including architecture, security, backups, firewall rules, and operational guidelines."
author: "VintageDon"
tags: ["PostgreSQL", "Big Data", "Relational Database", "SDR Data", "Service Asset"]
category: "Database Services"
kb_type: "Service Asset"
version: "1.2"
status: "Published"
last_updated: "2025-03-02"
models_used:
  - "ChatGPT-4 Turbo (Initial Draft & Refinements)"
  - "Claude 3.7 Sonnet API (Verification & Review)"
review_process:
  - "Claude 3.7 Sonnet API verified security, firewall, and compliance accuracy"
  - "Final human validation conducted before publication"
---

# **pg01: Primary Relational Database Service Asset**

## **1. Overview**

`pg01` is the **primary relational database** for structured scientific data storage and analytics. It is optimized for **high-ingest, high-performance workloads**, supporting **real-time SDR data, research datasets, and structured analytics**.

It serves as the **core PostgreSQL instance** in the lab's **big-data architecture**, primarily storing:

- **On-prem SDR data** from radio astronomy and signal processing pipelines.
- **Research datasets** from **external sources and public archives**.
- **Periodic space weather and observational data** from **GEISS, EXIS, and astronomical surveys**.
- **Preprocessed data** for AI/ML analysis.

This database **ensures high availability, security, and structured data integrity**.

---

## **2. Scope**

| **Category**        | **Description** |
|---------------------|----------------|
| **In-Scope**       | Storing structured research data, AI/ML analytics, high-ingest workloads. |
| **Out-of-Scope**   | GIS data processing (`pggis01`), time-series optimized workloads (`pgts01`). |
| **Applicable OS**  | Ubuntu 24.04 LTS |
| **Database Engine** | PostgreSQL 16 |
| **Hosting Environment** | On-prem VM |

---

## **3. Technical Specifications**

| **Component**  | **Details** |
|---------------|------------|
| **Database Engine** | PostgreSQL 16 |
| **vCPUs** | 4 |
| **Memory** | 16GB RAM |
| **Storage** | 500GB NVMe SSD |
| **Storage Type** | Dedicated NVMe volume (`/var/lib/postgresql`) |
| **Replication** | None (single-node instance) |
| **Monitoring & Metrics** | Node Exporter, Process Exporter, PostgreSQL Exporter |
| **Backup Strategy** | Proxmox Backup Server (PBS) + Offsite DR |

---

## **4. Data Sources & Ingestion Workflows**

### **4.1 On-Prem Data Sources**

| **Source** | **Data Type** | **Update Frequency** |
|-----------|-------------|----------------|
| **SDR Data Pipelines** | Processed signal intelligence | Real-time |
| **Internal ML Datasets** | AI training data | On-demand |
| **Citizen Science Contributions** | External collaborations | Periodic |

### **4.2 External Public Data Sources**

| **Source** | **Data Type** | **Update Frequency** |
|-----------|-------------|----------------|
| **GEISS (NOAA Space Weather Data)** | Electromagnetic & space weather data | Every 5 minutes |
| **EXIS (GOES-16 & GOES-17 Satellite Data)** | Solar flare detection & X-ray flux | Every 10 minutes |
| **Astronomical Sky Surveys** | Research datasets | Varies (batch pulls) |
| **Research Paper Metadata** | Indexed scientific literature | Weekly |

---

## **5. Security & Compliance**

Security controls follow **CIS PostgreSQL Benchmarks** and **ISO 27001 best practices**.

| **Security Control** | **Implementation** |
|----------------------|--------------------|
| **Database Encryption** | **TLS 1.3 enforced** for remote connections |
| **Role-Based Access Control (RBAC)** | User roles with least privilege enforcement |
| **Auditing & Logging** | **pgAudit** enabled, logs sent to **Wazuh SIEM** |
| **Periodic Vulnerability Scans** | Weekly scans using **OSSEC & CIS-CAT Lite** |
| **Backup Encryption** | **PBS backups encrypted via GPG** |
| **Firewall Rules (UFW)** | Strictly restricted to trusted lab services |

---

## **6. Firewall Configuration (UFW)**

The **UFW firewall rules** ensure only necessary services can access `pg01`. All other traffic is **blocked by default**.

```bash
# Allow SSH (restricted to control plane, workload VLAN, and Ansible)
ufw allow from 10.25.20.0/24 to any port 22 comment "SSH - Workload Admin Access"
ufw allow from 10.25.10.15 to any port 22 comment "SSH - Ansible Configuration Management"

# Allow PostgreSQL Access (Only workload VLAN)
ufw allow from 10.25.20.0/24 to any port 5432 comment "Allow PostgreSQL access for workloads"

# Allow DNS resolution (internal resolvers only)
ufw allow from 10.25.10.3 to any port 53 comment "Allow internal DNS resolver 1"
ufw allow from 10.25.10.4 to any port 53 comment "Allow internal DNS resolver 2"

# Allow Prometheus Node Exporter (System Metrics - From mon01)
ufw allow from 10.25.10.13 to any port 9100 comment "Node Exporter - System metrics monitoring"

# Allow Prometheus Process Exporter (PostgreSQL Process Metrics - From mon01)
ufw allow from 10.25.10.13 to any port 9256 comment "Process Exporter - PostgreSQL process monitoring"

# Allow Prometheus PostgreSQL Exporter (Query Performance Metrics - From mon01)
ufw allow from 10.25.10.13 to any port 9187 comment "PostgreSQL Exporter - Query performance monitoring"

# Deny all other incoming traffic by default
ufw default deny incoming
ufw default allow outgoing
```

---

## **7. Backup & Disaster Recovery**

| **Backup Type** | **Frequency** | **Retention Policy** | **Storage Location** |
|---------------|--------------|-------------------|----------------|
| **Full Database Backup (PBS)** | Daily | 4 Weekly, 1 Monthly | Proxmox Backup Server |
| **Offsite Backup (Wasabi)** | Weekly, Monthly | 1 Year Retention | Wasabi Cloud Storage |
| **WAL Archiving** | Continuous | 24 Hours | Local Only |

Disaster recovery involves:

1. **Restoring from the latest full backup** using **Proxmox Backup Server**.
2. **Replaying WAL logs if necessary** for point-in-time recovery.
3. **Failover to standby instance if required**.

---

## **8. Monitoring & Logging**

Metrics and logs are exported to centralized monitoring tools.

| **Monitoring Tool** | **Purpose** |
|--------------------|------------|
| **Prometheus** | Query performance metrics |
| **Grafana** | Visual dashboards for system health |
| **Wazuh SIEM** | Security log aggregation |
| **pg_stat_statements** | Query-level performance insights |

Example query to check slow queries:

```sql
SELECT query, calls, total_time, mean_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

---

## **9. Service Access & Management**

### **9.1 PGAdmin Access**

Authorized users can access `pg01` via **PGAdmin**, hosted on **proj-apps01**.

| **Service** | **Access URL** |
|------------|---------------|
| **PGAdmin (On-Prem)** | [pgadmin.beardinthe.cloud](http://pgadmin.beardinthe.cloud) |

### **9.2 Database Connection**

Developers and researchers can connect using:

```bash
psql -h pg01 -U admin -d research_db
```

---

## **10. Troubleshooting & Common Issues**

| **Issue** | **Possible Cause** | **Solution** |
|----------|-------------------|-------------|
| **Slow Queries** | Lack of proper indexing | Run `EXPLAIN ANALYZE` on queries |
| **Connection Drops** | TLS misconfiguration | Verify `pg_hba.conf` and TLS settings |
| **Backup Failure** | Disk space full | Free up space or adjust retention |
| **High CPU Usage** | Inefficient query execution | Identify slow queries using `pg_stat_statements` |

---

## **11. Documentation & Revision Control**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.1       | 2025-03-02 | Updated firewall rules, backups, and PGAdmin access | VintageDon |
| 1.0       | 2025-03-02 | Initial KB version | VintageDon |

---

## **12. Summary**

`pg01` is the **primary relational database** supporting **SDR, research, and AI/ML analytics**.

### ✅ **Key Takeaways**

- **Optimized for structured high-ingest workloads**.
- **Strict security & compliance with CIS & ISO 27001**.
- **Daily backups via Proxmox Backup Server + offsite DR**.
- **Comprehensive monitoring with Prometheus, Grafana, and Wazuh**.

---

## ✅ Approval & Review  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-01 | ✅ Approved |

---

## 📜 Change Log  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-01 | Initial version | VintageDon |

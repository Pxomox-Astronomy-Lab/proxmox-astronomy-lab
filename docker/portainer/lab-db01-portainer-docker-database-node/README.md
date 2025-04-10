<!-- 
---
title: "Lab-DB01 Portainer Docker Database Node"
description: "Documentation for the Lab-DB01 Portainer worker node, detailing its role in hosting containerized database services for the control plane."
author: "VintageDon"
tags: ["portainer", "docker", "infrastructure", "databases", "control-plane"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

# 🗄️ **Lab-DB01 Portainer Docker Database Node**

# 🔍 **1. Overview**

Lab-DB01 is a dedicated **Portainer worker node** responsible for hosting **containerized database services** that support the **control plane infrastructure** of the Proxmox Astronomy Lab. Managed by **Lab-Port01** (Portainer master node), it provides a range of database technologies including relational, NoSQL, time-series, and messaging systems that serve as backend services for various lab applications.

This specialized node isolates database workloads from application services, ensuring optimal performance, security, and resource allocation for these critical infrastructure components.

---

# 🖥️ **2. Technical Specifications**

## **2.1 Virtual Machine Configuration**

This VM is configured with resources optimized for database performance, with emphasis on memory capacity, storage performance, and CPU resources to handle concurrent database operations.

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-db01.beardinthe.cloud |
| **VM ID** | 2005 |
| **vCPU** | 2 vCPUs |
| **RAM** | 4 GB |
| **Storage** | 32 GB (OS) + 500 GB (Database Storage) |
| **OS** | Ubuntu 24.04 LTS |
| **Networking** | VLAN10 (Infrastructure) |
| **IP Address** | 10.25.10.17/24 |
| **Gateway** | 10.25.10.1 |
| **DNS** | 10.25.10.3, 10.25.20.3 |

## **2.2 Physical Node Placement**

The VM is hosted on a specific physical Proxmox node to ensure adequate resources and performance.

| **Attribute** | **Value** |
|--------------|-----------|
| **Proxmox Node** | node03 |
| **Resource Pool** | control-plane |
| **VM Location** | local-lvm |
| **Backup Schedule** | Daily at 01:00 |
| **Migration Policy** | Allowed with constraints |

---

# 🐳 **3. Docker Infrastructure**

## **3.1 Docker Configuration**

The Docker environment is configured specifically for database workloads, with emphasis on persistent storage, data integrity, and performance optimization.

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3"
  },
  "default-address-pools": [
    {
      "base": "172.19.0.0/16",
      "size": 24
    }
  ],
  "metrics-addr": "0.0.0.0:9323",
  "experimental": true,
  "storage-driver": "overlay2",
  "data-root": "/mnt/docker"
}
```

## **3.2 Storage Configuration**

The storage is designed to maintain CIS compliance while providing adequate space for database operations. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 500 GB | Docker data directory (moved from default location) |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/backup/databases** | Part of OS volume | Database backup staging |

## **3.3 Portainer Integration**

This node is managed through Portainer's agent architecture, providing centralized control while maintaining isolation.

| **Component** | **Details** |
|--------------|------------|
| **Portainer Control Node** | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **Agent Version** | 2.19.4 |
| **Agent Endpoint** | 10.25.10.17:9001 |
| **Edge Key** | Managed via Vault |
| **Stacks Path** | `/docker/portainer-stacks/lab-db01-portainer-docker-database-node/` |

---

# 📂 **4. Hosted Database Services**

## **4.1 Relational Databases**

SQL-based database engines that provide ACID-compliant data storage for structured data needs across the infrastructure.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-----------------|
| **postgresql** | General-purpose relational database | [PostgreSQL Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/postgresql/README.md) |
| **mariadb** | MySQL-compatible database server | [MariaDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mariadb/README.md) |

## **4.2 NoSQL Databases**

Document-oriented and key-value stores providing flexible schema designs for specific application needs.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-----------------|
| **mongodb** | Document-oriented database | [MongoDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mongodb/README.md) |
| **redis** | In-memory key-value store & cache | [Redis Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/redis/README.md) |

## **4.3 Messaging & Time-Series**

Specialized database services for messaging, event processing, and time-series data storage.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-----------------|
| **rabbitmq** | Message broker & queue manager | [RabbitMQ Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/rabbitmq/README.md) |
| **influxdb** | Time-series database | [InfluxDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/influxdb/README.md) |

## **4.4 Network Configuration**

Docker networks are segmented to isolate different database services while enabling controlled access from application containers.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **db-network** | 172.19.0.0/24 | Primary database network |
| **messaging-network** | 172.19.1.0/24 | RabbitMQ and related services |
| **metrics-network** | 172.19.2.0/24 | InfluxDB and monitoring |

---

# 🔐 **5. Security & Compliance**

## **5.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect against common vulnerabilities and ensure compliance with security standards.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **OS Hardening** | CIS Ubuntu 24.04 Level 2 | Lynis scans, CIS-CAT Pro |
| **Container Isolation** | AppArmor profiles | Profile validation |
| **Network Security** | Internal-only networks | Network ACLs |
| **Authentication** | Secret management via Vault | Access logs |
| **TLS Certificates** | Automated cert management | Certificate validation |
| **Security Scanning** | Daily vulnerability scans | Scan reports |

## **5.2 Access Control**

Access to database services is strictly controlled through multiple authentication mechanisms, ensuring only authorized applications and users can access sensitive data.

| **Database** | **Authentication Method** | **Authorization** |
|--------------|---------------------------|------------------|
| **PostgreSQL** | Username/password, client certificates | Role-based access control |
| **MariaDB** | Username/password | Database-level privileges |
| **MongoDB** | Username/password, x.509 certificates | Role-based access control |
| **Redis** | Password | ACL-based access |
| **RabbitMQ** | Username/password | Virtual hosts, permissions |
| **InfluxDB** | Token-based authentication | Organization/bucket permissions |

## **5.3 CISv8.1 Compliance Mapping**

This subsection explicitly maps implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.1.1** | Hardware inventory in GLPI | CMDB record #2005 | Compliant |
| **CIS.4.1** | Secure configuration baseline | Ansible playbooks | Compliant |
| **CIS.5.1** | AD-integrated authentication | Access logs | Compliant |
| **CIS.8.2** | Audit logging enabled | Loki logs | Compliant |
| **CIS.10.1** | ClamAV, AppArmor | Daily scan reports | Compliant |

---

# 💾 **6. Backup & Recovery**

## **6.1 Backup Strategy**

A comprehensive backup strategy ensures all database services are properly backed up with consideration for their specific requirements.

| **Database** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **PostgreSQL** | pg_dump to S3 | Hourly | 24 hours |
| **MariaDB** | Logical dumps to S3 | Hourly | 24 hours |
| **MongoDB** | mongodump to S3 | Hourly | 24 hours |
| **Redis** | RDB snapshots | Every 15 minutes | 6 hours |
| **InfluxDB** | Native backup to S3 | Daily | 7 days |
| **All Services** | Docker volume backups | Daily | 7 days |
| **Full VM** | Proxmox Backup Server | Weekly | 4 backups |

## **6.2 Recovery Procedure**

Database restoration procedures are documented to ensure minimal data loss and downtime during recovery operations.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| **Container Failure** | 15 min | 15 min | Restore container from Portainer template | Infrastructure Engineer |
| **Data Corruption** | 30 min | 1 hour | Restore from database-specific backup | Database Administrator |
| **Volume Failure** | 1 hour | 24 hours | Restore from volume backup | Infrastructure Engineer |
| **VM Failure** | 2 hours | 24 hours | Restore VM from Proxmox Backup | Infrastructure Engineer |
| **Node Failure** | 4 hours | 24 hours | Migrate to alternative node | Infrastructure Engineer |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

---

# 📊 **7. Monitoring & Management**

## **7.1 Monitoring Integration**

The node and its database services are monitored through multiple systems to ensure comprehensive visibility.

| **Monitoring System** | **Components Monitored** | **Dashboard** |
|----------------------|--------------------------|--------------|
| **Prometheus** | Host metrics, container metrics | [Node Exporter Dashboard](/monitoring/grafana/dashboards/node-exporter-full-dashboard-screenshot.png) |
| **Loki** | Container logs, OS logs | [Log Dashboard](/docs/applications/observability/loki/log-dashboard.md) |
| **PostgreSQL Exporter** | Database metrics | [PostgreSQL Dashboard](/monitoring/grafana/dashboards/postgresql-dashboard-screenshot.png) |
| **Database-specific** | Service health, performance | [Database Metrics Dashboard](/docs/applications/observability/grafana/dashboards/database-metrics.md) |
| **Wazuh** | Security events, file integrity | [Security Dashboard](/docs/applications/security/wazuh/security-dashboard.md) |

## **7.2 Alert Thresholds**

Database-specific thresholds are configured to provide early warning of potential issues.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 70% for 5 minutes | 85% for 3 minutes |
| **Memory Usage** | 75% for 5 minutes | 85% for 3 minutes |
| **Disk Usage** | 70% | 85% |
| **Connection Count** | 70% of max | 85% of max |
| **Query Latency** | 2x baseline | 5x baseline |
| **Failed Transactions** | >0.1% | >1% |

## **7.3 Maintenance Schedule**

Database maintenance follows the lab's rotating schedule with special consideration for minimizing service disruption to dependent systems.

| **Maintenance Type** | **Schedule** | **Notification** | **Procedure Document** |
|----------------------|-------------|-----------------|------------------------|
| **OS Updates** | Weekly (Sundays 00:00-02:00) | 48 hours | [OS Update Procedure](/docs/infrastructure/maintenance/os-update-procedure.md) |
| **Security Patches** | As needed | 24 hours (standard)/None (critical) | [Security Patching Procedure](/docs/infrastructure/maintenance/security-patching.md) |
| **Docker Updates** | Monthly (First Saturday) | 72 hours | [Docker Update Procedure](/docs/infrastructure/maintenance/docker-update-procedure.md) |
| **Database Upgrades** | Quarterly | 1 week | [Database Upgrade Procedure](/docs/applications/databases/upgrade-procedure.md) |

---

# 🔗 **8. Directory Contents**

This section provides direct navigation to all subdirectories and key documents related to this node:

## **8.1 Related Documentation**

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| **Service Document** | Lab-DB01 ITIL Service Doc | [Service Documentation](/docs/control-plane/services/lab-db01-service-documentation.md) |
| **Stack Configurations** | Database Stack Definitions | [Stack Configurations](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/) |
| **Infrastructure Architecture** | Database Node Architecture | [Infrastructure Design](/docs/infrastructure/compute/database-nodes.md) |
| **Monitoring Configuration** | Database Monitoring | [Monitoring Setup](/docs/applications/observability/database-monitoring.md) |
| **Security Baseline** | Database Security Controls | [Security Baseline](/docs/compliance-security/implementation-guides/Linux/Ubuntu-24-04-Server/CISv8-L2-hardening-guide.md) |

## **8.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| **CI** | CI-2005 | lab-db01 | Primary configuration item |
| **Service** | SVC-103 | Database Services | Delivered service |
| **KB Article** | KB-405 | Database Troubleshooting | Support documentation |
| **Change Template** | CHG-DB-01 | Database Maintenance | Change template |

---

# 🔄 **9. Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|----------------|-------------------|
| **lab-port01** | Manages this Portainer node | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **lab-apps01** | Hosts applications using these databases | [lab-apps01](/infrastructure/control-plane/lab-apps01-docker-application-node.md) |
| **lab-mon01** | Monitors database performance | [lab-mon01](/infrastructure/control-plane/lab-mon01-prometheus-monitoring-logging-stack.md) |
| **node03** | Hosts this VM | [node03](/infrastructure/proxmox/node03-proxmox-compute.md) |

---

# ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

# 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

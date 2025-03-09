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

# **Lab-DB01 Portainer Docker Database Node**

Lab-DB01 is a dedicated **Portainer worker node** responsible for hosting **containerized database services** that support the **control plane infrastructure** of the Proxmox Astronomy Lab. Managed by **Lab-Port01** (Portainer master node), it provides a range of database technologies including relational, NoSQL, time-series, and messaging systems that serve as backend services for various lab applications.

This specialized node isolates database workloads from application services, ensuring optimal performance, security, and resource allocation for these critical infrastructure components.

## **1. Technical Specifications**

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

## **2. Docker Infrastructure**

The Docker environment is configured specifically for database workloads, with emphasis on persistent storage, data integrity, and performance optimization.

### **2.1 Docker Configuration**

The Docker daemon is configured with optimizations for database containers, prioritizing data persistence and I/O performance.

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

### **2.2 Storage Configuration**

The storage is designed to maintain CIS compliance while providing adequate space for database operations. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 500 GB | Docker data directory (moved from default location) |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/backup/databases** | Part of OS volume | Database backup staging |

## **3. Hosted Database Services**

Lab-DB01 hosts a variety of containerized database services that form the data persistence layer for the lab's control plane infrastructure.

### **3.1 Relational Databases**

SQL-based database engines that provide ACID-compliant data storage for structured data needs across the infrastructure.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **postgresql** | General-purpose relational database | 5432 |
| **mariadb** | MySQL-compatible database server | 3306 |

### **3.2 NoSQL Databases**

Document-oriented and key-value stores providing flexible schema designs for specific application needs.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **mongodb** | Document-oriented database | 27017 |
| **redis** | In-memory key-value store & cache | 6379 |

### **3.3 Messaging & Time-Series**

Specialized database services for messaging, event processing, and time-series data storage.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **rabbitmq** | Message broker & queue manager | 5672, 15672 |
| **influxdb** | Time-series database | 8086 |

### **3.4 Network Configuration**

Docker networks are segmented to isolate different database services while enabling controlled access from application containers.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **db-network** | 172.19.0.0/24 | Primary database network |
| **messaging-network** | 172.19.1.0/24 | RabbitMQ and related services |
| **metrics-network** | 172.19.2.0/24 | InfluxDB and monitoring |

## **4. Security & Compliance**

Database services require special security considerations to protect sensitive data while maintaining accessibility for authorized services.

### **4.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect against common vulnerabilities and ensure compliance with security standards.

- **CIS Ubuntu 24.04 Level 2** compliance for base OS
- **AppArmor profiles** for container isolation
- **Limited network exposure** with internal-only networks
- **Authentication required** for all database services
- **Automated TLS certificate management**
- **Regular security scanning** via integrated tools

### **4.2 Access Control**

Access to database services is strictly controlled through multiple authentication mechanisms, ensuring only authorized applications and users can access sensitive data.

| **Database** | **Authentication Method** | **Authorization** |
|--------------|---------------------------|------------------|
| **PostgreSQL** | Username/password, client certificates | Role-based access control |
| **MariaDB** | Username/password | Database-level privileges |
| **MongoDB** | Username/password, x.509 certificates | Role-based access control |
| **Redis** | Password | ACL-based access |
| **RabbitMQ** | Username/password | Virtual hosts, permissions |
| **InfluxDB** | Token-based authentication | Organization/bucket permissions |

## **5. Backup & Disaster Recovery**

Database services require specialized backup approaches to ensure data integrity and recoverability while minimizing service disruption.

### **5.1 Backup Strategy**

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

### **5.2 Recovery Procedure**

Database restoration procedures are documented to ensure minimal data loss and downtime during recovery operations.

1. **Assess failure scope** and determine optimal recovery path
2. **Restore VM** from Proxmox Backup Server if needed
3. **Verify Docker installation** and configuration
4. **Restore database containers** from Portainer templates
5. **Restore data** from appropriate backup source:
   - From volume backups for container-level issues
   - From database-specific backups for data corruption
   - From VM backup for complete system failure
6. **Verify database integrity** and functionality
7. **Reconnect dependent services** and verify end-to-end operation

## **6. Monitoring & Alerting**

Database services require specialized monitoring to ensure performance, availability, and data integrity.

### **6.1 Health Checks**

Comprehensive health monitoring ensures that database services remain operational and perform within expected parameters.

- **Database connectivity** checks via TCP probes
- **Query execution** tests for functional verification
- **Storage capacity** monitoring with predictive alerts
- **Replication status** checks where applicable
- **Backup success/failure** monitoring
- **Container resource usage** tracking
- **Host system performance** metrics

### **6.2 Alert Thresholds**

Database-specific thresholds are configured to provide early warning of potential issues.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 70% for 5 minutes | 85% for 3 minutes |
| **Memory Usage** | 75% for 5 minutes | 85% for 3 minutes |
| **Disk Usage** | 70% | 85% |
| **Connection Count** | 70% of max | 85% of max |
| **Query Latency** | 2x baseline | 5x baseline |
| **Failed Transactions** | >0.1% | >1% |

## **7. Management & Operations**

Structured operational procedures ensure stable and predictable management of database services.

### **7.1 Maintenance Schedule**

Database maintenance follows the lab's rotating schedule with special consideration for minimizing service disruption to dependent systems.

- **OS Updates**: Weekly on predefined maintenance windows
- **Security Patches**: Applied as needed with priority
- **Docker Updates**: Evaluated monthly
- **Database Updates**: Version upgrades scheduled quarterly
- **Schema Changes**: Implemented via change management process

VMs are updated and rebooted weekly on a rotating schedule to avoid service downtimes, with database components scheduled to minimize impact on dependent services.

### **7.2 Update Procedure**

Updates follow a standardized process with special considerations for database continuity.

1. **Review change documentation** in GLPI
2. **Notify dependent services** of maintenance window
3. **Create database backups** before any changes
4. **Implement updates** according to plan
5. **Verify database functionality** post-update
6. **Test dependent applications** to ensure proper operation
7. **Update documentation** with any changes

### **7.3 Troubleshooting Quick Reference**

Common database issues are documented with standard resolution paths to speed recovery and reduce downtime.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Connection Failures** | Check network connectivity and credentials | Inspect container logs |
| **High CPU/Memory** | Identify resource-intensive queries | Tune database parameters |
| **Storage Issues** | Verify available space | Investigate growing tables/collections |
| **Replication Lag** | Check network performance | Investigate system load |
| **Slow Queries** | Identify problematic queries | Review indexing strategy |

## **8. Documentation References**

Additional resources provide detailed information on database-specific configurations and management practices.

| **Document** | **Purpose** | **Location** |
|-------------|------------|-------------|
| **Service Documentation** | ITIL-aligned service document | [Lab-DB01 Service Documentation](../../../applications-services/lab-db01-docker-database-node.md) |
| **Database Sizing Guidelines** | Resource allocation recommendations | [Database Sizing Guidelines](../../../infrastructure/database/sizing-guidelines.md) |
| **Backup Procedures** | Detailed backup and restore instructions | [Database Backup Procedures](../../../infrastructure/database/backup-procedures.md) |

## **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

## **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

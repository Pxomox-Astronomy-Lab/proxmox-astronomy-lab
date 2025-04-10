<!-- 
---
title: "Portainer Stacks - Lab-DB01 Database Node"
description: "Documentation for the database stacks deployed on the lab-db01 Portainer Docker worker node in the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["portainer", "docker", "stacks", "databases", "infrastructure"]
category: "Docker"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

# 🗄️ **Portainer Stacks - Lab-DB01 Database Node**

# 🔍 **1. Overview**

This directory contains the **Portainer stack definitions** for the lab-db01 node, which serves as the **primary database host** for the Proxmox Astronomy Lab's control plane infrastructure. These containerized database services provide structured data storage, caching, and messaging capabilities that support the lab's core operations, monitoring systems, and automation workflows.

Each database service is deployed as a separate stack with its own configuration, persistent storage, and networking settings, allowing for modular management while ensuring appropriate isolation between services.

---

# 🐳 **2. Stack Deployment Process**

## **2.1 Deployment Infrastructure**

These stacks are deployed through the lab's GitOps workflow using Portainer's Git integration capabilities.

| **Component** | **Purpose** |
|--------------|-------------|
| **Portainer Master** | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) manages all stack deployments |
| **Worker Node** | [lab-db01](/infrastructure/control-plane/lab-db01-docker-database-node.md) hosts the deployed containers |
| **Git Repository** | Stack definitions stored in Gitea with version control |
| **Environment Files** | Secrets managed through `.env` files stored in HashiCorp Vault |
| **Deployment Pipeline** | Changes trigger automatic validation and deployment |

## **2.2 Common Stack Structure**

Each database stack follows a standardized structure for consistency and maintainability.

| **File** | **Purpose** |
|----------|------------|
| **README.md** | Documentation for the specific database stack |
| **docker-compose.yml** | Stack definition with services, networks, and volumes |
| **stack.env** | Environment variables for container configuration (vault-managed) |
| **stack.env.example** | Example environment file with placeholder values |
| **init-scripts/** | Database initialization scripts (when applicable) |
| **conf/** | Custom configuration files (when applicable) |

## **2.3 Deployment Workflow**

The standardized process for deploying and updating database stacks ensures consistency and reliability.

1. Edit stack definition in Git repository
2. Submit pull request with changes
3. Automated validation checks run (syntax, security scanning)
4. Code review and approval by infrastructure team
5. Merge triggers deployment to lab-db01 via Portainer webhook
6. Post-deployment health checks verify successful deployment

---

# 📊 **3. Database Stacks**

## **3.1 PostgreSQL Stack**

The PostgreSQL stack provides a robust, feature-rich relational database service for structured data storage across lab applications.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [postgresql/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/postgresql/) |
| **Image** | postgres:16-alpine |
| **Exposed Port** | 5432 (internal network only) |
| **Persistent Storage** | Docker volume with daily backups |
| **Primary Users** | GLPI, Gitea, Wiki.js, Zitadel |
| **Special Features** | Connection pooling, automated backups |

## **3.2 MariaDB Stack**

The MariaDB stack provides a MySQL-compatible database that supports specific applications requiring MySQL compatibility.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [mariadb/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mariadb/) |
| **Image** | mariadb:10.11 |
| **Exposed Port** | 3306 (internal network only) |
| **Persistent Storage** | Docker volume with daily backups |
| **Primary Users** | Specific lab applications requiring MySQL |
| **Special Features** | Optimized for performance on SFF hardware |

## **3.3 MongoDB Stack**

The MongoDB stack provides a document-oriented NoSQL database for applications requiring flexible schema designs.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [mongodb/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mongodb/) |
| **Image** | mongo:6.0 |
| **Exposed Port** | 27017 (internal network only) |
| **Persistent Storage** | Docker volume with daily backups |
| **Primary Users** | Milvus, RAG applications, document storage |
| **Special Features** | Authentication, role-based access control |

## **3.4 InfluxDB Stack**

The InfluxDB stack provides time-series database capabilities for metrics storage and analysis.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [influxdb/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/influxdb/) |
| **Image** | influxdb:2.7-alpine |
| **Exposed Port** | 8086 (internal network only) |
| **Persistent Storage** | Docker volume with retention policies |
| **Primary Users** | Prometheus, Telegraf, monitoring systems |
| **Special Features** | Data retention policies, InfluxQL and Flux support |

## **3.5 Redis Stack**

The Redis stack provides in-memory key-value storage for caching and message brokering with persistence.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [redis/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/redis/) |
| **Image** | redis:7.2-alpine |
| **Exposed Port** | 6379 (internal network only) |
| **Persistent Storage** | RDB and AOF persistence |
| **Primary Users** | Application caching, session storage |
| **Special Features** | Password authentication, maxmemory policies |

## **3.6 RabbitMQ Stack**

The RabbitMQ stack provides message queuing capabilities for asynchronous processing and service integration.

| **Component** | **Details** |
|--------------|------------|
| **Stack Directory** | [rabbitmq/](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/rabbitmq/) |
| **Image** | rabbitmq:3.12-management-alpine |
| **Exposed Ports** | 5672 (AMQP), 15672 (Management) |
| **Persistent Storage** | Docker volume with queue persistence |
| **Primary Users** | Distributed applications, automation pipelines |
| **Special Features** | Management interface, exchange types |

---

# 🔐 **4. Security & Access Controls**

## **4.1 Network Segmentation**

Database services are isolated through network segmentation to provide appropriate security boundaries.

| **Network Name** | **Purpose** | **Connected Systems** |
|-----------------|-------------|----------------------|
| **db-internal** | Inter-database communication | Database containers only |
| **db-backend** | Application to database connections | Application containers |
| **db-monitoring** | Monitoring system connections | Prometheus, Grafana |

## **4.2 Authentication & Authorization**

Each database stack implements secured authentication and authorization mechanisms.

| **Database** | **Authentication Method** | **User Management** |
|--------------|---------------------------|-------------------|
| **PostgreSQL** | Password, client certificates | Role-based with row-level security |
| **MariaDB** | Password authentication | Database and table grants |
| **MongoDB** | SCRAM authentication | Role-based access control |
| **InfluxDB** | Token-based authentication | Organization & bucket permissions |
| **Redis** | Password authentication | Command restrictions |
| **RabbitMQ** | Username/password | Virtual hosts, exchange permissions |

## **4.3 Secret Management**

Database credentials and other sensitive configurations are managed securely through multiple mechanisms.

| **Secret Type** | **Storage Method** | **Lifecycle Management** |
|----------------|-------------------|-------------------------|
| **Database Passwords** | HashiCorp Vault | Automatic rotation every 30 days |
| **TLS Certificates** | Vault PKI | 90-day certificates with auto-renewal |
| **Connection Strings** | Vault + environment files | Updated with password rotations |
| **API Keys** | Vault secure storage | Application-specific rotations |

---

# 💾 **5. Backup & Recovery**

## **5.1 Backup Strategy**

Each database stack implements its own backup mechanism appropriate to the specific database technology.

| **Database** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **PostgreSQL** | pg_dump to S3 | Hourly | 24 hours |
| **MariaDB** | mysqldump to S3 | Hourly | 24 hours |
| **MongoDB** | mongodump to S3 | Hourly | 24 hours |
| **InfluxDB** | Native backup to S3 | Daily | 7 days |
| **Redis** | RDB snapshots | Every 15 minutes | 6 hours |
| **RabbitMQ** | Definitions export | Hourly | 24 hours |

## **5.2 Recovery Procedures**

Standardized recovery procedures ensure quick restoration when needed.

| **Scenario** | **Recovery Method** | **RTO** | **Procedure Documentation** |
|--------------|-------------------|--------|----------------------------|
| **Container Failure** | Re-deploy container | 5 min | [Container Recovery](/docs/infrastructure/troubleshooting/container-recovery.md) |
| **Data Corruption** | Restore from backup | 30 min | [Database Restore](/docs/infrastructure/troubleshooting/database-restore.md) |
| **Volume Loss** | Restore from backup | 1 hour | [Volume Recovery](/docs/infrastructure/troubleshooting/volume-recovery.md) |
| **Complete Failure** | Re-deploy stack and restore | 2 hours | [Stack Recovery](/docs/infrastructure/troubleshooting/stack-recovery.md) |

---

# 📊 **6. Monitoring & Metrics**

## **6.1 Database Monitoring**

Each database stack includes integrated monitoring through Prometheus exporters and custom health checks.

| **Database** | **Exporter** | **Dashboard** |
|--------------|-------------|--------------|
| **PostgreSQL** | postgres_exporter | [PostgreSQL Dashboard](/monitoring/grafana/dashboards/postgresql-dashboard-screenshot.png) |
| **MariaDB** | mysqld_exporter | [MySQL Dashboard](/monitoring/grafana/dashboards/mysql-dashboard.png) |
| **MongoDB** | mongodb_exporter | [MongoDB Dashboard](/monitoring/grafana/dashboards/mongodb-dashboard.png) |
| **InfluxDB** | Built-in Prometheus endpoint | [InfluxDB Dashboard](/monitoring/grafana/dashboards/influxdb-dashboard.png) |
| **Redis** | redis_exporter | [Redis Dashboard](/monitoring/grafana/dashboards/redis-dashboard.png) |
| **RabbitMQ** | Built-in Prometheus plugin | [RabbitMQ Dashboard](/monitoring/grafana/dashboards/rabbitmq-dashboard.png) |

## **6.2 Alert Thresholds**

Critical database metrics are monitored with appropriate alerting thresholds.

| **Metric** | **Warning Threshold** | **Critical Threshold** | **Response Procedure** |
|------------|----------------------|------------------------|------------------------|
| **Connection Count** | 80% of max | 90% of max | [Connection Overflow](/docs/applications/databases/connection-overflow.md) |
| **Disk Usage** | 75% | 90% | [Storage Expansion](/docs/applications/databases/storage-expansion.md) |
| **Memory Usage** | 80% | 90% | [Memory Optimization](/docs/applications/databases/memory-optimization.md) |
| **Slow Queries** | >1 second | >5 seconds | [Query Optimization](/docs/applications/databases/query-optimization.md) |
| **Replication Lag** | >10 seconds | >30 seconds | [Replication Recovery](/docs/applications/databases/replication-recovery.md) |

---

# 🔄 **7. Stack Maintenance**

## **7.1 Upgrade Procedures**

Database upgrades follow a structured process to ensure data integrity and minimal downtime.

| **Database** | **Upgrade Method** | **Testing Requirement** | **Rollback Procedure** |
|--------------|-------------------|------------------------|------------------------|
| **PostgreSQL** | Blue-green deployment | Full data validation | Swap back to previous version |
| **MariaDB** | In-place with validation | Schema validation | Restore from backup |
| **MongoDB** | Replica set rolling upgrade | Application validation | Roll back binary version |
| **InfluxDB** | Side-by-side deployment | Query validation | Switch back to previous version |
| **Redis** | Replace with persistence | Function validation | Restore RDB file |
| **RabbitMQ** | Cluster rolling upgrade | Message flow validation | Rollback cluster nodes |

## **7.2 Maintenance Schedule**

Database maintenance follows the lab's standard maintenance windows with consideration for dependency impacts.

| **Maintenance Type** | **Schedule** | **Notification** | **Downtime Expected** |
|----------------------|-------------|-----------------|----------------------|
| **Minor Updates** | First Sunday, 01:00-03:00 | 48 hours | 5-15 minutes per service |
| **Major Upgrades** | Planned quarterly | 2 weeks | 30-60 minutes per service |
| **Security Patches** | As needed | 24 hours | Varies by severity |
| **Configuration Changes** | Second Tuesday, 01:00-02:00 | 72 hours | 0-5 minutes per service |

---

# 🔗 **8. Stack Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **8.1 Stack Directories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **PostgreSQL** | PostgreSQL database stack | [PostgreSQL Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/postgresql/README.md) |
| **MariaDB** | MariaDB database stack | [MariaDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mariadb/README.md) |
| **MongoDB** | MongoDB database stack | [MongoDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/mongodb/README.md) |
| **InfluxDB** | InfluxDB time-series database | [InfluxDB Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/influxdb/README.md) |
| **Redis** | Redis key-value store | [Redis Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/redis/README.md) |
| **RabbitMQ** | RabbitMQ message broker | [RabbitMQ Stack](/docker/portainer-stacks/lab-db01-portainer-docker-database-node/rabbitmq/README.md) |

## **8.2 Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Stack Style Guide** | Documentation standards | [Stack Documentation Style Guide](/docker/portainer-stacks/portainer-stacks-lab-documentation-and-style-guide.md) |
| **Database Best Practices** | Configuration guidance | [Database Container Best Practices](/docs/applications/databases/database-container-best-practices.md) |
| **Troubleshooting Guide** | Common issue resolution | [Database Stack Troubleshooting](/docs/applications/databases/database-stack-troubleshooting.md) |

---

# 🔄 **9. Related Resources**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Host VM Documentation** | Host for these stacks | [lab-db01](/infrastructure/control-plane/lab-db01-docker-database-node.md) |
| **Portainer Master** | Controls these stacks | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **Monitoring Configuration** | Monitors these databases | [Database Monitoring](/docs/applications/observability/database-monitoring.md) |
| **Backup Configuration** | Backs up these databases | [Database Backup Procedures](/docs/infrastructure/storage/database-backup-procedures.md) |
| **Application Stacks** | Consume these databases | [Application Stacks](/docker/portainer-stacks/lab-apps01-portainer-docker-application-node/) |

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

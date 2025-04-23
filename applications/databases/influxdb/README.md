<!-- 
---
title: "InfluxDB Time Series Database Service"
description: "Documentation for the InfluxDB time series database services providing metrics storage for monitoring and development workloads in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["influxdb", "time-series", "database", "monitoring", "metrics", "proxmox", "grafana", "docker"]
category: "Databases"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Grafana", "Prometheus", "Proxmox", "Docker"]
implements_policies: ["Data Management Policy", "Monitoring Policy", "Performance Management Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.1", "CIS.8.2", "CIS.8.5", "CIS.8.10"]
iso27001_controls: ["A.12.1.3", "A.12.4.1", "A.18.1.3"]
nist_controls: ["AU-2", "AU-6", "PM-14", "PM-15", "SC-28"]
---
-->

# 📊 **InfluxDB Time Series Database Service**

This document provides the authoritative reference for the InfluxDB time series database services in the Proxmox Astronomy Lab, documenting the implementation of dedicated instances for both production monitoring metrics and development workloads.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the InfluxDB time series database services, their deployment architecture, configuration details, and operational procedures. It serves as the definitive reference for time series data management within the Proxmox Astronomy Lab environment, covering both the production monitoring instance and the development workload instance.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| InfluxDB server configurations and architecture | Application-specific data schemas |
| Docker deployment details | Custom dashboard development (covered in Grafana documentation) |
| Data retention policies | Metric collection configuration (covered in Prometheus documentation) |
| Backup and recovery procedures | Advanced query development |
| Performance optimization guidelines | External data integrations beyond current systems |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Database Administrators
- DevOps Engineers
- Application Developers (for integration)

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the InfluxDB services within our operational framework.

### **2.1 Service Description**

InfluxDB provides purpose-built time series database services for the Proxmox Astronomy Lab, offering high-performance storage and retrieval of time-stamped data. Two distinct instances have been deployed:

1. **influxdb01**: Production instance dedicated to Proxmox cluster metrics, directly integrated with Grafana for visualization and alerting. This instance focuses exclusively on infrastructure monitoring data.

2. **influxdb02**: Development and small workload instance for application metrics, test data, and development projects. This instance provides a flexible environment for various time series data needs beyond core infrastructure monitoring.

Both instances are deployed as containerized services using Docker, allowing for consistent management and resource isolation.

### **2.2 Service Classification**

The following table defines how these services are categorized within our service management framework:

| **Attribute** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|--------------|----------------------------|----------------------------|
| **Service ID** | DB-TSDB-001 | DB-TSDB-002 |
| **Service Type** | Core | Supporting |
| **Service Category** | Monitoring | Development |
| **Business Criticality** | High | Medium |
| **Service Owner** | Monitoring Team | Database Team |

### **2.3 Service Hours**

This table defines when the services are operational and supported:

| **Hours Type** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|---------------|----------------------------|----------------------------|
| **Standard Service Hours** | 24x7x365 | 24x7x365 |
| **Support Hours** | 24x7 (critical issues)<br>8x5 (non-critical) | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Monthly on second Sunday, 2AM-4AM EST | Weekly on Wednesday, 8PM-10PM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the services.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|------------|----------------------------|----------------------------|
| **Availability** | 99.9% | 99.5% |
| **Query Response Time** | <500ms for standard queries | <1s for standard queries |
| **Write Throughput** | >10,000 points/second | >5,000 points/second |
| **Data Retention** | 90 days for raw data<br>2 years for downsampled data | 30 days (configurable per project) |

### **3.2 Monitoring and Reporting**

InfluxDB service health monitoring is implemented through:

- **Self-monitoring**: Each InfluxDB instance monitors its own health metrics
- **Prometheus**: External health and performance metrics collection
- **Grafana Dashboards**: Visualization of database performance
- **Container Resource Monitoring**: Docker-level resource utilization

Monthly service reports include metrics for query performance, storage utilization, and write throughput.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the services.

### **4.1 Architecture Overview**

Both InfluxDB instances are deployed as containerized services using Docker, with the following key architectural characteristics:

**influxdb01 (Production)**:

- Dedicated to Proxmox cluster metrics
- Direct integration with Grafana for visualization
- Optimized for high write throughput from infrastructure monitoring
- Configured with structured downsampling for long-term storage efficiency
- Deployed on the monitoring server (mon01)

**influxdb02 (Development)**:

- General-purpose time series database for smaller workloads
- Flexible configuration for various project needs
- Deployed on the database server (lab-db01)
- Lower resource allocation appropriate for development workloads

### **4.2 Infrastructure Components**

The following components comprise the InfluxDB infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **influxdb01** | Production Docker container | lab-mon01 | DB-INFLUX-001 |
| **influxdb01-data** | Production data volume | lab-mon01 | DB-INFLUX-VOL-001 |
| **influxdb02** | Development Docker container | lab-db01 | DB-INFLUX-002 |
| **influxdb02-data** | Development data volume | lab-db01 | DB-INFLUX-VOL-002 |

### **4.3 Docker Container Configuration**

The Docker configuration for both instances follows a similar pattern with resource adjustments appropriate to their use cases:

**influxdb01 (Production)**:

```yaml
version: '3'
services:
  influxdb:
    image: influxdb:2.7
    container_name: influxdb01
    restart: unless-stopped
    ports:
      - "8086:8086"
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup
      - DOCKER_INFLUXDB_INIT_USERNAME=influxadmin
      - DOCKER_INFLUXDB_INIT_PASSWORD=************
      - DOCKER_INFLUXDB_INIT_ORG=proxmoxlab
      - DOCKER_INFLUXDB_INIT_BUCKET=proxmox
      - DOCKER_INFLUXDB_INIT_RETENTION=90d
    volumes:
      - influxdb01-data:/var/lib/influxdb2
    networks:
      - monitoring_net
    mem_limit: 2g
    cpus: 2

volumes:
  influxdb01-data:
    external: true

networks:
  monitoring_net:
    external: true
```

**influxdb02 (Development)**:

```yaml
version: '3'
services:
  influxdb:
    image: influxdb:2.7
    container_name: influxdb02
    restart: unless-stopped
    ports:
      - "8086:8086"
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup
      - DOCKER_INFLUXDB_INIT_USERNAME=influxadmin
      - DOCKER_INFLUXDB_INIT_PASSWORD=************
      - DOCKER_INFLUXDB_INIT_ORG=proxmoxlab
      - DOCKER_INFLUXDB_INIT_BUCKET=development
      - DOCKER_INFLUXDB_INIT_RETENTION=30d
    volumes:
      - influxdb02-data:/var/lib/influxdb2
    networks:
      - database_net
    mem_limit: 1g
    cpus: 1

volumes:
  influxdb02-data:
    external: true

networks:
  database_net:
    external: true
```

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **influxdb01 Requires** | Docker engine on lab-mon01 | Service outage |
| **influxdb01 Requires** | Monitoring network | Data collection disruption |
| **influxdb01 Required By** | Grafana | Visualization failure |
| **influxdb01 Required By** | Proxmox monitoring | Historical metrics loss |
| **influxdb02 Requires** | Docker engine on lab-db01 | Service outage |
| **influxdb02 Requires** | Database network | Connection failure |
| **influxdb02 Required By** | Development projects | Test data storage failure |

### **4.5 Storage Configuration**

Both instances use Docker volumes for persistent storage with the following characteristics:

| **Volume** | **Size** | **Type** | **Host Path** | **Backup Included** |
|------------|--------|---------|--------------|-------------------|
| **influxdb01-data** | 200GB | SSD | /var/lib/docker/volumes/influxdb01-data | Yes |
| **influxdb02-data** | 100GB | SSD | /var/lib/docker/volumes/influxdb02-data | Yes |

### **4.6 Backup and Recovery**

The following parameters define our resilience strategy for InfluxDB:

| **Aspect** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|------------|----------------------------|----------------------------|
| **Backup Schedule** | Daily full backup | Weekly full backup |
| **Backup Method** | Native InfluxDB backup tool | Native InfluxDB backup tool |
| **Backup Location** | NFS share on backup01 | Local backup on lab-db01 |
| **Recovery Time Objective (RTO)** | 2 hours | 8 hours |
| **Recovery Point Objective (RPO)** | 24 hours | 1 week |
| **Recovery Procedure** | [Link to recovery procedure document] | [Link to recovery procedure document] |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the services throughout their lifecycle.

### **5.1 Access Management**

The following access control framework governs InfluxDB administration and usage:

| **User Role** | **Access Level** | **influxdb01** | **influxdb02** | **Authorization Process** |
|---------------|----------------|----------------|----------------|---------------------------|
| **Database Admin** | Full administrative access | Yes | Yes | Security team approval |
| **Monitoring Team** | Read/write for monitoring | Yes | No | Team lead approval |
| **Developer** | Project-specific buckets | No | Yes | Project manager approval |
| **Read-Only User** | Dashboard data access | Yes | No | Team lead approval |

### **5.2 Incident Management**

These parameters define how incidents affecting these services are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **influxdb01 Service Outage** | Critical | P1 | 15 minutes | 2 hours |
| **influxdb01 Performance Issue** | High | P2 | 30 minutes | 4 hours |
| **influxdb02 Service Outage** | Medium | P3 | 2 hours | 8 hours |
| **influxdb02 Performance Issue** | Low | P4 | 4 hours | 24 hours |

### **5.3 Change Management**

The following framework governs changes to the InfluxDB services:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade (Production)** | Yes | CAB approval | Maintenance window |
| **Version Upgrade (Development)** | No | Database admin approval | Any time with notification |
| **Configuration Change (Production)** | Yes | CAB approval | Maintenance window |
| **Configuration Change (Development)** | No | Database admin approval | Any time with notification |
| **Bucket Creation** | No | Database admin approval | Any time |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Applies To** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|--------------|----------------------|------------------------|
| **Health Check** | Daily | Both | Operations Team | [INFL-PROC-001] |
| **Disk Space Review** | Weekly | Both | Operations Team | [INFL-PROC-002] |
| **Performance Analysis** | Monthly | influxdb01 | Database Team | [INFL-PROC-003] |
| **Retention Policy Verification** | Monthly | Both | Database Team | [INFL-PROC-004] |
| **Backup Verification** | Monthly | Both | Operations Team | [INFL-PROC-005] |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Applies To** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|--------------|---------------------|------------|
| **High Memory Usage** | Container memory alerts | Both | Review queries, optimize cardinality | KEDB-INFL-001 |
| **Slow Queries** | Dashboard timeouts | Both | Query optimization, index verification | KEDB-INFL-002 |
| **Missing Data** | Gaps in time series | Both | Check collection agents, verify retention policies | KEDB-INFL-003 |
| **Container Restart Loop** | Service unavailability | Both | Check logs, verify storage availability | KEDB-INFL-004 |

## 🔐 **7. Security & Compliance**

This section documents the security controls and compliance requirements for these services.

### **7.1 Security Controls**

The following controls protect the InfluxDB services:

| **Control Category** | **Implementation** | **Applies To** | **Verification Method** |
|----------------------|-------------------|--------------|-------------------------|
| **Network Security** | Internal network only | Both | Network ACL review |
| **Authentication** | Token-based authentication | Both | Configuration audit |
| **Authorization** | Role-based permissions | Both | Access review |
| **Data Encryption** | TLS for connections | Both | Configuration verification |
| **Audit Logging** | Enabled for administrative actions | Both | Log verification |

### **7.2 CISv8.1 Compliance Mapping**

This section documents how the InfluxDB implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.1** | Audit log management | Container logging configuration | Compliant |
| **CIS.8.2** | Collect audit logs | Log forwarding to central system | Compliant |
| **CIS.8.5** | Centralized log collection | SIEM integration | Compliant |
| **CIS.8.10** | Centralized log analysis | Log analytics platform | Compliant |

### **7.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.1** | A.12.4.1 | AU-2 | Audit logging configuration |
| **CIS.8.2** | A.12.4.1 | AU-6 | Log collection and review |
| **CIS.8.5** | A.12.1.3 | PM-14 | Centralized monitoring |

## 📚 **8. Data Management**

This section documents the data management practices for the InfluxDB services.

### **8.1 Data Organization**

InfluxDB uses the following organizational structure:

| **Component** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|--------------|----------------------------|----------------------------|
| **Organization** | proxmoxlab | proxmoxlab |
| **Primary Bucket** | proxmox | development |
| **Additional Buckets** | proxmox_downsampled | project-specific buckets |

### **8.2 Retention Policies**

Data retention is managed through the following policies:

| **Bucket** | **Retention Period** | **Downsampling** | **Notes** |
|------------|---------------------|----------------|----------|
| **proxmox** | 90 days | No | Raw metrics data |
| **proxmox_downsampled** | 2 years | Yes (1h intervals) | Aggregated historical data |
| **development** | 30 days | No | Default for development |
| **project-specific** | Varies (7-90 days) | Project-dependent | Configured per project needs |

### **8.3 Query Performance Optimization**

The following measures are implemented to ensure optimal query performance:

- **Index optimization** for frequently queried time ranges
- **Cardinality management** to prevent excessive tag combinations
- **Query caching** for common dashboard queries
- **Resource limits** on individual queries to prevent resource contention

## 🔗 **9. Integration With Other Services**

This section documents how InfluxDB integrates with other key services in the environment.

### **9.1 Proxmox Integration**

**influxdb01** is configured to receive and store Proxmox cluster metrics:

| **Integration Aspect** | **Configuration** |
|------------------------|------------------|
| **Data Source** | Proxmox cluster nodes |
| **Collection Method** | Direct Proxmox metrics API |
| **Metrics Scope** | Node performance, VM metrics, storage metrics |
| **Collection Interval** | 30 seconds for critical metrics, 5 minutes for others |
| **Authentication** | Dedicated service account with read-only permissions |

### **9.2 Grafana Integration**

Both InfluxDB instances are configured as data sources in Grafana:

| **Integration Aspect** | **influxdb01 (Production)** | **influxdb02 (Development)** |
|------------------------|----------------------------|----------------------------|
| **Connection Type** | Direct (InfluxDB API) | Direct (InfluxDB API) |
| **Authentication** | Service account token | Service account token |
| **Dashboard Scope** | Infrastructure monitoring | Project-specific dashboards |
| **Default Query Language** | Flux | Flux |
| **Query Caching** | Enabled | Disabled |

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

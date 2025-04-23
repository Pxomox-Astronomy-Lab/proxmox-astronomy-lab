<!-- 
---
title: "Loki Log Aggregation Service"
description: "Documentation for the Loki log aggregation service providing centralized logging and log search capabilities for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["loki", "promtail", "logging", "observability", "log-aggregation", "troubleshooting", "compliance"]
category: "Observability"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Grafana", "Prometheus", "AlertManager"]
implements_policies: ["Logging Policy", "Security Monitoring Policy", "Compliance Monitoring Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.2", "CIS.8.5", "CIS.8.8", "CIS.8.10", "CIS.8.11"]
iso27001_controls: ["A.12.4.1", "A.12.4.2", "A.12.4.3", "A.16.1.7"]
nist_controls: ["AU-2", "AU-3", "AU-4", "AU-6", "AU-7", "AU-8", "AU-12"]
---
-->

# 📝 **Loki Log Aggregation Service**

This document provides the authoritative reference for the Loki log aggregation service in the Proxmox Astronomy Lab, documenting its implementation for centralized log collection, storage, and query capabilities across the infrastructure.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Loki log aggregation service, its deployment architecture, configuration details, and operational procedures. It serves as the definitive reference for centralized logging within the Proxmox Astronomy Lab environment, enabling efficient log collection, storage, search, and analysis.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Loki server configuration and architecture | Application-specific log parsing |
| Promtail agent deployment and configuration | Custom log analysis algorithms |
| Log storage and retention policies | Advanced query development |
| Integration with Grafana for visualization | Security incident response procedures |
| Basic operational procedures | SIEM functionality (handled by Wazuh) |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Operations Team Members
- Security Team Members
- DevOps Engineers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Loki service within our operational framework.

### **2.1 Service Description**

Loki provides a highly efficient, cost-effective log aggregation solution for the Proxmox Astronomy Lab. Unlike traditional logging systems that index the contents of logs, Loki takes a unique approach by only indexing metadata about your logs (labels) and leaving the log content unindexed. This design significantly reduces the resource requirements while still enabling powerful queries through LogQL, Loki's query language.

The Loki implementation covers:

- System logs from Linux servers (syslog, auth, kernel, etc.)
- Application logs from containerized services
- Security-relevant logs for compliance and auditing
- Infrastructure service logs for troubleshooting and monitoring

Loki works in conjunction with Promtail agents that collect logs from various sources and ship them to the central Loki service.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-LOG-001 |
| **Service Type** | Core |
| **Service Category** | Observability |
| **Business Criticality** | High |
| **Service Owner** | Monitoring Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 24x7 (critical issues)<br>8x5 (non-critical) |
| **Maintenance Windows** | Monthly on second Sunday, 4AM-6AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Prometheus monitoring |
| **Log Ingestion Latency** | <30s for 95% of logs | Timestamp analysis |
| **Query Response Time** | <3s for standard queries | Query statistics |
| **Storage Efficiency** | <2GB per server per day | Volume metrics |

### **3.2 Monitoring and Reporting**

Loki service health monitoring is implemented through:

- **Prometheus metrics**: Loki exposes metrics on port 3100
- **Grafana dashboards**: Dedicated monitoring dashboards for the Loki stack
- **Alerting rules**: Specific to log volume, latency, and error rates

Monthly service reports include metrics for log ingestion volume, query performance, and storage utilization.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

Loki is deployed as a standalone service on the monitoring server (lab-mon01), with the following key architectural characteristics:

- **Monolithic deployment** suitable for the lab's scale
- **Local filesystem storage** for simplicity and performance
- **Promtail agents** deployed on all monitored systems
- **Label-based indexing** strategy for efficient querying
- **Integration with Grafana** for visualization

The architecture prioritizes reliability and simplicity, with a focus on efficient log collection and query capabilities.

### **4.2 Infrastructure Components**

The following components comprise the Loki logging infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **Loki Server** | Central log aggregation service | lab-mon01 | MON-LOKI-001 |
| **Promtail Agents** | Log collection agents | All monitored systems | Multiple |
| **Storage Backend** | Log data persistence | lab-mon01 local disk | MON-LOKI-STORE-001 |
| **Grafana Integration** | Visualization interface | lab-mon01 | MON-GRAF-001 |

### **4.3 Server Configuration**

Loki is configured with the following settings:

```yaml
auth_enabled: false

server:
  http_listen_port: 3100

ingester:
  lifecycler:
    address: 127.0.0.1
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 5m
  chunk_retain_period: 30s

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

storage_config:
  boltdb_shipper:
    active_index_directory: /var/lib/loki/boltdb-shipper-active
    cache_location: /var/lib/loki/boltdb-shipper-cache
    cache_ttl: 24h
    shared_store: filesystem
  filesystem:
    directory: /var/lib/loki/chunks

limits_config:
  enforce_metric_name: false
  reject_old_samples: true
  reject_old_samples_max_age: 168h

compactor:
  working_directory: /var/lib/loki/compactor
  shared_store: filesystem

ruler:
  storage:
    type: local
    local:
      directory: /var/lib/loki/rules
  rule_path: /var/lib/loki/rules-temp
  alertmanager_url: http://localhost:9093
  ring:
    kvstore:
      store: inmemory
  enable_api: true
```

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | lab-mon01 host | Complete service outage |
| **Requires** | Network connectivity | Log collection failure |
| **Requires** | Disk storage | Log retention failure |
| **Required By** | Grafana | Log visualization unavailability |
| **Required By** | Security monitoring | Audit log collection failure |
| **Required By** | Troubleshooting workflows | Diagnostic capability loss |

### **4.5 Storage and Retention**

Loki is configured with the following storage parameters:

| **Parameter** | **Value** | **Purpose** |
|--------------|----------|------------|
| **Storage Path** | /var/lib/loki | Log data and index storage |
| **Retention Period** | 30 days | Historical log availability |
| **Storage Allocation** | 500GB | Maximum disk space |
| **Compaction Policy** | Default | Storage optimization |

### **4.6 Backup and Recovery**

The following parameters define our resilience strategy for Loki:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Weekly full backup |
| **Backup Method** | File system backup of data directory |
| **Backup Location** | NFS share on backup01 |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 1 week |
| **Recovery Procedure** | [Link to recovery procedure document] |

## 📑 **5. Promtail Configuration**

This section documents the configuration of Promtail agents that collect and forward logs to Loki.

### **5.1 Standard Promtail Configuration**

The following configuration is deployed to all Linux systems, with hostname customization:

```yaml
server:
  http_listen_port: 9080
positions:
  filename: /tmp/positions.yaml
clients:
  - url: http://10.25.10.13:3100/loki/api/v1/push
scrape_configs:
- job_name: system
  journal:
    max_age: "24h"
    labels:
      job: system
      hostname: lab-mon01  # Customized per host
- job_name: auth
  static_configs:
  - targets: ["localhost"]
    labels:
      job: auth
      path: /var/log/auth.log
      hostname: lab-mon01  # Customized per host
- job_name: kern
  static_configs:
  - targets: ["localhost"]
    labels:
      job: kern
      path: /var/log/kern.log
      hostname: lab-mon01  # Customized per host
- job_name: syslog
  static_configs:
  - targets: ["localhost"]
    labels:
      job: syslog
      path: /var/log/syslog
      hostname: lab-mon01  # Customized per host
- job_name: dpkg
  static_configs:
  - targets: ["localhost"]
    labels:
      job: dpkg
      path: /var/log/dpkg.log
      hostname: lab-mon01  # Customized per host
- job_name: fail2ban
  static_configs:
  - targets: ["localhost"]
    labels:
      job: fail2ban
      path: /var/log/fail2ban.log
      hostname: lab-mon01  # Customized per host
```

### **5.2 Log Sources and Labels**

The following standard log sources are collected from Linux systems:

| **Log Source** | **Path** | **Label** | **Purpose** |
|----------------|---------|-----------|------------|
| **Journal** | systemd journal | system | System service logs |
| **Auth Log** | /var/log/auth.log | auth | Authentication events |
| **Kernel Log** | /var/log/kern.log | kern | Kernel events and errors |
| **Syslog** | /var/log/syslog | syslog | General system messages |
| **DPKG Log** | /var/log/dpkg.log | dpkg | Package management events |
| **Fail2ban Log** | /var/log/fail2ban.log | fail2ban | Intrusion prevention logs |

### **5.3 Specialized Configurations**

In addition to the standard configuration, specialized Promtail configurations are deployed to specific systems:

| **System Type** | **Additional Log Sources** | **Purpose** |
|-----------------|--------------------------|------------|
| **Database Servers** | PostgreSQL logs | Database event monitoring |
| **Web Servers** | Nginx/Apache logs | Web access and error logging |
| **Kubernetes Nodes** | Container logs | Kubernetes pod and container logs |
| **Security Systems** | Wazuh logs | Security event collection |

### **5.4 Label Strategy**

Labels are applied systematically to enable efficient querying and filtering:

| **Label Type** | **Examples** | **Purpose** |
|----------------|------------|------------|
| **hostname** | lab-mon01, proj-k8sm01 | Source system identification |
| **job** | auth, syslog, postgresql | Log source classification |
| **environment** | production, development | Environment classification |
| **application** | postgres, nginx, kubernetes | Application classification |
| **severity** | error, warning, info | Log severity filtering |

## 🔄 **6. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **6.1 Access Management**

The following access control framework governs Loki administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Monitoring Admin** | Full administrative access | Security team approval |
| **Operations Team** | Query and visualization access | Team lead approval |
| **Security Team** | Security log query access | Security team lead approval |
| **Application Team** | Application-specific log access | Application owner approval |

### **6.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Loki Server Outage** | High | P2 | 30 minutes | 4 hours |
| **Log Collection Failure** | Medium | P3 | 1 hour | 8 hours |
| **Query Performance Issue** | Medium | P3 | 2 hours | 8 hours |
| **Storage Exhaustion** | High | P2 | 30 minutes | 4 hours |

### **6.3 Change Management**

The following framework governs changes to the Loki service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | Yes | CAB approval | Maintenance window |
| **Configuration Change** | Yes | CAB approval | Maintenance window |
| **Agent Deployment** | No | Monitoring team approval | Business hours |
| **Storage Expansion** | Yes | CAB approval | Maintenance window |

## 🛠️ **7. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **7.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Health Check** | Daily | Operations Team | [LOKI-PROC-001] |
| **Storage Utilization Review** | Weekly | Monitoring Team | [LOKI-PROC-002] |
| **Query Performance Analysis** | Monthly | Monitoring Team | [LOKI-PROC-003] |
| **Log Coverage Audit** | Quarterly | Monitoring Team | [LOKI-PROC-004] |

### **7.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Log Collection Failure** | Missing logs from specific sources | Check Promtail service status, verify connectivity | KEDB-LOKI-001 |
| **High Query Latency** | Slow query results, timeouts | Review query complexity, check index performance | KEDB-LOKI-002 |
| **Storage Utilization Issues** | Disk space warnings, ingestion failures | Verify retention settings, analyze log volume | KEDB-LOKI-003 |
| **Promtail Configuration Issues** | Missing or mis-labeled logs | Review agent configuration, restart service | KEDB-LOKI-004 |

## 🔐 **8. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect the Loki service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Network Security** | Internal network only, no public access | Network ACL verification |
| **Authentication** | Basic auth for UI access | Configuration review |
| **Authorization** | Role-based access via Grafana | User access audit |
| **Data Protection** | Local-only storage with backup | Storage configuration review |
| **Audit Logging** | HTTP access logs enabled | Log verification |

### **8.2 CISv8.1 Compliance Mapping**

This section documents how the Loki implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.2** | Comprehensive log collection | Agent configuration | Compliant |
| **CIS.8.5** | Centralized log storage | Loki storage configuration | Compliant |
| **CIS.8.8** | Retention policy implementation | Loki configuration | Compliant |
| **CIS.8.10** | Centralized analysis capability | Loki + Grafana integration | Compliant |
| **CIS.8.11** | Log-based alerting capability | Loki + AlertManager | Compliant |

### **8.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.2** | A.12.4.1 | AU-3 | Comprehensive logging configuration |
| **CIS.8.5** | A.12.4.3 | AU-4 | Centralized log architecture |
| **CIS.8.10** | A.16.1.7 | AU-6 | Log analysis capabilities |

## 📊 **9. LogQL Query Examples**

This section provides reference examples of commonly used LogQL queries.

### **9.1 Basic Queries**

| **Query** | **Purpose** |
|-----------|------------|
| `{hostname="lab-mon01", job="auth"}` | Authentication logs from monitoring server |
| `{job="syslog"} |= "error"` | All syslog entries containing "error" |
| `{hostname=~"proj-k8s.*"} |~ "OOM.*"` | OOM errors on Kubernetes nodes |
| `{job="postgresql"} |= "database"` | Database-related log entries |

### **9.2 Advanced Queries**

| **Query** | **Purpose** |
|-----------|------------|
| `sum by(hostname) (count_over_time({job="auth"} |= "Failed password" [1h]))` | Failed password attempts per host in last hour |
| `{job="syslog"} |= "error" \| json | level="error"` | JSON-formatted error logs |
| `{hostname="proj-apps01"} \| pattern "<_> address=<addr> port=<port>"` | Extract address and port from logs |
| `{job="kubernetes"} \| logfmt \| status!="200"` | Non-200 Kubernetes API responses |

## 🔗 **10. Integration With Other Services**

This section documents how Loki integrates with other key services in the environment.

### **10.1 Grafana Integration**

Loki serves as a primary data source for Grafana:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Connection Type** | Direct (Loki API) |
| **URL** | <http://localhost:3100> |
| **Authentication** | None (local connection) |
| **Dashboards** | System logs, application logs, security logs |
| **Default Query Type** | LogQL |

### **10.2 Prometheus Integration**

Loki and Prometheus complement each other for complete observability:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Metrics Exposure** | Loki exports metrics to Prometheus |
| **Grafana Correlation** | Metrics and logs linked in dashboards |
| **Alert Coordination** | Both systems send to the same AlertManager |

### **10.3 AlertManager Integration**

Loki can generate alerts based on log patterns:

| **Aspect** | **Configuration** |
|------------|------------------|
| **AlertManager Endpoint** | <http://localhost:9093> |
| **Alert Rules** | Defined in Loki ruler configuration |
| **Rule Storage** | /var/lib/loki/rules |

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

<!-- 
---
title: "Prometheus Monitoring Service"
description: "Documentation for the Prometheus metrics collection and storage service providing comprehensive infrastructure monitoring for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["prometheus", "monitoring", "metrics", "observability", "alertmanager", "exporters", "time-series", "grafana"]
category: "Observability"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Grafana", "AlertManager", "Loki", "InfluxDB", "Node Exporter", "SNMP Exporter"]
implements_policies: ["Monitoring Policy", "Performance Management Policy", "Incident Response Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.2", "CIS.8.5", "CIS.8.10", "CIS.8.11", "CIS.12.1"]
iso27001_controls: ["A.12.1.3", "A.12.4.1", "A.16.1.2", "A.16.1.4"]
nist_controls: ["AU-6", "CA-7", "PM-14", "PM-15", "SI-4"]
---
-->

# 📊 **Prometheus Monitoring Service**

This document provides the authoritative reference for the Prometheus monitoring service in the Proxmox Astronomy Lab, documenting its implementation for metrics collection, storage, and alerting across the infrastructure.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Prometheus monitoring service, its deployment architecture, configuration details, and operational procedures. It serves as the definitive reference for infrastructure and application metrics monitoring within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Prometheus server configuration and architecture | Application-specific metrics definitions |
| Exporter deployment and configuration | Advanced query development |
| Target discovery and relabeling | Dashboard development (covered in Grafana documentation) |
| Alert rules and notification | Log management (covered in Loki documentation) |
| High-level integration with other monitoring tools | Detailed troubleshooting of monitored systems |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Operations Team Members
- Security Team Members
- DevOps Engineers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Prometheus service within our operational framework.

### **2.1 Service Description**

Prometheus provides a comprehensive metrics collection and monitoring solution for the Proxmox Astronomy Lab. It implements a pull-based architecture that scrapes metrics from various targets at configurable intervals, stores them in a time-series database, and provides a flexible query language (PromQL) for data retrieval and analysis. It integrates with AlertManager for notification and with Grafana for visualization.

The Prometheus implementation covers:

- System-level metrics from Linux and Windows servers
- Proxmox node performance metrics
- Kubernetes cluster monitoring
- Network device metrics via SNMP
- Application-specific metrics from databases and services
- Process-level monitoring across critical systems
- GPU resource utilization

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-MTR-001 |
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
| **Maintenance Windows** | Monthly on second Sunday, 2AM-4AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Self-monitoring via service checks |
| **Scrape Interval Adherence** | >99% | Prometheus scrape duration metrics |
| **Scrape Completion Time** | <5s for 95% of scrapes | Scrape duration histograms |
| **Query Response Time** | <1s for 95% of queries | Query statistics |
| **Alert Notification Time** | <30s from trigger | AlertManager metrics |

### **3.2 Monitoring and Reporting**

Prometheus service health monitoring is implemented through:

- **Self-monitoring**: Prometheus scrapes its own metrics
- **External synthetic checks**: Basic availability monitoring
- **Grafana dashboards**: Dedicated monitoring dashboards for the monitoring stack
- **Alert rules**: Specific to monitoring infrastructure health

Monthly service reports include metrics for scrape performance, storage utilization, and alerting statistics.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

Prometheus is deployed as a standalone service on the monitoring server (lab-mon01), with the following key architectural characteristics:

- **Pull-based metrics collection** from various exporters and endpoints
- **Local time-series database** for metrics storage
- **Integration with AlertManager** for alerting
- **Grouped target configuration** for logical organization
- **Relabeling configurations** for consistent naming and metadata

The architecture follows a single-instance deployment model, with comprehensive target coverage organized into logical job categories. Metrics retention is configured to balance storage requirements with historical data availability.

### **4.2 Infrastructure Components**

The following components comprise the Prometheus monitoring infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **Prometheus Server** | Core metrics collection and storage | lab-mon01 | MON-PROM-001 |
| **AlertManager** | Alert routing and notification | lab-mon01 | MON-ALRT-001 |
| **Node Exporter** | System metrics collection for Linux hosts | All Linux servers | Multiple |
| **Windows Exporter** | System metrics collection for Windows hosts | All Windows servers | Multiple |
| **SNMP Exporter** | Network device metrics | lab-mon01 | MON-SNMP-001 |
| **Process Exporter** | Process-level metrics | All Linux servers | Multiple |
| **Postgres Exporter** | PostgreSQL database metrics | All PostgreSQL servers | Multiple |
| **cAdvisor** | Container metrics | Docker hosts | Multiple |
| **Blackbox Exporter** | Endpoint probing | lab-mon01 | MON-BBX-001 |
| **GPU Exporter** | NVIDIA GPU metrics | proj-k8sw04 | MON-GPU-001 |

### **4.3 Server Configuration**

The Prometheus server is configured with the following settings:

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
```

The configuration ensures metrics are collected every 15 seconds, and alert rules are evaluated at the same interval.

### **4.4 Target Organization**

Prometheus targets are organized into logical groups, each with specific relabeling configurations for consistent naming:

| **Job Group** | **Purpose** | **Target Type** |
|--------------|------------|----------------|
| **prometheus** | Self-monitoring | Prometheus server |
| **loki** | Log system monitoring | Loki server |
| **influxdb** | Time series DB monitoring | InfluxDB server |
| **proxmox_nodes** | Proxmox hosts monitoring | Node exporter on Proxmox hosts |
| **all** | Complete infrastructure view | All node exporters |
| **linux** | Linux server monitoring | Node exporter on Linux servers |
| **windows** | Windows server monitoring | Windows exporter on Windows servers |
| **k8s_masters** | Kubernetes control plane | Node exporter on K8s control plane nodes |
| **k8s_workers** | Kubernetes worker nodes | Node exporter on K8s worker nodes |
| **rancher** | Rancher management server | Rancher metrics endpoint |
| **databases** | Database server monitoring | Node exporter on database servers |
| **postgres_exporter** | PostgreSQL metric collection | PostgreSQL exporter |
| **app_servers** | Application servers | Node exporter on app servers |
| **dom_controllers** | Domain controllers | Windows exporter on DCs |
| **file_servers** | File servers | Windows exporter on file servers |
| **process_exporter** | Process-level monitoring | Process exporter on Linux servers |
| **monitoring** | Monitoring infrastructure | Node exporter on monitoring server |
| **snmp** | Network device monitoring | SNMP exporter |
| **gpu** | GPU resource monitoring | NVIDIA GPU exporter |
| **pihole** | DNS filtering monitoring | Pi-hole exporter |
| **gitea** | Git server monitoring | Gitea metrics endpoint |
| **cadvisor_nodes** | Container monitoring | cAdvisor on Docker hosts |

### **4.5 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | lab-mon01 host | Complete service outage |
| **Requires** | Network connectivity | Target data collection failure |
| **Requires** | Node/Windows Exporters | System-specific metrics loss |
| **Required By** | Grafana | Visualization source unavailable |
| **Required By** | AlertManager | Alert rule evaluation failure |
| **Required By** | Operational dashboards | Performance visibility loss |

### **4.6 Storage and Retention**

Prometheus is configured with the following storage parameters:

| **Parameter** | **Value** | **Purpose** |
|--------------|----------|------------|
| **Storage Path** | /var/lib/prometheus/data | Metrics database location |
| **Retention Time** | 30 days | Historical data availability |
| **Retention Size** | 100GB | Maximum storage allocation |
| **TSDB Blocks** | 2h | Time series block duration |
| **Compaction Policy** | Default | Storage optimization |

### **4.7 Backup and Recovery**

The following parameters define our resilience strategy for Prometheus:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Weekly full backup |
| **Backup Method** | Snapshot of TSDB directory |
| **Backup Location** | NFS share on backup01 |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 1 week |
| **Recovery Procedure** | [Link to recovery procedure document] |

## 📈 **5. Scrape Configuration**

This section documents the detailed scrape configuration for Prometheus targets.

### **5.1 Default Scrape Parameters**

All targets use the following default scrape parameters unless otherwise specified:

| **Parameter** | **Value** | **Purpose** |
|--------------|----------|------------|
| **scrape_interval** | 15s | Frequency of metrics collection |
| **scrape_timeout** | 10s | Maximum time for a scrape operation |
| **scheme** | http | Protocol for scrape requests |
| **metrics_path** | /metrics | Default endpoint path |

### **5.2 Custom Endpoints**

Some targets use custom scrape endpoints:

| **Target Type** | **metrics_path** | **Notes** |
|----------------|----------------|----------|
| **SNMP Exporter** | /snmp | Uses target parameter for device selection |
| **Blackbox Exporter** | /probe | Uses target parameter for endpoint probing |

### **5.3 Relabeling Configuration**

Extensive relabeling configurations are implemented to:

- **Standardize instance names** across all targets
- **Add metadata** such as role and environment
- **Organize targets** into logical groups
- **Normalize labels** for consistent querying

For example, Linux servers use hostname-based instance labels instead of IP addresses:

```yaml
- source_labels: [__address__]
  regex: "10.25.20.4:9100"
  replacement: "proj-k8sm01"
  target_label: instance
```

### **5.4 Service Discovery**

While primarily using static configuration, the following service discovery methods are implemented:

| **Discovery Method** | **Target Type** | **Implementation** |
|---------------------|----------------|-------------------|
| **Static Configuration** | Most targets | Explicit IP:port listings |
| **File-based Discovery** | Some Linux servers | Generated config files |
| **DNS Discovery** | Future implementation | Planned for dynamic environments |

## 🔄 **6. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **6.1 Access Management**

The following access control framework governs Prometheus administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Monitoring Admin** | Full administrative access | Security team approval |
| **Operations Team** | Read-only access, alert management | Team lead approval |
| **Application Team** | Read-only access to relevant targets | Application owner approval |
| **Security Team** | Read-only access, security-related alerts | Security team lead approval |

### **6.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Prometheus Server Outage** | Critical | P1 | 15 minutes | 2 hours |
| **Exporter Failure (Critical Service)** | High | P2 | 30 minutes | 4 hours |
| **Exporter Failure (Standard Service)** | Medium | P3 | 2 hours | 8 hours |
| **Alert Configuration Issue** | High | P2 | 30 minutes | 4 hours |
| **Query Performance Degradation** | Medium | P3 | 2 hours | 8 hours |

### **6.3 Change Management**

The following framework governs changes to the Prometheus service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | Yes | CAB approval | Maintenance window |
| **Configuration Change (Major)** | Yes | CAB approval | Maintenance window |
| **Configuration Change (Minor)** | No | Monitoring team approval | Business hours |
| **Target Addition/Removal** | No | Monitoring team approval | Any time |
| **Alert Rule Changes** | Yes | CAB approval | Maintenance window |

## 🛠️ **7. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **7.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Health Check** | Daily | Operations Team | [PROM-PROC-001] |
| **Storage Utilization Review** | Weekly | Monitoring Team | [PROM-PROC-002] |
| **Scrape Performance Analysis** | Monthly | Monitoring Team | [PROM-PROC-003] |
| **Alert Rule Review** | Monthly | Monitoring Team | [PROM-PROC-004] |
| **Target Coverage Audit** | Quarterly | Monitoring Team | [PROM-PROC-005] |

### **7.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Target Scrape Failures** | Up metric shows 0, scrape_up alerts | Verify target connectivity, check exporter service status | KEDB-PROM-001 |
| **High Query Latency** | Slow dashboard loading, query timeout alerts | Review query complexity, optimize storage, check resource utilization | KEDB-PROM-002 |
| **Storage Utilization Issues** | Disk space warnings, compaction failures | Check retention settings, verify disk space, analyze data volume growth | KEDB-PROM-003 |
| **Alert Notification Failures** | Alerts not delivered, AlertManager connectivity issues | Check AlertManager status, verify notification configuration | KEDB-PROM-004 |
| **Exporter Configuration Issues** | Missing or invalid metrics | Review exporter configuration, check for version compatibility | KEDB-PROM-005 |

## 🔐 **8. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect the Prometheus service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Network Security** | Internal network only, no public access | Network ACL verification |
| **Authentication** | Basic auth for UI access | Configuration review |
| **Authorization** | Role-based access control | User access audit |
| **Data Protection** | Local-only storage with backup | Storage configuration review |
| **Audit Logging** | HTTP access logs enabled | Log verification |

### **8.2 CISv8.1 Compliance Mapping**

This section documents how the Prometheus implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.2** | Comprehensive metrics collection | Target configuration | Compliant |
| **CIS.8.5** | Centralized metrics storage | Architecture design | Compliant |
| **CIS.8.10** | Centralized analysis capability | Prometheus + Grafana integration | Compliant |
| **CIS.8.11** | Real-time alerting | AlertManager configuration | Compliant |
| **CIS.12.1** | Network device monitoring | SNMP exporter configuration | Compliant |

### **8.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.2** | A.12.4.1 | AU-6 | Comprehensive logging configuration |
| **CIS.8.5** | A.12.1.3 | PM-14 | Centralized monitoring architecture |
| **CIS.8.11** | A.16.1.2 | SI-4 | Real-time alerting capability |

## 📡 **9. Exporter Deployment**

This section documents the deployment of various exporters that provide metrics to Prometheus.

### **9.1 Node Exporter (Linux)**

Deployed on all Linux servers to collect system-level metrics:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Systemd service |
| **Version** | 1.3.1 |
| **Port** | 9100 |
| **Collectors Enabled** | cpu, diskstats, filesystem, loadavg, meminfo, netdev, systemd, uname |
| **Custom Flags** | --collector.systemd, --collector.processes, --web.listen-address=:9100, --path.rootfs=/ |

### **9.2 Windows Exporter**

Deployed on all Windows servers:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Windows service |
| **Version** | 0.21.0 |
| **Port** | 9182 |
| **Collectors Enabled** | cpu, cs, logical_disk, memory, net, os, service, system, tcp |
| **Custom Flags** | --collectors.enabled=cpu,cs,logical_disk,memory,net,os,service,system,tcp |

### **9.3 Process Exporter**

Deployed on Linux servers to monitor specific processes:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Systemd service |
| **Version** | 0.7.10 |
| **Port** | 9256 |
| **Process Groups** | database, web, container, kubernetes, monitoring |
| **Custom Flags** | --config.path=/etc/process-exporter/config.yml |

### **9.4 PostgreSQL Exporter**

Deployed on all PostgreSQL database servers:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Systemd service |
| **Version** | 0.12.0 |
| **Port** | 9187 |
| **Connection String** | DATABASE_URL=postgresql://prometheus:password@localhost:5432/postgres?sslmode=disable |
| **Query Path** | /etc/postgres_exporter/queries.yaml |

### **9.5 SNMP Exporter**

Centralized deployment for network device monitoring:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Systemd service |
| **Version** | 0.21.0 |
| **Port** | 9116 |
| **Module Path** | /etc/snmp_exporter/snmp.yml |
| **Targets** | Network switches (labswitch01, labswitch02) |

### **9.6 GPU Exporter**

Deployed on GPU-equipped server:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Deployment Method** | Systemd service |
| **Version** | 0.4.0 |
| **Port** | 9835 |
| **Metrics Collected** | GPU utilization, memory, temperature, power, processes |
| **Custom Flags** | --web.listen-address=:9835 |

## 🔔 **10. Alerting Configuration**

This section documents the alerting configuration in Prometheus and its integration with AlertManager.

### **10.1 Alert Rules Organization**

Alert rules are organized into logical groups:

| **Rule Group** | **Purpose** | **File Location** |
|----------------|-----------|------------------|
| **Node Alerts** | System-level issues | /etc/prometheus/rules/node.rules.yml |
| **Service Alerts** | Application service issues | /etc/prometheus/rules/service.rules.yml |
| **Network Alerts** | Network-related issues | /etc/prometheus/rules/network.rules.yml |
| **Database Alerts** | Database performance and availability | /etc/prometheus/rules/database.rules.yml |
| **Kubernetes Alerts** | Kubernetes cluster issues | /etc/prometheus/rules/kubernetes.rules.yml |

### **10.2 Alert Priority Levels**

Alerts are categorized into priority levels that determine notification behavior:

| **Priority** | **Severity** | **Response Time** | **Notification Methods** |
|--------------|------------|------------------|-------------------------|
| **Critical** | Service outage or severe degradation | Immediate | Email, SMS, Slack |
| **Warning** | Performance issues or threshold breach | <30 minutes | Email, Slack |
| **Info** | Non-urgent notifications | <24 hours | Email |

### **10.3 AlertManager Integration**

AlertManager handles alert delivery and management:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Endpoint** | localhost:9093 |
| **Route Configuration** | Structured by priority and team |
| **Notification Methods** | Email, Slack integration |
| **Grouping Rules** | By service, instance, and alert name |
| **Inhibition Rules** | Prevent notification storms during outages |

## 📊 **11. Integration With Other Services**

This section documents how Prometheus integrates with other key services in the environment.

### **11.1 Grafana Integration**

Prometheus serves as a primary data source for Grafana:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Connection Type** | Direct (Prometheus API) |
| **URL** | <http://localhost:9090> |
| **Authentication** | None (local connection) |
| **Dashboards** | System monitoring, application performance, custom metrics |
| **Default Query Type** | PromQL |

### **11.2 AlertManager Integration**

Prometheus forwards alerts to AlertManager for notification management:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Endpoint** | localhost:9093 |
| **Integration Method** | Native Prometheus configuration |
| **Rule Files** | alert.rules.yml (and others as needed) |

### **11.3 Loki Integration**

While separate systems, Prometheus and Loki work together for complete observability:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Grafana Correlation** | Metrics and logs linked in dashboards |
| **Reciprocal Monitoring** | Each system monitors the other |
| **Alert Coordination** | Both systems send to the same AlertManager |

## ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

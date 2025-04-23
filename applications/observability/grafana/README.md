<!-- 
---
title: "Grafana Visualization Service"
description: "Documentation for the Grafana visualization platform providing dashboards and monitoring visualization for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["grafana", "visualization", "dashboards", "monitoring", "observability", "prometheus", "loki"]
category: "Observability"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Prometheus", "Loki", "InfluxDB", "AlertManager", "SNMP Exporter"]
implements_policies: ["Monitoring Policy", "Visualization Standards Policy", "Observability Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.10", "CIS.8.11", "CIS.12.8"]
iso27001_controls: ["A.12.1.1", "A.12.1.3", "A.16.1.2"]
nist_controls: ["CA-7", "IR-4", "IR-5", "PM-14", "SI-4"]
---
-->

# 📊 **Grafana Visualization Service**

This document provides the authoritative reference for the Grafana visualization service in the Proxmox Astronomy Lab, documenting its implementation for metrics and log visualization, dashboarding, and alerting.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Grafana visualization service, its configuration, dashboard organization, and operational procedures. It serves as the definitive reference for monitoring visualization within the Proxmox Astronomy Lab environment, enabling comprehensive visibility into infrastructure and application performance.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Grafana server configuration and architecture | Detailed data source configuration (covered in respective docs) |
| Dashboard organization and structure | Custom query development |
| Data source integrations | Alert rule creation (basic coverage only) |
| User access management | Application-specific visualization requirements |
| Basic operational procedures | Advanced dashboard development methodology |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Operations Team Members
- Database Administrators
- Application Support Personnel

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Grafana service within our operational framework.

### **2.1 Service Description**

Grafana provides a comprehensive visualization platform for the Proxmox Astronomy Lab's monitoring data. It serves as the primary interface for viewing metrics, logs, and other observability data collected by Prometheus, Loki, and other monitoring components. The platform enables creation of custom dashboards, organized by functional areas, providing real-time and historical views of system performance, availability, and resource utilization.

The current implementation includes dedicated dashboard collections for:

- Proxmox Cluster monitoring
- VM and container monitoring
- Database performance
- Application metrics
- Network monitoring
- GPU resources
- Log analysis
- Kubernetes cluster monitoring

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-VIZ-001 |
| **Service Type** | Core |
| **Service Category** | Observability |
| **Business Criticality** | High |
| **Service Owner** | Monitoring Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Monthly on second Sunday, 2AM-4AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Uptime monitoring |
| **Dashboard Load Time** | <3 seconds | Synthetic testing |
| **Query Performance** | <1 second for standard queries | Query statistics |
| **Alert Processing Time** | <15 seconds | Alert metrics |

### **3.2 Monitoring and Reporting**

Grafana service health monitoring is implemented through:

- **Self-monitoring**: Grafana monitors its own health metrics
- **External synthetic checks**: Basic availability monitoring
- **Access logs**: User activity and usage patterns
- **Error rate tracking**: Dashboard and query failures

Monthly service reports include metrics for dashboard usage, query performance, and user activity.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

Grafana is deployed as a standalone service on the monitoring server (lab-mon01), with the following key architectural characteristics:

- **Container-based deployment** using Docker
- **Persistent storage** for dashboards, users, and settings
- **Reverse proxy** for secure access
- **Integration with multiple data sources**
- **Organized folder structure** for dashboard organization

The architecture prioritizes reliability, performance, and usability while maintaining security and access controls.

### **4.2 Infrastructure Components**

The following components comprise the Grafana visualization infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **Grafana Server** | Core visualization platform | lab-mon01 | MON-GRAF-001 |
| **Grafana Database** | Settings and dashboard storage | lab-mon01 | MON-GRAF-DB-001 |
| **Dashboard Provisioning** | Git-based dashboard source control | Git repository | MON-GRAF-GIT-001 |

### **4.3 Data Source Integrations**

Grafana integrates with the following data sources:

| **Data Source** | **Type** | **Purpose** | **URL** |
|----------------|---------|------------|---------|
| **Prometheus** | Time series metrics | Performance and utilization metrics | <http://localhost:9090> |
| **Loki** | Log aggregation | Centralized log querying | <http://localhost:3100> |
| **InfluxDB** | Time series metrics | Proxmox monitoring data | <http://localhost:8086> |
| **PostgreSQL** | Relational database | Custom metrics and metadata | varies by instance |

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | lab-mon01 host | Complete service outage |
| **Requires** | Data sources (Prometheus, Loki, etc.) | Data visualization failure |
| **Requires** | Network connectivity | User access disruption |
| **Required By** | Operations teams | Monitoring visibility loss |
| **Required By** | Incident response processes | Diagnostic capability loss |
| **Required By** | Capacity planning | Historical trending loss |

### **4.5 Backup and Recovery**

The following parameters define our resilience strategy for Grafana:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily database backup, weekly configuration |
| **Backup Method** | Database export, configuration files in Git |
| **Backup Location** | NFS share on backup01, Git repository |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Link to recovery procedure document] |

## 📂 **5. Dashboard Organization**

This section documents the organization of dashboards within Grafana.

### **5.1 Folder Structure**

Dashboards are organized into functional folders based on the monitoring domain:

| **Folder** | **Purpose** | **Primary Audience** |
|-----------|-----------|----------------------|
| **Application Monitoring** | Application-specific metrics | Application Teams |
| **Databases** | Database performance and health | Database Administrators |
| **Docker** | Container metrics and performance | Container Platform Team |
| **GPU Monitoring** | GPU resource utilization | ML/AI Teams |
| **Logging** | Log visualization and analysis | Operations Teams |
| **Network Monitoring** | Network devices and performance | Network Team |
| **Proxmox Cluster** | Hypervisor and cluster metrics | Infrastructure Team |
| **VM Monitoring** | Virtual machine performance | Infrastructure Team |

### **5.2 Key Dashboards**

The following key dashboards are available:

| **Dashboard** | **Folder** | **Purpose** |
|--------------|----------|------------|
| **Gitea Repository Dashboard** | Application Monitoring | Git server performance |
| **PostgreSQL Databases** | Databases | Database server metrics |
| **cAdvisor: Compute Resources** | Docker | Container CPU and memory |
| **cAdvisor: Docker Insights** | Docker | Container detailed metrics |
| **cAdvisor: Performance Dashboard** | Docker | Container performance trends |
| **Nvidia GPU Metrics** | GPU Monitoring | GPU utilization and performance |
| **SSH Logs: By Machine** | Logging | Per-host SSH authentication |
| **SSH Logs: Global View** | Logging | Cross-system SSH activity |
| **DNS Filtering** | Network Monitoring | Pi-hole/DNS metrics |
| **SNMP Device Summary** | Network Monitoring | Network device overview |
| **SNMP Exporter** | Network Monitoring | Network device metrics |
| **SNMP Interface Detail** | Network Monitoring | Network interface metrics |
| **Proxmox Cluster, Graphical (Flux)** | Proxmox Cluster | Visual cluster dashboard |
| **Proxmox Cluster, Numeric (Flux)** | Proxmox Cluster | Detailed cluster metrics |
| **Proxmox Cluster, Alt (Flux)** | Proxmox Cluster | Alternative cluster view |
| **Linux: Top Processes** | VM Monitoring | Process resource utilization |
| **Node Exporter Full** | VM Monitoring | Comprehensive host metrics |
| **K8s RKE cluster monitoring** | VM Monitoring | Kubernetes cluster metrics |
| **WELL K8s RKE Cluster Monitoring** | VM Monitoring | Enhanced Kubernetes metrics |

### **5.3 Dashboard Provisioning**

Dashboards are managed through the following methods:

| **Method** | **Dashboard Type** | **Update Process** |
|------------|------------------|------------------|
| **Git Repository** | Core infrastructure dashboards | Git-based workflow with CI/CD |
| **JSON Export/Import** | Standard dashboards | Manual export/import with version control |
| **UI Creation** | Experimental dashboards | Direct creation in Grafana UI |

## 🔐 **6. Access Control**

This section documents the access control model for Grafana.

### **6.1 Authentication Methods**

The following authentication methods are configured:

| **Method** | **Primary Users** | **Configuration** |
|------------|-----------------|------------------|
| **Local Authentication** | System administrators | Username/password with MFA |
| **AD/LDAP Integration** | Regular users | Group-based access via AD groups |
| **API Tokens** | Automation systems | Limited scope, service-specific tokens |

### **6.2 Authorization Model**

Access is controlled through a role-based model:

| **Role** | **Permissions** | **Assignment Method** |
|----------|---------------|----------------------|
| **Admin** | Full system administration | Direct assignment |
| **Editor** | Dashboard edit, folder management | Group membership |
| **Viewer** | Read-only access to dashboards | Group membership |
| **Team-specific** | Access to team dashboards | Team membership |

### **6.3 Team Structure**

Teams are defined for specific functional areas:

| **Team** | **Members** | **Dashboard Access** |
|----------|-----------|---------------------|
| **Infrastructure** | Infrastructure administrators | Proxmox, VM, Network dashboards |
| **Database** | Database administrators | Database performance dashboards |
| **Security** | Security team | Security and logging dashboards |
| **Application** | Application support teams | Application-specific dashboards |

## 🔄 **7. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **7.1 Access Management**

The following access control framework governs Grafana administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Grafana Admin** | Full administrative access | Security team approval |
| **Monitoring Team** | Dashboard creation and editing | Team lead approval |
| **Operations Team** | Dashboard viewing | Team membership |
| **Application Team** | Application dashboard viewing | Application owner approval |

### **7.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Grafana Outage** | High | P2 | 30 minutes | 4 hours |
| **Dashboard Unavailable** | Medium | P3 | 2 hours | 8 hours |
| **Query Performance** | Medium | P3 | 2 hours | 8 hours |
| **Data Source Failure** | High | P2 | 30 minutes | 4 hours |

### **7.3 Change Management**

The following framework governs changes to the Grafana service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | Yes | CAB approval | Maintenance window |
| **Data Source Addition** | No | Monitoring team approval | Business hours |
| **Dashboard Creation** | No | Folder admin approval | Business hours |
| **Configuration Change** | Yes | CAB approval | Maintenance window |

## 🛠️ **8. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **8.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Service Health Check** | Daily | Operations Team | [GRAF-PROC-001] |
| **Dashboard Review** | Monthly | Monitoring Team | [GRAF-PROC-002] |
| **User Access Audit** | Quarterly | Security Team | [GRAF-PROC-003] |
| **Performance Optimization** | Quarterly | Monitoring Team | [GRAF-PROC-004] |

### **8.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Dashboard Loading Issues** | Slow or failed dashboard loads | Check data source connectivity, review query complexity | KEDB-GRAF-001 |
| **Authentication Problems** | Unable to log in, access denied | Verify AD connectivity, check user permissions | KEDB-GRAF-002 |
| **Missing Data** | Panels showing "No data" | Check data source health, verify time range selection | KEDB-GRAF-003 |
| **Performance Degradation** | Slow UI, high resource usage | Review query optimization, check database performance | KEDB-GRAF-004 |

## 🔐 **9. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **9.1 Security Controls**

The following controls protect the Grafana service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Network Security** | Reverse proxy with TLS | Configuration review |
| **Authentication** | AD integration, MFA | Login process testing |
| **Authorization** | Role-based access control | Permission audit |
| **API Security** | Token-based access, limited scope | Token review |
| **Audit Logging** | User activity logging | Log verification |

### **9.2 CISv8.1 Compliance Mapping**

This section documents how the Grafana implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.10** | Centralized analysis capabilities | Dashboard configuration | Compliant |
| **CIS.8.11** | Alert visualization and management | AlertManager integration | Compliant |
| **CIS.12.8** | Network monitoring visualization | Network dashboards | Compliant |

### **9.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.10** | A.12.1.3 | CA-7 | Centralized monitoring visualization |
| **CIS.8.11** | A.16.1.2 | IR-4 | Alert visualization and management |
| **CIS.12.8** | A.12.1.1 | SI-4 | Network monitoring dashboards |

## 📊 **10. Dashboard Standards**

This section documents the standards applied to dashboard development.

### **10.1 Layout Standards**

The following standards apply to dashboard layouts:

| **Element** | **Standard** | **Purpose** |
|------------|------------|------------|
| **Resolution** | 1920x1080 optimization | Consistent viewing experience |
| **Panel Arrangement** | Grid-based layout | Visual organization |
| **Information Density** | Maximum 12 panels per dashboard | Readability and performance |
| **Time Picker** | Upper right corner, standardized ranges | Consistent time selection |
| **Variables** | Top of dashboard, standardized names | Consistent filtering |

### **10.2 Visualization Standards**

The following standards apply to visualizations:

| **Chart Type** | **Use Case** | **Best Practices** |
|----------------|------------|-------------------|
| **Time Series** | Metrics over time | Clear Y-axis labels, appropriate units |
| **Gauge** | Current value vs. threshold | Consistent color coding |
| **Stat** | Single value display | Clear unit indicator, appropriate precision |
| **Table** | Multi-dimensional data | Concise column names, appropriate sorting |
| **Logs** | Log data visualization | Consistent level styling |

### **10.3 Color Coding Standards**

The following color standards are used across dashboards:

| **Color** | **Meaning** | **Example Usage** |
|-----------|-----------|------------------|
| **Green** | Healthy, normal | Values within expected range |
| **Yellow** | Warning, attention needed | Values approaching thresholds |
| **Red** | Critical, immediate action | Values exceeding critical thresholds |
| **Blue** | Informational, neutral | Reference lines, supplementary data |

## 🔗 **11. Integration With Other Services**

This section documents how Grafana integrates with other key services in the environment.

### **11.1 Prometheus Integration**

Grafana serves as the primary visualization platform for Prometheus metrics:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Data Source Type** | Prometheus |
| **URL** | <http://localhost:9090> |
| **Access Mode** | Server (direct) |
| **Query Language** | PromQL |
| **Dashboard Examples** | Node Exporter, Kubernetes monitoring |

### **11.2 Loki Integration**

Grafana provides visualization for Loki logs:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Data Source Type** | Loki |
| **URL** | <http://localhost:3100> |
| **Access Mode** | Server (direct) |
| **Query Language** | LogQL |
| **Dashboard Examples** | SSH Logs, Container Logs |

### **11.3 InfluxDB Integration**

Grafana visualizes InfluxDB metrics primarily for Proxmox monitoring:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Data Source Type** | InfluxDB |
| **URL** | <http://localhost:8086> |
| **Access Mode** | Server (direct) |
| **Query Language** | Flux |
| **Dashboard Examples** | Proxmox Cluster dashboards |

### **11.4 AlertManager Integration**

Grafana can visualize and manage alerts from AlertManager:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Integration Type** | Alerting data source |
| **URL** | <http://localhost:9093> |
| **Feature** | Alert visualization and management |
| **Dashboard Example** | Alert Overview dashboard |

## ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

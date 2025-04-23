<!-- 
---
title: "cAdvisor Container Monitoring Service"
description: "Documentation for the cAdvisor container monitoring service providing container metrics for Docker hosts in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["cadvisor", "containers", "docker", "monitoring", "metrics", "observability", "kubernetes"]
category: "Observability"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Prometheus", "Grafana", "Docker", "Portainer"]
implements_policies: ["Monitoring Policy", "Container Security Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.2", "CIS.8.5", "CIS.8.10"]
iso27001_controls: ["A.12.1.3", "A.12.4.1"]
nist_controls: ["AU-2", "AU-6", "PM-14", "SI-4"]
---
-->

# 📦 **cAdvisor Container Monitoring Service**

This document provides the authoritative reference for the cAdvisor container monitoring service in the Proxmox Astronomy Lab, documenting its implementation for container performance metrics collection across Docker hosts.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the cAdvisor container monitoring service, its deployment architecture, and integration with the central monitoring system. It serves as the definitive reference for container-level metrics collection within the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| cAdvisor deployment architecture | Container orchestration details |
| Integration with Prometheus | Application-specific metrics |
| Standard metrics collection | Custom metrics development |
| Basic operational procedures | Container security scanning |
| Containerized service monitoring | Container image management |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Container Platform Engineers
- DevOps Engineers
- Application Support Personnel

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the cAdvisor service within our operational framework.

### **2.1 Service Description**

cAdvisor (Container Advisor) provides container users with an understanding of the resource usage and performance characteristics of their running containers. It is a running daemon that collects, aggregates, processes, and exports information about running containers. Specifically, for each container, it keeps resource isolation parameters, historical resource usage, histograms of complete historical resource usage, and network statistics.

In the Proxmox Astronomy Lab, cAdvisor is deployed on all Docker hosts to provide detailed container-level metrics to the central Prometheus monitoring system. This enables comprehensive visibility into container performance, resource utilization, and health.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-CONT-001 |
| **Service Type** | Supporting |
| **Service Category** | Observability |
| **Business Criticality** | Medium |
| **Service Owner** | Container Platform Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Aligned with Docker host maintenance |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.5% | Prometheus monitoring |
| **Metrics Collection Interval** | 15 seconds | Prometheus scrape frequency |
| **Resource Overhead** | <5% CPU, <200MB RAM | Host monitoring |
| **Data Freshness** | <30 seconds | Metric timestamp analysis |

### **3.2 Monitoring and Reporting**

cAdvisor service health monitoring is implemented through:

- **Prometheus metrics**: Endpoint availability monitoring
- **Resource utilization**: CPU and memory consumption tracking
- **Container metrics coverage**: Verification all containers are monitored

Daily service health checks are conducted to ensure cAdvisor is functioning correctly on all Docker hosts.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

cAdvisor is deployed as a containerized service on all Docker hosts, with the following key architectural characteristics:

- **Container deployment**: Running as a privileged container with host access
- **Standard configuration**: Using default settings appropriate for most scenarios
- **Direct Prometheus integration**: Exposing metrics on port 8080
- **Monitored by central Prometheus**: Metrics scraped by lab-mon01
- **No persistent storage**: Stateless operation with short-term metrics retention

The architecture prioritizes simplicity and reliability, using the standard cAdvisor deployment model with minimal customization.

### **4.2 Infrastructure Components**

The following components comprise the cAdvisor monitoring infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **cAdvisor on lab-apps01** | Container metrics collector | lab-apps01 | MON-CADV-001 |
| **cAdvisor on proj-apps01** | Container metrics collector | proj-apps01 | MON-CADV-002 |
| **cAdvisor on lab-db01** | Container metrics collector | lab-db01 | MON-CADV-003 |

### **4.3 Docker Deployment**

cAdvisor is deployed using the following Docker run command or equivalent docker-compose configuration:

```yaml
version: '3'

services:
  cadvisor:
    image: gcr.io/cadvisor/cadvisor:v0.47.0
    container_name: cadvisor
    restart: unless-stopped
    privileged: true
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    devices:
      - /dev/kmsg
    networks:
      - monitoring_net
```

### **4.4 Prometheus Integration**

cAdvisor instances are configured as targets in Prometheus with the following job definition:

```yaml
- job_name: "cadvisor_nodes"
  metrics_path: "/metrics"
  scheme: http
  static_configs:
    - targets:
        - "10.25.10.18:8080"  # lab-apps01
        - "10.25.20.21:8080"  # proj-apps01
        - "10.25.10.17:8080"  # lab-db01
      labels:
        env: "lab"
        role: "cadvisor"
  relabel_configs:
    - source_labels: [__address__]
      target_label: instance
      regex: "10.25.10.18:8080"
      replacement: "lab-apps01"
    - source_labels: [__address__]
      target_label: instance
      regex: "10.25.20.21:8080"
      replacement: "proj-apps01"
    - source_labels: [__address__]
      target_label: instance
      regex: "10.25.10.17:8080"
      replacement: "lab-db01"
```

### **4.5 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Docker Engine | Service failure |
| **Requires** | Host kernel access | Limited metrics collection |
| **Required By** | Prometheus | Container metrics unavailable |
| **Required By** | Container monitoring dashboards | Visualization failure |
| **Required By** | Container resource alerts | Alert functionality failure |

## 📉 **5. Metrics Collection**

This section documents the metrics collected by cAdvisor and their usage.

### **5.1 Container Metrics**

cAdvisor collects the following container-level metrics:

| **Metric Category** | **Examples** | **Usage** |
|---------------------|------------|----------|
| **CPU** | Usage, throttling, scheduling | Performance monitoring, capacity planning |
| **Memory** | Usage, cache, swap, page faults | Resource monitoring, memory leak detection |
| **Network** | Bytes transmitted/received, errors, drops | Network performance, connectivity issues |
| **Filesystem** | Reads/writes, usage by device | Storage performance, capacity monitoring |
| **Task Stats** | Process counts, thread counts | Application scaling, resource utilization |

### **5.2 Key Metrics for Monitoring**

The following key metrics are used for operational monitoring:

| **Metric Name** | **Description** | **Normal Range** | **Alert Threshold** |
|----------------|----------------|----------------|---------------------|
| **container_cpu_usage_seconds_total** | Cumulative CPU time consumed | Varies by workload | >80% sustained usage |
| **container_memory_usage_bytes** | Current memory usage | <container limit | >90% of limit |
| **container_fs_usage_bytes** | Filesystem usage | <80% of capacity | >90% of capacity |
| **container_network_receive_bytes_total** | Network bytes received | Workload dependent | N/A (monitoring only) |
| **container_network_transmit_bytes_total** | Network bytes transmitted | Workload dependent | N/A (monitoring only) |

### **5.3 Metric Labels**

cAdvisor attaches the following labels to metrics for filtering and aggregation:

| **Label** | **Purpose** | **Example Values** |
|-----------|-----------|-------------------|
| **container_name** | Identifies specific containers | cadvisor, prometheus, grafana |
| **image** | Container image name and tag | nginx:latest, postgres:13 |
| **name** | Alternative container identifier | k8s_prometheus_prometheus-server-77f87f5cc4-nbr8f |
| **id** | Container ID | 5fb68d3846c1a1a15a23eb516643692baec5b9eac427f4d707f147f06e06d65b |
| **pod_name** | For Kubernetes pods | prometheus-server-77f87f5cc4-nbr8f |

## 🔄 **6. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **6.1 Access Management**

The following access control framework governs cAdvisor administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Container Admin** | Full administrative access | Team lead approval |
| **Monitoring Team** | Read-only access to metrics | Monitoring team membership |
| **Application Team** | Read-only access to their containers | Application owner approval |

### **6.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **cAdvisor Outage** | Medium | P3 | 2 hours | 8 hours |
| **Metrics Collection Failure** | Medium | P3 | 2 hours | 8 hours |
| **Performance Impact to Host** | High | P2 | 30 minutes | 4 hours |

### **6.3 Change Management**

The following framework governs changes to the cAdvisor service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | No | Container team approval | Business hours |
| **Configuration Change** | No | Container team approval | Business hours |
| **New Host Deployment** | No | Container team approval | Business hours |

## 🛠️ **7. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **7.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Service Health Check** | Daily | Monitoring Team | [CADV-PROC-001] |
| **Version Review** | Quarterly | Container Team | [CADV-PROC-002] |
| **Resource Impact Assessment** | Monthly | Container Team | [CADV-PROC-003] |

### **7.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Service Unavailable** | 'down' in Prometheus, no metrics | Restart container, check Docker logs | KEDB-CADV-001 |
| **High Resource Usage** | Container consuming excessive CPU/memory | Update version, check for resource leaks | KEDB-CADV-002 |
| **Missing Container Metrics** | Some containers not appearing in metrics | Check container runtime, verify mount paths | KEDB-CADV-003 |
| **Permission Issues** | Access denied errors in logs | Verify container is running with privileged flag | KEDB-CADV-004 |

## 🔐 **8. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect the cAdvisor service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Network Access** | Internal network only | Network ACL verification |
| **Container Privilege** | Privileged mode, required for operation | Configuration review |
| **Port Exposure** | Limited to monitored networks | Docker network configuration |
| **Update Cycle** | Regular version updates | Update compliance checking |

### **8.2 CISv8.1 Compliance Mapping**

This section documents how the cAdvisor implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.2** | Collection of container resource metrics | Prometheus metrics | Compliant |
| **CIS.8.5** | Centralized container metrics collection | Monitoring architecture | Compliant |
| **CIS.8.10** | Resource utilization analysis | Grafana dashboards | Compliant |

### **8.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.2** | A.12.4.1 | AU-2 | Container metrics logging |
| **CIS.8.5** | A.12.1.3 | SI-4 | Container performance monitoring |

## 📊 **9. Visualization & Dashboards**

This section documents the visualization of cAdvisor metrics in Grafana.

### **9.1 Primary Dashboards**

The following Grafana dashboards utilize cAdvisor metrics:

| **Dashboard** | **Purpose** | **URL** | **Primary Audience** |
|--------------|-----------|-------|----------------------|
| **Container Overview** | General container metrics | `/grafana/d/containers` | Operations Team |
| **Docker Host Performance** | Host-level container impact | `/grafana/d/docker-hosts` | Container Team |
| **Application Containers** | Application-specific containers | `/grafana/d/app-containers` | Application Teams |

### **9.2 Key Visualizations**

The following standard visualizations are included in dashboards:

| **Visualization** | **Metrics Used** | **Purpose** |
|-------------------|----------------|-----------|
| **Container CPU Usage** | container_cpu_usage_seconds_total | CPU utilization trends |
| **Container Memory Usage** | container_memory_usage_bytes | Memory consumption patterns |
| **Container Network I/O** | container_network_receive/transmit_bytes_total | Network traffic analysis |
| **Container Disk I/O** | container_fs_reads/writes_bytes_total | Storage performance analysis |
| **Container Count** | Count of container metrics | Environment scale monitoring |

## 🔗 **10. Integration With Other Services**

This section documents how cAdvisor integrates with other key services in the environment.

### **10.1 Prometheus Integration**

cAdvisor metrics are collected by Prometheus:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Scrape Interval** | 15 seconds |
| **Metrics Path** | /metrics |
| **Target Labeling** | Instance name mapping via relabeling |
| **Job Labels** | cadvisor_nodes, role=cadvisor, env=lab |

### **10.2 Grafana Integration**

cAdvisor metrics are visualized through Grafana:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Data Source** | Prometheus |
| **Dashboard Provisioning** | Git-managed dashboards |
| **Primary Dashboards** | Container Overview, Docker Host Performance |
| **Access Control** | Role-based dashboard access |

### **10.3 AlertManager Integration**

cAdvisor metrics can trigger alerts through Prometheus:

| **Alert Category** | **Trigger Condition** | **Severity** |
|--------------------|---------------------|------------|
| **Container CPU High** | >80% utilization for 15 minutes | Warning |
| **Container Memory High** | >90% of limit | Warning |
| **Container Restart** | Restart count increasing | Warning |

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

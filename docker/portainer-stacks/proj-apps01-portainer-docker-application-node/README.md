---
title: "Proj-Apps01 Portainer Docker Application Node"
description: "Documentation for the Proj-Apps01 Portainer worker node, detailing its role in hosting project-specific applications and services."
author: "VintageDon"
tags: ["portainer", "docker", "infrastructure", "applications", "project-services"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---

# **Proj-Apps01 Portainer Docker Application Node**

Proj-Apps01 is a dedicated **Portainer worker node** that hosts **project-specific applications and services** for the Proxmox Astronomy Lab's research initiatives. Managed by **Lab-Port01** (Portainer master node), it runs **Docker on Ubuntu 24.04** within the **project network segment (VLAN20)**, providing a platform for research tools, visualization interfaces, and collaborative applications.

Unlike the lab-apps01 node which focuses on lab-wide infrastructure services, Proj-Apps01 specializes in hosting applications directly related to research workflows and data processing, creating a clear separation between infrastructure and research workloads.

## **1. Technical Specifications**

This VM provides dedicated resources for project-specific applications with emphasis on performance, storage, and research workflow integration.

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | proj-apps01.beardinthe.cloud |
| **VM ID** | 2004 |
| **vCPU** | 4 vCPUs |
| **RAM** | 12 GB |
| **Storage** | 32 GB (OS) + 500 GB (Container Storage) |
| **OS** | Ubuntu 24.04 LTS |
| **Networking** | VLAN20 (Research) |
| **IP Address** | 10.25.20.21/24 |
| **Gateway** | 10.25.20.1 |
| **DNS** | 10.25.10.3, 10.25.20.3 |

## **2. Docker Infrastructure**

The Docker environment is configured to support research applications with high data throughput, visualization capabilities, and integration with scientific workflows.

### **2.1 Docker Configuration**

The Docker daemon is configured with optimizations for project workloads, including appropriate storage and network configurations.

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3"
  },
  "default-address-pools": [
    {
      "base": "172.21.0.0/16",
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

The storage is designed to maintain CIS compliance while providing ample space for data-intensive research applications. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 500 GB | Docker data directory (moved from default location) |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/data/research** | NFS mount | Shared research data repository |

## **3. Hosted Applications**

Proj-Apps01 hosts project-specific applications that support research workflows, data visualization, and collaboration among researchers.

### **3.1 Source Control and Collaboration**

Project-specific source control and collaboration tools enable coordinated research and development activities.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **gitea** | Project-specific Git repositories | 3000, 22 |
| **nextcloud** | File collaboration and sharing | 8080 |

### **3.2 Visualization and Analysis**

Specialized visualization tools provide insights into research data and analytical results.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **grafana** | Project-specific data visualization | 3001 |
| **jupyter** | Interactive data analysis notebooks | 8888 |
| **rstudio** | R statistical analysis environment | 8787 |

### **3.3 Project Infrastructure**

Core infrastructure services supporting project workflows and data access.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **nginx** | Web interfaces and API proxies | 80, 443 |
| **kong** | API gateway for research services | 8000, 8001 |
| **dashy** | Project-specific dashboard | 4000 |
| **portainer-agent** | Portainer management | 9001 |

### **3.4 Network Configuration**

Docker networks are segmented to organize project services while enabling appropriate interconnectivity.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **proj-frontend** | 172.21.0.0/24 | Web interfaces and dashboards |
| **proj-backend** | 172.21.1.0/24 | APIs and data services |
| **proj-storage** | 172.21.2.0/24 | Data access services |

## **4. Security & Compliance**

Project services implement appropriate security measures to protect research data while enabling collaboration.

### **4.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect research applications and data.

- **CIS Ubuntu 24.04 Level 2** compliance for base OS
- **AppArmor profiles** for container isolation
- **Authentication required** for all services
- **HTTPS enforced** for all web interfaces
- **Data encryption** for sensitive information
- **Regular security scanning** via integrated tools

### **4.2 Access Control**

Access to project services is managed through role-based permissions with integration to the lab's identity management system.

| **Service** | **Authentication Method** | **Authorization** |
|-------------|---------------------------|------------------|
| **Gitea** | Entra ID + OAuth | Repository-level permissions |
| **Nextcloud** | Entra ID + OAuth | Folder and file permissions |
| **Grafana** | Entra ID + OAuth | Dashboard access control |
| **Jupyter** | Entra ID + OAuth | User-specific workspaces |
| **RStudio** | Entra ID + OAuth | User-specific environments |
| **Kong API Gateway** | API keys | Service-specific permissions |

## **5. Integration with Research Infrastructure**

The Proj-Apps01 node integrates with other research components to form a cohesive scientific computing environment.

### **5.1 Database Integration**

Project applications connect to specialized database services for data storage and retrieval.

| **Application** | **Database Service** | **Connection Type** |
|----------------|----------------------|-------------------|
| **Gitea** | proj-pg01 (PostgreSQL) | Direct connection |
| **Nextcloud** | proj-pg01 (PostgreSQL) | Direct connection |
| **Grafana** | proj-pgts01 (TimescaleDB) | Direct connection |
| **Jupyter** | proj-pggis01 (PostGIS) | Python connectors |
| **RStudio** | proj-pggis01 (PostGIS) | R database libraries |

### **5.2 Kubernetes Integration**

Project applications interact with the lab's Kubernetes cluster for specialized workloads and data processing tasks.

| **Application** | **K8s Integration** | **Purpose** |
|----------------|---------------------|------------|
| **Gitea** | Webhook triggers | CI/CD pipeline automation |
| **Kong** | Service discovery | API routing to K8s services |
| **Jupyter** | Compute kernels | Distributed computation |
| **Grafana** | Data sources | K8s metrics visualization |

## **6. Backup & Disaster Recovery**

Comprehensive backup strategies ensure research data and application configurations are protected against loss.

### **6.1 Backup Strategy**

Multiple backup approaches protect different aspects of the project environment.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Container Configurations** | Git repositories | Real-time | Unlimited |
| **Docker Volumes** | Proxmox Backup Server | Daily | 7 days |
| **Nextcloud Data** | Dedicated backup container | Hourly | 14 days |
| **Project Databases** | Database-specific backups | Hourly | 7 days |
| **Full VM Backup** | Proxmox Backup Server | Weekly | 4 backups |

### **6.2 Recovery Procedure**

A structured recovery process ensures minimal disruption to research activities during recovery operations.

1. **Restore VM** from Proxmox Backup Server if needed
2. **Verify Docker installation** and configuration
3. **Reconnect Portainer Agent** to Lab-Port01
4. **Restore application data** from appropriate backups
5. **Verify integrations** with databases and K8s services
6. **Test end-to-end functionality** for key research workflows

## **7. Monitoring & Alerting**

Comprehensive monitoring ensures project applications remain available and performant for research activities.

### **7.1 Health Checks**

Multiple monitoring approaches ensure the health and performance of project applications.

- **Container status** monitoring via Prometheus exporters
- **Application-specific health checks** via HTTP endpoints
- **Integration status** with databases and external services
- **User experience metrics** for web interfaces
- **Storage utilization** tracking
- **Backup success/failure** monitoring

### **7.2 Alert Thresholds**

Targeted alerts ensure proactive response to potential issues affecting research applications.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 75% for 5 minutes | 90% for 3 minutes |
| **Memory Usage** | 80% for 5 minutes | 90% for 3 minutes |
| **Disk Usage** | 75% | 90% |
| **Response Time** | 2 seconds | 5 seconds |
| **Error Rate** | 1% | 5% |
| **Integration Failures** | 3 in 15 minutes | 5 in 5 minutes |

## **8. Management & Operations**

Structured operational procedures ensure stable and predictable management of project applications.

### **8.1 Maintenance Schedule**

The Proj-Apps01 node follows the lab's rotating maintenance schedule with special consideration for research activities.

- **OS Updates**: Weekly on predefined maintenance windows
- **Security Patches**: Applied as needed with priority
- **Docker Updates**: Evaluated monthly
- **Application Updates**: Coordinated with research schedules
- **Database Schema Changes**: Implemented via change management process

VMs are updated and rebooted weekly on a rotating schedule to avoid service downtimes, with project components scheduled to minimize impact on active research.

### **8.2 Update Procedure**

Updates follow a standardized process with consideration for research continuity.

1. **Review change documentation** in GLPI
2. **Notify research teams** of planned maintenance
3. **Create application backups** before updates
4. **Implement updates** according to plan
5. **Verify application functionality** post-update
6. **Test research workflows** to ensure proper operation
7. **Update documentation** with any changes

### **8.3 Troubleshooting Quick Reference**

Common issues are documented with standard resolution paths to speed recovery and reduce research disruption.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Container Exit** | Check container logs | Inspect resource limits |
| **Integration Failure** | Verify connectivity to dependency | Check authentication credentials |
| **Storage Issue** | Check available space | Investigate volume mounts |
| **Performance Degradation** | Identify resource bottlenecks | Review application configurations |
| **Authentication Problems** | Check Zitadel connectivity | Verify OAuth configurations |

## **9. Documentation References**

Additional resources provide detailed information on project application configurations and research workflows.

| **Document** | **Purpose** | **Location** |
|-------------|------------|-------------|
| **Service Documentation** | ITIL-aligned service document | [Proj-Apps01 Service Documentation](../../../applications-services/proj-apps01-docker-application-node.md) |
| **Research Workflow Guide** | End-to-end workflow documentation | [Research Workflow Documentation](../../../observatory-projects/workflows/end-to-end-guide.md) |
| **Application User Guides** | Usage instructions for researchers | [Application User Guides](../../../observatory-projects/applications/user-guides.md) |

## **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

## **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |
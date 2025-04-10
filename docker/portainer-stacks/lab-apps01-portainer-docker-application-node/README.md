<!-- 
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
-->

# 📱 **Proj-Apps01 Portainer Docker Application Node**

# 🔍 **1. Overview**

Proj-Apps01 is a dedicated **Portainer worker node** that hosts **project-specific applications and services** for the Proxmox Astronomy Lab's research initiatives. Managed by **Lab-Port01** (Portainer master node), it runs **Docker on Ubuntu 24.04** within the **project network segment (VLAN20)**, providing a platform for research tools, visualization interfaces, and collaborative applications.

Unlike the lab-apps01 node which focuses on lab-wide infrastructure services, Proj-Apps01 specializes in hosting applications directly related to research workflows and data processing, creating a clear separation between infrastructure and research workloads.

---

# 🖥️ **2. Technical Specifications**

## **2.1 Virtual Machine Configuration**

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

## **2.2 Physical Node Placement**

The VM is hosted on a specific physical Proxmox node to ensure adequate resources and performance.

| **Attribute** | **Value** |
|--------------|-----------|
| **Proxmox Node** | node04 |
| **Resource Pool** | research |
| **VM Location** | local-nvme |
| **Backup Schedule** | Daily at 02:00 |
| **Migration Policy** | Allowed with constraints |

---

# 🐳 **3. Docker Infrastructure**

## **3.1 Docker Configuration**

The Docker environment is configured to support research applications with high data throughput, visualization capabilities, and integration with scientific workflows.

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

## **3.2 Storage Configuration**

The storage is designed to maintain CIS compliance while providing ample space for data-intensive research applications. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 500 GB | Docker data directory (moved from default location) |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/data/research** | NFS mount | Shared research data repository |

## **3.3 Portainer Integration**

This node is managed through Portainer's agent architecture, providing centralized control from the lab-port01 master node.

| **Component** | **Details** |
|--------------|------------|
| **Portainer Control Node** | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **Agent Version** | 2.19.4 |
| **Agent Endpoint** | 10.25.20.21:9001 |
| **Edge Key** | Managed via Vault |
| **Stacks Path** | `/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/` |

---

# 📂 **4. Hosted Applications**

## **4.1 Source Control and Collaboration**

Project-specific source control and collaboration tools enable coordinated research and development activities.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-------------------------|
| **gitea** | Project-specific Git repositories | [Gitea Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/gitea/README.md) |
| **nextcloud** | File collaboration and sharing | [Nextcloud Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/nextcloud/README.md) |

## **4.2 Visualization and Analysis**

Specialized visualization tools provide insights into research data and analytical results.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-------------------------|
| **grafana** | Project-specific data visualization | [Grafana Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/grafana/README.md) |
| **jupyter** | Interactive data analysis notebooks | [Jupyter Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/jupyter/README.md) |
| **rstudio** | R statistical analysis environment | [RStudio Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/rstudio/README.md) |

## **4.3 Project Infrastructure**

Core infrastructure services supporting project workflows and data access.

| **Container** | **Purpose** | **Stack Documentation** |
|--------------|-------------|-------------------------|
| **nginx** | Web interfaces and API proxies | [Nginx Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/nginx/README.md) |
| **kong** | API gateway for research services | [Kong Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/kong/README.md) |
| **dashy** | Project-specific dashboard | [Dashy Stack](/docker/portainer-stacks/proj-apps01-portainer-docker-application-node/dashy/README.md) |
| **portainer-agent** | Portainer management | Built-in Agent |

## **4.4 Network Configuration**

Docker networks are segmented to organize project services while enabling appropriate interconnectivity.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **proj-frontend** | 172.21.0.0/24 | Web interfaces and dashboards |
| **proj-backend** | 172.21.1.0/24 | APIs and data services |
| **proj-storage** | 172.21.2.0/24 | Data access services |

---

# 🔐 **5. Security & Compliance**

## **5.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect research applications and data.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **OS Hardening** | CIS Ubuntu 24.04 Level 2 | Lynis scans, CIS-CAT Pro |
| **Container Isolation** | AppArmor profiles | Profile validation |
| **Network Security** | HTTPS enforcement | Certificate validation |
| **Authentication** | Entra ID integration | Access logs |
| **Data Encryption** | Volume encryption | Verification scripts |
| **Security Scanning** | Daily vulnerability scans | Scan reports |

## **5.2 Access Control**

Access to project services is managed through role-based permissions with integration to the lab's identity management system.

| **Service** | **Authentication Method** | **Authorization** |
|-------------|---------------------------|------------------|
| **Gitea** | Entra ID + OAuth | Repository-level permissions |
| **Nextcloud** | Entra ID + OAuth | Folder and file permissions |
| **Grafana** | Entra ID + OAuth | Dashboard access control |
| **Jupyter** | Entra ID + OAuth | User-specific workspaces |
| **RStudio** | Entra ID + OAuth | User-specific environments |
| **Kong API Gateway** | API keys | Service-specific permissions |

## **5.3 CISv8.1 Compliance Mapping**

This subsection explicitly maps implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.1.1** | Hardware inventory in GLPI | CMDB record #2004 | Compliant |
| **CIS.4.1** | Secure configuration baseline | Ansible playbooks | Compliant |
| **CIS.5.1** | AD-integrated authentication | Access logs | Compliant |
| **CIS.8.2** | Audit logging enabled | Loki logs | Compliant |
| **CIS.10.1** | ClamAV, AppArmor | Daily scan reports | Compliant |

---

# 🔄 **6. Integration with Research Infrastructure**

## **6.1 Database Integration**

Project applications connect to specialized database services for data storage and retrieval.

| **Application** | **Database Service** | **Connection Type** |
|----------------|----------------------|-------------------|
| **Gitea** | [proj-pg01](/infrastructure/projects/proj-pg01-postgresql.md) | Direct connection |
| **Nextcloud** | [proj-pg01](/infrastructure/projects/proj-pg01-postgresql.md) | Direct connection |
| **Grafana** | [proj-pgts01](/infrastructure/projects/proj-pgts01-timescale.md) | Direct connection |
| **Jupyter** | [proj-pggis01](/infrastructure/projects/proj-pggis01-prostresql-with-gis.md) | Python connectors |
| **RStudio** | [proj-pggis01](/infrastructure/projects/proj-pggis01-prostresql-with-gis.md) | R database libraries |

## **6.2 Kubernetes Integration**

Project applications interact with the lab's Kubernetes cluster for specialized workloads and data processing tasks.

| **Application** | **K8s Integration** | **Purpose** |
|----------------|---------------------|------------|
| **Gitea** | Webhook triggers | CI/CD pipeline automation |
| **Kong** | Service discovery | API routing to K8s services |
| **Jupyter** | Compute kernels | Distributed computation |
| **Grafana** | Data sources | K8s metrics visualization |

---

# 💾 **7. Backup & Recovery**

## **7.1 Backup Strategy**

Multiple backup approaches protect different aspects of the project environment.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Container Configurations** | Git repositories | Real-time | Unlimited |
| **Docker Volumes** | Proxmox Backup Server | Daily | 7 days |
| **Nextcloud Data** | Dedicated backup container | Hourly | 14 days |
| **Project Databases** | Database-specific backups | Hourly | 7 days |
| **Full VM Backup** | Proxmox Backup Server | Weekly | 4 backups |

## **7.2 Recovery Procedure**

A structured recovery process ensures minimal disruption to research activities during recovery operations.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| **Container Failure** | 15 min | 0 min | Restore container from Portainer template | Infrastructure Engineer |
| **Data Corruption** | 30 min | 1 hour | Restore from application-specific backup | Research Data Manager |
| **Volume Failure** | 1 hour | 24 hours | Restore from volume backup | Infrastructure Engineer |
| **VM Failure** | 2 hours | 24 hours | Restore VM from Proxmox Backup | Infrastructure Engineer |
| **Node Failure** | 4 hours | 24 hours | Migrate to alternative node | Infrastructure Engineer |

---

# 📊 **8. Monitoring & Management**

## **8.1 Health Checks**

Multiple monitoring approaches ensure the health and performance of project applications.

| **Monitoring System** | **Components Monitored** | **Dashboard** |
|----------------------|--------------------------|--------------|
| **Prometheus** | Host metrics, container metrics | [Node Exporter Dashboard](/monitoring/grafana/dashboards/node-exporter-full-dashboard-screenshot.png) |
| **Loki** | Container logs, OS logs | [Log Dashboard](/docs/applications/observability/loki/log-dashboard.md) |
| **cAdvisor** | Container performance | [cAdvisor Dashboard](/monitoring/grafana/dashboards/cadvisor-docker-insights-dashboard-screenshot.png) |
| **Application Health** | Application-specific endpoints | [Application Health Dashboard](/docs/applications/observability/application-health.md) |
| **Wazuh** | Security events, file integrity | [Security Dashboard](/docs/applications/security/wazuh/security-dashboard.md) |

## **8.2 Alert Thresholds**

Targeted alerts ensure proactive response to potential issues affecting research applications.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 75% for 5 minutes | 90% for 3 minutes |
| **Memory Usage** | 80% for 5 minutes | 90% for 3 minutes |
| **Disk Usage** | 75% | 90% |
| **Response Time** | 2 seconds | 5 seconds |
| **Error Rate** | 1% | 5% |
| **Integration Failures** | 3 in 15 minutes | 5 in 5 minutes |

## **8.3 Maintenance Schedule**

The Proj-Apps01 node follows the lab's rotating maintenance schedule with special consideration for research activities.

| **Maintenance Type** | **Schedule** | **Notification** | **Procedure Document** |
|----------------------|-------------|-----------------|------------------------|
| **OS Updates** | Weekly (Sundays 00:00-02:00) | 48 hours | [OS Update Procedure](/docs/infrastructure/maintenance/os-update-procedure.md) |
| **Security Patches** | As needed | 24 hours (standard)/None (critical) | [Security Patching Procedure](/docs/infrastructure/maintenance/security-patching.md) |
| **Docker Updates** | Monthly (First Saturday) | 72 hours | [Docker Update Procedure](/docs/infrastructure/maintenance/docker-update-procedure.md) |
| **Application Updates** | Coordinated with research schedules | 1 week | [Application Update Procedure](/docs/infrastructure/maintenance/application-update-procedure.md) |

---

# 🛠️ **9. Troubleshooting**

## **9.1 Common Issues**

Common issues are documented with standard resolution paths to speed recovery and reduce research disruption.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Container Exit** | Check container logs | Inspect resource limits |
| **Integration Failure** | Verify connectivity to dependency | Check authentication credentials |
| **Storage Issue** | Check available space | Investigate volume mounts |
| **Performance Degradation** | Identify resource bottlenecks | Review application configurations |
| **Authentication Problems** | Check Zitadel connectivity | Verify OAuth configurations |

## **9.2 Diagnostic Commands**

These commands assist in diagnosing and resolving common issues with project applications.

```bash
# Check application container status
docker ps -a | grep [container-name]

# View container logs
docker logs [container-name]

# Check database connectivity
docker exec [container-name] nc -zv proj-pg01 5432

# Check disk space
df -h /mnt/docker

# Monitor resource usage
docker stats [container-name]
```

---

# 🔗 **10. Directory Contents**

This section provides direct navigation to all subdirectories and key documents related to this node:

## **10.1 Related Documentation**

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| **Service Document** | Proj-Apps01 ITIL Service Doc | [Service Documentation](/docs/control-plane/services/proj-apps01-service-documentation.md) |
| **Research Workflow Guide** | End-to-end workflow documentation | [Research Workflow Documentation](/docs/observatory-projects/workflows/end-to-end-guide.md) |
| **Application User Guides** | Usage instructions for researchers | [Application User Guides](/docs/observatory-projects/applications/user-guides.md) |
| **Security Baseline** | Research Application Security | [Security Controls](/docs/compliance-security/implementation-guides/research-applications.md) |

## **10.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| **CI** | CI-2004 | proj-apps01 | Primary configuration item |
| **Service** | SVC-201 | Research Applications | Delivered service |
| **KB Article** | KB-505 | Research Application Troubleshooting | Support documentation |
| **Change Template** | CHG-RES-01 | Research Application Maintenance | Change template |

---

# 🔄 **11. Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|----------------|-------------------|
| **lab-port01** | Manages this Portainer node | [lab-port01](/infrastructure/control-plane/lab-port01-portainer-control-node.md) |
| **proj-pg01** | Provides database services | [proj-pg01](/infrastructure/projects/proj-pg01-postgresql.md) |
| **proj-pgts01** | Provides time-series database | [proj-pgts01](/infrastructure/projects/proj-pgts01-timescale.md) |
| **proj-pggis01** | Provides GIS database | [proj-pggis01](/infrastructure/projects/proj-pggis01-prostresql-with-gis.md) |
| **node04** | Hosts this VM | [node04](/infrastructure/proxmox/node04-proxmox-gpu-hpc.md) |

---

# ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

# 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

<!-- 
---
title: "Lab-Port01 Portainer Master Control Node"
description: "Documentation for the Lab-Port01 Portainer master node, detailing its role in orchestrating containerized workloads across the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["portainer", "docker", "infrastructure", "orchestration", "control-plane"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-09"
---
-->

# 🐳 **Lab-Port01 Portainer Master Control Node**

# 🔍 **1. Overview**

Lab-Port01 serves as the **central management and orchestration platform** for all containerized workloads in the Proxmox Astronomy Lab. As the **Portainer master node**, it provides a unified control interface for deploying, monitoring, and managing Docker containers across multiple worker nodes, including lab-apps01, lab-db01, and proj-apps01.

This node plays a crucial role in the lab's containerization strategy, enabling standardized deployment processes, security enforcement, and operational visibility across the distributed container ecosystem.

---

# 🖥️ **2. Technical Specifications**

## **2.1 Virtual Machine Configuration**

The Portainer master node is configured with resources to support management operations and the Portainer web interface, with emphasis on reliability and security rather than high-volume processing.

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-port01.beardinthe.cloud |
| **VM ID** | 1008 |
| **vCPU** | 2 vCPUs |
| **RAM** | 4 GB |
| **Storage** | 32 GB (OS) + 100 GB (Portainer Data) |
| **OS** | Ubuntu 24.04 LTS |
| **Networking** | VLAN10 (Infrastructure) |
| **IP Address** | 10.25.10.16/24 |
| **Gateway** | 10.25.10.1 |
| **DNS** | 10.25.10.3, 10.25.20.3 |

## **2.2 Physical Node Placement**

The VM is hosted on a specific physical Proxmox node to ensure adequate resources and performance.

| **Attribute** | **Value** |
|--------------|-----------|
| **Proxmox Node** | node01 |
| **Resource Pool** | control-plane |
| **VM Location** | local-lvm |
| **Backup Schedule** | Daily at 01:00 |
| **Migration Policy** | Allowed with constraints |

---

# 📦 **3. Portainer Infrastructure**

## **3.1 Docker Configuration**

The Docker daemon is configured specifically for the Portainer master role, with appropriate security and networking configurations.

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3"
  },
  "default-address-pools": [
    {
      "base": "172.20.0.0/16",
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

The storage is designed to maintain CIS compliance while providing adequate space for Portainer operational data. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 100 GB | Docker data directory (moved from default location) |
| **/data/portainer** | Part of Docker volume | Portainer application data |
| **/data/deployments** | Part of Docker volume | Stack definitions and templates |

## **3.3 Portainer Components**

The master node hosts the core Portainer services that enable centralized management of the container ecosystem.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **portainer** | Main Portainer server | 9000, 8000 |
| **portainer-agent** | Local agent for self-management | 9001 |
| **cadvisor** | Container metric collection | 8080 |
| **nginx** | Reverse proxy for web interface | 80, 443 |

---

# 🌐 **4. Managed Environment**

## **4.1 Managed Worker Nodes**

The Portainer master manages multiple worker nodes, each with specific roles in the infrastructure.

| **Node** | **Role** | **Container Types** | **Network** |
|----------|---------|-------------------|------------|
| **lab-apps01** | Application Services | Wiki.js, GLPI, Gitea, etc. | VLAN10 |
| **lab-db01** | Database Services | PostgreSQL, MariaDB, MongoDB, etc. | VLAN10 |
| **proj-apps01** | Project Services | Project-specific applications | VLAN20 |

## **4.2 Network Configuration**

Portainer's networking is configured to enable secure communication between the master and worker nodes while providing appropriate isolation.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **portainer-network** | 172.20.0.0/24 | Portainer internal services |
| **agent-network** | 172.20.1.0/24 | Secure agent communication |
| **proxy-network** | 172.20.2.0/24 | Web proxy services |

## **4.3 Deployment Capabilities**

The Portainer master provides standardized methods for deploying containerized workloads across the managed nodes.

| **Method** | **Use Case** | **Primary Users** |
|------------|------------|------------------|
| **Stack Deployments** | Multi-container applications | DevOps, Engineers |
| **Web Editor** | Quick container configuration | Administrators |
| **Git Integration** | Version-controlled deployments | DevOps, Engineers |
| **Templates** | Standardized application deployment | All users |

---

# 🔐 **5. Security & Compliance**

## **5.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect against unauthorized access to container management functions.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|------------------------|
| **OS Hardening** | CIS Ubuntu 24.04 Level 2 | Lynis scans, CIS-CAT Pro |
| **Container Security** | AppArmor profiles | Profile validation |
| **Network Security** | TLS encryption | Certificate validation |
| **Authentication** | Entra ID integration | Access logs |
| **API Security** | Rate limiting, IP restrictions | Access logs |
| **Security Scanning** | Daily vulnerability scans | Scan reports |

## **5.2 Role-Based Access Control**

Portainer's access control system provides granular permissions based on user roles and team assignments.

| **Role** | **Access Level** | **Authentication Method** |
|----------|----------------|---------------------------|
| **Administrator** | Full system access | Entra ID + MFA |
| **DevOps Engineer** | Create/manage stacks | Entra ID + MFA |
| **Developer** | View-only access | Entra ID + MFA |
| **Monitoring** | Stats and logs only | Entra ID + MFA |

## **5.3 CISv8.1 Compliance Mapping**

This subsection explicitly maps implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.1.1** | Hardware inventory in GLPI | CMDB record #1008 | Compliant |
| **CIS.4.1** | Secure configuration baseline | Ansible playbooks | Compliant |
| **CIS.5.1** | AD-integrated authentication | Access logs | Compliant |
| **CIS.8.2** | Audit logging enabled | Loki logs | Compliant |
| **CIS.10.1** | ClamAV, AppArmor | Daily scan reports | Compliant |

---

# 💾 **6. Backup & Recovery**

## **6.1 Backup Strategy**

Backup approaches focus on preserving both Portainer configuration data and deployment definitions.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Portainer Configuration** | Volume backup to S3 | Daily | 30 days |
| **Stack Definitions** | Git repositories | Real-time | Unlimited |
| **Container Templates** | Export to S3 | Weekly | 12 weeks |
| **Full VM Backup** | Proxmox Backup Server | Weekly | 4 backups |

## **6.2 Recovery Procedure**

A structured recovery process ensures the Portainer environment can be restored with minimal disruption.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| **Container Failure** | 15 min | 0 min | Restart container | Infrastructure Engineer |
| **Portainer Data Corruption** | 30 min | 24 hours | Restore volume from backup | Infrastructure Engineer |
| **Stack Definition Loss** | 15 min | 0 min | Deploy from Git repository | DevOps Engineer |
| **VM Failure** | 2 hours | 24 hours | Restore VM from PBS | Infrastructure Engineer |
| **Node Failure** | 4 hours | 24 hours | Migrate to alternative node | Infrastructure Engineer |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

---

# 📊 **7. Monitoring & Management**

## **7.1 Health Checks**

Multiple monitoring approaches ensure the health and security of the Portainer control plane.

| **Monitoring System** | **Components Monitored** | **Dashboard** |
|----------------------|--------------------------|--------------|
| **Prometheus** | Host metrics, container metrics | [Node Exporter Dashboard](/monitoring/grafana/dashboards/node-exporter-full-dashboard-screenshot.png) |
| **Loki** | Container logs, OS logs | [Log Dashboard](/docs/applications/observability/loki/log-dashboard.md) |
| **cAdvisor** | Container performance | [cAdvisor Dashboard](/monitoring/grafana/dashboards/cadvisor-docker-insights-dashboard-screenshot.png) |
| **Blackbox Exporter** | API responsiveness | [API Dashboard](/docs/applications/observability/blackbox-exporter.md) |
| **Wazuh** | Security events, file integrity | [Security Dashboard](/docs/applications/security/wazuh/security-dashboard.md) |

## **7.2 Alert Thresholds**

Targeted alerts ensure proactive response to potential issues in the container management environment.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 60% for 5 minutes | 80% for 3 minutes |
| **Memory Usage** | 70% for 5 minutes | 85% for 3 minutes |
| **Disk Usage** | 70% | 85% |
| **Agent Disconnect** | 2 minutes | 5 minutes |
| **Failed Deployments** | 1 in 24 hours | 3 in 24 hours |
| **Authentication Failures** | 3 in 15 minutes | 5 in 5 minutes |

## **7.3 Maintenance Schedule**

The Portainer master follows the lab's rotating maintenance schedule with special consideration for minimizing impact on container deployments.

| **Maintenance Type** | **Schedule** | **Notification** | **Procedure Document** |
|----------------------|-------------|-----------------|------------------------|
| **OS Updates** | Weekly (Sundays 00:00-02:00) | 48 hours | [OS Update Procedure](/docs/infrastructure/maintenance/os-update-procedure.md) |
| **Security Patches** | As needed | 24 hours (standard)/None (critical) | [Security Patching Procedure](/docs/infrastructure/maintenance/security-patching.md) |
| **Docker Updates** | Monthly (First Saturday) | 72 hours | [Docker Update Procedure](/docs/infrastructure/maintenance/docker-update-procedure.md) |
| **Portainer Updates** | Quarterly | 1 week | [Portainer Update Procedure](/docs/infrastructure/maintenance/portainer-update-procedure.md) |

---

# 🔍 **8. Troubleshooting**

## **8.1 Common Issues**

Common Portainer issues are documented with standard resolution paths to speed recovery and reduce downtime.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Agent Disconnect** | Verify agent container status | Check network connectivity |
| **Deployment Failure** | Review stack logs | Validate stack file syntax |
| **Authentication Issues** | Check Entra ID connectivity | Verify user role assignments |
| **Performance Degradation** | Check resource utilization | Review container logs |
| **Web Interface Errors** | Check NGINX configuration | Verify Portainer container health |

## **8.2 Diagnostic Commands**

These commands assist in diagnosing and resolving common issues with the Portainer environment.

```bash
# Check Portainer container status
docker ps -a | grep portainer

# View Portainer logs
docker logs portainer

# Check agent connectivity
curl -k https://10.25.10.17:9001/ping

# Verify NGINX configuration
docker exec nginx nginx -t

# Check Portainer resource usage
docker stats portainer
```

---

# 🔗 **9. Directory Contents**

This section provides direct navigation to all subdirectories and key documents related to this node:

## **9.1 Related Documentation**

| **Document Type** | **Document Name** | **Location** |
|-------------------|-------------------|-------------|
| **Service Document** | Lab-Port01 ITIL Service Doc | [Service Documentation](/docs/control-plane/services/lab-port01-service-documentation.md) |
| **User Guide** | Portainer User Guide | [Portainer User Guide](/docs/applications/containerized-services/portainer/user-guide.md) |
| **Deployment Standards** | Container Deployment Standards | [Deployment Standards](/docs/applications/containerized-services/deployment-standards.md) |
| **Architecture Document** | Container Orchestration Architecture | [Architecture Document](/docs/infrastructure/container-orchestration-architecture.md) |

## **9.2 Related GLPI Items**

ITSM system references for this service:

| **Item Type** | **ID** | **Name** | **Relationship** |
|--------------|-------|----------|-----------------|
| **CI** | CI-1008 | lab-port01 | Primary configuration item |
| **Service** | SVC-102 | Container Orchestration | Delivered service |
| **KB Article** | KB-304 | Portainer Troubleshooting | Support documentation |
| **Change Template** | CHG-PORT-01 | Portainer Maintenance | Change template |

---

# 🔄 **10. Related Infrastructure**

| **Component** | **Relationship** | **Documentation** |
|--------------|----------------|-------------------|
| **lab-apps01** | Managed worker node | [lab-apps01](/infrastructure/control-plane/lab-apps01-docker-application-node.md) |
| **lab-db01** | Managed worker node | [lab-db01](/infrastructure/control-plane/lab-db01-docker-database-node.md) |
| **proj-apps01** | Managed worker node | [proj-apps01](/infrastructure/projects/proj-apps01-docker-application-node.md) |
| **node01** | Hosts this VM | [node01](/infrastructure/proxmox/node01-proxmox-compute.md) |

---

# ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

---

# 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

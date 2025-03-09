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

# **Lab-Port01 Portainer Master Control Node**

Lab-Port01 serves as the **central management and orchestration platform** for all containerized workloads in the Proxmox Astronomy Lab. As the **Portainer master node**, it provides a unified control interface for deploying, monitoring, and managing Docker containers across multiple worker nodes, including lab-apps01, lab-db01, and proj-apps01.

This node plays a crucial role in the lab's containerization strategy, enabling standardized deployment processes, security enforcement, and operational visibility across the distributed container ecosystem.

## **1. Technical Specifications**

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

## **2. Portainer Infrastructure**

The Portainer environment is configured to provide centralized control over Docker resources across multiple nodes, with emphasis on security, role-based access, and standardized deployments.

### **2.1 Docker Configuration**

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

### **2.2 Storage Configuration**

The storage is designed to maintain CIS compliance while providing adequate space for Portainer operational data. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 100 GB | Docker data directory (moved from default location) |
| **/data/portainer** | Part of Docker volume | Portainer application data |
| **/data/deployments** | Part of Docker volume | Stack definitions and templates |

## **3. Portainer Environment**

The Portainer environment consists of the master node (lab-port01) and multiple worker nodes distributed across different segments of the lab infrastructure.

### **3.1 Portainer Components**

The master node hosts the core Portainer services that enable centralized management of the container ecosystem.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **portainer** | Main Portainer server | 9000, 8000 |
| **portainer-agent** | Local agent for self-management | 9001 |
| **cadvisor** | Container metric collection | 8080 |
| **nginx** | Reverse proxy for web interface | 80, 443 |

### **3.2 Managed Worker Nodes**

The Portainer master manages multiple worker nodes, each with specific roles in the infrastructure.

| **Node** | **Role** | **Container Types** | **Network** |
|----------|---------|-------------------|------------|
| **lab-apps01** | Application Services | Wiki.js, GLPI, Gitea, etc. | VLAN10 |
| **lab-db01** | Database Services | PostgreSQL, MariaDB, MongoDB, etc. | VLAN10 |
| **proj-apps01** | Project Services | Project-specific applications | VLAN20 |

### **3.3 Network Configuration**

Portainer's networking is configured to enable secure communication between the master and worker nodes while providing appropriate isolation.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **portainer-network** | 172.20.0.0/24 | Portainer internal services |
| **agent-network** | 172.20.1.0/24 | Secure agent communication |
| **proxy-network** | 172.20.2.0/24 | Web proxy services |

## **4. Security & Access Control**

As a critical control plane component, the Portainer master implements comprehensive security measures to protect management functions while enabling authorized access.

### **4.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect against unauthorized access to container management functions.

- **CIS Ubuntu 24.04 Level 2** compliance for base OS
- **TLS encryption** for all Portainer communications
- **Web interface protected** by Entra ID authentication
- **Agent communication secured** with mutual TLS
- **API access restricted** to authorized services
- **Regular security scanning** via integrated tools

### **4.2 Role-Based Access Control**

Portainer's access control system provides granular permissions based on user roles and team assignments.

| **Role** | **Access Level** | **Authentication Method** |
|----------|----------------|---------------------------|
| **Administrator** | Full system access | Entra ID + MFA |
| **DevOps Engineer** | Create/manage stacks | Entra ID + MFA |
| **Developer** | View-only access | Entra ID + MFA |
| **Monitoring** | Stats and logs only | Entra ID + MFA |

## **5. Deployment Capabilities**

The Portainer master provides standardized methods for deploying containerized workloads across the managed nodes.

### **5.1 Deployment Methods**

Multiple deployment approaches are supported to accommodate different operational needs.

| **Method** | **Use Case** | **Primary Users** |
|------------|------------|------------------|
| **Stack Deployments** | Multi-container applications | DevOps, Engineers |
| **Web Editor** | Quick container configuration | Administrators |
| **Git Integration** | Version-controlled deployments | DevOps, Engineers |
| **Templates** | Standardized application deployment | All users |

### **5.2 Stack Deployment Strategy**

Standardized stack deployments ensure consistency and proper configuration across the container ecosystem.

- **Stack files stored** in Git repositories for version control
- **Environment variables** used for configuration differences between environments
- **Deployment validation** performed before application
- **Rollback capability** maintained for all deployments
- **Standard labels** applied for monitoring and management

## **6. Backup & Disaster Recovery**

The Portainer master node implements comprehensive backup strategies to ensure recoverability of the container management environment.

### **6.1 Backup Strategy**

Backup approaches focus on preserving both Portainer configuration data and deployment definitions.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Portainer Configuration** | Volume backup to S3 | Daily | 30 days |
| **Stack Definitions** | Git repositories | Real-time | Unlimited |
| **Container Templates** | Export to S3 | Weekly | 12 weeks |
| **Full VM Backup** | Proxmox Backup Server | Weekly | 4 backups |

### **6.2 Recovery Procedure**

A structured recovery process ensures the Portainer environment can be restored with minimal disruption.

1. **Restore VM** from Proxmox Backup Server if needed
2. **Verify Docker installation** and configuration
3. **Restore Portainer data volume** from backup
4. **Launch Portainer container** with restored volume
5. **Verify agent connections** to all worker nodes
6. **Validate access control** and user permissions
7. **Test deployment functionality** with sample stack

## **7. Monitoring & Alerting**

Comprehensive monitoring ensures the Portainer management environment remains operational and secure.

### **7.1 Health Checks**

Multiple monitoring approaches ensure the health and security of the Portainer control plane.

- **Portainer service status** monitoring
- **Agent connectivity** checks for all worker nodes
- **API responsiveness** metrics
- **Authentication event** logging and alerting
- **Deployment success/failure** tracking
- **Resource utilization** monitoring

### **7.2 Alert Thresholds**

Targeted alerts ensure proactive response to potential issues in the container management environment.

| **Metric** | **Warning Threshold** | **Critical Threshold** |
|------------|----------------------|------------------------|
| **CPU Usage** | 60% for 5 minutes | 80% for 3 minutes |
| **Memory Usage** | 70% for 5 minutes | 85% for 3 minutes |
| **Disk Usage** | 70% | 85% |
| **Agent Disconnect** | 2 minutes | 5 minutes |
| **Failed Deployments** | 1 in 24 hours | 3 in 24 hours |
| **Authentication Failures** | 3 in 15 minutes | 5 in 5 minutes |

## **8. Management & Operations**

Structured operational procedures ensure stable and predictable management of the Portainer environment.

### **8.1 Maintenance Schedule**

The Portainer master follows the lab's rotating maintenance schedule with special consideration for minimizing impact on container deployments.

- **OS Updates**: Weekly on predefined maintenance windows
- **Security Patches**: Applied as needed with priority
- **Docker Updates**: Evaluated monthly
- **Portainer Updates**: Version upgrades scheduled quarterly
- **Template Updates**: Reviewed monthly

VMs are updated and rebooted weekly on a rotating schedule to avoid service downtimes, with control plane components like lab-port01 scheduled at times of minimal deployment activity.

### **8.2 Update Procedure**

Updates follow a standardized process with special considerations for maintaining container orchestration capabilities.

1. **Review change documentation** in GLPI
2. **Notify all users** of planned maintenance
3. **Backup Portainer data** before updates
4. **Update components** in sequence:
   - OS updates first
   - Docker updates if needed
   - Portainer updates last
5. **Verify functionality** post-update:
   - Agent connectivity
   - User authentication
   - Deployment capability
6. **Update documentation** with any changes

### **8.3 Troubleshooting Quick Reference**

Common Portainer issues are documented with standard resolution paths to speed recovery and reduce downtime.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Agent Disconnect** | Verify agent container status | Check network connectivity |
| **Deployment Failure** | Review stack logs | Validate stack file syntax |
| **Authentication Issues** | Check Entra ID connectivity | Verify user role assignments |
| **Performance Degradation** | Check resource utilization | Review container logs |
| **Web Interface Errors** | Check NGINX configuration | Verify Portainer container health |

## **9. Documentation References**

Additional resources provide detailed information on Portainer implementation and operational practices.

| **Document** | **Purpose** | **Location** |
|-------------|------------|-------------|
| **Service Documentation** | ITIL-aligned service document | [Lab-Port01 Service Documentation](../../../applications-services/lab-port01-portainer-master-control-node.md) |
| **Portainer User Guide** | Staff usage instructions | [Portainer User Guide](../../../infrastructure/portainer/user-guide.md) |
| **Deployment Standards** | Stack deployment guidelines | [Container Deployment Standards](../../../infrastructure/portainer/deployment-standards.md) |

## **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ✅ Approved |

## **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |
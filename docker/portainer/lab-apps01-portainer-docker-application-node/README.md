<!-- ---
title: "Lab-Apps01 Portainer Docker Application Node"
description: "Documentation for the Lab-Apps01 Portainer worker node, detailing its role in hosting lab-wide applications and containerized services."
author: "VintageDon"
tags: ["portainer", "docker", "infrastructure", "applications", "microservices"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---
 -->

# **Lab-Apps01 Portainer Docker Application Node**

Lab-Apps01 is a **Portainer worker node** that hosts **lab-wide applications and containerized services** for the Proxmox Astronomy Lab. Managed by **Lab-Port01** (Portainer master node), it runs **Docker on Ubuntu 24.04**, serving as the **primary application hosting platform** for **lab infrastructure services**.

The node hosts critical lab-level services including documentation systems, ITIL-aligned service management, and identity management, providing the core infrastructure needed to support research operations and system administration.

## **1. Technical Specifications**

This VM provides a dedicated environment for running containerized applications with sufficient resources to handle multiple concurrent services and their associated data volumes.

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-apps01.beardinthe.cloud |
| **VM ID** | 2006 |
| **vCPU** | 4 vCPUs |
| **RAM** | 16 GB |
| **Storage** | 32 GB (OS) + 250 GB (Container Storage) |
| **OS** | Ubuntu 24.04 LTS |
| **Networking** | VLAN10 (Infrastructure) |
| **IP Address** | 10.25.10.18/24 |
| **Gateway** | 10.25.10.1 |
| **DNS** | 10.25.10.3, 10.25.20.3 |

## **2. Docker Infrastructure**

The Docker environment is configured for optimal performance and security, with dedicated storage that complies with CIS security guidelines while providing ample space for containerized applications.

### **2.1 Docker Configuration**

The Docker daemon is configured with performance and security optimizations to support multiple containerized services while maintaining proper logging and resource isolation.

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3"
  },
  "default-address-pools": [
    {
      "base": "172.18.0.0/16",
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

The storage is designed to maintain CIS compliance while providing adequate space for Docker operations. The OS drive is partitioned according to CIS compliance requirements, with Docker data relocated to a separate volume.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|-------------|
| **/mnt/docker** | 250 GB | Docker data directory (moved from default location) |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/backup/containers** | Part of OS volume | Container configuration backups |

## **3. Hosted Applications**

Lab-Apps01 serves as the central platform for lab infrastructure applications that support documentation, service management, and identity systems based on the Phase 3 deployment plan.

### **3.1 Source Control and Documentation**

The node hosts documentation and source control systems that serve as the foundation for collaborative work and knowledge management across the lab environment.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **gitea** | Git repository management | 3000, 22 |
| **wikijs** | Documentation platform | 3001 |

### **3.2 Infrastructure Services**

Core infrastructure services provide the foundation for lab operations, including service management, identity, and security systems that enable secure and organized workflows.

| **Container** | **Purpose** | **Port** |
|--------------|-------------|---------|
| **glpi** | ITIL-aligned ticketing system | 80 |
| **vault** | Secrets management | 8200 |
| **zitadel** | Identity & Access Management (IAM) | 8080 |
| **nginx-proxy-manager** | Reverse proxy & SSL management | 81, 443 |
| **portainer-agent** | Portainer management | 9001 |
| **homer** | Service dashboard | 8081 |
| **minio-console** | S3 storage management | 9090 |

### **3.3 Network Configuration**

Docker networks are segmented to isolate different types of services, enhancing security and reducing the impact of potential issues across container groups.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **proxy-network** | 172.18.0.0/24 | NGINX Proxy Manager & web services |
| **app-network** | 172.18.1.0/24 | Application-specific containers |
| **management-network** | 172.18.2.0/24 | Infrastructure management |

## **4. Security & Compliance**

Security is a primary concern for infrastructure services, with multiple layers of protection implemented from the OS through to the container level.

### **4.1 Security Hardening**

The VM implements comprehensive security measures at both the OS and container levels to protect against common vulnerabilities and ensure compliance with security standards.

- **CIS Ubuntu 24.04 Level 2** compliance for base OS
- **AppArmor profiles** for container isolation
- **Rootless container execution** where possible
- **Limited capabilities** following principle of least privilege
- **No privileged containers** except when required
- **Regular security scanning** via integrated tools

### **4.2 Access Control**

Access to the system and its services is strictly controlled through multiple authentication and authorization mechanisms, ensuring only authorized personnel can access or modify critical infrastructure.

| **Access Method** | **Authentication** | **Authorization** |
|-------------------|-------------------|------------------|
| **Docker API** | TLS certificates | Restricted to Portainer |
| **Portainer Agent** | API key | Restricted to Lab-Port01 |
| **SSH Access** | Entra ID | Admin group only |
| **Container Services** | Zitadel | Role-based |

## **5. Backup & Disaster Recovery**

A comprehensive backup strategy ensures data integrity and swift recovery capabilities for all hosted services, with redundant methods for critical data.

### **5.1 Backup Strategy**

Multiple backup methods are employed to ensure data integrity and recovery options for different types of container data and configurations.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Container Configs** | Git + Automated Export | Daily | 30 days |
| **Docker Volumes** | Proxmox Backup Server | Daily | 7 days |
| **Database Volumes** | Dedicated backup containers | Hourly | 48 hours |
| **Full VM Backup** | Proxmox Backup Server | Weekly | 4 backups |

### **5.2 Recovery Procedure**

A structured recovery process ensures rapid restoration of services in the event of failures, with clear steps for different recovery scenarios.

1. **Restore VM** from Proxmox Backup Server
2. **Verify Docker installation** and configuration
3. **Reconnect Portainer Agent** to Lab-Port01
4. **Restore volumes** from backup if needed
5. **Deploy containers** via Portainer stacks
6. **Verify application functionality**

## **6. Monitoring & Alerting**

Comprehensive monitoring ensures early detection of potential issues and maintains optimal performance across all hosted services.

### **6.1 Health Checks**

Multiple health monitoring mechanisms ensure that both the host system and individual containers are operating correctly, with appropriate alerting when issues arise.

- **Container status** monitoring via Prometheus exporters
- **Host resource usage** alerts (CPU, RAM, Disk)
- **Service-specific health checks** via HTTP/TCP probes
- **Docker daemon status** monitoring
- **Certificate expiration** tracking
- **Backup success/failure** monitoring

### **6.2 Alert Thresholds**

Clearly defined thresholds trigger appropriate alerts, enabling proactive management before issues become critical.

| **Component** | **Warning Threshold** | **Critical Threshold** |
|--------------|----------------------|------------------------|
| **CPU Usage** | 75% for 5 minutes | 90% for 3 minutes |
| **Memory Usage** | 80% for 5 minutes | 90% for 3 minutes |
| **Disk Usage** | 75% | 90% |
| **Container Restarts** | 3 in 15 minutes | 5 in 5 minutes |

## **7. Management & Operations**

Structured operational procedures ensure stable and predictable management of the system throughout its lifecycle.

### **7.1 Maintenance Schedule**

VM maintenance follows the lab's rotating schedule to minimize service disruption, with planned updates occurring during predetermined windows to reduce impact on operations.

- **OS Updates**: Weekly on predefined maintenance windows
- **Security Patches**: Applied as needed with priority
- **Docker Updates**: Evaluated monthly
- **Application Updates**: According to change management process

VMs are updated and rebooted weekly on a rotating schedule to avoid service downtimes, with infrastructure components like lab-apps01 included in appropriate rotation groups.

### **7.2 Update Procedure**

Updates follow a standardized process to ensure changes are properly documented, tested, and implemented with minimal risk to operational services.

1. **Review change documentation** in GLPI
2. **Create maintenance window** notification
3. **Export current container configurations**
4. **Update Docker Engine** if required
5. **Update container images** via Portainer
6. **Verify application functionality**
7. **Update documentation** with any changes

### **7.3 Troubleshooting Quick Reference**

Common issues are documented with standard resolution paths to speed recovery and reduce downtime during incidents.

| **Problem** | **First Response** | **Second Response** |
|------------|-------------------|---------------------|
| **Container Exit** | Check container logs | Inspect resource limits |
| **Network Issue** | Verify Docker networks | Check NGINX Proxy Manager configuration |
| **Storage Issue** | Check available space | Inspect volume mounts |
| **Resource Contention** | Identify high-usage containers | Adjust resource limits |

## **8. Documentation References**

Additional resources provide detailed information on specific aspects of the system and its components.

| **Document** | **Purpose** | **Location** |
|-------------|------------|-------------|
| **Service Documentation** | ITIL-aligned service document | [Lab-Apps01 Service Documentation](../../../applications-services/lab-apps01-docker-application-node.md) |
| **Portainer User Guide** | Official documentation | [Portainer Documentation](https://docs.portainer.io/) |
| **Docker Best Practices** | Security & performance guidelines | [Internal Docker Guidelines](../docker-best-practices.md) |

## **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |

## **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial documentation | VintageDon |


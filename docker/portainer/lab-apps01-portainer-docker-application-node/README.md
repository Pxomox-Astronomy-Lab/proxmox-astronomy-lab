<!-- 
---
title: "Lab-Apps01 Portainer Docker Application Node"
description: "Documentation for the Lab-Apps01 Portainer worker node, detailing containerized applications and services deployed through the Portainer management interface."
author: "VintageDon"
tags: ["portainer", "docker", "containers", "infrastructure", "applications"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Draft"
last_updated: "2025-04-04"
related_services: ["Docker", "Portainer", "Infrastructure Services"]
---
-->

# 📦 **Lab-Apps01 Portainer Docker Application Node**

# 🔍 **1. Overview**

The Lab-Apps01 node serves as a dedicated Portainer worker node within the Proxmox Astronomy Lab environment, hosting containerized applications and services that support lab-wide operations. This node is managed by the Portainer control plane running on Lab-Port01 and provides containerized services like documentation systems, identity management, and key infrastructure applications.

Lab-Apps01 is a Ubuntu 24.04 virtual machine with dedicated storage volumes for container data, configured according to CIS security standards while providing adequate performance for service hosting. Its purpose is to centralize non-research applications that support lab operations and management functions.

---

# 🐳 **2. Docker Configuration**

## **2.1 Technical Specifications**

Lab-Apps01 is provisioned with adequate resources to support multiple containerized applications with consistent performance.

| **Component** | **Specification** |
|--------------|-------------------|
| **Hostname** | lab-apps01.beardinthe.cloud |
| **VM ID** | 2006 |
| **vCPU** | 4 vCPUs |
| **RAM** | 16 GB |
| **Storage** | 32 GB (OS) + 250 GB (Container Volume) |
| **OS** | Ubuntu 24.04 LTS with CIS L2 hardening |
| **IP Address** | 10.25.10.18/24 |
| **Networking** | VLAN10 (Infrastructure) |

## **2.2 Container Storage**

Docker storage is configured with performance and security in mind, following infrastructure best practices.

| **Mount Point** | **Size** | **Purpose** |
|----------------|---------|------------|
| **/mnt/docker** | 250 GB | Main Docker data volume |
| **/var/lib/portainer** | Part of OS volume | Portainer agent data |
| **/backup/containers** | Part of OS volume | Container configuration backups |

Docker is configured to use the overlay2 storage driver with a relocated data root to the dedicated volume, ensuring optimal performance and separation from the OS volume.

---

# 🚢 **3. Deployed Applications**

## **3.1 Infrastructure Services**

Lab-Apps01 hosts critical infrastructure services that support overall lab operations and management.

| **Container** | **Purpose** | **Access URL** | **Documentation** |
|--------------|-------------|----------------|-------------------|
| **gitea** | Git repository and version control | https://git.lab.local | [Gitea Documentation](/docs/Applications/Version-Control/Gitea/Lab-Gitea.md) |
| **wikijs** | Documentation and knowledge management | https://wiki.lab.local | [Wiki.js Documentation](/docs/Applications/Documentation/WikiJS/README.md) |
| **glpi** | ITIL-aligned service desk and asset management | https://helpdesk.lab.local | [GLPI Documentation](/docs/Applications/ITSM/GLPI/README.md) |
| **zitadel** | Identity and access management | https://id.lab.local | [Zitadel Documentation](/docs/Applications/Identity/Zitadel/README.md) |

## **3.2 Network Configuration**

Container networks are segregated to provide appropriate isolation and security boundaries.

| **Network Name** | **Subnet** | **Purpose** |
|-----------------|-----------|------------|
| **proxy-network** | 172.18.0.0/24 | NGINX Proxy Manager connectivity |
| **app-network** | 172.18.1.0/24 | Application service containers |
| **management-network** | 172.18.2.0/24 | Infrastructure management containers |

---

# 📊 **4. Monitoring & Management**

## **4.1 Health Monitoring**

Lab-Apps01 is monitored through multiple observability systems to ensure service availability and performance.

| **Component** | **Monitoring Method** | **Dashboard** |
|--------------|----------------------|--------------| 
| **Host Metrics** | Prometheus Node Exporter | [Node Metrics Dashboard](https://grafana.lab.local/d/node-metrics) |
| **Container Metrics** | cAdvisor | [Container Dashboard](https://grafana.lab.local/d/container-metrics) |
| **Application Logs** | Loki with Promtail | [Application Logs Dashboard](https://grafana.lab.local/d/application-logs) |
| **Service Health** | Prometheus Blackbox Exporter | [Service Health Dashboard](https://grafana.lab.local/d/service-health) |

## **4.2 Backup Strategy**

Consistent backup procedures ensure data integrity and service recoverability.

| **Component** | **Backup Method** | **Schedule** | **Retention** |
|--------------|-------------------|-------------|--------------|
| **Container Configs** | Git repository + automated export | Daily | 30 days |
| **Persistent Volumes** | Proxmox Backup Server (PBS) | Daily | 7 days |
| **Database Volumes** | Dedicated database backup containers | Hourly | 48 hours |
| **VM-level Backup** | Proxmox Backup Server (PBS) | Weekly | 4 backups |

---

# 🔒 **5. Security & Compliance**

This section documents security measures implemented on the Lab-Apps01 node to ensure appropriate protection of containerized services.

## **5.1 Security Hardening**

Multiple security layers protect the container environment and hosted applications.

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|--------------------------|
| **Container Isolation** | Non-privileged containers with dropped capabilities | Portainer container inspection |
| **Host Hardening** | CIS Level 2 compliance for Ubuntu 24.04 | Weekly compliance scans |
| **Network Security** | Container network segmentation and access controls | Network ACL verification |
| **Secrets Management** | Docker secrets and external vault integration | Secret rotation verification |

## **5.2 Access Control**

Access to the node and its containerized applications is carefully controlled to maintain security.

| **Access Method** | **Authentication** | **Authorization** |
|-------------------|-------------------|------------------|
| **SSH Access** | Entra ID with MFA | Infrastructure admin group membership |
| **Portainer Management** | Portainer agent + control plane auth | Role-based access control |
| **Container Services** | OIDC with Zitadel | Service-specific RBAC |

---

# 🔗 **6. Directory Contents**

This section provides direct navigation to related resources and documentation:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Lab-Apps01 VM Documentation** | Virtual machine configuration details | [lab-apps01.md](/infrastructure/control-plane/lab-apps01-docker-application-node.md) |
| **Portainer Stacks** | Container deployment configurations | [Portainer Stacks](/docker/portainer-stacks/lab-apps01-portainer-docker-application-node/README.md) |

---

# 🔄 **7. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Portainer Control Node** | Management master for this worker | [Lab-Port01](/docker/portainer/lab-port01-portainer-master-control-node/README.md) |
| **Docker Configuration** | Base containerization platform | [Docker Documentation](/wiki/docker/README.md) |
| **Application Services** | Detailed application documentation | [Applications Documentation](/docs/Applications/README.md) |

---

# ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ⏳ In Progress |

---

# 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial documentation | VintageDon |

---
title: "Project Infrastructure - Proxmox Astronomy Lab"
description: "Documentation of project-specific virtual machines, services, and workloads supporting the research and application infrastructure of the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["infrastructure", "projects", "virtual-machines", "postgres", "timescale", "vdi", "docker"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---

# **Project Infrastructure - Proxmox Astronomy Lab**

## **1. Overview**

This section documents the **project-specific infrastructure components** that support the Proxmox Astronomy Lab's research and applications. Unlike the core infrastructure components that provide foundational services, these project VMs are dedicated to specific research workloads, data processing pipelines, and user-facing services.

The project infrastructure layer consists of **specialized virtual machines** that handle **database storage, geospatial analysis, time-series processing, application hosting, virtual desktop infrastructure, and shared file services**. These components collectively enable the lab's scientific research capabilities while providing the necessary interfaces for both internal and external collaborators.

### **1.1 Infrastructure Purpose**

The project infrastructure serves several key purposes within the lab's overall architecture:

- **Research Data Storage** - Specialized database systems for various data types and query patterns
- **User Access Environments** - Virtual desktop and workspaces for secure lab access
- **Research Application Hosting** - Containerized environments for scientific applications
- **Shared Resource Management** - File shares and collaborative tools
- **Time-Series Data Processing** - Optimized environments for temporal data analysis

### **1.2 Deployment Strategy**

Project infrastructure is deployed following core principles:

- **Resource Isolation** - Each project component runs in its own VM for security and resource management
- **Consistent Hardening** - All VMs follow CISv8 Level 2 hardening standards (Ubuntu) or CISv9 Level 1 (Windows)
- **Configuration Management** - All configurations are version-controlled and applied via Ansible
- **High Availability** - Critical services are configured with appropriate backup and recovery mechanisms
- **Performance Optimization** - VMs are sized and tuned for their specific workloads

---

## **2. Database Infrastructure**

The database infrastructure provides specialized data storage and processing capabilities for different research needs, from relational data to geospatial and time-series analysis.

### **2.1 PostgreSQL Database Server (proj-pg01)**

This VM provides the primary **PostgreSQL database service** for the lab, hosting structured research data, user authentication databases, and application data.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-pg01.beardinthe.cloud |
| **VM Configuration** | 4 vCPU, 16GB RAM, 32GB OS disk, 500GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 L2) |
| **Software** | PostgreSQL 16 |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Daily logical backups, continuous WAL archiving |
| **Primary Functions** | Core relational data storage, authentication databases, metadata repository |
| **Service Dependencies** | Domain authentication (dc01/dc02), Monitoring (lab-mon01) |
| **Documentation** | [PostgreSQL Service Documentation](proj-pg01-postgresql.md) |

### **2.2 PostgreSQL with GIS Extensions (proj-pggis01)**

This specialized PostgreSQL instance focuses on **geospatial data analysis** through PostGIS extensions, enabling spatial querying and mapping capabilities.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-pggis01.beardinthe.cloud |
| **VM Configuration** | 4 vCPU, 16GB RAM, 32GB OS disk, 500GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 L2) |
| **Software** | PostgreSQL 16 with PostGIS 3.4 |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Daily logical backups, continuous WAL archiving |
| **Primary Functions** | Spatial data storage, astronomical coordinate mapping, observation region tracking |
| **Service Dependencies** | Domain authentication (dc01/dc02), Primary PostgreSQL (proj-pg01), Monitoring (lab-mon01) |
| **Documentation** | [PostgreSQL with GIS Service Documentation](proj-pggis01-prostresql-with-gis.md) |

### **2.3 TimescaleDB Server (proj-pgts01)**

This VM hosts **TimescaleDB**, a time-series database built on PostgreSQL, optimized for storing and analyzing time-series data from astronomical observations.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-pgts01.beardinthe.cloud |
| **VM Configuration** | 4 vCPU, 16GB RAM, 32GB OS disk, 500GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 L2) |
| **Software** | TimescaleDB 2.13 (PostgreSQL 16) |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Daily logical backups, continuous WAL archiving |
| **Primary Functions** | Time-series astronomical data storage, signal analysis data, sensor telemetry |
| **Service Dependencies** | Domain authentication (dc01/dc02), Primary PostgreSQL (proj-pg01), Monitoring (lab-mon01) |
| **Documentation** | [TimescaleDB Service Documentation](proj-pgts01-timescale.md) |

---

## **3. User Access Infrastructure**

These components provide secure, controlled access to lab resources for both internal and external users.

### **3.1 Remote Desktop Services (proj-rds01)**

This Windows Server VM provides **Remote Desktop Services** for users requiring Windows-based tools and applications.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-rds01.beardinthe.cloud |
| **VM Configuration** | 4 vCPU, 16GB RAM, 125GB OS disk, 100GB data disk |
| **Operating System** | Windows Server 2025 (CISv9 L1) |
| **Software** | Remote Desktop Services, Office LTSC Professional 2024 |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Daily VM snapshots, application-aware backups |
| **Primary Functions** | Windows desktop environment, Office applications, Windows-specific tools |
| **Service Dependencies** | Domain controllers (dc01/dc02), Entra Private Access, File server (proj-fs01) |
| **Documentation** | [Remote Desktop Services Documentation](proj-rds01-staff-vdi.md) |

### **3.2 Kasm Workspaces (proj-kasm01)**

This VM hosts **Kasm Workspaces**, providing browser-based virtual desktops and application streaming for secure, containerized access to lab resources.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-kasm01.beardinthe.cloud |
| **VM Configuration** | 6 vCPU, 24GB RAM, 150GB OS disk, 250GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 L2) |
| **Software** | Kasm Workspaces 1.14 |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Weekly VM snapshots, configuration backups |
| **Primary Functions** | Browser-based virtual workspaces, containerized application access, secure external collaboration |
| **Service Dependencies** | Domain authentication (dc01/dc02), Entra Private Access, Docker registry |
| **Documentation** | [Kasm Workspaces Documentation](proj-kasm01-kasm-workspaces-vdi-server.md) |

---

## **4. Application & Storage Infrastructure**

These components provide application hosting and shared storage capabilities for the lab's projects.

### **4.1 Docker Application Node (proj-apps01)**

This VM serves as a **Docker host** for containerized applications and services specific to research projects.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-apps01.beardinthe.cloud |
| **VM Configuration** | 4 vCPU, 12GB RAM, 32GB OS disk, 500GB data disk |
| **Operating System** | Ubuntu 24.04 LTS (CISv8 L2) |
| **Software** | Docker 24.x, Portainer Agent |
| **Network** | VLAN20 (Production) |
| **Backup Strategy** | Daily container volume backups, application configuration backups |
| **Primary Functions** | Research application hosting, data processing containers, visualization services |
| **Service Dependencies** | Portainer control (lab-port01), PostgreSQL databases (proj-pg01, proj-pgts01, proj-pggis01), Monitoring (lab-mon01) |
| **Documentation** | [Docker Application Node Documentation](proj-apps01-docker-application-node.md) |

### **4.2 Active Directory File Shares (proj-fs01)**

This Windows Server VM provides **SMB file shares** for documents, research data, and shared resources.

| **Attribute** | **Value** |
|---------------|-----------|
| **Hostname** | proj-fs01.beardinthe.cloud |
| **VM Configuration** | 2 vCPU, 6GB RAM, 32GB OS disk, 250GB data disk |
| **Operating System** | Windows Server 2025 (CISv9 L1) |
| **Software** | Windows File Server role, DFS Replication |
| **Network** | VLAN10 (Infrastructure) |
| **Backup Strategy** | Daily data backups, VSS-aware snapshots |
| **Primary Functions** | Structured file storage, document management, user shares |
| **Service Dependencies** | Domain controllers (dc01/dc02), Monitoring (lab-mon01) |
| **Documentation** | [File Server Documentation](proj-fs01-active-directory-file-shares.md) |

---

## **5. Resource Allocation & Performance**

The project infrastructure VMs are carefully sized and distributed across the physical nodes to ensure optimal performance and resource utilization.

### **5.1 Resource Allocation by Project VM**

| **Virtual Machine** | **vCPU** | **RAM** | **Storage** | **Node Placement** |
|---------------------|----------|---------|-------------|-------------------|
| proj-pg01 | 4 | 16GB | 532GB | node04 |
| proj-pggis01 | 4 | 16GB | 532GB | node04 |
| proj-pgts01 | 4 | 16GB | 532GB | node04 |
| proj-rds01 | 4 | 16GB | 225GB | node04 |
| proj-kasm01 | 6 | 24GB | 400GB | nas01 |
| proj-apps01 | 4 | 12GB | 532GB | node04 |
| proj-fs01 | 2 | 6GB | 282GB | node04 |

### **5.2 Performance Monitoring & Optimization**

Performance of project infrastructure is continuously monitored through the lab's monitoring stack:

- **Resource Utilization** - Tracked via Prometheus and visualized in Grafana dashboards
- **Database Performance** - Monitored via pgstatstatements and custom PostgreSQL exporters
- **Application Metrics** - Collected through containerized Prometheus exporters
- **User Experience** - Tracked through synthetic monitoring and periodic testing

Performance optimization is an ongoing process, with quarterly reviews to identify bottlenecks and improvement opportunities.

---

## **6. Security & Compliance**

All project infrastructure components adhere to strict security and compliance standards.

### **6.1 Security Controls**

| **Control Category** | **Implementation** |
|----------------------|-------------------|
| **Access Control** | Entra ID-based authentication, RBAC permissions, Just-in-time access for administration |
| **Network Security** | VLAN segmentation, Firewall rules, TLS for all communications |
| **System Hardening** | CISv8 Level 2 (Linux VMs), CISv9 Level 1 (Windows VMs) |
| **Monitoring & Detection** | Wazuh agents on all VMs, Centralized logging, Anomaly detection |
| **Patching & Updates** | Monthly patch cycles, Zero-day vulnerability expedited process |

### **6.2 Compliance Status**

| **VM** | **Compliance Standard** | **Last Assessment** | **Status** |
|--------|------------------------|-------------------|------------|
| proj-pg01 | CISv8 L2 | 2025-03-01 | Compliant |
| proj-pggis01 | CISv8 L2 | 2025-03-01 | Compliant |
| proj-pgts01 | CISv8 L2 | 2025-03-01 | Compliant |
| proj-rds01 | CISv9 L1 | 2025-03-01 | Compliant |
| proj-kasm01 | CISv8 L2 | 2025-03-01 | Compliant |
| proj-apps01 | CISv8 L2 | 2025-03-01 | Compliant |
| proj-fs01 | CISv9 L1 | 2025-03-01 | Compliant |

---

## **7. Backup & Disaster Recovery**

Project infrastructure components are protected through a comprehensive backup and recovery strategy.

### **7.1 Backup Approach by VM Type**

| **VM Type** | **Backup Method** | **Frequency** | **Retention** | **Verification** |
|-------------|-------------------|--------------|--------------|------------------|
| **Database Servers** | Logical dumps, WAL archiving, VM snapshots | Daily dumps, Continuous WAL, Weekly snapshots | 7 daily, 4 weekly, 3 monthly | Monthly recovery test |
| **Windows Servers** | VSS-aware backups, File-level backups | Daily | 7 daily, 4 weekly | Quarterly recovery test |
| **Linux Application Servers** | Application config backups, Data volume backups, VM snapshots | Daily | 7 daily, 4 weekly | Quarterly recovery test |

### **7.2 Recovery Time Objectives**

| **Infrastructure Component** | **RTO (Recovery Time Objective)** | **RPO (Recovery Point Objective)** |
|------------------------------|----------------------------------|-----------------------------------|
| Database Servers | 4 hours | 15 minutes (WAL archiving) |
| Application Servers | 2 hours | 24 hours |
| File Servers | 4 hours | 24 hours |
| VDI/Workspace Servers | 8 hours | 24 hours |

---

## **8. Ongoing Development**

The project infrastructure evolves with the lab's research needs. Several initiatives are currently in progress or planned.

### **8.1 Current Development Initiatives**

| **Initiative** | **Description** | **Status** | **Target Completion** |
|----------------|----------------|------------|----------------------|
| **Database High Availability** | Implementing streaming replication for PostgreSQL databases | In progress | Q2 2025 |
| **AI Workloads Expansion** | Additional compute resources for machine learning pipelines | Planning | Q3 2025 |
| **Expanded Visualization Services** | Dedicated VM for advanced data visualization tools | Planning | Q3 2025 |
| **Enhanced External Collaboration** | Additional secure access methods for research partners | In progress | Q2 2025 |

### **8.2 Future Roadmap**

Long-term evolution of the project infrastructure includes:

- **Database scalability improvements** - Potential sharding or read replicas for high-query workloads
- **Multi-cloud expansion** - Extending selected services to cloud providers for redundancy
- **Containerization strategy** - Transitioning more services to containerized deployments
- **Automated scaling** - Implementing dynamic resource allocation for variable workloads

---

## **9. Documentation & References**

### **9.1 Individual VM Documentation**

Each project VM has detailed documentation covering its specific configuration, management procedures, and operational characteristics:

- [PostgreSQL Database Server](proj-pg01-postgresql.md)
- [PostgreSQL with GIS Extensions](proj-pggis01-prostresql-with-gis.md)
- [TimescaleDB Server](proj-pgts01-timescale.md)
- [Remote Desktop Services](proj-rds01-staff-vdi.md)
- [Kasm Workspaces](proj-kasm01-kasm-workspaces-vdi-server.md)
- [Docker Application Node](proj-apps01-docker-application-node.md)
- [Active Directory File Shares](proj-fs01-active-directory-file-shares.md)

### **9.2 Related Documentation**

| **Document** | **Description** | **Location** |
|--------------|----------------|-------------|
| Infrastructure Overview | General infrastructure architecture | [Infrastructure README](../README.md) |
| Network Architecture | Network segmentation and connectivity | [Network Documentation](../networking/README.md) |
| Security Framework | Security controls and compliance approach | [Security Documentation](../../compliance-security/README.md) |
| Operational Procedures | Day-to-day management procedures | [Operations Documentation](../../troubleshooting-procedures/README.md) |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial version | VintageDon |

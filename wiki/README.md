<!--
---
title: "Wiki Knowledge Base"
description: "Comprehensive technical wiki providing operational procedures, how-to guides, and practical implementation documentation for the Proxmox Astronomy Lab enterprise infrastructure and research computing workflows"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4"
date: "2025-07-20"
version: "1.0"
status: "Published"
tags:
- type: [directory-overview/wiki-documentation/knowledge-base]
- domain: [technical-procedures/operational-guides/implementation-docs]
- tech: [proxmox/kubernetes/docker/postgresql/monitoring]
- phase: [phase-2]
related_documents:
- "[Repository Overview](../README.md)"
- "[Documentation Standards](../docs/documentation-standards/README.md)"
- "[Infrastructure Overview](../infrastructure/README.md)"
---
-->

# 📖 **Wiki Knowledge Base**

Comprehensive technical wiki providing operational procedures, how-to guides, and practical implementation documentation for the Proxmox Astronomy Lab enterprise infrastructure and research computing workflows. This knowledge base serves as the primary resource for hands-on technical procedures, troubleshooting guides, and step-by-step implementation documentation across our 7-node hybrid infrastructure.

## **Overview**

The Wiki Knowledge Base provides the practical implementation layer of our documentation architecture, focusing on actionable procedures, technical how-to guides, and operational workflows that enable effective day-to-day management of our enterprise astronomical computing platform. This knowledge base bridges the gap between high-level architectural documentation and practical implementation requirements.

The wiki architecture emphasizes hands-on technical procedures, real-world troubleshooting scenarios, and proven implementation workflows that have been validated in our production environment. This approach ensures research teams and administrators have immediate access to reliable, tested procedures for managing and utilizing our sophisticated hybrid infrastructure.

---

## **📂 Directory Contents**

This section provides systematic navigation to all wiki categories and their comprehensive technical documentation.

### **Active Wiki Categories**

| **Directory** | **Purpose** | **Documentation** |
|--------------|-------------|-------------------|
| **[observability/](observability/)** | Monitoring, metrics collection, and observability stack procedures | [observability/README.md](observability/README.md) |
| **[docker/](docker/)** | Docker container management and containerization workflows | [docker/README.md](docker/README.md) |
| **[storage/](storage/)** | Storage management, backup procedures, and data lifecycle workflows | [storage/README.md](storage/README.md) |
| **[databases/](databases/)** | PostgreSQL administration and astronomical database management | [databases/README.md](databases/README.md) |
| **[k8s/](k8s/)** | Kubernetes cluster operations and container orchestration procedures | [k8s/README.md](k8s/README.md) |
| **[fileservices/](fileservices/)** | File sharing, distributed storage, and collaborative workspace management | [fileservices/README.md](fileservices/README.md) |
| **[automation-and-orchestration/](automation-and-orchestration/)** | Infrastructure automation and GitOps workflow procedures | [automation-and-orchestration/README.md](automation-and-orchestration/README.md) |
| **[portainer/](portainer/)** | Portainer management and web-based container orchestration | [portainer/README.md](portainer/README.md) |

### **Pending Documentation Areas**

| **Directory** | **Purpose** | **Status** |
|--------------|-------------|------------|
| **[active-directory/](active-directory/)** | Enterprise authentication and identity management procedures | README-pending.md |
| **[backups/](backups/)** | Backup system configuration and disaster recovery procedures | README-pending.md |
| **[data-processing-and-pipelines/](data-processing-and-pipelines/)** | Data processing workflows and astronomical pipeline management | README-pending.md |
| **[gitops-portainer/](gitops-portainer/)** | GitOps workflow integration with Portainer management | README-pending.md |
| **[mcp-servers/](mcp-servers/)** | Model Context Protocol server configuration and management | README-pending.md |
| **[proxmox/](proxmox/)** | Proxmox VE administration and virtualization management | README-pending.md |
| **[vdi-kasm-workspaces/](vdi-kasm-workspaces/)** | Virtual desktop infrastructure and remote workspace management | README-pending.md |

---

## **📁 Repository Structure**

``` markdown
wiki/
├── 📊 observability/          # Monitoring and observability procedures
│   ├── README.md             # Observability implementation guides
│   ├── postgresql-exporter-setup-ubuntu2404.md # Database monitoring setup
│   └── [monitoring procedures and guides]
├── 🐳 docker/                # Docker container management procedures
│   ├── README.md             # Docker administration and workflows
│   ├── add-a-docker-volume-to-linux-ubuntu2404.md # Volume management guide
│   ├── move-docker-service-to-dedicated-volume-linux-ubuntu2404.md # Service migration
│   └── [container management procedures]
├── 💾 storage/               # Storage management and data procedures
│   ├── README.md             # Storage administration workflows
│   └── [storage and backup procedures]
├── 🗄️ databases/            # Database administration procedures
│   ├── README.md             # PostgreSQL and database management
│   └── [database administration guides]
├── ☸️ k8s/                  # Kubernetes operations procedures
│   ├── README.md             # RKE2 cluster management workflows
│   └── [cluster operation procedures]
├── 📁 fileservices/         # File services and collaborative storage
│   ├── README.md             # File sharing and distributed storage
│   └── [file service procedures]
├── 🤖 automation-and-orchestration/ # Infrastructure automation procedures
│   ├── README.md             # IaC and automation workflow procedures
│   └── [automation procedures]
├── 🚢 portainer/            # Portainer management procedures
│   ├── README.md             # Portainer administration and workflows
│   └── [Portainer management guides]
├── 🔐 active-directory/     # Enterprise authentication (pending)
│   └── README-pending.md    # Identity management procedures
├── 💾 backups/              # Backup and recovery (pending)
│   └── README-pending.md    # Backup system procedures
├── 🔄 data-processing-and-pipelines/ # Data pipelines (pending)
│   └── README-pending.md    # Pipeline management procedures
├── 🔄 gitops-portainer/     # GitOps integration (pending)
│   └── README-pending.md    # GitOps workflow procedures
├── 🤖 mcp-servers/          # MCP servers (pending)
│   └── README-pending.md    # MCP server management
├── 🖥️ proxmox/             # Proxmox administration (pending)
│   └── README-pending.md    # Proxmox VE procedures
├── 🖥️ vdi-kasm-workspaces/ # VDI workspaces (pending)
│   └── README-pending.md    # Virtual desktop procedures
├── 📝 README.md              # This file
└── 📄 wiki-conventions.md    # Wiki contribution and formatting standards
```

### **Navigation Guide:**

- **[📊 Observability](observability/README.md)** - Monitoring setup, metrics collection, and observability procedures
- **[🐳 Docker](docker/README.md)** - Container management, volume configuration, and Docker workflows
- **[💾 Storage](storage/README.md)** - Storage administration, backup procedures, and data management
- **[🗄️ Databases](databases/README.md)** - PostgreSQL administration and astronomical database procedures

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the technical knowledge graph.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Infrastructure Overview](../infrastructure/README.md)** | Infrastructure components requiring operational procedures and maintenance | [../infrastructure/README.md](../infrastructure/README.md) |
| **[Documentation Standards](../docs/documentation-standards/README.md)** | Wiki template standards and contribution guidelines | [../docs/documentation-standards/README.md](../docs/documentation-standards/README.md) |
| **[Monitoring & Observability](../docs/monitoring-observability/README.md)** | Monitoring documentation and observability implementation guides | [../docs/monitoring-observability/README.md](../docs/monitoring-observability/README.md) |
| **[RKE2 Kubernetes](../docs/k8s-rke2/README.md)** | Kubernetes documentation and cluster management procedures | [../docs/k8s-rke2/README.md](../docs/k8s-rke2/README.md) |
| **[Astronomy Projects](../astronomy-projects/README.md)** | Research computing procedures and scientific workflow implementation | [../astronomy-projects/README.md](../astronomy-projects/README.md) |

---

## **Getting Started**

For new users approaching the wiki knowledge base:

1. **Start Here:** [Observability Procedures](observability/README.md) - Monitoring and metrics collection setup
2. **Container Management:** [Docker Workflows](docker/README.md) - Container administration and volume management
3. **Data Management:** [Storage Procedures](storage/README.md) - Storage administration and backup workflows
4. **Database Operations:** [Database Management](databases/README.md) - PostgreSQL and astronomical database procedures

---

## **🛠️ Technical Procedure Categories**

### **Infrastructure Operations**

Comprehensive operational procedures for enterprise infrastructure management:

**Monitoring and Observability:**

- **PostgreSQL Exporter Setup** - Database monitoring configuration on Ubuntu 24.04
- **Prometheus Configuration** - Metrics collection and alerting setup procedures
- **Grafana Dashboard Management** - Dashboard creation and customization workflows
- **Log Aggregation** - Loki log collection and analysis procedures

**Container Management:**

- **Docker Volume Management** - Adding and configuring Docker volumes on Linux systems
- **Service Migration** - Moving Docker services to dedicated storage volumes
- **Container Lifecycle** - Container creation, deployment, and maintenance procedures
- **Portainer Administration** - Web-based container management workflows

### **Data and Storage Management**

Specialized procedures for astronomical data management and storage operations:

**Storage Administration:**

- **NVMe Storage Management** - High-performance storage configuration and optimization
- **Backup Procedures** - Comprehensive backup configuration and validation
- **Data Lifecycle Management** - Archival and retention policy implementation
- **Performance Optimization** - Storage tuning for astronomical workload patterns

**Database Operations:**

- **PostgreSQL Administration** - Database installation, configuration, and optimization
- **Astronomical Database Setup** - Specialized database configuration for research data
- **Backup and Recovery** - Database backup procedures and disaster recovery
- **Performance Tuning** - Query optimization and index management for large datasets

---

## **🔬 Research Computing Procedures**

### **Scientific Workflow Implementation**

Specialized procedures supporting astronomical research computing workflows:

**Data Processing Pipelines:**

- **DESI Data Processing** - Large-scale astronomical survey data processing workflows
- **ML/AI Pipeline Setup** - Machine learning infrastructure and training procedures
- **Distributed Computing** - Kubernetes cluster utilization for research computing
- **GPU Computing** - Graphics processing unit allocation and optimization

**Collaborative Research:**

- **Multi-User Environments** - Shared research computing resource management
- **File Sharing Setup** - Collaborative data sharing and workspace configuration
- **Access Management** - Research project access control and user management
- **Resource Allocation** - Fair resource sharing across multiple research projects

### **Development and Testing**

Development environment setup and testing procedures:

**Development Environments:**

- **Research Software Installation** - Astronomical software deployment and configuration
- **Container Development** - Research application containerization workflows
- **Testing Frameworks** - Automated testing for research software and pipelines
- **CI/CD Integration** - Continuous integration for scientific software development

**Quality Assurance:**

- **Procedure Validation** - Testing and validation of operational procedures
- **Performance Benchmarking** - Infrastructure performance testing and optimization
- **Security Validation** - Security procedure testing and compliance verification
- **Disaster Recovery Testing** - Regular testing of backup and recovery procedures

---

## **📚 Wiki Standards and Conventions**

### **Documentation Standards**

Wiki contribution guidelines ensuring consistent, high-quality technical documentation:

**Content Standards:**

- **Step-by-Step Procedures** - Clear, actionable instructions with validation steps
- **Enterprise Context** - Procedures reflecting production infrastructure reality
- **Troubleshooting Integration** - Common issues and resolution procedures included
- **Cross-Reference Network** - Links to related procedures and infrastructure documentation

**Quality Assurance:**

- **Procedure Testing** - All procedures validated in production environment
- **Regular Updates** - Documentation maintenance aligned with infrastructure changes
- **User Feedback** - Community feedback integration and procedure improvement
- **Version Control** - Systematic version management and change tracking

### **Contribution Framework**

Guidelines for contributing to the wiki knowledge base:

**Contribution Process:**

- **Template Usage** - Standardized wiki article template for consistent structure
- **Review Procedures** - Technical review and validation before publication
- **Testing Requirements** - Procedure testing and validation in appropriate environments
- **Documentation Standards** - Alignment with enterprise documentation framework

**Community Guidelines:**

- **Collaborative Development** - Team-based procedure development and improvement
- **Knowledge Sharing** - Best practice sharing and lessons learned integration
- **Training Integration** - Procedure documentation supporting training and onboarding
- **Continuous Improvement** - Regular review and enhancement of wiki content

---

## **🔄 Future Wiki Development**

### **Pending Documentation Areas**

Strategic wiki expansion supporting growing infrastructure capabilities:

**Enterprise Authentication:**

- **Active Directory Integration** - Enterprise authentication setup and management
- **SSO Configuration** - Single sign-on implementation across platform services
- **User Lifecycle Management** - Automated user provisioning and access management
- **Security Procedures** - Authentication security and compliance procedures

**Advanced Infrastructure:**

- **Proxmox VE Administration** - Hypervisor management and virtualization procedures
- **VDI Workspace Management** - Virtual desktop infrastructure deployment and management
- **GitOps Integration** - Git-based operational workflow implementation
- **MCP Server Management** - Model Context Protocol server configuration and operations

### **Enhancement Priorities**

Wiki improvement priorities supporting operational excellence:

**Content Enhancement:**

- **Procedure Automation** - Integration of manual procedures with automation frameworks
- **Visual Documentation** - Diagram and screenshot integration for complex procedures
- **Video Tutorials** - Video-based procedure documentation for complex workflows
- **Interactive Guides** - Web-based interactive procedure guides and checklists

**Platform Integration:**

- **Monitoring Integration** - Wiki procedure integration with monitoring and alerting
- **Automation Integration** - Procedure automation through Infrastructure as Code
- **Quality Metrics** - Wiki usage analytics and procedure effectiveness measurement
- **Search Enhancement** - Advanced search capabilities and content discovery

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: wiki, technical-procedures, operational-guides, knowledge-base, implementation-docs

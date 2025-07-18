<!--
---
title: "proj-mon01 Asset Sheet"
description: "Comprehensive asset documentation for proj-mon01 (VM ID 2008), the enterprise monitoring stack within the Proxmox Astronomy Lab infrastructure, providing centralized observability through Prometheus, Loki, and Grafana with comprehensive dashboard management, metrics collection, and 90-day retention supporting operational excellence"
author: "[Human Author Name]"
ai_contributor: "Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)"
date: "2025-07-07"
version: "1.0"
status: "Published"
tags:
- type: vm-asset-sheet
- domain: monitoring-observability
- domain: enterprise-metrics
- tech: prometheus
- tech: loki-grafana
- scale: enterprise-monitoring
related_documents:
- "[Infrastructure Overview](../../infrastructure/README.md)"
- "[Monitoring Infrastructure](../../monitoring/README.md)"
- "[Database Monitoring](proj-pg01-asset-sheet.md)"
- "[Security Monitoring](../../security/README.md)"
---
-->

# 📊 **proj-mon01 Asset Sheet**

This document provides comprehensive asset documentation for proj-mon01 (VM ID 2008), the enterprise monitoring stack within the Proxmox Astronomy Lab infrastructure. This critical observability component serves as the centralized monitoring platform providing Prometheus metrics collection, Loki log aggregation, and Grafana visualization with comprehensive dashboard management, supporting every VM and node with node_exporter and Grafana Alloy for logs, maintaining 90-day on-premises retention with Glacier archival storage ensuring enterprise-grade operational excellence and systematic infrastructure observability.

# 🎯 **1. Introduction**

## **1.1 Purpose**

The proj-mon01 asset sheet provides authoritative documentation for the enterprise monitoring stack within the Proxmox Astronomy Lab infrastructure, enabling monitoring specialists, infrastructure operations teams, and platform administrators to understand comprehensive observability capabilities, current monitoring coverage, and operational characteristics essential for systematic infrastructure monitoring, performance optimization, and enterprise operational excellence.

## **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| VM specifications and monitoring stack platform configuration | Individual dashboard creation procedures and alert configuration details |
| Prometheus, Loki, and Grafana architecture and integration | Specific metric collection intervals and detailed exporter configurations |
| Comprehensive dashboard portfolio and metrics collection strategy | Individual node troubleshooting procedures and performance tuning |
| Retention policies and Glacier integration for long-term storage | Application-specific monitoring requirements and custom metric definitions |
| Node exporter and Grafana Alloy deployment across all infrastructure | Detailed alert routing procedures and incident response workflows |

## **1.3 Target Audience**

**Primary Audience:** Monitoring specialists, observability engineers, and infrastructure operations teams responsible for enterprise monitoring infrastructure
**Secondary Audience:** System administrators, research computing teams, and platform teams requiring monitoring capabilities and performance visibility
**Required Background:** Understanding of enterprise monitoring platforms, Prometheus/Grafana architecture, log aggregation systems, and infrastructure observability requirements

## **1.4 Overview**

proj-mon01 functions as the enterprise monitoring hub within the 7-node Proxmox cluster, providing comprehensive observability through Prometheus, Loki, and Grafana with 4 CPU cores, 12GB RAM, and 500GB storage optimized for monitoring workloads. The system operates on node05 within VLAN 20 (10.25.20.9) orchestrating cluster-wide monitoring through universal node_exporter deployment, Grafana Alloy log collection, comprehensive dashboard management with 90-day on-premises retention and Glacier archival storage supporting enterprise operational excellence.

# 🔗 **2. Dependencies & Relationships**

## **2.1 Related Services**

| **Service** | **Relationship Type** | **Integration Points** | **Documentation** |
|-------------|----------------------|------------------------|-------------------|
| **Infrastructure Monitoring** | **Monitors** | Universal node_exporter and Grafana Alloy deployment across all VMs and nodes | [Monitoring Infrastructure](../../monitoring/README.md) |
| **Database Monitoring** | **Collects-metrics-from** | PostgreSQL monitoring via postgres_exporter from proj-pg01 and proj-pgsql02 | [Database Services](../../infrastructure/databases/README.md) |
| **Security Monitoring** | **Integrates-with** | Wazuh metrics and security event correlation through Loki integration | [Security Framework](../../security/README.md) |
| **Backup Integration** | **Protected-by** | Enterprise backup with long-term retention via Glacier storage | [Infrastructure Overview](../../infrastructure/README.md) |
| **Network Monitoring** | **Observes** | SNMP monitoring for switches and network infrastructure performance | [Infrastructure Overview](../../infrastructure/README.md) |

## **2.2 Policy Implementation**

proj-mon01 operations implement enterprise monitoring policies through comprehensive metrics collection and systematic observability management. Monitoring administration adheres to data retention policies ensuring 90-day on-premises storage with Glacier archival. Security policies govern monitoring data access and dashboard management while operational policies ensure systematic performance tracking and infrastructure observability excellence.

## **2.3 Responsibility Matrix**

| **Activity** | **Monitoring Ops** | **Infrastructure Ops** | **Security Ops** | **Platform Teams** |
|--------------|-------------------|------------------------|------------------|-------------------|
| **Monitoring Platform** | **A** | **C** | **I** | **C** |
| **Dashboard Management** | **A** | **R** | **C** | **R** |
| **Metrics Collection** | **R** | **A** | **I** | **C** |
| **Log Aggregation** | **A** | **C** | **R** | **C** |
| **Retention Management** | **A** | **R** | **I** | **I** |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

# ⚙️ **3. Virtual Machine Configuration**

## **3.1 VM Architecture & Design**

proj-mon01 implements enterprise monitoring architecture with optimized resource allocation designed for Prometheus performance, Loki scalability, and Grafana responsiveness:

```mermaid
graph TB
    subgraph "proj-mon01 Enterprise Monitoring Architecture"
        subgraph "Virtualization Platform"
            VM[VM ID 2008<br/>4 vCPU, 12GB RAM<br/>500GB Storage]
            HOST[Host: node05<br/>Intel i5-12600H<br/>Storage Node Platform]
        end
        
        subgraph "Core Monitoring Stack"
            PROMETHEUS[Prometheus<br/>Metrics Collection & Storage]
            LOKI[Loki<br/>Log Aggregation & Processing]
            GRAFANA[Grafana<br/>Visualization & Dashboard Management]
            ALERTMANAGER[AlertManager<br/>Alert Processing & Routing]
        end
        
        subgraph "Comprehensive Dashboard Portfolio"
            APPS[App: Gitea<br/>Application Monitoring]
            BACKUPS[Backups: Proxmox Backup Server (Flux v2)<br/>Backup System Monitoring]
            DATABASES[Database: MongoDB, PostgreSQL (v2), PostgreSQL Overview<br/>Database Performance Monitoring]
            DOCKER[Docker: cAdvisor Overview, Compute Resources, WUD<br/>Container Monitoring]
        end
        
        subgraph "Infrastructure Monitoring"
            GPU[GPU: nVidia<br/>GPU Performance Monitoring]
            LOGS[Logs: ServiceName, Fail2Ban, SSH (by Service), SSH Logs (Global)<br/>Security & System Log Analysis]
            PERFORMANCE[Performance: Linux (All), Linux (Single)<br/>System Performance Monitoring]
            PROXMOX[Proxmox Cluster (Flux v1/v2)<br/>Hypervisor Monitoring]
        end
        
        subgraph "Network & Storage Monitoring"
            SERVER[Server Performance: Node Exporter<br/>Hardware Performance Monitoring]
            STORAGE[Storage: Minio<br/>Object Storage Monitoring]
            SWITCH[Switch: Network Speeds (SNMP), Interface Details (SNMP)<br/>Network Infrastructure Monitoring]
        end
        
        subgraph "Universal Agent Deployment"
            NODEEXPORTER[node_exporter<br/>Deployed on Every VM & Node]
            ALLOY[Grafana Alloy<br/>Log Collection on Every System]
            EXPORTERS[Specialized Exporters<br/>postgres_exporter, cAdvisor, etc.]
        end
        
        subgraph "Data Retention Strategy"
            ONPREM[90-Day On-Premises<br/>High-Performance Local Storage]
            GLACIER[Glacier Archive<br/>CIS Minimum / Best Practice Retention]
            BACKUP[Enterprise Backup<br/>PBS Integration]
        end
    end
    
    VM --> HOST
    
    PROMETHEUS --> LOKI
    LOKI --> GRAFANA
    GRAFANA --> ALERTMANAGER
    
    APPS --> BACKUPS
    BACKUPS --> DATABASES
    DATABASES --> DOCKER
    
    GPU --> LOGS
    LOGS --> PERFORMANCE
    PERFORMANCE --> PROXMOX
    
    SERVER --> STORAGE
    STORAGE --> SWITCH
    
    NODEEXPORTER --> ALLOY
    ALLOY --> EXPORTERS
    
    ONPREM --> GLACIER
    GLACIER --> BACKUP
    
    PROMETHEUS --> NODEEXPORTER
    LOKI --> ALLOY
    GRAFANA --> APPS
    
    style PROMETHEUS fill:#e1f5fe
    style GRAFANA fill:#e8f5e8
    style NODEEXPORTER fill:#fff3e0
    style ONPREM fill:#f3e5f5
```

## **3.2 Hardware & Virtual Specifications**

**Virtual Machine Specifications:**

| **Component** | **Specification** | **Purpose** | **Status** |
|---------------|------------------|-------------|------------|
| **VM ID** | **2008** | Unique cluster identifier for enterprise monitoring stack | Active |
| **CPU Allocation** | **4 vCPU** | Optimized for Prometheus processing and Grafana visualization | Active |
| **Memory** | **12.00 GiB** | Balanced allocation for monitoring workloads and dashboard performance | Active |
| **Boot Storage** | **32.00 GiB** | System boot disk for OS and monitoring platform installation | Active |
| **Data Storage** | **500.00 GiB** | Large monitoring data volume for metrics, logs, and dashboard storage | Active |
| **Network Interface 1** | **virtio (BC:24:11:C6:1F:61)** | Primary VLAN 20 research network connectivity | Active |
| **Network Interface 2** | **virtio (BC:24:11:FB:AE:C8)** | Secondary vmbr0 management network access | Active |
| **Host Node** | **node05** | Intel i5-12600H storage node platform | Active |

**Platform Configuration:**

- **BIOS**: OVMF (UEFI) for modern enterprise boot standards
- **Machine Type**: Default (i440fx) for monitoring platform compatibility
- **SCSI Controller**: VirtIO SCSI single for high-performance storage access
- **EFI Disk**: 528K with secure boot configuration
- **TPM State**: v2.0 with 4M allocation for security
- **Storage**: nvmethin01 allocation with backup exclusion for data volume

**Network Configuration:**

- **Primary Interface**: VLAN 20 (Research Network) at 10.25.20.9/24
- **Secondary Interface**: vmbr0 management network for infrastructure access
- **Container Networking**: 172.17.0.1 for containerized monitoring services
- **Network Role**: Centralized monitoring hub with dual-network access

## **3.3 Monitoring Stack Architecture**

**Enterprise Monitoring Platform:**

**Core Stack Components:**

- **Prometheus**: Metrics collection, storage, and alerting with 15-second scrape intervals
- **Loki**: Log aggregation and processing for centralized log management
- **Grafana**: Visualization platform with comprehensive dashboard management
- **AlertManager**: Alert processing, routing, and notification management

**Comprehensive Dashboard Portfolio:**

**Application & Service Monitoring:**

- **App: Gitea**: Git repository service monitoring and performance tracking
- **Backups: Proxmox Backup Server (Flux v2)**: Backup system health and performance
- **Database: MongoDB, PostgreSQL (v2), PostgreSQL Overview**: Database performance monitoring
- **Docker: cAdvisor Overview, Compute Resources, WUD**: Container platform monitoring

**Infrastructure & Performance Monitoring:**

- **GPU: nVidia**: GPU performance monitoring for research computing workloads
- **Logs: ServiceName, Fail2Ban, SSH (by Service), SSH Logs (Global)**: Security and system log analysis
- **Performance: Linux (All), Linux (Single)**: System performance monitoring across infrastructure
- **Proxmox Cluster (Flux v1/v2)**: Hypervisor performance and cluster health monitoring

**Network & Storage Monitoring:**

- **Server Performance: Node Exporter**: Hardware performance monitoring across all systems
- **Storage: Minio**: Object storage performance and capacity monitoring
- **Switch: Network Speeds (SNMP), Interface Details (SNMP)**: Network infrastructure monitoring

**Universal Agent Deployment Strategy:**

**Comprehensive Coverage:**

- **node_exporter**: Deployed on every VM and physical node for system metrics
- **Grafana Alloy**: Log collection agent deployed universally for centralized logging
- **Specialized Exporters**: postgres_exporter, cAdvisor, and service-specific monitoring
- **SNMP Monitoring**: Network switch monitoring for infrastructure visibility

**Data Retention & Archival Strategy:**

**Multi-Tier Retention Policy:**

- **90-Day On-Premises**: High-performance local storage for operational monitoring
- **Glacier Archival**: Long-term storage following CIS minimum requirements and best practices
- **Enterprise Backup**: PBS integration for monitoring infrastructure protection
- **Compliance**: Retention policies aligned with enterprise governance and security frameworks

# 🛠️ **4. Management & Operations**

## **4.1 Lifecycle Management**

proj-mon01 lifecycle management follows enterprise operational patterns ensuring continuous availability for critical monitoring services and infrastructure observability. Platform deployment utilizes systematic provisioning with automated monitoring stack configuration, dashboard import procedures, and universal agent deployment supporting enterprise-wide monitoring reliability and sophisticated observability orchestration.

## **4.2 Monitoring & Quality Assurance**

proj-mon01 monitoring implements self-monitoring capabilities through Prometheus metrics collection, Grafana dashboard health tracking, and Loki log processing performance surveillance. Performance monitoring includes monitoring stack health, dashboard responsiveness, and data retention management enabling proactive maintenance and optimization decisions for the monitoring infrastructure itself.

## **4.3 Maintenance and Optimization**

Maintenance procedures include weekly monitoring stack health assessments, monthly dashboard optimization reviews, and quarterly retention policy evaluations. Performance optimization adapts monitoring configuration based on infrastructure growth patterns while maintenance includes dashboard updates, agent deployment verification, and monitoring performance improvement supporting observability excellence.

# 🔒 **5. Security & Compliance**

## **5.1 Security Controls**

**DISCLAIMER: We are not security professionals** - this is our baseline and we are working towards compliance with CIS Controls v8, NIST frameworks, and industry standards. proj-mon01 security implements enterprise-grade monitoring platform hardening including Grafana access controls, Prometheus security configuration, and monitoring data protection ensuring sophisticated infrastructure protection and advanced monitoring security excellence.

## **5.2 CIS Controls Mapping**

| **CIS Control** | **Implementation Status** | **Evidence Location** | **Assessment Date** |
|-----------------|--------------------------|----------------------|-------------------|
| **CIS.1.1** | **Compliant** | Monitoring infrastructure asset tracking and comprehensive platform documentation | 2025-07-07 |
| **CIS.6.1** | **Compliant** | Comprehensive logging via Loki and centralized log management | 2025-07-07 |
| **CIS.8.1** | **Compliant** | Extensive audit logging via monitoring stack and security log analysis | 2025-07-07 |
| **CIS.12.1** | **Compliant** | Network monitoring and infrastructure performance tracking | 2025-07-07 |

## **5.3 Framework Compliance**

proj-mon01 security implementation integrates enterprise security frameworks with monitoring requirements ensuring appropriate protection while maintaining performance for Prometheus operations, Grafana visualization, and Loki log processing maintaining enterprise infrastructure security standards for critical monitoring systems.

# 💾 **6. Backup & Recovery**

## **6.1 Protection Strategy**

proj-mon01 monitoring infrastructure protection integrates with enterprise backup strategy through **pbs01.radioastronomy.io** (10.16.207.218) providing automated VM backup combined with specialized **Glacier archival** for long-term monitoring data retention. Daily backup procedures ensure comprehensive protection for monitoring configurations, dashboard definitions, and historical metrics while systematic Glacier integration provides cost-effective long-term storage following CIS requirements and best practices.

| **Protection Component** | **Backup Frequency** | **Retention** | **Recovery Objective** |
|--------------------------|---------------------|---------------|----------------------|
| **VM Configuration** | **Daily PBS backup** | **7 days on-site, 1 month cloud** | **RTO: <2H / RPO: <24H** |
| **Monitoring Data** | **90-day on-premises** | **Glacier archival per CIS/best practice** | **RTO: <4H / RPO: <24H** |
| **Dashboard Configs** | **Daily configuration backup** | **30 days on-site, 1 year cloud** | **RTO: <30min / RPO: <24H** |

## **6.2 Recovery Procedures**

proj-mon01 recovery procedures prioritize rapid restoration of critical monitoring services through systematic monitoring stack rebuilding, dashboard restoration, and agent reconnection supporting enterprise observability resilience and operational monitoring continuity.

# 📚 **7. References & Related Resources**

## **7.1 Internal References**

| **Document Type** | **Document Title** | **Relationship** | **Link** |
|-------------------|-------------------|------------------|----------|
| **Monitoring** | Monitoring Infrastructure | Enterprise monitoring framework and observability architecture | [Monitoring](../../monitoring/README.md) |
| **Infrastructure** | Infrastructure Overview | Enterprise platform architecture and monitoring integration | [Infrastructure](../../infrastructure/README.md) |
| **Database Monitoring** | PostgreSQL Monitoring | Database performance monitoring and metrics collection | [Database Services](../../infrastructure/databases/README.md) |
| **Security** | Security Framework | Security monitoring integration and log analysis | [Security](../../security/README.md) |

## **7.2 External Standards**

- **[Prometheus Documentation](https://prometheus.io/docs/)** - Official metrics collection and monitoring platform
- **[Grafana Documentation](https://grafana.com/docs/)** - Visualization and dashboard management platform
- **[Loki Documentation](https://grafana.com/docs/loki/)** - Log aggregation and processing system
- **[Node Exporter](https://github.com/prometheus/node_exporter)** - System metrics collection agent

# ✅ **8. Approval & Review**

## **8.1 Review Process**

proj-mon01 asset documentation undergoes systematic review by monitoring specialists, infrastructure operations teams, and observability engineers to ensure accuracy and operational relevance for enterprise monitoring infrastructure.

## **8.2 Approval Matrix**

| **Reviewer** | **Role/Expertise** | **Review Date** | **Approval Status** | **Comments** |
|-------------|-------------------|----------------|-------------------|--------------|
| [Monitoring Specialist] | Enterprise Monitoring & Observability Platform | [YYYY-MM-DD] | **Approved** | Monitoring stack specifications and dashboard portfolio validated |
| [Infrastructure Engineer] | Enterprise Infrastructure & Platform Integration | [YYYY-MM-DD] | **Approved** | Infrastructure monitoring and agent deployment confirmed |
| [Operations Manager] | Operational Excellence & Monitoring Strategy | [YYYY-MM-DD] | **Approved** | Operational monitoring capabilities and retention policies verified |

# 📜 **9. Documentation Metadata**

## **9.1 Change Log**

| **Version** | **Date** | **Changes** | **Author** | **Review Status** |
|------------|---------|-------------|------------|------------------|
| 1.0 | 2025-07-07 | Initial proj-mon01 asset sheet with comprehensive enterprise monitoring documentation | [Human Author] | **Approved** |

## **9.2 Authorization & Review**

proj-mon01 asset documentation reflects current virtual machine configuration and enterprise monitoring platform status validated through systematic infrastructure analysis ensuring accuracy for operational excellence and monitoring platform administration.

## **9.3 Authorship Details**

**Human Author:** [Full name and role - Monitoring Specialist/Infrastructure Operations Engineer]
**AI Contributor:** Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)
**Collaboration Method:** Request-Analyze-Verify-Generate-Validate (RAVGV)
**Human Oversight:** Complete monitoring platform review and validation of proj-mon01 documentation accuracy

## **9.4 AI Collaboration Disclosure**

This document was collaboratively developed to establish comprehensive enterprise monitoring infrastructure documentation enabling systematic observability management and operational excellence.

---

**🤖 AI Collaboration Disclosure**

This document was collaboratively developed using the Request-Analyze-Verify-Generate-Validate (RAVGV) methodology. The proj-mon01 asset documentation reflects current virtual machine configuration and enterprise monitoring platform status derived from systematic infrastructure analysis. All content has been thoroughly reviewed, validated, and approved by qualified human subject matter experts. The human author retains complete responsibility for accuracy, compliance, and monitoring infrastructure effectiveness.

*Generated: 2025-07-07 | Human Author: [Name] | AI Assistant: Claude 4 Sonnet | Review Status: Approved | Document Version: 1.0*

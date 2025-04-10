<!-- 
---
title: "Prometheus Monitoring Service - Proxmox Astronomy Lab"
description: "Documentation of the central metrics collection and monitoring system that provides infrastructure and research observability"
author: "VintageDon"
tags: ["prometheus", "monitoring", "observability", "metrics", "alerting", "time-series"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Active"
last_updated: "2025-04-04"
related_services: ["Grafana", "AlertManager", "Node Exporter", "SNMP Exporter"]
implements_policies: ["Monitoring Policy", "Incident Response Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.9", "CIS.12.4", "CIS.12.3"]
iso27001_controls: ["A.12.1.3", "A.12.4.1", "A.16.1.2"]
nist_controls: ["CA-7", "SI-4", "AU-6"]
---
 -->

# 📊 **Prometheus Monitoring Service**

# 🔍 **1. Overview**

This section provides the foundational context for Prometheus, explaining its purpose, scope, and implementation within the Proxmox Astronomy Lab's observability stack. Prometheus serves as the central metrics collection system, providing real-time visibility into infrastructure health and performance.

## **1.1 Purpose**

This subsection clearly defines why Prometheus exists in our environment, the problems it addresses, and what value it provides to operations and research functions.

Prometheus serves as the **core time-series metrics collection platform** for the Proxmox Astronomy Lab, providing **comprehensive monitoring of infrastructure components, containerized services, and research workloads**. By collecting metrics at regular intervals, Prometheus enables proactive performance monitoring, capacity planning, and alerting for both IT operations and scientific research functions.

## **1.2 Scope**

This subsection defines the boundaries of what Prometheus covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Infrastructure metrics collection | Log aggregation (handled by Loki) |
| Performance monitoring | Security event monitoring (handled by Wazuh) |
| Alerting on threshold violations | Long-term metrics archiving beyond 90 days |
| Service discovery | User activity monitoring |
| Research equipment monitoring | Full packet analysis |

Prometheus is deployed on `lab-mon01` (10.25.10.13) and collects metrics from all virtual machines, physical hosts, network devices, and research equipment within the lab environment.

## **1.3 Target Audience**

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

This document is intended for:
- Infrastructure Engineers responsible for monitoring
- Operations Staff managing system performance
- Research Scientists analyzing equipment performance
- Security Administrators verifying monitoring compliance

# 🔗 **2. Dependencies & Relationships**

This section maps how Prometheus relates to other elements within the environment, capturing both upstream and downstream dependencies that form the basis for impact analysis and service maps.

## **2.1 Related Services**

This subsection identifies other services that interact with Prometheus, establishing the service ecosystem and integration points.

Prometheus **relates to**:

- [Grafana](/docs/Applications/Observability/Grafana/Grafana-Server.md) - Visualization of metrics collected by Prometheus
- [AlertManager](/docs/Applications/Observability/Prometheus/AlertManager.md) - Handles alert routing and notifications from Prometheus
- [Node Exporter](/docs/Applications/Observability/Prometheus/Exporters/Node-Exporter.md) - Exports system metrics from Linux hosts
- [Windows Exporter](/docs/Applications/Observability/Prometheus/Exporters/Windows-Exporter.md) - Exports system metrics from Windows hosts
- [SNMP Exporter](/docs/Applications/Observability/Prometheus/Exporters/SNMP-Exporter.md) - Exports metrics from network devices

The list above documents service dependencies that should be considered when making changes or troubleshooting issues with Prometheus.

## **2.2 Implements Policies**

This subsection connects this document to the governance framework by identifying which organizational policies Prometheus implements or supports.

Prometheus **implements**:

- [Monitoring Policy](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/13-network-monitoring-and-defense/cisv81-13-network-monitoring-and-defense-policy.md) - Fulfills requirements for system and service monitoring
- [Incident Response Policy](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/17-incident-response-management/cisv81-17-incident-response-management-termplate.md) - Supports timely detection of operational incidents

The list above shows how Prometheus contributes to organizational compliance and governance objectives.

## **2.3 Responsibility Matrix**

This subsection defines accountabilities and responsibilities for key activities related to Prometheus, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure** | **Security Admin** | **Engineer** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Configuration Management | R/A | C | I | I |
| Alert Management | R | A/C | I | R |
| Exporter Deployment | R/A | C | I | I |
| Dashboard Development | R | I | C | R/A |
| Performance Tuning | R/A | I | C | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 🛠️ **3. Technical Documentation**

This section provides the technical details necessary for Prometheus implementation, configuration, and troubleshooting, serving as the authoritative technical reference.

## **3.1 Architecture & Components**

This subsection explains the technical architecture, component relationships, and design decisions that shape the Prometheus implementation.

Prometheus operates within a multi-component architecture:

1. **Prometheus Server** - Central service that scrapes and stores time-series data
2. **Exporters** - Agents deployed on monitored systems to expose metrics
3. **AlertManager** - Handles alert routing, deduplication, and notification
4. **Grafana** - Provides visualization and dashboarding for metrics
5. **Push Gateway** - Allows batch jobs to push metrics to Prometheus

Prometheus is deployed on `lab-mon01` (10.25.10.13) as a systemd service, with a dedicated 750GB data volume mounted at `/var/lib/prometheus`. It scrapes metrics every 15 seconds from all configured targets and retains data for 90 days.

## **3.2 Configuration Details**

This subsection provides specific configuration parameters, file locations, and settings required for proper implementation and operation of Prometheus.

Prometheus configuration is stored in `/etc/prometheus/prometheus.yml` with the following structure:

```yaml
# PROMETHEUS CONFIGURATION - PROXMOX ASTRONOMY LAB
# Centralized metrics collection using Prometheus.
# - Scrapes system, container, and application metrics.
# - 15s scrape interval for real-time visibility.
# - 90-day retention period for historical analysis.
# - Federation with external monitoring systems.
# - AlertManager integration for notifications.

global:
  scrape_interval: 15s
  evaluation_interval: 15s
  scrape_timeout: 10s

rule_files:
  - "/etc/prometheus/rules/*.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']

scrape_configs:
  # Prometheus self-monitoring
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # Linux system metrics
  - job_name: 'node'
    file_sd_configs:
      - files:
        - '/etc/prometheus/file_sd/node_targets.yml'
    relabel_configs:
      - source_labels: [__address__]
        target_label: instance
        regex: '(.*)(:.*)?'
        replacement: '$1'

  # Windows system metrics
  - job_name: 'windows'
    file_sd_configs:
      - files:
        - '/etc/prometheus/file_sd/windows_targets.yml'

  # Network device metrics
  - job_name: 'snmp'
    file_sd_configs:
      - files:
        - '/etc/prometheus/file_sd/snmp_targets.yml'
    metrics_path: /snmp
    params:
      module: [if_mib]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9116

  # Additional job configurations omitted for brevity
```

Exporters are deployed as systemd services on each monitored system, with the following configuration for Node Exporter:

```bash
# Node Exporter systemd unit file
# /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
  --collector.filesystem \
  --collector.netdev \
  --collector.meminfo \
  --collector.cpu \
  --collector.loadavg \
  --web.listen-address=:9100

[Install]
WantedBy=multi-user.target
```

The configuration details above should be specific enough to enable complete implementation without requiring additional research.

## **3.3 Monitored Systems and Targets**

This subsection documents the systems and services monitored by Prometheus, establishing the monitoring scope and coverage.

Prometheus collects metrics from the following target groups:

| **Target Type** | **Quantity** | **Exporter** | **Metrics Collected** |
|----------------|------------|--------------|----------------------|
| Proxmox Nodes | 5 | Node Exporter | CPU, memory, disk, network |
| Linux VMs | 16 | Node Exporter | System resources, service stats |
| Windows VMs | 4 | Windows Exporter | System performance, .NET stats |
| Network Devices | 3 | SNMP Exporter | Interface traffic, errors, status |
| Kubernetes Cluster | 8 pods | cAdvisor | Container metrics, resource usage |
| SDR Equipment | 2 | Custom Exporter | Signal strength, frequency stability |

Target discovery is managed through static configuration files in the `/etc/prometheus/file_sd/` directory, with automatic updates via an Ansible playbook that runs hourly to ensure all systems are properly monitored.

# 📊 **4. Management & Operations**

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for Prometheus, providing practical guidance needed for ongoing maintenance and support.

## **4.1 Routine Procedures**

This subsection documents regular maintenance and operational tasks required to keep Prometheus functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Storage usage verification | Weekly | Operations | [Storage Management](/docs/Applications/Observability/Prometheus/storage-management.md) |
| Alert rule review | Monthly | Security Admin | [Alert Review Procedure](/docs/Applications/Observability/Prometheus/alert-review.md) |
| Exporter version updates | Quarterly | Infrastructure | [Exporter Maintenance](/docs/Applications/Observability/Prometheus/exporter-maintenance.md) |
| Performance optimization | Quarterly | Infrastructure | [Performance Tuning](/docs/Applications/Observability/Prometheus/performance-tuning.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## **4.2 Troubleshooting**

This subsection provides guidance for identifying and resolving common issues with Prometheus, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Target showing as DOWN | Exporter service stopped | Verify exporter status: `systemctl status node_exporter` | [Exporter Troubleshooting](/docs/Applications/Observability/Prometheus/exporter-troubleshooting.md) |
| High CPU utilization | Too many active queries | Optimize query load, increase resources | [Performance Issues](/docs/Applications/Observability/Prometheus/performance-issues.md) |
| Disk space filling up | Retention policy inadequate | Adjust storage.tsdb.retention settings | [Storage Issues](/docs/Applications/Observability/Prometheus/storage-issues.md) |
| Missing metrics | Scrape configuration issue | Check prometheus.yml and reload configuration | [Configuration Troubleshooting](/docs/Applications/Observability/Prometheus/configuration-troubleshooting.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## **4.3 Alert Management**

This subsection details the alert configuration and management process, ensuring that appropriate notifications are generated for operational issues.

Prometheus alerts are defined in YAML files located in the `/etc/prometheus/rules/` directory, with the following alert categories:

| **Alert Category** | **Severity Levels** | **Notification Channels** | **Response SLA** |
|-------------------|-------------------|--------------------------|-----------------|
| Node Down | Critical | Teams, Email, SMS | 15 minutes |
| High Resource Usage | Warning, Critical | Teams, Email | 30 minutes |
| Service Issues | Warning, Critical | Teams, Email | 30 minutes |
| Network Performance | Warning, Critical | Teams | 1 hour |
| Research Equipment | Warning, Critical | Teams, Email | 1 hour |

Example alert rule:

```yaml
groups:
- name: host
  rules:
  - alert: HostDown
    expr: up == 0
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "Host {{ $labels.instance }} is down"
      description: "{{ $labels.instance }} has been down for more than 5 minutes."
```

Alerts are routed through AlertManager to the appropriate teams based on severity and type, with critical alerts generating SMS notifications during non-business hours.

# 🔐 **5. Security & Compliance**

This section documents how security controls are implemented in Prometheus and how compliance requirements are met, providing the mapping between security requirements and their practical implementation.

## **5.1 Security Controls**

This subsection documents specific security measures implemented for Prometheus, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Basic authentication for UI | Config file review, access test | CIS.12.3 |
| Network Security | HTTPS with self-signed cert | SSL verification | CIS.12.4 |
| Service Account | Dedicated prometheus user | permissions check | CIS.12.1 |
| Firewall Rules | Restricted to internal VLAN10 | iptables verification | CIS.12.7 |
| Configuration Security | Read-only config file permissions | File permission audit | CIS.12.2 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## **5.2 CISv8.1 Compliance Mapping**

This subsection explicitly maps Prometheus implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.9 (Centralized Monitoring) | Prometheus central monitoring | Configuration file | Compliant |
| CIS.12.3 (Security Monitoring) | Critical service monitoring | Alert rules configuration | Compliant |
| CIS.12.4 (Encrypted Monitoring) | HTTPS for all interfaces | Web configuration | Compliant |
| CIS.12.8 (Platform Monitoring) | Host-level resource monitoring | Node Exporter configuration | Compliant |

The compliance mapping table above demonstrates how Prometheus satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## **5.3 Related Framework Mappings**

This subsection shows how controls implemented in Prometheus map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.8.9 | A.12.1.3 | DE.CM-1 | Centralized metrics collection |
| CIS.12.3 | A.12.4.1 | DE.CM-7 | Security-relevant metrics |
| CIS.12.4 | A.14.1.3 | PR.DS-2 | Encrypted communications |
| CIS.12.8 | A.12.1.3 | DE.CM-4 | Platform resource monitoring |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

# 💾 **6. Backup & Recovery**

This section documents data protection measures, backup strategies, and recovery procedures for Prometheus, providing the guidance needed to ensure business continuity and disaster recovery capabilities.

## **6.1 Backup Procedure**

This subsection details how Prometheus data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily at 01:00 UTC |
| **Backup Method** | Proxmox Backup Server job targeting `/var/lib/prometheus` |
| **Retention Policy** | 7 daily backups, 4 weekly backups |
| **Backup Location** | PBS storage pool on node05 |
| **Verification Process** | Weekly test recovery to validate backup integrity |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability of Prometheus metrics data.

## **6.2 Recovery Procedure**

This subsection provides recovery steps for various Prometheus failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Service failure | 15 min | 0 min | Service restart procedure | Operations |
| Database corruption | 1 hour | 24 hours | Restore from backup | Infrastructure |
| Complete node failure | 2 hours | 24 hours | Recover to alternate node | Infrastructure |

Recovery procedures are documented in the [Prometheus Recovery Playbook](/docs/Applications/Observability/Prometheus/recovery-playbook.md).

The recovery procedure table above outlines steps to restore Prometheus service in different failure scenarios, supporting business continuity objectives.

# 📚 **7. References & Related Resources**

This section provides links to related documentation and external resources, establishing the connections between this document and other knowledge sources both internal and external.

## **7.1 Internal References**

This subsection identifies other internal documents related to Prometheus, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Installation Guide | Prometheus Installation | [/docs/Applications/Observability/Prometheus/installation-guide.md](/docs/Applications/Observability/Prometheus/installation-guide.md) | Detailed setup instructions |
| Configuration Guide | Prometheus Configuration | [/docs/Applications/Observability/Prometheus/configuration-guide.md](/docs/Applications/Observability/Prometheus/configuration-guide.md) | Config file specifications |
| Dashboard Guide | Prometheus Dashboards | [/docs/Applications/Observability/Grafana/Dashboards/prometheus-dashboards.md](/docs/Applications/Observability/Grafana/Dashboards/prometheus-dashboards.md) | Visualization configuration |
| Exporter Guide | Prometheus Exporters | [/docs/Applications/Observability/Prometheus/Exporters/README.md](/docs/Applications/Observability/Prometheus/Exporters/README.md) | Exporter documentation |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## **7.2 External References**

This subsection provides links to external resources that provide additional context, technical details, or supporting information about Prometheus.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Prometheus Documentation | [https://prometheus.io/docs/](https://prometheus.io/docs/) | [/docs/Archives/prometheus-docs-2025-03.pdf](/docs/Archives/prometheus-docs-2025-03.pdf) | 2025-03-01 |
| PromQL Documentation | [https://prometheus.io/docs/prometheus/latest/querying/basics/](https://prometheus.io/docs/prometheus/latest/querying/basics/) | [/docs/Archives/promql-docs-2025-03.pdf](/docs/Archives/promql-docs-2025-03.pdf) | 2025-03-01 |
| AlertManager Documentation | [https://prometheus.io/docs/alerting/latest/alertmanager/](https://prometheus.io/docs/alerting/latest/alertmanager/) | [/docs/Archives/alertmanager-docs-2025-03.pdf](/docs/Archives/alertmanager-docs-2025-03.pdf) | 2025-03-01 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## **7.3 Change Request References**

This subsection documents formal change requests that have modified Prometheus, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-021 | Initial Prometheus deployment | 2025-01-10 | [GLPI-45302](https://glpi.lab.local/ticket/45302) |
| CR-2025-035 | Update to Prometheus 2.45.0 | 2025-02-05 | [GLPI-45987](https://glpi.lab.local/ticket/45987) |
| CR-2025-073 | Add SDR equipment monitoring | 2025-03-01 | [GLPI-46754](https://glpi.lab.local/ticket/46754) |

The change request table above tracks formal changes that have affected Prometheus, supporting troubleshooting and audit activities.

# ✅ **8. Approval & Review**

This section documents the formal review and approval process for this document, ensuring accountability and tracking who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 📜 **9. Change Log**

This section tracks the document's revision history, providing transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial documentation | VintageDon |

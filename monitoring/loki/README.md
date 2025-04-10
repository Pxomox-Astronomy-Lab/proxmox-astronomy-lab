<!-- 
---
title: "Loki Logging System - Proxmox Astronomy Lab"
description: "Documentation for Loki, including configuration and logging structure for centralized log aggregation in the lab environment."
author: "VintageDon"
tags: ["loki", "logging", "monitoring", "observability", "compliance", "grafana", "promtail"]
category: "Services"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-09"
related_services: ["Grafana", "Prometheus", "Alertmanager"]
implements_policies: ["Monitoring Policy", "Log Management Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.1", "CIS.8.2", "CIS.8.5", "CIS.8.10"]
iso27001_controls: ["A.12.4.1", "A.12.4.2", "A.12.4.3"]
nist_controls: ["AU-3", "AU-4", "AU-8", "AU-9", "SI-4"]
---
 -->

# 📊 **Loki Logging System**

# 🔍 **1. Overview**

This section provides the foundational context for Loki, explaining its purpose, scope, and implementation within the Proxmox Astronomy Lab's observability stack. Loki serves as the central logging solution that complements Prometheus metrics and Grafana visualizations.

## **1.1 Purpose**

This subsection clearly defines why Loki exists in our environment, the problems it addresses, and what value it provides to operations and security functions.

Loki serves as the **centralized logging solution** for the **Proxmox Astronomy Lab**, aggregating logs from infrastructure components. Unlike traditional log aggregation systems, Loki is **efficient and index-free**, designed to work seamlessly with **Promtail** and **Grafana** for log visualization and querying.

## **1.2 Scope**

This subsection defines the boundaries of what Loki covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|-------------|------------------|
| Aggregation of system logs | Advanced log correlation & AI analysis (future) |
| Promtail log scraping | Long-term log retention beyond 30 days |
| Integration with Grafana | SIEM-level security auditing |
| Compliance-required log capture | Full packet capture |
| Basic LogQL querying | Complex event correlation |

Loki is deployed on `lab-mon01` and ingests logs from various system components, including authentication, kernel, syslog, and security tools like Fail2Ban.

## **1.3 Target Audience**

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

This document is intended for:
- Infrastructure Engineers responsible for monitoring
- Security Administrators verifying logging compliance
- Operations Staff troubleshooting system issues
- Change Advisory Board members evaluating modifications

# 🔗 **2. Dependencies & Relationships**

This section maps how Loki relates to other elements within the environment, capturing both upstream and downstream dependencies that form the basis for impact analysis and service maps.

## **2.1 Related Services**

This subsection identifies other services that interact with Loki, establishing the service ecosystem and integration points.

Loki **relates to**:

- [Grafana](/docs/Applications/Observability/Grafana/Grafana-Server.md) - Provides visualization for Loki logs
- [Prometheus](/docs/Applications/Observability/Prometheus/Prometheus-Server.md) - Complements metrics with log data
- [Promtail](/docs/Applications/Observability/Loki/Promtail-Agent.md) - Agent that scrapes and forwards logs to Loki

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## **2.2 Implements Policies**

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

Loki **implements**:

- [Log Management Policy](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/08-audit-log-management/cisv81-08-audit-log-management-policy.md) - Fulfills requirements for centralized log collection
- [Security Monitoring Policy](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/13-network-monitoring-and-defense/cisv81-13-network-monitoring-and-defense-policy.md) - Supports security event monitoring requirements

The list above shows how Loki contributes to organizational compliance and governance objectives.

## **2.3 Responsibility Matrix**

This subsection defines accountabilities and responsibilities for key activities related to Loki, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure** | **Security Admin** | **Engineer** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Configuration Management | R/A | C | I | I |
| Log Retention | R | A/C | I | I |
| Query Access | R | A | I | C |
| Alert Configuration | R | A/C | I | I |
| Performance Monitoring | R/A | I | I | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 🛠️ **3. Technical Documentation**

This section provides the technical details necessary for Loki implementation, configuration, and troubleshooting, serving as the authoritative technical reference.

## **3.1 Architecture & Components**

This subsection explains the technical architecture, component relationships, and design decisions that shape the Loki implementation.

Loki operates within a three-component architecture:

1. **Loki Server** - Central service that stores and indexes logs
2. **Promtail Agents** - Deployed on monitored systems to collect and forward logs
3. **Grafana Frontend** - Provides log visualization and querying interface

Loki is deployed on `lab-mon01` (10.25.10.13) and listens on port 3100 for incoming logs from Promtail agents. It indexes logs based on labels rather than content, making it highly efficient for storage while maintaining query capabilities.

## **3.2 Configuration Details**

This subsection provides specific configuration parameters, file locations, and settings required for proper implementation and operation of Loki.

Loki's configuration is stored in `/etc/loki/config.yaml` with the following key parameters:

```yaml
# LOKI CONFIGURATION - PROXMOX ASTRONOMY LAB
# Centralized log aggregation using Loki.
# - Logs system, authentication, security, and package management events.
# - Retains logs for 30 days before compaction.
# - Integrated with Promtail for log collection.
# - Supports Grafana for log visualization.

server:
  # Loki's internal HTTP server for API access and log ingestion.
  http_listen_port: 3100

storage:
  # Storage configuration defines how and where logs are stored
  filesystem:
    directory: /var/lib/loki/chunks

schema_config:
  configs:
    - from: 2023-01-01
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

compactor:
  # Compaction settings for log storage efficiency
  working_directory: /var/lib/loki/compactor
  retention_enabled: true
  retention_delete_delay: 2h
  retention_delete_worker_count: 150

limits_config:
  # Log retention period settings
  retention_period: 720h  # 30 days

# Additional settings omitted for brevity
```

Promtail configuration on monitored systems includes the log sources to be collected:

```yaml
server:
  http_listen_port: 9080

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://10.25.10.13:3100/loki/api/v1/push

scrape_configs:
  # System logs via journalctl
  - job_name: system
    journal:
      max_age: "24h"
      labels:
        job: system
        hostname: ${HOSTNAME}

  # Auth logs for authentication events
  - job_name: auth
    static_configs:
    - targets: [ "localhost" ]
      labels:
        job: auth
        __path__: /var/log/auth.log
        hostname: ${HOSTNAME}

  # Additional log sources omitted for brevity
```

The configuration details above should be specific enough to enable complete implementation without requiring additional research.

## **3.3 Log Sources & Job Configuration**

This subsection documents the specific log sources collected by Loki through Promtail agents, establishing the log collection architecture.

Loki ingests logs from the following sources through Promtail:

| **Job Name** | **Log Path** | **Purpose** | **Compliance Control** |
|-------------|-------------|------------|------------------------|
| `system` | `journalctl` | General system events | CIS.8.2, NIST AU-3 |
| `auth` | `/var/log/auth.log` | Authentication events, SSH logins | CIS.8.1, NIST AC-7 |
| `kern` | `/var/log/kern.log` | Kernel messages and warnings | CIS.8.2, NIST SI-4 |
| `syslog` | `/var/log/syslog` | General system logs | CIS.8.2, NIST AU-3 |
| `dpkg` | `/var/log/dpkg.log` | Package installation logs | CIS.8.5, NIST CM-6 |
| `fail2ban` | `/var/log/fail2ban.log` | Banned IPs and intrusion attempts | CIS.8.10, NIST SI-4 |

The table above provides a comprehensive view of log sources collected by Loki, ensuring all critical system events are captured according to compliance requirements.

# 📊 **4. Management & Operations**

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for Loki, providing practical guidance needed for ongoing maintenance and support.

## **4.1 Routine Procedures**

This subsection documents regular maintenance and operational tasks required to keep Loki functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Storage usage verification | Weekly | Operations | [Loki Storage Check](/docs/Applications/Observability/Loki/storage-management.md) |
| Log retention audit | Monthly | Security Admin | [Log Retention Procedure](/docs/Compliance-Security/Assessment-Tools/log-retention-audit.md) |
| Performance review | Quarterly | Infrastructure | [Observability Performance Review](/docs/Control-Plane/Observability/performance-review.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## **4.2 Troubleshooting**

This subsection provides guidance for identifying and resolving common issues with Loki, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Missing logs in Grafana | Promtail service stopped | Check Promtail service status on affected host: `systemctl status promtail` | [Promtail Troubleshooting](/docs/Applications/Observability/Loki/promtail-troubleshooting.md) |
| High storage usage | Retention policy not enforced | Verify compactor is running and settings correctly applied | [Loki Storage Issues](/docs/Applications/Observability/Loki/storage-troubleshooting.md) |
| Query timeout errors | Complex LogQL query | Simplify query or increase query timeout in configuration | [LogQL Optimization](/docs/Applications/Observability/Loki/logql-optimization.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## **4.3 Integration with Grafana**

This subsection documents how Loki integrates with Grafana for log visualization and querying, providing the practical information needed for effective log analysis.

Loki logs are visualized in Grafana using the following configuration:

- **Grafana Data Source**: Named `Loki` with URL `http://10.25.10.13:3100`
- **Authentication**: None (internal network only)
- **Access Method**: Server (proxy through Grafana)

Key dashboards include:

| **Dashboard** | **Purpose** | **URL** |
|--------------|------------|--------|
| SSH Access Logs | Authentication monitoring | [https://grafana.lab.local/d/ssh-logs](https://grafana.lab.local/d/ssh-logs) |
| System Events | General system monitoring | [https://grafana.lab.local/d/system-events](https://grafana.lab.local/d/system-events) |
| Security Monitoring | Fail2Ban and auth failures | [https://grafana.lab.local/d/security-events](https://grafana.lab.local/d/security-events) |
| Package Management | Software installation tracking | [https://grafana.lab.local/d/package-events](https://grafana.lab.local/d/package-events) |

Basic LogQL queries for common tasks:

```
# View authentication failures
{job="auth"} |= "Failed"

# View kernel errors
{job="kern"} |= "error" or {job="kern"} |= "fail"

# View package installations
{job="dpkg"} |= "installed"
```

The integration details above provide practical guidance for using Loki's log data through Grafana's visualization capabilities.

# 🔐 **5. Security & Compliance**

This section documents how security controls are implemented in Loki and how compliance requirements are met, providing the mapping between security requirements and their practical implementation.

## **5.1 Security Controls**

This subsection documents specific security measures implemented for Loki, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Network Security | Loki listens only on internal VLAN10 | `netstat -tulpn \| grep loki` | CIS.12.2 |
| Access Control | No authentication at service layer, network segmentation enforced | VLAN verification | CIS.12.4 |
| Data Protection | Log files stored with restrictive permissions | `ls -la /var/lib/loki/chunks` | CIS.3.3 |
| Monitoring | Loki server health monitored via Prometheus | Grafana Loki dashboard | CIS.8.9 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## **5.2 CISv8.1 Compliance Mapping**

This subsection explicitly maps Loki implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.1 (Establish Log Management) | Centralized logging with Loki | Loki configuration file, Grafana dashboards | Compliant |
| CIS.8.2 (Collect Audit Logs) | Log collection via Promtail | Promtail scrape configs | Compliant |
| CIS.8.5 (Collect Software Installation Events) | DPKG log collection | Promtail configuration, Grafana dashboard | Compliant |
| CIS.8.10 (Retain Logs) | 30-day retention policy | Loki configuration file | Compliant |

The compliance mapping table above demonstrates how Loki satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## **5.3 Related Framework Mappings**

This subsection shows how controls implemented in Loki map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.8.1 | A.12.4.1 | PR.PT-1 | Centralized logging with retention |
| CIS.8.2 | A.12.4.2 | DE.CM-1 | Collection of system logs |
| CIS.8.5 | A.12.4.3 | DE.CM-7 | Software installation monitoring |
| CIS.8.10 | A.12.4.1 | PR.DS-4 | 30-day retention policy |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

# 💾 **6. Backup & Recovery**

This section documents data protection measures, backup strategies, and recovery procedures for Loki, providing the guidance needed to ensure business continuity and disaster recovery capabilities.

## **6.1 Backup Procedure**

This subsection details how Loki data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily at 02:00 UTC |
| **Backup Method** | Proxmox Backup Server job targeting `/var/lib/loki` |
| **Retention Policy** | 7 daily backups, 4 weekly backups |
| **Backup Location** | PBS storage pool on node05 |
| **Verification Process** | Weekly test recovery to validate backup integrity |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability of Loki log data.

## **6.2 Recovery Procedure**

This subsection provides recovery steps for various Loki failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Service failure | 30 min | 0 min | Service restart procedure | Operations |
| Storage corruption | 2 hours | 24 hours | Restore from backup | Infrastructure |
| Complete node failure | 4 hours | 24 hours | Migration to alternate server | Infrastructure |

Recovery procedures are documented in the [Loki Recovery Playbook](/docs/Applications/Observability/Loki/recovery-playbook.md).

The recovery procedure table above outlines steps to restore Loki service in different failure scenarios, supporting business continuity objectives.

# 📚 **7. References & Related Resources**

This section provides links to related documentation and external resources, establishing the connections between this document and other knowledge sources both internal and external.

## **7.1 Internal References**

This subsection identifies other internal documents related to Loki, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Installation Guide | Loki Installation | [/docs/Applications/Observability/Loki/installation-guide.md](/docs/Applications/Observability/Loki/installation-guide.md) | Detailed setup instructions |
| Dashboard Guide | Loki Dashboards | [/docs/Applications/Observability/Grafana/Dashboards/loki-dashboards.md](/docs/Applications/Observability/Grafana/Dashboards/loki-dashboards.md) | Visualization configuration |
| Query Guide | LogQL Examples | [/docs/Applications/Observability/Loki/logql-examples.md](/docs/Applications/Observability/Loki/logql-examples.md) | Query reference examples |
| Policy Document | Log Management Policy | [/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/08-audit-log-management/cisv81-08-audit-log-management-policy.md](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/08-audit-log-management/cisv81-08-audit-log-management-policy.md) | Governing policy for logs |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## **7.2 External References**

This subsection provides links to external resources that provide additional context, technical details, or supporting information about Loki.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Loki Documentation | [https://grafana.com/docs/loki/latest/](https://grafana.com/docs/loki/latest/) | [/docs/Archives/loki-docs-2025-03.pdf](/docs/Archives/loki-docs-2025-03.pdf) | 2025-03-01 |
| LogQL Query Language | [https://grafana.com/docs/loki/latest/logql/](https://grafana.com/docs/loki/latest/logql/) | [/docs/Archives/logql-docs-2025-03.pdf](/docs/Archives/logql-docs-2025-03.pdf) | 2025-03-01 |
| Promtail Documentation | [https://grafana.com/docs/loki/latest/clients/promtail/](https://grafana.com/docs/loki/latest/clients/promtail/) | [/docs/Archives/promtail-docs-2025-03.pdf](/docs/Archives/promtail-docs-2025-03.pdf) | 2025-03-01 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## **7.3 Change Request References**

This subsection documents formal change requests that have modified Loki, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-032 | Initial Loki deployment | 2025-01-15 | [GLPI-45321](https://glpi.lab.local/ticket/45321) |
| CR-2025-047 | Update Loki to v2.9.2 | 2025-02-10 | [GLPI-46102](https://glpi.lab.local/ticket/46102) |
| CR-2025-089 | Add DPKG log source | 2025-03-05 | [GLPI-47231](https://glpi.lab.local/ticket/47231) |

The change request table above tracks formal changes that have affected Loki, supporting troubleshooting and audit activities.

# ✅ **8. Approval & Review**

This section documents the formal review and approval process for this document, ensuring accountability and tracking who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-09 | ⏳ In Progress |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 📜 **9. Change Log**

This section tracks the document's revision history, providing transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-09 | Initial documentation | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.

<!-- 
---
title: "AlertManager Service"
description: "Documentation for the AlertManager service providing alert notification and routing capabilities for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["alertmanager", "monitoring", "notifications", "alerting", "prometheus", "teams", "power-automate"]
category: "Observability"
kb_type: "Service Document"
version: "1.0"
status: "Initial Implementation"
last_updated: "2025-04-23"
related_services: ["Prometheus", "Grafana", "Loki", "Teams"]
implements_policies: ["Monitoring Policy", "Incident Response Policy", "Notification Policy"]
phase: "phase-2"
cis_controls: ["CIS.8.11", "CIS.12.8", "CIS.19.7"]
iso27001_controls: ["A.12.1.1", "A.12.1.3", "A.16.1.2", "A.16.1.4"]
nist_controls: ["IR-4", "IR-5", "IR-6", "SI-4", "SI-5"]
---
-->

# 🔔 **AlertManager Service**

This document provides the authoritative reference for the AlertManager service in the Proxmox Astronomy Lab, documenting its implementation for alert notification, routing, and integration with Microsoft Teams.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the AlertManager service, its configuration, integration with notification systems, and operational procedures. It serves as the definitive reference for alert management within the Proxmox Astronomy Lab environment, enabling consistent notification of infrastructure and application issues.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| AlertManager server configuration | Alert rule definitions (covered in Prometheus documentation) |
| Alert notification routing | Detailed incident response procedures |
| Microsoft Teams integration via Power Automate | Notification content customization details |
| Basic operational procedures | Alert remediation automation |
| Future enhancement roadmap | Alert analytics and reporting |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Monitoring System Administrators
- Operations Team Members
- Incident Response Personnel
- DevOps Engineers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the AlertManager service within our operational framework.

### **2.1 Service Description**

AlertManager handles alerts sent by Prometheus and other monitoring systems, providing capabilities for deduplication, grouping, routing, and notification. It serves as the centralized notification hub that ensures the right people are informed about critical issues in the environment. The current implementation focuses on essential infrastructure monitoring alerts with planned expansion to more sophisticated alerting in future phases.

The AlertManager implementation currently covers basic infrastructure alerts including:

- High CPU utilization (>90% for 15 minutes)
- High memory utilization
- High disk usage
- Low disk space
- System availability/downtime

Alerts are routed to Microsoft Teams channels via Power Automate workflow and delivered as Adaptive Cards for improved readability and interaction.

> **Note:** This document reflects the initial implementation phase. Enhanced notification workflows, alert silencing, and advanced routing are planned for future phases.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | MON-ALRT-001 |
| **Service Type** | Core |
| **Service Category** | Observability |
| **Business Criticality** | High |
| **Service Owner** | Monitoring Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 24x7 (critical issues)<br>8x5 (non-critical) |
| **Maintenance Windows** | Monthly on second Sunday, 3AM-5AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Prometheus monitoring |
| **Notification Delivery Time** | <2 minutes | End-to-end notification testing |
| **Alert Processing Time** | <15 seconds | AlertManager metrics |
| **False Positive Rate** | <5% | Manual tracking and review |

### **3.2 Monitoring and Reporting**

AlertManager service health monitoring is implemented through:

- **Prometheus metrics**: AlertManager exposes metrics on port 9093
- **Synthetic alert testing**: Periodic test alerts to verify functionality
- **End-to-end notification testing**: Verification of delivery to Teams

Monthly service reports include metrics for alert volume, notification delivery statistics, and common alert patterns.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

AlertManager is deployed as a standalone service on the monitoring server (lab-mon01), with the following key architectural characteristics:

- **Integration with Prometheus** for alert reception
- **Local configuration file** for route and receiver definition
- **Webhook integration** with Power Automate for Teams notification
- **Grouping and deduplication** of similar alerts
- **Simple routing** based on alert severity and service

The architecture prioritizes reliability and simplicity in this initial phase, focusing on ensuring critical alerts are properly delivered to the appropriate Teams channels.

### **4.2 Infrastructure Components**

The following components comprise the AlertManager notification infrastructure:

| **Component** | **Description** | **Location** | **CMDB ID** |
|---------------|----------------|-------------|------------|
| **AlertManager Server** | Alert processing service | lab-mon01 | MON-ALRT-001 |
| **Power Automate Flow** | Workflow automation for Teams notification | Microsoft Cloud | CLOUD-PA-001 |
| **Teams Channels** | Notification destinations | Microsoft Teams | CLOUD-TEAMS-001 |

### **4.3 Server Configuration**

AlertManager is configured with the following basic settings:

```yaml
global:
  resolve_timeout: 5m
  http_config:
    follow_redirects: true
  smtp_hello: localhost
  smtp_require_tls: true
  pagerduty_url: https://events.pagerduty.com/v2/enqueue
  opsgenie_api_url: https://api.opsgenie.com/
  hipchat_api_url: https://api.hipchat.com/
  victorops_api_url: https://alert.victorops.com/integrations/generic/20131114/alert/

route:
  group_by: ['alertname', 'job', 'severity']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 4h
  receiver: 'teams-monitoring'
  routes:
  - match:
      severity: critical
    receiver: 'teams-critical'
    group_wait: 10s
    repeat_interval: 1h
  - match:
      severity: warning
    receiver: 'teams-monitoring'
  - match:
      severity: info
    receiver: 'teams-monitoring'
    group_wait: 2m
    repeat_interval: 12h

receivers:
- name: 'teams-critical'
  webhook_configs:
  - url: 'https://prod-xx.westus.logic.azure.com:443/workflows/xxx/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=xxxxx'
    send_resolved: true
- name: 'teams-monitoring'
  webhook_configs:
  - url: 'https://prod-xx.westus.logic.azure.com:443/workflows/xxx/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=xxxxx'
    send_resolved: true

inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'instance']
```

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | lab-mon01 host | Complete service outage |
| **Requires** | Prometheus | No alerts generated |
| **Requires** | Internet connectivity | Teams notification failure |
| **Requires** | Power Automate | Teams notification failure |
| **Required By** | Incident response workflow | Delayed incident detection |
| **Required By** | SLA monitoring | Service level tracking interruption |

### **4.5 Backup and Recovery**

The following parameters define our resilience strategy for AlertManager:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Weekly configuration backup |
| **Backup Method** | File system backup of configuration |
| **Backup Location** | Git repository and NFS share |
| **Recovery Time Objective (RTO)** | 1 hour |
| **Recovery Point Objective (RPO)** | 1 week |
| **Recovery Procedure** | [Link to recovery procedure document] |

## 🎯 **5. Alert Configuration**

This section documents the current alert configuration and planned enhancements.

### **5.1 Current Alert Categories**

The following baseline infrastructure alerts are currently configured:

| **Alert Category** | **Threshold** | **Severity** | **Description** |
|-------------------|-------------|------------|----------------|
| **High CPU Utilization** | >90% for 15 minutes | Warning | Sustained high processor usage |
| **Critical CPU Utilization** | >95% for 15 minutes | Critical | Critical processor saturation |
| **High Memory Usage** | >85% | Warning | Elevated memory consumption |
| **Critical Memory Usage** | >95% | Critical | Near-memory exhaustion |
| **High Disk Usage** | >85% | Warning | Elevated disk space consumption |
| **Critical Disk Usage** | >95% | Critical | Near-disk space exhaustion |
| **Service Down** | Instance unavailable | Critical | Service or host unavailability |

### **5.2 Alert Grouping Strategy**

Alerts are grouped by the following dimensions to reduce notification noise:

| **Grouping Dimension** | **Purpose** |
|------------------------|-----------|
| **alertname** | Combines alerts of the same type |
| **job** | Groups by monitoring job |
| **severity** | Separates by importance level |
| **instance** | Groups by affected system |

### **5.3 Teams Integration**

Microsoft Teams integration is implemented through Power Automate with the following characteristics:

| **Aspect** | **Implementation** |
|------------|-------------------|
| **Notification Format** | Adaptive Cards |
| **Critical Alert Channel** | #monitoring-critical |
| **Standard Alert Channel** | #monitoring-general |
| **Card Content** | Alert name, severity, system affected, timestamp, description |
| **Interactive Elements** | View details button linking to Grafana |

Sample Adaptive Card format:

```json
{
  "type": "AdaptiveCard",
  "body": [
    {
      "type": "Container",
      "style": "emphasis",
      "items": [
        {
          "type": "ColumnSet",
          "columns": [
            {
              "type": "Column",
              "width": "stretch",
              "items": [
                {
                  "type": "TextBlock",
                  "text": "ALERT: ${alertname}",
                  "wrap": true,
                  "weight": "Bolder",
                  "size": "Medium",
                  "color": "${if(severity == 'critical', 'attention', 'warning')}"
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "type": "FactSet",
      "facts": [
        {
          "title": "Severity",
          "value": "${severity}"
        },
        {
          "title": "System",
          "value": "${instance}"
        },
        {
          "title": "Time",
          "value": "${time}"
        },
        {
          "title": "Description",
          "value": "${description}"
        }
      ]
    }
  ],
  "actions": [
    {
      "type": "Action.OpenUrl",
      "title": "View in Grafana",
      "url": "${grafanaUrl}"
    }
  ],
  "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
  "version": "1.3"
}
```

## 🔄 **6. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **6.1 Access Management**

The following access control framework governs AlertManager administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Monitoring Admin** | Full administrative access | Security team approval |
| **Operations Team** | View access, silence capability | Team lead approval |
| **Incident Response** | View access | Security team approval |
| **Development Team** | No direct access | N/A |

### **6.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **AlertManager Outage** | Critical | P1 | 15 minutes | 2 hours |
| **Notification Failure** | High | P2 | 30 minutes | 4 hours |
| **Configuration Issue** | Medium | P3 | 2 hours | 8 hours |
| **False Positive Alert** | Low | P4 | 24 hours | 72 hours |

### **6.3 Change Management**

The following framework governs changes to the AlertManager service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | Yes | CAB approval | Maintenance window |
| **Configuration Change** | Yes | CAB approval | Maintenance window |
| **Receiver Addition** | No | Monitoring team approval | Business hours |
| **Route Modification** | Yes | CAB approval | Maintenance window |

## 🛠️ **7. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **7.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Health Check** | Daily | Operations Team | [ALRT-PROC-001] |
| **Notification Testing** | Weekly | Monitoring Team | [ALRT-PROC-002] |
| **Configuration Review** | Monthly | Monitoring Team | [ALRT-PROC-003] |
| **False Positive Analysis** | Monthly | Monitoring Team | [ALRT-PROC-004] |

### **7.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Notification Failure** | Alerts not appearing in Teams | Check Power Automate flow, verify webhook configuration | KEDB-ALRT-001 |
| **Alert Grouping Issues** | Too many individual notifications | Review grouping configuration, adjust group_by parameters | KEDB-ALRT-002 |
| **Duplicate Alerts** | Same alert appearing multiple times | Check deduplication settings, verify alert fingerprinting | KEDB-ALRT-003 |
| **Inhibition Failure** | Lower priority alerts not suppressed | Review inhibit_rules configuration | KEDB-ALRT-004 |

## 🔐 **8. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **8.1 Security Controls**

The following controls protect the AlertManager service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Network Security** | Internal network only, webhook over HTTPS | Network configuration review |
| **Webhook Authentication** | Signature-based authentication for Power Automate | Configuration verification |
| **Configuration Security** | File permissions, version control | Permission audit |
| **Access Control** | Restricted administrative access | User access review |

### **8.2 CISv8.1 Compliance Mapping**

This section documents how the AlertManager implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.8.11** | Real-time alerting for system abnormalities | Alert configuration | Compliant |
| **CIS.12.8** | Network device monitoring with alerts | SNMP alert configuration | Compliant |
| **CIS.19.7** | Incident notification and alerting | Teams integration | Compliant |

### **8.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.8.11** | A.12.1.1 | SI-4 | Real-time alert notification |
| **CIS.12.8** | A.12.1.3 | SI-5 | Security alerting capability |
| **CIS.19.7** | A.16.1.2 | IR-6 | Incident reporting automation |

## 🔮 **9. Future Enhancements**

This section outlines the planned enhancements for the AlertManager service in future phases.

### **9.1 Planned Features**

The following improvements are planned for future implementation phases:

| **Enhancement** | **Description** | **Priority** | **Planned Phase** |
|-----------------|----------------|------------|------------------|
| **Advanced Routing** | More sophisticated routing based on service, team, and time of day | High | Phase 3 |
| **Escalation Paths** | Multi-tier escalation for unacknowledged alerts | Medium | Phase 3 |
| **PagerDuty Integration** | Critical alert escalation to on-call personnel | Medium | Phase 3 |
| **Mobile App Notifications** | Direct push notifications to mobile devices | Low | Phase 4 |
| **Alert Correlation** | Root cause analysis through alert correlation | High | Phase 4 |
| **SIEM Integration** | Security event correlation with Wazuh | Medium | Phase 4 |

### **9.2 Alert Expansion**

Additional alert categories planned for future implementation:

| **Alert Category** | **Description** | **Priority** | **Planned Phase** |
|-------------------|----------------|------------|------------------|
| **Application-Specific Alerts** | Custom alerts for application performance and availability | High | Phase 3 |
| **Database Performance Alerts** | PostgreSQL performance and availability monitoring | High | Phase 3 |
| **Network Performance Alerts** | Advanced network metrics and thresholds | Medium | Phase 3 |
| **Security Threshold Alerts** | Security-relevant event thresholds | High | Phase 4 |
| **Business Logic Alerts** | Alerts based on business process metrics | Medium | Phase 4 |

## 🔗 **10. Integration With Other Services**

This section documents how AlertManager integrates with other key services in the environment.

### **10.1 Prometheus Integration**

AlertManager receives alerts from Prometheus:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Alert Rules Source** | Prometheus alert.rules.yml |
| **Evaluation Interval** | 15 seconds (configured in Prometheus) |
| **Communication Path** | Direct Prometheus to AlertManager API |

### **10.2 Power Automate Integration**

Microsoft Power Automate handles the webhook processing and Teams notification:

| **Aspect** | **Configuration** |
|------------|------------------|
| **Trigger Type** | HTTP Webhook |
| **Authentication** | URL signature-based |
| **Processing Logic** | JSON parsing, Adaptive Card formatting |
| **Destination** | Teams channel based on severity |

### **10.3 Grafana Integration**

Alerts can link directly to Grafana dashboards:

| **Aspect** | **Configuration** |
|------------|------------------|
| **URL Construction** | Dynamic based on alert labels |
| **Time Range** | Set to span alert period |
| **Dashboard Selection** | Based on service and metrics |

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

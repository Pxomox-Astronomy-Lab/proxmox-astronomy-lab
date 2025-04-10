<!-- 
---
title: "Proxmox Cluster Monitoring - Proxmox Astronomy Lab"
description: "Documentation for Proxmox cluster-level monitoring using InfluxDB and Grafana in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["proxmox", "monitoring", "influxdb", "grafana", "metrics", "observability"]
category: "Monitoring"
kb_type: "Service Document"
version: "1.0"
status: "Draft"
last_updated: "2025-04-04"
related_services: ["Grafana", "InfluxDB", "Prometheus", "Node Exporter"]
implements_policies: ["Monitoring Policy", "Observability Standards"]
phase: "phase-2"
cis_controls: ["CIS.8.9", "CIS.8.10", "CIS.12.8"]
iso27001_controls: ["A.12.1.3", "A.12.4.1"]
nist_controls: ["CA-7", "SI-4"]
---
 -->

# 📊 **Proxmox Cluster Monitoring**

# 🔍 **1. Overview**

This section provides the foundational context for Proxmox Cluster Monitoring, explaining its purpose, scope, and implementation within the Proxmox Astronomy Lab's observability stack. It serves as the authoritative source for cluster-level monitoring from the virtualization layer.

## **1.1 Purpose**

This subsection clearly defines why Proxmox Cluster Monitoring exists in our environment, the problems it addresses, and what value it provides to operations.

The **Proxmox metrics server** provides a **native, low-overhead** method for collecting high-level cluster and node metrics. These metrics are **pushed directly to InfluxDB** and visualized in **Grafana**, offering a **more reliable** source of cluster-wide health data compared to scraped exporters.

This setup does **not replace Node Exporter**, but rather **complements it**:

- **Proxmox Metrics → Best for Cluster-Wide Monitoring** (high-level, built-in, reliable)
- **Node Exporter → Best for Deep-Dive System Analysis** (per-node, granular, detailed)

By integrating both, we get **the best of both worlds**: a **trustworthy cluster view** with **detailed system telemetry** when needed.

## **1.2 Scope**

This subsection defines the boundaries of what Proxmox Cluster Monitoring covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Cluster-wide CPU and memory utilization | Process-level monitoring (use Node Exporter) |
| VM status and performance metrics | Container-level metrics (use cAdvisor) |
| Storage pool and datastore utilization | Application performance (use application exporters) |
| Node availability and status | Security monitoring (use Wazuh) |
| Aggregated I/O performance | Log aggregation (use Loki) |

The Proxmox Cluster Monitoring system integrates the built-in metrics capabilities of Proxmox VE with InfluxDB for storage and Grafana for visualization, providing insight into the virtualization layer's health and performance.

## **1.3 Target Audience**

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

This document is intended for:
- Infrastructure Engineers responsible for Proxmox management
- Operations Staff monitoring cluster health
- Capacity Planners analyzing resource utilization trends
- Service Owners verifying platform performance

# 🔗 **2. Dependencies & Relationships**

This section maps how Proxmox Cluster Monitoring relates to other elements within the environment, capturing both upstream and downstream dependencies that form the basis for impact analysis and service maps.

## **2.1 Related Services**

This subsection identifies other services that interact with Proxmox Cluster Monitoring, establishing the service ecosystem and integration points.

Proxmox Cluster Monitoring **relates to**:

- [InfluxDB](/docs/Applications/Databases/InfluxDB/InfluxDB-Server.md) - Time-series database that stores Proxmox metrics
- [Grafana](/docs/Applications/Observability/Grafana/Grafana-Server.md) - Visualizes Proxmox metrics data
- [Prometheus](/docs/Applications/Observability/Prometheus/Prometheus-Server.md) - Complements with additional scraped metrics
- [Node Exporter](/docs/Applications/Observability/Prometheus/Exporters/Node-Exporter.md) - Provides detailed OS-level metrics

The list above documents service dependencies that should be considered when making changes or troubleshooting issues with Proxmox Cluster Monitoring.

## **2.2 Implements Policies**

This subsection connects this document to the governance framework by identifying which organizational policies Proxmox Cluster Monitoring implements or supports.

Proxmox Cluster Monitoring **implements**:

- [Monitoring Policy](/docs/Compliance-Security/Security-Policies/CIS-Security-Policies/13-network-monitoring-and-defense/cisv81-13-network-monitoring-and-defense-policy.md) - Fulfills requirements for infrastructure monitoring
- [Observability Standards](/docs/Control-Plane/Observability/observability-standards.md) - Adheres to lab-wide observability principles

The list above shows how Proxmox Cluster Monitoring contributes to organizational compliance and governance objectives.

## **2.3 Responsibility Matrix**

This subsection defines accountabilities and responsibilities for key activities related to Proxmox Cluster Monitoring, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure** | **Security Admin** | **Engineer** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Configuration Management | R/A | I | C | I |
| Dashboard Maintenance | R | I | C | R/A |
| Performance Monitoring | R | I | I | R/A |
| Alert Response | I | C | I | R/A |
| Capacity Planning | R/A | I | C | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 🔄 **3. Architecture & Data Flow**

This section provides the technical details necessary for understanding the Proxmox Cluster Monitoring implementation, configuration, and data flow, serving as the authoritative technical reference.

## **3.1 Component Architecture**

This subsection explains the technical architecture, component relationships, and design decisions that shape the Proxmox Cluster Monitoring implementation.

The Proxmox cluster monitoring stack consists of the following components:

| **Component** | **Role** |
|--------------|----------|
| **Proxmox Metrics Server** | Natively pushes cluster and VM stats to InfluxDB |
| **InfluxDB (lab-mon01)** | Stores Proxmox's metrics (running as a container) |
| **Grafana (lab-mon01)** | Visualizes cluster performance data |
| **AlertManager** | Uses Proxmox's direct metrics for more accurate alerting |

These components work together to provide a comprehensive view of the Proxmox cluster's health and performance, with data flowing from the Proxmox nodes to InfluxDB and then being visualized in Grafana.

## **3.2 Configuration Details**

This subsection provides specific configuration parameters, file locations, and settings required for proper implementation and operation of Proxmox Cluster Monitoring.

The Proxmox metrics server is configured through the Proxmox web interface under Datacenter > Options > Metrics Server:

| **Parameter** | **Value** | **Purpose** |
|--------------|----------|------------|
| **Enable** | Yes | Activates metrics collection |
| **Server** | 10.25.10.13 | InfluxDB server address |
| **Port** | 8086 | InfluxDB service port |
| **Transport** | HTTPS | Secure connection to InfluxDB |
| **Organization** | proxlab | InfluxDB organization |
| **Bucket** | proxmox | InfluxDB storage bucket |
| **Token** | [Secure Token] | Authentication token (stored in Vault) |
| **Verify Certificate** | Yes | Validates TLS certificate |

The configuration screenshot below shows the actual settings in the Proxmox interface:

![proxmox-metrics-server-settings](/assets/images/proxmox-metrics-server-settings.png)

The settings above establish a secure connection between Proxmox and InfluxDB, enabling metrics to be pushed directly without the need for external scrapers.

## **3.3 Advantages of Native Metrics**

This subsection explains the benefits of using Proxmox's native metrics capabilities compared to external scraping methods, providing justification for the design decisions.

### **3.3.1 Benefits Over External Scrapers**

Using Proxmox's built-in metrics server provides several key advantages:

- **Source of Truth Data**: Proxmox itself reports its state, eliminating discrepancies
- **Lower Overhead**: Push-based model reduces the impact of constant polling
- **Complete Coverage**: Captures metrics that external scrapers cannot access
- **VM-Aware Monitoring**: Understands the relationship between VMs and hosts
- **Reliable Status Information**: Accurately reflects Proxmox's internal view of component health

### **3.3.2 Metrics Comparison**

The following table compares the metrics available through Proxmox's native metrics server versus those collected by Node Exporter:

| **Metric Type** | **Proxmox Metrics Server** | **Node Exporter** |
|-----------------|---------------------------|------------------|
| Cluster-wide CPU/memory | ✅ Yes | ❌ No |
| VM I/O and network usage | ✅ Yes | ❌ No |
| VM power state awareness | ✅ Yes | ❌ No |
| Storage pool utilization | ✅ Yes | ❌ No |
| Node CPU temperature | ❌ No | ✅ Yes |
| Per-core CPU usage | ❌ No | ✅ Yes |
| Per-node disk I/O & partitions | ❌ No | ✅ Yes |
| Process-level monitoring | ❌ No | ✅ Yes |

The comparison above demonstrates that both monitoring approaches have complementary strengths, justifying the use of both systems in parallel.

# 📊 **4. Visualization & Dashboards**

This section covers the visualization of Proxmox metrics in Grafana, including dashboard configurations and alert definitions.

## **4.1 Dashboard Overview**

This subsection documents the Grafana dashboards used to visualize Proxmox metrics, providing a reference for operations staff.

The following dashboards have been created for Proxmox Cluster Monitoring:

| **Dashboard** | **Purpose** | **URL** | **Screenshot** |
|--------------|------------|--------|----------------|
| **Proxmox Cluster Overview** | High-level cluster health and utilization | [https://grafana.lab.local/d/proxmox-cluster](https://grafana.lab.local/d/proxmox-cluster) | [Cluster Dashboard](/assets/images/dashboards/proxmox-cluster-flux-graphical-dashboard-screenshot.png) |
| **Proxmox Node Performance** | Detailed node-level metrics | [https://grafana.lab.local/d/proxmox-nodes](https://grafana.lab.local/d/proxmox-nodes) | [Node Dashboard](/assets/images/dashboards/promox-cluster-flux-numerical-dashboard-screenshot.png) |
| **Proxmox VM Performance** | VM-specific performance metrics | [https://grafana.lab.local/d/proxmox-vms](https://grafana.lab.local/d/proxmox-vms) | Not shown |
| **Proxmox Storage Utilization** | Storage pool and datastore metrics | [https://grafana.lab.local/d/proxmox-storage](https://grafana.lab.local/d/proxmox-storage) | Not shown |

The screenshot below shows the main Proxmox Cluster Dashboard:

![proxmox-cluster-flux-graphical-dashboard-screenshot](/assets/images/dashboards/proxmox-cluster-flux-graphical-dashboard-screenshot.png)

These dashboards provide comprehensive visibility into the Proxmox virtualization environment, enabling operations staff to monitor health, performance, and capacity.

## **4.2 Alert Configuration**

This subsection documents the alerts configured for Proxmox Cluster Monitoring, establishing the threshold values and notification channels.

The following alerts have been configured based on Proxmox metrics:

| **Alert Name** | **Threshold** | **Severity** | **Notification Channel** |
|----------------|--------------|--------------|--------------------------|
| **Node Down** | No data for 5m | Critical | Teams, Email, SMS |
| **High Cluster CPU** | >85% for 15m | Warning | Teams, Email |
| **High Cluster Memory** | >90% for 15m | Warning | Teams, Email |
| **Storage Pool Critical** | >95% for 1h | Critical | Teams, Email |
| **VM Unreachable** | Status != "running" for configured VMs | Warning | Teams |

These alerts provide proactive notification of potential issues with the Proxmox cluster, enabling timely intervention to prevent service impacts.

# 🔍 **5. Security & Compliance**

This section documents how security controls are implemented in Proxmox Cluster Monitoring and how compliance requirements are met, providing the mapping between security requirements and their practical implementation.

## **5.1 Security Controls**

This subsection documents specific security measures implemented for Proxmox Cluster Monitoring, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Authentication | Secure API token for InfluxDB access | Token verification | CIS.12.1 |
| Transport Security | HTTPS for all communications | TLS verification | CIS.12.4 |
| Access Control | Role-based access to Grafana dashboards | Permission audit | CIS.12.3 |
| Data Protection | InfluxDB data encrypted at rest | Storage verification | CIS.12.6 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## **5.2 CISv8.1 Compliance Mapping**

This subsection explicitly maps Proxmox Cluster Monitoring implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.9 (Centralized Monitoring) | Centralized collection of Proxmox metrics | InfluxDB configuration | Compliant |
| CIS.8.10 (Retention of Metrics) | 90-day retention policy in InfluxDB | InfluxDB retention policy | Compliant |
| CIS.12.8 (Platform Monitoring) | Comprehensive Proxmox platform metrics | Grafana dashboards | Compliant |

The compliance mapping table above demonstrates how Proxmox Cluster Monitoring satisfies specific CIS Controls requirements, supporting audit and assessment activities.

# 🚀 **6. Next Steps**

This section documents planned enhancements and future work for Proxmox Cluster Monitoring, providing a roadmap for continued improvement.

## **6.1 Completed Milestones**

This subsection documents what has already been accomplished with Proxmox Cluster Monitoring.

The following milestones have been completed:

- ✅ **Proxmox Metrics → InfluxDB pipeline is fully operational**
- ✅ **Grafana dashboards structured for optimal cluster visibility**
- ✅ **Basic alerting configured for critical cluster states**

## **6.2 Planned Enhancements**

This subsection documents planned improvements to Proxmox Cluster Monitoring, establishing a roadmap for future development.

The following enhancements are planned:

- 📌 **Expand alerting to prioritize Proxmox-based metrics over log-based alerts**
- 📌 **Integrate VM performance data with application-level metrics for correlation**
- 📌 **Develop capacity planning dashboards based on historical usage patterns**
- 📌 **Automate dashboard deployment & integrate additional Proxmox metadata**

These enhancements will further improve the visibility and utility of Proxmox Cluster Monitoring, enabling more proactive management of the virtualization environment.

# ✅ **7. Approval & Review**

This section documents the formal review and approval process for this document, ensuring accountability and tracking who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ⏳ In Progress |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 📜 **8. Change Log**

This section tracks the document's revision history, providing transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Initial documentation | VintageDon |

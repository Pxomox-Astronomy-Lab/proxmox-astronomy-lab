<!-- 
---
title: "CIS Control 1: Inventory and Control of Enterprise Assets - Proxmox Astronomy Lab"
description: "Implementation of CIS Control 1 for maintaining comprehensive inventory and control of all enterprise assets within the Proxmox Astronomy Lab"
author: "VintageDon"
tags: ["security", "compliance", "cisv8", "asset-management", "inventory", "enterprise-assets"]
category: "Security"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🖥️ **CIS Control 1: Inventory and Control of Enterprise Assets**

## 🔍 **1. Overview**

CIS Control 1 focuses on the **accurate inventory and effective control of all enterprise assets** within the Proxmox Astronomy Lab. This foundational security control ensures that **only authorized devices can connect to the network** and that all assets are **properly tracked, monitored, and managed** throughout their lifecycle.

This documentation covers our implementation of CIS Control 1, including **automated asset discovery, inventory management processes, unauthorized device detection**, and compliance validation methods.

This implementation is based on the official CIS Control 1 policy templates published by the Center for Internet Security (CISSecurity.org), ensuring structural alignment with industry-standard compliance requirements.

---

## 🎯 **2. Control Objectives**

### **2.1 Primary Goals**

The implementation of CIS Control 1 achieves several key security objectives:

| **Objective** | **Description** | **Implementation Approach** |
|--------------|----------------|----------------------------|
| **Complete Asset Visibility** | Maintain accurate inventory of all hardware and virtual assets | Centralized tracking via GLPI, Netbox, and Azure Arc |
| **Unauthorized Asset Detection** | Quickly identify unauthorized devices connecting to networks | Network scanning, DHCP monitoring, and Wazuh alerts |
| **Network Access Control** | Ensure only compliant and authorized assets connect to lab networks | Quarantine VLANs, Fortigate firewall enforcement |
| **Asset Lifecycle Management** | Track assets from acquisition through decommissioning | Formal onboarding/offboarding procedures with audit trail |

### **2.2 Compliance Mapping**

This control satisfies requirements across multiple security frameworks:

| **Framework** | **Control Reference** | **Description** |
|--------------|----------------------|----------------|
| **CIS Controls v8.1** | Control 1 | Inventory and Control of Enterprise Assets |
| **NIST 800-53 Rev 5** | CM-8, CM-9 | System Component Inventory, Configuration Management Plan |
| **ISO 27001:2022** | A.8.1 | Asset Management |
| **MITRE ATT&CK** | Initial Access (TA0001) | Mitigates unauthorized device-based attack vectors |

---

## 🛠️ **3. Implementation Details**

### **3.1 Asset Inventory Systems**

The lab employs multiple integrated systems to maintain comprehensive asset inventory:

| **System** | **Purpose** | **Assets Tracked** | **Integration Points** |
|------------|------------|-------------------|------------------------|
| **GLPI** | Primary asset management platform | Physical hardware, virtual servers, network equipment | AD integration, API automation |
| **Netbox** | Network infrastructure documentation | IP space, network topology, rack layouts | Automated network scanning |
| **Active Directory** | Identity management and computer registration | Windows servers, workstations | Entra ID sync, hybrid join |
| **Azure Arc** | Cloud management of on-prem resources | Linux servers, Kubernetes clusters | Azure Monitor, Azure Policy |
| **Osquery** | Real-time system inventory and state monitoring | Software, configuration, network connections | Wazuh integration |

This multi-layered approach ensures that assets are tracked from multiple perspectives, creating redundancy in the inventory process.

### **3.2 Asset Discovery & Registration**

#### **3.2.1 Automated Discovery Methods**

The lab implements several automated discovery mechanisms to ensure comprehensive asset visibility:

| **Discovery Method** | **Scope** | **Frequency** | **Implementation Details** |
|---------------------|----------|--------------|---------------------------|
| **Network Scanning** | All networked devices | Quarterly | Nmap integration with Netbox |
| **DHCP Logs Analysis** | Dynamic IP allocations | Real-time | Windows Server 2025 DHCP logs to Wazuh |
| **Active Directory Computer Objects** | Domain-joined systems | Real-time | PowerShell automation scripts |
| **Kubernetes Node Registration** | Container platform | Continuous | RKE2 node registration validation |
| **Proxmox API Integration** | Virtual machines | Quarterly | Custom scripts to validate VM inventory |

#### **3.2.2 Asset Registration Workflow**

New assets follow a formal registration process:

1. **Procurement Registration** - Assets are added to GLPI during procurement
2. **Deployment Configuration** - Systems are configured according to baselines
3. **Network Registration** - MAC addresses are authorized in DHCP/network controls
4. **Active Monitoring Enrollment** - Systems are added to monitoring platforms
5. **Compliance Verification** - Initial baseline compliance is validated

This structured workflow ensures that only properly configured and documented assets enter the environment.

### **3.3 Unauthorized Asset Detection & Response**

#### **3.3.1 Detection Methods**

The lab employs multiple approaches to detect unauthorized assets:

| **Detection Mechanism** | **Implementation** | **Response Action** |
|------------------------|-------------------|---------------------|
| **MAC Address Filtering** | Unauthorized MACs trigger alerts | Quarantine VLAN assignment |
| **Network Segment Monitoring** | Wazuh alerts on unexpected devices | Security team notification |
| **Rogue DHCP Detection** | Fortigate firewall monitoring | Automatic port shutdown |
| **Periodic Network Validation** | Scheduled discovery scans | Reconciliation with inventory |

#### **3.3.2 Response Workflow**

When unauthorized assets are detected, the following response procedure is initiated:

1. **Automatic Quarantine** - Device is isolated in a restricted VLAN
2. **Investigation** - Security team determines if device is legitimate
3. **Registration/Removal** - Device is either properly registered or removed
4. **Root Cause Analysis** - Process gaps are identified and addressed
5. **Documentation** - Incident is recorded for trend analysis

---

## 📊 **4. Verification & Validation**

### **4.1 Compliance Metrics**

The following metrics are tracked to measure the effectiveness of asset control:

| **Metric** | **Target** | **Measurement Method** | **Current Status** |
|------------|-----------|------------------------|-------------------|
| **Inventory Accuracy** | >99% | Quarterly physical audit | 99.7% |
| **Unauthorized Device Detection Time** | <15 minutes | Wazuh alert timing | 8 minutes avg |
| **Asset Onboarding Compliance** | 100% | Process validation checks | 100% |
| **Inventory Metadata Completeness** | >95% | GLPI reporting | 97.3% |

### **4.2 Validation Procedures**

Regular validation ensures the continued effectiveness of asset controls:

| **Validation Activity** | **Frequency** | **Responsible Role** | **Documentation** |
|------------------------|--------------|----------------------|-------------------|
| **Physical Asset Audit** | Quarterly | Infrastructure Engineer | [Audit Procedure](../../security-monitoring/audit-procedures.md) |
| **Network Discovery vs. Inventory** | Quarterly | Security Administrator | [Network Validation](../../security-monitoring/network-validation.md) |
| **Active Directory Reconciliation** | Quarterly | Systems Administrator | [AD Audit Script](../../security-automation/scripts/ad-inventory-audit.ps1) |
| **Vulnerability Scan Coverage** | Semi-annual | Security Administrator | [Scan Coverage Report](../../security-monitoring/vulnerability-scan-coverage.md) |

---

## 🔄 **5. Operational Procedures**

### **5.1 Asset Lifecycle Management**

The following procedures govern the full lifecycle of enterprise assets:

| **Lifecycle Stage** | **Key Procedures** | **Documentation** |
|--------------------|-------------------|-------------------|
| **Acquisition** | Procurement registration, security review | [Asset Acquisition](../../itil-processes/asset-management/acquisition-procedure.md) |
| **Deployment** | Configuration, baseline compliance, inventory | [Asset Deployment](../../itil-processes/asset-management/deployment-procedure.md) |
| **Maintenance** | Updates, compliance checking, recertification | [Asset Maintenance](../../itil-processes/asset-management/maintenance-procedure.md) |
| **Decommissioning** | Data sanitization, inventory update, disposal | [Asset Retirement](../../itil-processes/asset-management/retirement-procedure.md) |

### **5.2 Role Responsibilities**

Clear role assignments ensure accountability for asset management:

| **Role** | **Primary Responsibilities** | **Secondary Responsibilities** |
|----------|----------------------------|-------------------------------|
| **Lab Owner** | Asset budget approval, inventory review | Policy exception approval |
| **Infrastructure Engineer** | Infrastructure asset management | System hardening, automation |
| **Security Administrator** | Security compliance validation | Unauthorized device response |
| **System Administrator** | System configuration, AD management | Asset metadata maintenance |

---

## 🚀 **6. Tools & Resources**

The following tools support the implementation of CIS Control 1:

| **Tool** | **Purpose** | **Documentation** |
|----------|------------|-------------------|
| **GLPI** | Primary asset management system | [GLPI Configuration](../../applications/glpi/configuration.md) |
| **Netbox** | IP and network infrastructure management | [Netbox Setup](../../applications/netbox/setup.md) |
| **Wazuh** | Security monitoring and alert management | [Wazuh Configuration](../../security-monitoring/wazuh/configuration.md) |
| **Osquery** | Real-time system state monitoring | [Osquery Deployment](../../security-monitoring/osquery/deployment.md) |
| **Fortigate 40F** | Network access control enforcement | [Fortigate Configuration](../../networking/fortigate/configuration.md) |

---

## 🔗 **7. Related Documentation**

| **Document** | **Description** | **Location** |
|--------------|----------------|-------------|
| **Enterprise Asset Management Policy** | Comprehensive policy document | [Asset Management Policy](cisv81-01-enterprise-asset-management-policy.md) |
| **CIS Controls Implementation Guide** | Overall compliance framework | [CIS Implementation](../README.md) |
| **Network Security Architecture** | Network controls and segmentation | [Network Security](../../networking/security-architecture.md) |
| **Security Monitoring Configuration** | Detection and alerting setup | [Security Monitoring](../../security-monitoring/configuration.md) |
| **CIS Security Policy Templates** | Official CIS policy templates | [CIS Policy Templates](https://www.cisecurity.org/insights/white-papers/cis-controls-v8-implementation-guide-for-small-medium-enterprises) |

---

## ✅ **8. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **9. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial documentation of CIS Control 1 implementation | VintageDon |
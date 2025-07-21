<!--
---
title: "CIS Control 1: Inventory and Control of Enterprise Assets"
description: "Implementation of CIS Control 1 for Proxmox Astronomy Lab including enterprise asset inventory, management procedures, and security controls mapped to NIST CSF 2.0 and NIST AI RMF supporting astronomical computing platform security assurance"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Anthropic Claude 4 Sonnet (claude-4-sonnet-20250514)"
date: "2025-07-20"
version: "1.0"
status: "Published"
tags:
- type: security-control-implementation
- domain: asset-management
- tech: enterprise-inventory
- tech: asset-tracking
- compliance: cis-control-1
- compliance: nist-csf-2-0
- compliance: nist-ai-rmf
- phase: phase-1
related_documents:
- "[Security Assurance Overview](../README.md)"
- "[Hardware Infrastructure](../../hardware/README.md)"
- "[Infrastructure Overview](../../infrastructure/README.md)"
---
-->

# 🏗️ **CIS Control 1: Inventory and Control of Enterprise Assets**

This directory contains the implementation of CIS Control 1: Inventory and Control of Enterprise Assets for the Proxmox Astronomy Lab, focusing on actively managing (inventory, track, and correct) all enterprise assets connected to the infrastructure physically, virtually, remotely, and those within cloud environments. This control establishes the foundation for security monitoring, incident response, and asset protection across our astronomical computing platform.

## **Overview**

CIS Control 1 emphasizes that enterprises cannot defend what they do not know they have, making managed control of all enterprise assets critical for security monitoring, incident response, system backup, and recovery. Our implementation addresses the comprehensive asset management requirements for the 7-node Proxmox cluster, including physical servers, virtual machines, network devices, and specialized astronomical computing equipment.

The control implementation supports our enterprise astronomical computing platform by providing systematic asset tracking, unauthorized asset detection, and comprehensive inventory management that enables effective security controls, monitoring integration, and incident response capabilities essential for research computing environments.

---

## **📂 Directory Contents**

This section provides systematic navigation to all CIS Control 1 implementation documentation within this category.

### **Core Documentation**

| **Document** | **Purpose** | **Link** |
|--------------|-------------|----------|
| **[README.md](README.md)** | This file - CIS Control 1 implementation overview and framework mapping | [README.md](README.md) |

### **Implementation Documentation**

*The following CIS Control 1 implementation documentation will be developed:*

- **Enterprise Asset Inventory**: Detailed inventory procedures and asset management systems
- **Asset Classification**: Asset type classification and security categorization procedures
- **Unauthorized Asset Detection**: Procedures for identifying and addressing unauthorized assets
- **Asset Lifecycle Management**: Asset provisioning, management, and decommissioning procedures
- **Monitoring Integration**: Asset monitoring and security event correlation procedures
- **Compliance Evidence**: Documentation and evidence collection for audit and compliance validation

---

## **📁 Repository Structure**

```
security-assurance/01-inventory-and-control-of-enterprise-assets/
├── evidence/                        # Compliance evidence and documentation
└── 📝 README.md                    # This file - implementation overview
```

*Additional implementation documentation will be organized as:*

```
security-assurance/01-inventory-and-control-of-enterprise-assets/ (Future Structure)
├── 📋 enterprise-asset-inventory.md # Detailed inventory procedures and systems
├── 🏷️ asset-classification.md       # Asset type classification and categorization
├── 🚨 unauthorized-asset-detection.md # Detection and response procedures
├── 🔄 asset-lifecycle-management.md # Provisioning and decommissioning procedures
├── 📊 monitoring-integration.md     # Asset monitoring and security correlation
├── ✅ compliance-evidence.md        # Audit evidence and validation documentation
├── evidence/                        # Supporting evidence and documentation
│   ├── asset-inventory-reports.md
│   ├── discovery-scan-results.md
│   └── dhcp-logs-analysis.md
└── 📝 README.md                    # This file
```

### **Navigation Guide:**

- **[📝 Control Implementation](README.md)** - CIS Control 1 implementation and framework alignment
- **[🔒 Security Assurance](../README.md)** - Broader security assurance framework and CIS Controls implementation
- **[🖥️ Hardware Infrastructure](../../hardware/README.md)** - Physical assets and infrastructure inventory
- **[🏗️ Infrastructure Overview](../../infrastructure/README.md)** - Virtual assets and service inventory

---

## **Framework Alignment**

### **NIST CSF 2.0 Mapping**

CIS Control 1 aligns with NIST Cybersecurity Framework 2.0, particularly supporting the Identify function and establishing governance foundations for cybersecurity programs:

**Primary CSF 2.0 Functions:**
- **GV.OC (Organizational Context)**: Enterprise asset inventory supports organizational cybersecurity context
- **ID.AM (Asset Management)**: Direct alignment with asset inventory and management requirements
- **ID.RA (Risk Assessment)**: Asset inventory enables comprehensive risk assessment and management
- **PR.AT (Awareness and Training)**: Asset awareness supporting security training and procedures

**CSF 2.0 Categories Supported:**
- **ID.AM-1**: Physical devices and systems are inventoried
- **ID.AM-2**: Software platforms and applications are inventoried
- **ID.AM-3**: Organizational communication and data flows are mapped
- **ID.AM-4**: External information systems are catalogued

### **NIST AI Risk Management Framework Integration**

The NIST AI Risk Management Framework (AI RMF) emphasizes the need for systematic risk management throughout the AI lifecycle, including governance, mapping, measurement, and management functions:

**AI RMF Function Alignment:**
- **GOVERN**: Asset inventory supports AI governance through systematic tracking of AI-enabled systems
- **MAP**: Asset classification enables mapping of AI systems within organizational context
- **MEASURE**: Asset monitoring provides measurement capabilities for AI system performance and risks
- **MANAGE**: Asset lifecycle management enables systematic AI risk management and response

**AI Asset Considerations:**
- **GPU Computing Assets**: RTX A4000 and specialized ML/AI computing resources
- **AI-Enabled Services**: Astronomical analysis tools and machine learning platforms
- **Data Assets**: Training datasets and model artifacts requiring specialized protection
- **AI Development Infrastructure**: Kubernetes clusters and container platforms supporting AI workloads

---

## **CIS Control 1 Safeguards Implementation**

### **Safeguard 1.1: Establish and Maintain Detailed Enterprise Asset Inventory**

Establish and maintain an accurate, detailed, and up-to-date inventory of all enterprise assets with the potential to store or process data, including end-user devices, network devices, non-computing/IoT devices, and servers:

**Physical Infrastructure Assets:**
- **Compute Nodes**: 7 enterprise nodes (node01-node06 active, node07 pending)
- **CPU Resources**: 104+ cores across active nodes with Intel 12900H and 12600H processors
- **Memory Resources**: 500+ GB RAM across cluster nodes
- **Storage Infrastructure**: 13+ TB enterprise NVMe storage across cluster
- **Network Equipment**: Managed switches, firewall, and network infrastructure

**Virtual Infrastructure Assets:**
- **Virtual Machines**: 18+ production VMs across management, project, and infrastructure roles
- **Container Infrastructure**: Docker hosts and RKE2 Kubernetes cluster
- **Database Systems**: PostgreSQL, MongoDB, and specialized astronomical databases
- **File Services**: MinIO object storage and Windows file servers

### **Safeguard 1.2: Address Unauthorized Assets**

Ensure that unauthorized software is either removed from use on enterprise assets or receives a documented exception:

**Network Access Control:**
- **SNAT-Only Architecture**: Network design preventing unauthorized inbound access
- **Cloudflare ZTNA**: All remote access through verified zero trust network access
- **VLAN Segmentation**: Network segmentation isolating different asset categories
- **Access Authentication**: Comprehensive authentication for all asset access

### **Safeguard 1.3: Utilize an Active Discovery Tool**

Active discovery implementation for comprehensive asset identification:

**Proxmox Integration:**
- **Cluster Management**: Native Proxmox cluster asset discovery and inventory
- **VM Discovery**: Automated virtual machine inventory and configuration tracking
- **Resource Monitoring**: Real-time resource utilization and capacity tracking
- **Health Monitoring**: Systematic health monitoring and status reporting

**Network Discovery:**
- **DHCP Logging**: Comprehensive DHCP log analysis for dynamic asset discovery
- **Network Scanning**: Regular network scanning for asset identification
- **SNMP Integration**: Network device monitoring and inventory through SNMP
- **Passive Discovery**: Traffic analysis for asset identification and validation

### **Safeguard 1.4: Use DHCP Logging to Update Enterprise Asset Inventory**

Use DHCP logging on all DHCP servers to update the enterprise's asset inventory weekly or more frequently:

**Implementation Status:**
- **Network Infrastructure**: DHCP services integrated with network monitoring
- **Log Collection**: Systematic DHCP log collection and analysis
- **Inventory Updates**: Regular inventory updates based on DHCP activity
- **Anomaly Detection**: Unauthorized device detection through DHCP analysis

### **Safeguard 1.5: Use a Passive Asset Discovery Tool**

Use a passive discovery tool to identify assets connected to the enterprise's network and update the enterprise's asset inventory at least weekly:

**Monitoring Integration:**
- **mon01 Stack**: Centralized monitoring providing passive asset discovery
- **Network Traffic Analysis**: Traffic analysis for asset identification
- **Service Discovery**: Automated service and application discovery
- **Security Monitoring**: Security event correlation for asset tracking

---

## **Asset Classification Framework**

### **Enterprise Asset Categories**

**Physical Computing Assets:**
- **Primary Servers**: Enterprise compute nodes supporting research workloads
- **Specialized Hardware**: GPU nodes supporting AI/ML astronomical analysis
- **Network Infrastructure**: Switches, firewall, and connectivity equipment
- **Storage Systems**: Enterprise NVMe storage and backup infrastructure

**Virtual Computing Assets:**
- **Infrastructure VMs**: Core platform services (databases, monitoring, management)
- **Project VMs**: Research-specific virtual machines and development environments
- **Container Infrastructure**: Docker hosts and Kubernetes cluster nodes
- **Backup Systems**: Proxmox Backup Server and related infrastructure

**Data Assets:**
- **Research Data**: DESI DR1 datasets and astronomical analysis data
- **System Configurations**: Infrastructure configurations and operational data
- **Application Data**: Database systems and application-specific information
- **Backup Data**: Protected data copies and archival information

### **Asset Security Classification**

**Based on Research Computing Requirements:**
- **Public Research Data**: DESI astronomical datasets with minimal confidentiality requirements
- **Operational Infrastructure**: System configurations requiring integrity and availability protection
- **Authentication Systems**: Identity and access management requiring comprehensive protection
- **Backup Systems**: Data protection infrastructure requiring availability and integrity controls

---

## **Monitoring and Compliance Integration**

### **Centralized Asset Monitoring**

**mon01 Integration:**
- **Prometheus Metrics**: Asset performance and health monitoring
- **Grafana Visualization**: Asset status dashboards and operational visibility
- **Loki Logging**: Asset activity logging and security event correlation
- **AlertManager**: Asset-based alerting and incident response integration

**Security Event Correlation:**
- **Asset-Based Alerting**: Security alerts correlated with specific assets
- **Incident Response**: Asset inventory supporting security incident investigation
- **Change Detection**: Asset configuration change detection and validation
- **Compliance Monitoring**: Continuous compliance monitoring and validation

### **Audit and Evidence Collection**

**Compliance Documentation:**
- **Asset Inventory Reports**: Regular asset inventory reporting for audit purposes
- **Discovery Scan Results**: Network discovery and asset validation evidence
- **Change Management**: Asset change tracking and approval documentation
- **Security Assessment**: Asset security posture assessment and validation

---

## **Implementation Benefits**

### **Security Enhancement**

**Foundation for Security Controls:**
- **Complete Visibility**: Comprehensive visibility into all enterprise assets
- **Risk Assessment**: Asset-based risk assessment and security planning
- **Incident Response**: Rapid asset identification during security incidents
- **Security Monitoring**: Asset-aware security monitoring and alerting

### **Operational Excellence**

**Infrastructure Management:**
- **Resource Planning**: Asset inventory supporting capacity planning and growth
- **Change Management**: Systematic asset change management and tracking
- **Maintenance Planning**: Asset lifecycle management and maintenance scheduling
- **Cost Management**: Asset utilization analysis and cost optimization

### **Research Productivity**

**Astronomical Computing Support:**
- **Resource Allocation**: Optimal resource allocation for research workloads
- **Performance Optimization**: Asset performance monitoring and optimization
- **Collaboration Support**: Asset sharing and collaboration capabilities
- **Data Management**: Comprehensive data asset management and protection

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting CIS Control 1 to related platform domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Hardware Infrastructure](../../hardware/README.md)** | Physical asset inventory and specifications supporting CIS Control 1 implementation | [../../hardware/README.md](../../hardware/README.md) |
| **[Infrastructure Overview](../../infrastructure/README.md)** | Virtual asset inventory and service management supporting enterprise asset control | [../../infrastructure/README.md](../../infrastructure/README.md) |
| **[Security Assurance Overview](../README.md)** | Parent security assurance framework providing CIS Controls implementation context | [../README.md](../README.md) |
| **[CIS Control 2](../02-inventory-and-control-of-software-assets/README.md)** | Software asset management complementing enterprise asset inventory | [../02-inventory-and-control-of-software-assets/README.md](../02-inventory-and-control-of-software-assets/README.md) |

---

## **Getting Started**

For users approaching CIS Control 1 implementation:

1. **Start Here:** [Hardware Infrastructure](../../hardware/README.md) - Physical asset inventory and cluster specifications
2. **Background Reading:** [Infrastructure Overview](../../infrastructure/README.md) - Virtual asset inventory and service management
3. **Implementation:** [Security Assurance Overview](../README.md) - Broader CIS Controls implementation framework
4. **Advanced Topics:** Asset monitoring integration and compliance evidence collection

---

## **AI Transparency**

This document was collaboratively developed using AI assistance while maintaining complete human oversight and validation. All CIS Control 1 implementations reflect actual platform deployment and asset management procedures with proper framework mapping to NIST CSF 2.0 and NIST AI RMF. The human author retains full responsibility for accuracy and technical correctness.

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: cis-control-1, enterprise-assets, asset-inventory, nist-csf-2-0, nist-ai-rmf, security-assurance
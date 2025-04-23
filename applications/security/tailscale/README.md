<!-- 
---
title: "Tailscale Zero Trust Network Access"
description: "Documentation for the Tailscale mesh VPN service providing zero trust network access to the Proxmox Astronomy Lab with Entra ID integration."
author: "VintageDon"
tags: ["tailscale", "vpn", "zero-trust", "network-access", "entra-id", "scim", "security", "remote-access"]
category: "Security"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Entra ID", "RDS", "Kasm Workspaces", "Active Directory"]
implements_policies: ["Zero Trust Network Access Policy", "Remote Access Policy", "Network Security Policy"]
phase: "phase-2"
cis_controls: ["CIS.12.1", "CIS.12.2", "CIS.12.3", "CIS.12.4", "CIS.12.5", "CIS.13.4", "CIS.14.1"]
iso27001_controls: ["A.8.3.1", "A.13.1.1", "A.13.1.3", "A.13.2.1", "A.13.2.3"]
nist_controls: ["AC-17", "AC-20", "SC-7", "SC-8", "SC-13"]
---
-->

# 🔒 **Tailscale Zero Trust Network Access Service**

This document provides the authoritative reference for the Tailscale service in the Proxmox Astronomy Lab, documenting its implementation as a Zero Trust Network Access (ZTNA) solution integrated with Microsoft Entra ID for identity management.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Tailscale service, its configuration, security implementation, and operational procedures. It serves as the definitive reference for secure remote access to the Proxmox Astronomy Lab environment via Tailscale's mesh VPN technology.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Tailscale configuration and architecture | Detailed endpoint device management |
| Entra ID SCIM integration and user provisioning | Network architecture beyond Tailscale nodes |
| Security controls and access policies | Application-specific configurations |
| Management procedures and operational processes | End-user device support procedures |
| Backup and recovery procedures | Client-side VPN troubleshooting |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Security Team Personnel
- Network Administrators
- Systems Engineers
- Service Desk Personnel (for troubleshooting)

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Tailscale service within our operational framework.

### **2.1 Service Description**

Tailscale provides a secure, zero-trust network access solution that enables authenticated remote access to specific resources within the Proxmox Astronomy Lab. It leverages WireGuard® protocol for its underlying encrypted connections and integrates with Microsoft Entra ID for identity and access management. The service is configured in split tunnel mode with specific DNS settings to resolve internal domain resources.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | SEC-NET-003 |
| **Service Type** | Core |
| **Service Category** | Security/Infrastructure |
| **Business Criticality** | Critical |
| **Service Owner** | Security Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Third Sunday of each month, 2AM-6AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Uptime monitoring via Prometheus |
| **Connection Establishment Time** | <5 seconds | Synthetic testing |
| **Latency Impact** | <10ms additional | Network performance testing |
| **Throughput Capability** | >50 Mbps per session | Performance monitoring |

### **3.2 Monitoring and Reporting**

Tailscale health and performance monitoring is implemented through:

- **Prometheus metrics** for node connectivity and performance
- **Grafana dashboard** for visibility and historical trends
- **Alerting** through AlertManager for connection failures
- **Security events** logged to Wazuh SIEM for analysis

Monthly service reports include metrics for active connections, authentication failures, and network performance.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

Tailscale is implemented as a mesh VPN network that connects authorized users to specific resources within the Proxmox Astronomy Lab. The architecture follows a zero trust networking model where access is limited to specific resources based on identity and group membership. Split tunneling is configured to route only traffic destined for lab resources through the Tailscale connection, while all other traffic uses the client's default internet connection.

Key design elements include:

- Integration with Entra ID for identity management via SCIM
- Access control through network ACLs based on group membership
- Split DNS configuration for radioastronomy.io domain
- Dedicated exit nodes for specific service access

### **4.2 Infrastructure Components**

The following components comprise the Tailscale infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Tailscale Network** | Mesh VPN network with custom ACLs | SEC-TS-001 |
| **Entra ID Integration** | SCIM-based identity management | SEC-TS-002 |
| **Tailnet DNS** | Split DNS for internal domain resolution | SEC-TS-003 |
| **RDS Access Node** | Exit node for RDS service access | SEC-TS-RDS01 |
| **Kasm Access Node** | Exit node for Kasm service access | SEC-TS-KASM01 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Internet connectivity | Remote access service interruption |
| **Requires** | Entra ID | User authentication and authorization failure |
| **Required By** | Remote workers | Loss of secure lab access |
| **Required By** | External researchers | Research workflow interruption |
| **Required By** | Remote administrative access | Operational management impact |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for Tailscale:

| **Aspect** | **Details** |
|------------|------------|
| **Configuration Backup** | ACL policies and network configuration backed up to Git repository |
| **Recovery Time Objective (RTO)** | 2 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Link to Tailscale recovery procedure document] |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs Tailscale administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Tailscale Admin** | Full administrative access | Security team approval + GRP_Tailscale_Admins group membership |
| **Staff User** | RDS service access | Employment verification + GRP_Tailscale_Users group membership |
| **Research User** | Kasm service access | Research agreement + GRP_Tailscale_Users group membership |
| **Service Desk** | Troubleshooting access | Support role assignment + GRP_Tailscale_Helpdesk group membership |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Service Outage** | Critical | P1 | 15 minutes | 4 hours |
| **User Access Issue** | High | P2 | 30 minutes | 8 hours |
| **Performance Degradation** | Medium | P3 | 2 hours | 24 hours |
| **Feature Request** | Low | P4 | 24 hours | Next release |

### **5.3 Change Management**

The following framework governs changes to the Tailscale service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Emergency** | No (post-review) | Security Lead approval | Any time |
| **Standard** | Yes | CAB weekly meeting | Maintenance window |
| **ACL Changes** | No | Security team approval | Business hours |
| **Node Addition** | No | Network team approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Connectivity Verification** | Daily | Operations Team | [TS-PROC-001] |
| **ACL Audit** | Monthly | Security Team | [TS-PROC-002] |
| **User Access Review** | Quarterly | Security Team | [TS-PROC-003] |
| **Performance Testing** | Monthly | Network Team | [TS-PROC-004] |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Connection Failure** | Unable to establish VPN connection | Verify network, check credentials, reset client | KEDB-TS-001 |
| **DNS Resolution Issues** | Unable to resolve internal hostnames | Check split DNS configuration, clear DNS cache | KEDB-TS-002 |
| **Performance Degradation** | Slow connection speeds | Check exit node load, verify local network performance | KEDB-TS-003 |
| **Authentication Failure** | "Authentication failed" message | Verify Entra ID account status, check group membership | KEDB-TS-004 |

## 🔐 **7. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **7.1 Security Controls**

The following controls protect the Tailscale service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Encryption** | WireGuard® protocol (ChaCha20) | Protocol analysis, connection auditing |
| **Authentication** | Entra ID integration, MFA-enforced | Authentication logs, access reviews |
| **Access Control** | Group-based ACLs | Tailnet policy review |
| **Endpoint Security** | Device posture checking | Client compliance verification |
| **Monitoring** | Connection logging to SIEM | Log correlation and alerting |

### **7.2 CISv8.1 Compliance Mapping**

This section documents how the Tailscale implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.12.1** | Maintain inventory of network boundaries | Tailnet configuration | Compliant |
| **CIS.12.2** | Scan for unauthorized connections | Tailscale auditing | Compliant |
| **CIS.12.3** | Deny by default, allow by exception | Tailscale ACL policies | Compliant |
| **CIS.12.4** | Encrypt remote access connections | WireGuard® protocol | Compliant |
| **CIS.12.5** | Manage access between network segments | ACL segmentation | Compliant |
| **CIS.13.4** | Perform application layer filtering | Service-specific access | Compliant |
| **CIS.14.1** | Establish and maintain a security awareness program | User training | Compliant |

### **7.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.12.4** | A.8.3.1 | SC-8 | Encryption of data in transit |
| **CIS.12.3** | A.13.1.1 | AC-17 | Zero-trust access controls |
| **CIS.12.5** | A.13.1.3 | SC-7 | Segment-based access restrictions |
| **CIS.13.4** | A.13.2.1 | AC-20 | Application filtering policies |

### **7.4 Risk Assessment**

The following table identifies key risks associated with the Tailscale service and their mitigations:

| **Risk** | **Likelihood** | **Impact** | **Mitigation** |
|----------|--------------|-----------|---------------|
| **Unauthorized Access** | Low | Critical | MFA enforcement, group-based ACLs, continuous monitoring |
| **Man-in-the-middle attack** | Very Low | Critical | WireGuard® encryption, control plane security |
| **Service Disruption** | Medium | High | Redundant connections, monitoring, documented recovery |
| **Credential Theft** | Low | High | MFA enforcement, limited access scope, device authorization |

## 🌐 **8. Entra ID Integration**

This section documents the specific configuration for Microsoft Entra ID integration.

### **8.1 SCIM Provisioning**

System for Cross-domain Identity Management (SCIM) is configured for automatic user provisioning and deprovisioning:

| **Feature** | **Configuration** | **Purpose** |
|-------------|----------------|------------|
| **User Provisioning** | Enabled | Automatic user creation in Tailscale |
| **Group Mapping** | Enabled | Access control based on AD groups |
| **Attribute Mapping** | Custom | Maps Entra ID attributes to Tailscale user properties |
| **Deprovisioning** | Enabled | Automatic removal when group membership changes |

### **8.2 Group Configuration**

The following Active Directory groups control access to Tailscale:

| **Group Name** | **Access Level** | **Resource Access** |
|----------------|----------------|---------------------|
| **GRP_Tailscale_Admins** | Full administration | All Tailscale resources |
| **GRP_Tailscale_Users** | User access | RDS or Kasm based on role |

## 📡 **9. Network Configuration**

This section documents the specific network configuration for the Tailscale implementation.

### **9.1 Split Tunnel Configuration**

Tailscale is configured in split tunnel mode with the following parameters:

| **Configuration** | **Setting** | **Purpose** |
|-------------------|----------|------------|
| **Default Route** | Disabled | Only lab traffic routes through Tailscale |
| **Route Prefixes** | 10.25.0.0/16 | Internal network routing |
| **Exit Nodes** | RDS and Kasm specific | Targeted service access |

### **9.2 DNS Configuration**

Split DNS is configured to resolve internal domains while allowing normal resolution for other domains:

| **Domain** | **DNS Servers** | **Purpose** |
|------------|----------------|------------|
| **radioastronomy.io** | 10.25.10.3, 10.25.20.3 | Internal domain resolution |
| **All other domains** | Client default | Normal internet resolution |

### **9.3 Access Control Policies**

Network ACLs define which resources users can access based on their group membership:

| **User Group** | **Target Resource** | **Access Type** |
|----------------|---------------------|----------------|
| **Staff Users** | proj-rds01 (10.25.20.20) | RDP |
| **All Other Users** | kasm01 (10.25.20.12) | HTTPS |
| **Administrators** | All resources | Full access |

## ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

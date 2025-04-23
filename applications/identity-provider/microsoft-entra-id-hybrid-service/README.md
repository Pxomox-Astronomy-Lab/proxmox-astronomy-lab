<!-- 
---
title: "Microsoft Entra ID Hybrid - radioastronomy.io"
description: "Documentation for the Microsoft Entra ID hybrid identity integration, providing cloud identity services with on-premises Active Directory synchronization for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["entra-id", "azure-ad", "hybrid-identity", "conditional-access", "authentication", "mfa", "identity-protection", "cloud-identity"]
category: "Security"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Active Directory", "Entra Private Access", "Microsoft 365", "DNS"]
implements_policies: ["Identity Management Policy", "Cloud Security Policy", "Authentication Policy", "Zero Trust Policy"]
phase: "phase-1"
cis_controls: ["CIS.5.1", "CIS.5.2", "CIS.6.1", "CIS.6.2", "CIS.6.3", "CIS.6.4", "CIS.6.5", "CIS.16.1"]
iso27001_controls: ["A.9.2.1", "A.9.2.2", "A.9.2.3", "A.9.2.4", "A.9.2.5", "A.9.2.6"]
nist_controls: ["AC-1", "AC-2", "AC-3", "AC-6", "IA-2", "IA-4", "IA-5", "SC-8"]
---
-->

# 🔐 **Microsoft Entra ID Hybrid Service**

This document provides the authoritative reference for the Microsoft Entra ID hybrid identity infrastructure in the Proxmox Astronomy Lab, documenting its configuration, security controls, integration with on-premises Active Directory, and operational procedures.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Microsoft Entra ID hybrid identity service, its integration with on-premises Active Directory, security configuration, and management procedures. It serves as the definitive reference for the cloud identity foundation that enables secure access to both on-premises and cloud resources in the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Entra ID tenant configuration and architecture | Microsoft 365 service-specific configurations |
| Hybrid identity integration with on-premises AD | On-premises domain controller management |
| Conditional Access policies and security controls | End-user workstation management |
| Authentication protocols and MFA configuration | Application-specific permission assignments |
| Identity Protection and monitoring | Third-party application integrations |

### **1.3 Target Audience**

This document is intended for:

- Cloud Infrastructure Administrators
- Identity Management Specialists
- Security Team Personnel
- Systems Integration Engineers
- Auditors and Compliance Reviewers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Entra ID service within our operational framework.

### **2.1 Service Description**

Microsoft Entra ID provides cloud-based identity and access management services for the Proxmox Astronomy Lab. It extends the capabilities of on-premises Active Directory through synchronization, enabling single sign-on, multi-factor authentication, conditional access, and identity protection across both cloud and on-premises resources.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | SEC-IDM-002 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | Critical |
| **Service Owner** | Cloud Identity Management Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Microsoft-defined (typically weekends) |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Microsoft SLA monitoring |
| **Authentication Response Time** | <1 second | Azure Monitor, synthetic transactions |
| **Directory Sync Latency** | <30 minutes | Azure AD Connect Health |
| **MFA Response Time** | <3 seconds | User experience monitoring |

### **3.2 Monitoring and Reporting**

Entra ID health and performance monitoring is implemented through multiple layers:

- **Azure Monitor** for Entra ID sign-in and audit logs
- **Microsoft Defender for Cloud Apps** for advanced monitoring
- **Azure AD Connect Health** for synchronization monitoring
- **Workbooks and Dashboards** for visualization and reporting
- **Security alerts** configured for suspicious activities

Monthly service reports are generated and reviewed in IT service meetings, including metrics for conditional access policy effectiveness, authentication volume, MFA usage, and risk detections.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Entra ID hybrid implementation follows Microsoft's recommended best practices for hybrid identity, with synchronized identities from on-premises Active Directory and enhanced security through conditional access policies and MFA.

The environment consists of a single Entra ID tenant (`radioastronomy.io`) with tenant ID `0fa216d7-bb90-4927-a651-6e197fc37044`. The tenant is configured for hybrid identity with the following key features:

- Synchronized identities from on-premises Active Directory
- Seamless Single Sign-On for integrated authentication
- Self-Service Password Reset with on-premises writeback
- Multi-Factor Authentication for all users
- Conditional Access policies for contextual security
- Identity Protection for risk-based authentication

### **4.2 Infrastructure Components**

The following components comprise the Entra ID infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Entra ID Tenant** | Primary identity provider (tenant ID: 0fa216d7-bb90-4927-a651-6e197fc37044) | AZURE-IDM-001 |
| **Azure AD Connect** | Identity synchronization service | RADIO-SRV-AADC01 |
| **Resource Group** | radioastronomyio (East US) | AZURE-RG-001 |
| **Subscription** | Enterprise (ID: 8f84fa89-f4b2-4d16-9245-a38b44bb6130) | AZURE-SUB-001 |
| **Entra Domain Services** | Azure-hosted domain controllers (optional) | N/A |
| **Entra ID Connect Health** | Synchronization monitoring service | AZURE-IDM-002 |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Microsoft 365 subscription | License assignment failure |
| **Requires** | Internet connectivity | Cloud authentication interruption |
| **Requires** | On-premises Active Directory | Identity synchronization failure |
| **Required By** | All cloud services | Authentication and authorization failure |
| **Required By** | Conditional Access | Security policy enforcement failure |
| **Required By** | Entra Private Access | Remote access authentication failure |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for Entra ID:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Method** | Microsoft-managed (Entra ID is a PaaS service) |
| **Tenant Backup** | Export of configuration settings quarterly |
| **Connect Server Backup** | System State backup daily at 1AM |
| **Recovery Time Objective (RTO)** | 4 hours for local components |
| **Recovery Point Objective (RPO)** | 24 hours (Microsoft guarantee for cloud data) |
| **Recovery Procedure** | [Link to Entra ID recovery procedure document] |

## 🔒 **5. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **5.1 Security Controls**

The following controls protect the Entra ID service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Access Control** | Role-based access control | Azure AD PIM activity reports |
| **Authentication** | MFA, passwordless options | Sign-in logs, authentication methods report |
| **Conditional Access** | Context-based authentication policies | CA insights and reporting, sign-in logs |
| **Identity Protection** | Risk-based policies, proactive detection | Identity Protection dashboard |
| **Privileged Access** | Just-in-time, time-limited | PIM role activation logs |
| **Audit Logging** | Comprehensive sign-in and activity logs | Log Analytics workspace |

### **5.2 CISv8.1 Compliance Mapping**

This section documents how the Entra ID implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.5.1** | Established account management process | Azure AD access reviews | Compliant |
| **CIS.5.2** | Role-based access control model | Azure AD role assignments | Compliant |
| **CIS.6.1** | Centralized authentication | Entra ID tenant configuration | Compliant |
| **CIS.6.2** | MFA for all users | Conditional Access policies | Compliant |
| **CIS.6.3** | Password complexity requirements | Authentication methods policy | Compliant |
| **CIS.6.4** | Secure password storage | FIPS-compliant hashing (Microsoft-managed) | Compliant |
| **CIS.6.5** | Conditional Access enforcement | Policy configuration dashboard | Compliant |
| **CIS.16.1** | Cloud security monitoring | Defender for Cloud Apps | Compliant |

### **5.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.5.1** | A.9.2.1 | AC-2 | Automated lifecycle management |
| **CIS.5.2** | A.9.2.2 | AC-6 | Least privilege through RBAC |
| **CIS.6.1** | A.9.2.3 | IA-2 | Centralized cloud authentication |
| **CIS.6.3** | A.9.2.4 | IA-5 | Strong password + MFA requirements |

### **5.4 Risk Assessment**

The following table identifies key risks associated with the Entra ID service and their mitigations:

| **Risk** | **Likelihood** | **Impact** | **Mitigation** |
|----------|--------------|-----------|---------------|
| **Global admin account compromise** | Low | Critical | MFA enforcement, PIM, dedicated admin accounts |
| **Identity sync interruption** | Medium | High | Monitoring, alerting, documented recovery procedures |
| **Password spray attacks** | High | Medium | Smart lockout, Identity Protection, risk-based CA |
| **Legacy authentication exploitation** | Medium | High | Blocked by Conditional Access policies |

## 🗂️ **6. Conditional Access Policies**

This section documents the Conditional Access policies implemented to enforce security controls based on user, device, network, and application context.

### **6.1 Baseline Policies**

The following baseline Conditional Access policies are implemented to enforce security standards across the organization:

| **Policy Name** | **Status** | **Activation Date** | **Description** |
|-----------------|----------|---------------------|----------------|
| **baseline_block_legacy_auth_apps** | Enabled | 4/15/2025 | Blocks all legacy authentication protocols that can't enforce MFA |
| **baseline_block_onedrive_sharepoint_downloads** | Enabled | 4/15/2025 | Prevents downloads from unmanaged devices |
| **baseline_geofencing_us_canada_plus_temp_only** | Enabled | 4/15/2025 | Restricts access to US and Canada locations with temporary exceptions |
| **baseline_mfa_join_devices_require** | Enabled | 4/15/2025 | Requires MFA for all device registration and join operations |
| **baseline_require_mfa_all_users** | Enabled | 4/15/2025 | Enforces MFA for all users accessing cloud resources |
| **baseline_require_mfa_intune_device_enrollment** | Enabled | 4/15/2025 | Requires MFA for Intune device enrollment |
| **baseline_require_mfa_register_security_info** | Enabled | 4/15/2025 | Enforces MFA when registering security information |
| **baseline_require_phish_resistant_MFA_admins** | Enabled | 4/15/2025 | Requires phishing-resistant MFA for administrator accounts |

### **6.2 Policy Configuration Details**

This section provides detailed configuration for key Conditional Access policies:

**baseline_require_mfa_all_users**:

- **Users**: All users (excluding emergency access accounts)
- **Cloud apps**: All cloud apps
- **Conditions**: Any device, any location
- **Grant controls**: Require multi-factor authentication
- **Session controls**: None

**baseline_block_legacy_auth_apps**:

- **Users**: All users
- **Cloud apps**: All cloud apps
- **Conditions**: Client apps = Legacy authentication clients
- **Grant controls**: Block access
- **Session controls**: N/A

**baseline_geofencing_us_canada_plus_temp_only**:

- **Users**: All users
- **Cloud apps**: All cloud apps
- **Conditions**: Locations not included in "Allowed Locations"
- **Grant controls**: Block access
- **Session controls**: N/A

**baseline_require_phish_resistant_MFA_admins**:

- **Users**: Members of admin roles
- **Cloud apps**: All cloud apps
- **Conditions**: Any device, any location
- **Grant controls**: Require phishing-resistant MFA
- **Session controls**: None

## 🔄 **7. License Management**

This section documents the licensing structure for Entra ID and related services.

### **7.1 License Assignments**

The following licenses are assigned to users based on their roles:

| **License Type** | **Assignment Scope** | **Key Features Used** |
|------------------|---------------------|----------------------|
| **Microsoft 365 E5** | Primary administrators | Advanced Security, Premium Entra ID features |
| **Microsoft 365 F3** | Regular staff | Basic productivity and identity features |
| **Entra ID P1** | All users (global assignment) | Self-service capabilities, MFA, Conditional Access |
| **Entra ID P2** | All users (global assignment) | Identity Protection, PIM, Access Reviews |
| **Microsoft Entra Suite** | All users (global assignment) | Advanced identity governance, security features |

### **7.2 License Optimization**

License usage is optimized through:

- Group-based license assignment for automatic provisioning
- Regular license audit to reclaim unused licenses
- Service plan selective enablement to avoid conflicts
- License reporting through Power BI dashboard

## 🔨 **8. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **8.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Entra ID health check** | Daily | Cloud Admin | [ENTRA-PROC-001] |
| **Sync monitoring** | Daily | Identity Admin | [ENTRA-PROC-002] |
| **Access reviews** | Quarterly | Security Admin | [ENTRA-PROC-003] |
| **Admin role review** | Monthly | Security Admin | [ENTRA-PROC-004] |
| **Conditional Access review** | Quarterly | Identity Admin | [ENTRA-PROC-005] |

### **8.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Synchronization failures** | Objects not updating in cloud | Check sync server, review sync logs | KEDB-ENTRA-001 |
| **Conditional Access blocks** | Unexpected access denials | Review sign-in logs for policy triggers | KEDB-ENTRA-002 |
| **MFA registration issues** | Users unable to set up MFA | Check license assignment, authentication methods | KEDB-ENTRA-003 |
| **Account lockouts** | User unable to sign in | Check Identity Protection risk detections | KEDB-ENTRA-004 |

## 🌐 **9. Hybrid Identity Configuration**

This section documents the specific configuration for hybrid identity integration.

### **9.1 Entra Connect Configuration**

The environment is configured with Azure AD Connect for identity synchronization:

| **Feature** | **Status** | **Configuration Details** |
|-------------|----------|---------------------------|
| **Sync Interval** | Every 30 minutes | Default sync cycle |
| **Password Hash Synchronization** | Enabled | Primary authentication method |
| **Pass-through Authentication** | Disabled | Using password hash sync instead |
| **Password Writeback** | Enabled | Allows cloud-initiated password resets |
| **Seamless Single Sign-On** | Enabled | Configured with AzureADSSO computer account |
| **Directory Extension Sync** | Enabled | Custom attributes synchronized |
| **Filtering** | Enabled | OU-based filtering for controlled sync |

### **9.2 Identity Protection Configuration**

Identity Protection is configured to detect and remediate identity risks:

| **Protection Feature** | **Configuration** | **Automated Action** |
|------------------------|----------------|----------------------|
| **Sign-in risk policy** | Medium and above | Require MFA |
| **User risk policy** | High | Require password change |
| **MFA registration policy** | All users | Require registration in 14 days |
| **Risky sign-in alerts** | Medium and above | Security team notification |
| **Risk detections** | All enabled | Integrated with SIEM for monitoring |

## 🔐 **10. Integration with Other Services**

This section documents how Entra ID integrates with other key services in the environment.

### **10.1 Entra Private Access**

Entra Private Access is configured to provide zero-trust network access:

| **Feature** | **Configuration** | **Purpose** |
|-------------|----------------|------------|
| **Application proxy** | Enabled | Remote access to on-premises web applications |
| **Private Link** | Configured | Direct connectivity to Azure services |
| **Connector groups** | Production and Test | Segregated application access |
| **Pre-authentication** | Entra ID | Ensures authorized access before traffic reaches apps |

### **10.2 Microsoft 365 Integration**

Entra ID provides identity services for Microsoft 365:

| **Feature** | **Configuration** | **Purpose** |
|-------------|----------------|------------|
| **Modern authentication** | Enabled | Secure authentication to all M365 services |
| **Guest access** | Restricted | Controlled external collaboration |
| **Application access** | Conditional Access enforced | Contextual security for M365 apps |
| **Device compliance** | Required for sensitive apps | Ensures managed device access |

### **10.3 Azure Arc Integration**

Entra ID integrates with Azure Arc for server management:

| **Feature** | **Configuration** | **Purpose** |
|-------------|----------------|------------|
| **Server onboarding** | Identity-based | Secure server registration |
| **RBAC** | Role assignments | Controlled access to Arc resources |
| **Policy assignment** | User identity-linked | Compliance enforcement by identity |

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

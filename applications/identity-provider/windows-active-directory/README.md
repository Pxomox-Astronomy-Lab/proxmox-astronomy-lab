<!-- 
---
title: "Windows Server Active Directory - radioastronomy.io"
description: "Documentation for the on-premises Active Directory infrastructure supporting hybrid identity, authentication, and access control for the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["active-directory", "identity", "windows-server", "authentication", "rbac", "hybrid-identity", "entra", "domain-services"]
category: "Security"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Entra ID", "DNS", "DHCP", "Linux AD Integration", "Kasm Workspaces", "RDS"]
implements_policies: ["Identity Management Policy", "Access Control Policy", "Authentication Policy"]
phase: "phase-1"
cis_controls: ["CIS.5.1", "CIS.5.2", "CIS.6.1", "CIS.6.2", "CIS.6.3", "CIS.6.4", "CIS.6.5", "CIS.6.7"]
iso27001_controls: ["A.9.2.1", "A.9.2.2", "A.9.2.3", "A.9.2.4", "A.9.2.5", "A.9.2.6"]
nist_controls: ["AC-1", "AC-2", "AC-3", "AC-6", "IA-2", "IA-4", "IA-5"]
---
-->

# 🔐 **Windows Server Active Directory Service**

This document provides the authoritative reference for the Windows Server Active Directory infrastructure in the Proxmox Astronomy Lab, documenting its architecture, configuration, security controls, and operational procedures.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the Windows Server Active Directory (AD) service, its deployment architecture, security configuration, and management procedures. It serves as the definitive reference for the on-premises identity foundation that supports hybrid identity in the Proxmox Astronomy Lab environment.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Domain controller configuration and architecture | Detailed GPO specifications (covered in GPO documentation) |
| Hybrid identity integration with Entra ID | Cloud-only identity management |
| Security group structure and RBAC design | Application-specific permission assignments |
| Linux system AD integration approach | End-user workstation management |
| Authentication protocols and security | Certificate services (covered in PKI documentation) |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators and Engineers
- Security Team Personnel
- Identity Management Specialists
- Systems Integration Engineers
- Auditors and Compliance Reviewers

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the Active Directory service within our operational framework.

### **2.1 Service Description**

Windows Server Active Directory provides centralized authentication, authorization, and directory services for the Proxmox Astronomy Lab. It serves as the authoritative identity source for all on-premises systems and synchronizes with Entra ID to enable hybrid identity, conditional access, and seamless single sign-on across both on-premises and cloud resources.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | SEC-IDM-001 |
| **Service Type** | Core |
| **Service Category** | Infrastructure |
| **Business Criticality** | Critical |
| **Service Owner** | Identity Management Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Second Sunday of each month, 2AM-6AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Uptime monitoring via Prometheus |
| **Authentication Response Time** | <500ms | Performance counters, synthetic transactions |
| **Replication Latency** | <15 minutes | AD replication monitoring |
| **Password Reset Time** | <5 minutes | Service desk metrics tracking |

### **3.2 Monitoring and Reporting**

Active Directory health and performance monitoring is implemented through multiple layers:

- **Wazuh Agent** on all domain controllers for security monitoring
- **AD-specific health checks** via Prometheus Windows Exporter
- **Synthetic logon tests** run every 5 minutes from monitoring server
- **LDAP query response time** metrics collected for performance trending
- **Replication status** monitored via PowerShell scheduled tasks

Monthly service reports are generated and reviewed in IT service meetings, including metrics for uptime, authentication volume, account lockouts, and failed logon attempts.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

The Active Directory implementation follows a multi-site, fault-tolerant design with domain controllers distributed across network segments for resilience.

The environment consists of a single forest and domain (`radioastronomy.io`) with NETBIOS name `RADIO`. The domain functional level is Windows Server 2025, providing the latest available security features and capabilities.

Primary design considerations include:

- Separation of DCs across VLANs for network fault tolerance
- Hybrid identity integration with Entra ID
- AD-joined Linux systems for unified authentication
- Structured RBAC through security groups

### **4.2 Infrastructure Components**

The following components comprise the Active Directory infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **DC01** | Primary domain controller (VLAN10) | RADIO-SRV-DC01 |
| **DC02** | Secondary domain controller (VLAN20) | RADIO-SRV-DC02 |
| **DNS01** | Primary DNS server with Technitium | RADIO-SRV-DNS01 |
| **DNS02** | Secondary DNS server with Technitium | RADIO-SRV-DNS02 |
| **Windows Server 2025** | Server operating system | N/A |
| **DHCP Service** | IP address assignment (100-200 range) | N/A |

### **4.3 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Physical hosts (Proxmox) | Complete service outage |
| **Requires** | Network infrastructure | Authentication failure across environment |
| **Requires** | DNS services | Name resolution failure, authentication issues |
| **Required By** | All AD-joined systems | Authentication and authorization failure |
| **Required By** | Entra ID Connect sync | Cloud identity synchronization interruption |
| **Required By** | RADIUS services | Network authentication failure |

### **4.4 Backup and Recovery**

The following parameters define our resilience strategy for Active Directory:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | System State backup daily at 1AM |
| **Backup Method** | Proxmox Backup Server with AD-aware snapshot |
| **Recovery Time Objective (RTO)** | 4 hours |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Link to DC recovery procedure document] |

## 🔄 **5. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **5.1 Security Controls**

The following controls protect the Active Directory service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Access Control** | Tiered administration model (T0/T1/T2) | Admin access audit, quarterly review |
| **Authentication** | FIPS-compliant Kerberos, multi-factor | Protocol analysis, security logging |
| **Privileged Access** | Just-in-time, time-limited | PIM role activation logs |
| **Account Management** | Automated provisioning/deprovisioning | User lifecycle workflow verification |
| **Audit Logging** | Advanced audit policy configuration | Log forwarding to SIEM verification |
| **Patch Management** | Monthly security updates | Compliance scanning, update reporting |

### **5.2 CISv8.1 Compliance Mapping**

This section documents how the AD implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.5.1** | Established account management process | GLPI workflow documentation | Compliant |
| **CIS.5.2** | Role-based access control model | AD security group structure | Compliant |
| **CIS.6.1** | Centralized authentication | Domain authentication settings | Compliant |
| **CIS.6.2** | MFA for administrative access | Entra Conditional Access policies | Compliant |
| **CIS.6.3** | Password complexity requirements | Domain password policy | Compliant |
| **CIS.6.4** | Secure password storage | Kerberos AES256 enforcement | Compliant |
| **CIS.6.5** | Group Policy enforcement | GPO baseline reports | Compliant |
| **CIS.6.7** | Account monitoring and alerting | Wazuh alerts configuration | Compliant |

### **5.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.5.1** | A.9.2.1 | AC-2 | Formal user registration and deregistration process |
| **CIS.5.2** | A.9.2.2 | AC-6 | Least privilege implementation through security groups |
| **CIS.6.1** | A.9.2.3 | IA-2 | Centralized authentication for all systems |
| **CIS.6.3** | A.9.2.4 | IA-5 | Strong password requirements enforced domain-wide |

### **5.4 Risk Assessment**

The following table identifies key risks associated with the Active Directory service and their mitigations:

| **Risk** | **Likelihood** | **Impact** | **Mitigation** |
|----------|--------------|-----------|---------------|
| **Domain controller compromise** | Low | Critical | LAPS, Tier 0 network isolation, enhanced security monitoring |
| **Directory data corruption** | Low | High | Regular backups, authoritative restore procedures |
| **Replication failure** | Medium | Medium | Monitoring, auto-remediation scripts, redundant network paths |
| **Privilege escalation** | Medium | High | Tiered administration, privileged access workstations, regular privilege review |

## 🗂️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **AD health check** | Daily | Tier 1 Admin | [AD-PROC-001] |
| **Replication verification** | Weekly | Tier 1 Admin | [AD-PROC-002] |
| **Security group review** | Monthly | Security Admin | [AD-PROC-003] |
| **Privileged account audit** | Quarterly | Security Admin | [AD-PROC-004] |
| **Forest health assessment** | Quarterly | Tier 0 Admin | [AD-PROC-005] |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Replication failures** | Event 1311, 1388 errors | Verify network, check domain controller properties | KEDB-AD-001 |
| **Authentication failures** | Unexpected logon denials | Verify Kerberos ticket issuance, check time sync | KEDB-AD-002 |
| **Account lockouts** | User unable to log in | Check bad password attempts, verify mapped drives | KEDB-AD-003 |
| **Group Policy application issues** | Policy not applying as expected | Run GPResult, verify WMI functionality | KEDB-AD-004 |

## 📈 **7. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **7.1 Access Management**

The following access control framework governs Active Directory administration:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Tier 0 Admin** | Full domain controller access | Executive approval, background check |
| **Tier 1 Admin** | Server administration | Manager + Tier 0 approval |
| **Tier 2 Admin** | Workstation administration | Manager approval |
| **Help Desk** | Password reset, group membership | Role-based assignment |
| **User** | Self-service password change | Automated based on employment status |

### **7.2 Change Management**

The following framework governs changes to the Active Directory service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Emergency** | No (post-review) | CIO approval | Any time with notification |
| **Standard** | Yes | CAB approval | Maintenance window only |
| **Schema modification** | Yes | CAB + Security approval | Extended maintenance window |
| **Group Policy changes** | Yes | CAB approval | Maintenance window only |

## 🛠️ **8. Security Group Structure**

This section documents the security group design that implements role-based access control across the environment.

### **8.1 Group Naming Convention**

Security groups follow a structured naming convention that clearly identifies their purpose and scope:

**GRP_[Area]_[Access Level]**

Where:

- **Area**: Functional area or system (e.g., Radio, AIML, DB, Infra)
- **Access Level**: Permission level (e.g., Admin, View, Ops)

### **8.2 Core Security Groups**

The following table documents the primary security groups that control access to resources:

| **Group Name** | **Description** | **Membership Scope** |
|----------------|----------------|----------------------|
| **GRP_Radio_Data** | Access to radio astronomy data | All levels + Researchers |
| **GRP_AIML_Dev** | AI/ML model development and tuning | L3 + ML Engineers |
| **GRP_Admin_All** | All administrator access roles | L3 + Primary Admins |
| **GRP_Remote_Basic** | Basic remote access capabilities | L1 + Researchers |
| **GRP_Obs_View** | Dashboard viewing without configuration | L1 + Researchers |
| **GRP_DB_Ops** | Database operational management | L2 |
| **GRP_Infra_Ops** | Day-to-day infrastructure operations | L2 |
| **GRP_Login_DevBox** | Development environment login access | Developers |
| **GRP_Admin_Domain** | Domain administrator access | Primary Admins |
| **GRP_Admin_Engineers** | Engineer administrator access | L3 |
| **GRP_Radio_Admin** | Full administration of radio astronomy tools | L3 |
| **GRP_AIML_Admin** | Full AI/ML platform administration | L3 |
| **GRP_Pipe_Admin** | Full data pipeline administration | L3 |
| **GRP_DB_Admin** | Full database administration access | L3 |
| **GRP_Infra_Admin** | Full infrastructure management | L3 |
| **GRP_Obs_Admin** | Full observability platform management | L3 |
| **GRP_Remote_Full** | Full remote workspace capabilities | L3 + L2 |
| **GRP_Sec_Admin** | Full security administration | L3 |
| **GRP_Kasm_Desktop_All** | Kasm workspace access for all authorized users | All authorized users |
| **GRP_Login_Linux** | Linux system login access | Linux system users |
| **GRP_Pipe_Ops** | Managing workflow execution | L2 |
| **GRP_Radio_Ops** | Operating radio astronomy equipment | L2 + Researchers |
| **GRP_Obs_Ops** | Operational monitoring and alerts | L2 |
| **GRP_Admin_Ops** | Operations administrator access | L2 |
| **GRP_RDP_All** | RDP access for all authorized users | All authorized users |
| **GRP_RDP_Research** | RDP access for researchers | Researchers |
| **GRP_DB_Read** | Read-only access to databases | All levels + Researchers |
| **GRP_Infra_Read** | Read-only infrastructure monitoring | L1 |
| **GRP_Remote_Admin** | Remote access infrastructure administration | L3 |
| **GRP_Sec_Audit** | Security auditing capabilities | L1 + Compliance |
| **GRP_Sec_Ops** | Security operations and monitoring | L2 |
| **GRP_Admin_Sysadmin** | System administrator access | L1 |
| **GRP_AIML_Use** | Using deployed AI/ML tools | All levels + Researchers |
| **GRP_Pipe_View** | Viewing pipeline status and results | L1 + Researchers |

### **8.3 Organizational Structure**

The Active Directory organizational structure follows a functional design with the following key containers:

- **OU=ORG**: Primary container for organizational objects
  - **OU=Groups**: Contains all security and distribution groups
    - **OU=Permissions**: Access control groups
    - **OU=Roles**: Role-based groups
  - **OU=Servers**: Server computer objects
    - **OU=Apps**: Application servers
    - **OU=ControlPlane**: Infrastructure control services
    - **OU=FileServers**: File server systems
    - **OU=Infra**: Core infrastructure servers
    - **OU=Linux**: Linux-based servers
    - **OU=RDS**: Remote Desktop Services
    - **OU=Research**: Research-specific servers
  - **OU=ServiceAccounts**: Managed service accounts
  - **OU=Users**: User accounts
    - **OU=Privileged**: Administrator accounts
  - **OU=Workstations**: End-user devices
    - **OU=Windows**: Windows workstations
    - **OU=Linux**: Linux workstations

## 📈 **9. Hybrid Identity Configuration**

This section documents the integration with Microsoft Entra ID for hybrid identity management.

### **9.1 Entra Connect Sync Configuration**

The environment is configured with Entra Connect Sync to enable hybrid identity capabilities:

| **Feature** | **Status** | **Configuration Details** |
|-------------|----------|---------------------------|
| **Password Hash Synchronization** | Enabled | Includes support for legacy authentication protocols |
| **Password Writeback** | Enabled | Allows cloud-initiated password resets |
| **Seamless Single Sign-On** | Enabled | Configured with AzureADSSO computer account |
| **Self-Service Password Reset** | Enabled | With on-premises writeback |
| **Device Writeback** | Enabled | Allows Entra-joined devices to access on-premises resources |

### **9.2 Licensing**

User accounts are assigned appropriate licenses based on their roles:

| **License Type** | **Users** | **Capabilities** |
|-----------------|----------|------------------|
| **Microsoft 365 E5** | Primary Administrators | Full productivity and security suite |
| **Microsoft 365 F3** | Operations Staff | Frontline worker capabilities |
| **Azure AD P2** | All synchronized users | Advanced identity protection features |
| **B2B Guest Access** | External Collaborators | Secure access for research partners |

## 🔗 **10. Linux Integration**

This section documents how Linux systems are integrated with Active Directory.

### **10.1 Linux AD Join Configuration**

All Ubuntu 24.04 LTS servers in the environment are domain-joined using SSSD with the following configuration:

```bash
[sssd]
domains = radioastronomy.io
config_file_version = 2
services = nss, pam, sudo

[domain/radioastronomy.io]
ad_domain = radioastronomy.io
krb5_realm = RADIOASTRONOMY.IO
realmd_tags = manages-system joined-with-adcli
cache_credentials = True
id_provider = ad
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = False
fallback_homedir = /home/%u
access_provider = ad
```

### **10.2 Linux Group Membership**

Linux system access is controlled through the **GRP_Login_Linux** security group. Users must be members of this group to log in to Linux systems. Additional group memberships map to local Linux groups for specific permissions.

## 📚 **11. DNS Integration**

This section documents the DNS configuration supporting Active Directory.

### **11.1 DNS Architecture**

The DNS infrastructure is designed with Technitium DNS servers that work alongside the built-in AD DNS:

| **Server** | **Role** | **Configuration** |
|------------|---------|-------------------|
| **DC01, DC02** | Primary AD DNS | Hosts _msdcs and other AD zones |
| **DNS01** | Technitium Primary | Serves secondary copies of AD zones with dynamic updates |
| **DNS02** | Technitium Secondary | Redundant Technitium server for failover |

### **11.2 DNS Filtering**

Technitium DNS servers implement security-focused filtering:

- **Security blocklists** for malware domains
- **Privacy protection** filters for tracking domains
- **Advertisement blocking** for improved performance
- **API-based management** for automated zone management

## ✅ **12. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **13. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

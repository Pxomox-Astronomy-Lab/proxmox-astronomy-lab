<!--
---
title: "Resource Tagging Strategy - Proxmox Astronomy Lab"
description: "Comprehensive documentation of the tagging approach for hybrid cloud and on-premises resources in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["infrastructure", "governance", "tagging", "cloud", "on-premises", "documentation"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-13"
---
-->

# **Resource Tagging Strategy - Proxmox Astronomy Lab**

## **1. Overview**

### **1.1 Purpose**

This article documents the comprehensive tagging strategy implemented across the Proxmox Astronomy Lab's hybrid infrastructure. It defines the standardized approach to resource tagging for both Azure cloud resources and on-premises Proxmox infrastructure, ensuring consistent governance, cost allocation, security compliance, and operational management.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| - Azure cloud resources | - End-user devices |
| - Proxmox VMs and containers | - Personal equipment |
| - Physical infrastructure | - External shared resources not directly managed by the lab |
| - Storage resources | |
| - Network components | |
| - Research-specific resources | |

### **1.3 Target Audience**

This article is intended for Lab Engineers, System Administrators, Operations team members, and external collaborators who deploy or manage infrastructure within the Proxmox Astronomy Lab environment.

---

## **2. Tagging Principles**

### **2.1 Core Tagging Philosophy**

The lab's tagging strategy adheres to these fundamental principles:

- **Consistency First**: All resources must have a consistent set of required tags
- **Governance Aligned**: Tags directly support compliance, cost management, and security requirements
- **Automation Enabled**: Tags are structured to support automated processes and reporting
- **Research Focused**: Special consideration for tags that support astronomy research objectives
- **Hybrid Approach**: Consistent taxonomy across cloud and on-premises resources

### **2.2 Required vs. Optional Tags**

| **Required Tags** | **Enforcement** | **Purpose** |
|-------------------|----------------|------------|
| CISComplianceLevel | Policy-enforced | Indicates the CIS compliance level (L1/L2) |
| Environment | Policy-enforced | Identifies the deployment environment (Dev/Test/Prod) |
| SecurityTier | Policy-enforced | Specifies the security classification |
| Owner | Policy-enforced | Identifies the responsible individual or team |
| VLAN | Policy-enforced (on-prem) | Identifies network segmentation |
| Lifecycle | Policy-enforced | Indicates resource lifecycle stage |
| ServiceCatalogItem | Policy-enforced | Maps to service catalog entries |

Optional tags provide additional context but are not mandatory for all resources.

---

## **3. Tag Categories and Definitions**

### **3.1 Operational Tags**

| **Tag Name** | **Description** | **Example Values** | **Applied To** |
|--------------|----------------|-------------------|---------------|
| CISComplianceLevel | CIS benchmark level | L1, L2 | All resources |
| Owner | Resource owner | TeamName, Username | All resources |
| Environment | Deployment environment | Dev, Test, Prod | All resources |
| Lifecycle | Resource lifecycle stage | Planning, Active, Deprecated | All resources |
| MaintenanceWindow | Allowed maintenance period | Sat-0100-0500-UTC, Daily-0200-0400-UTC | All resources |
| ServiceCatalogItem | Related service catalog entry | SDR-Processing, K8s-Platform | All resources |
| SLALevel | Service level agreement | Basic, Standard, Premium | Service-providing resources |
| SecurityTier | Security classification | Standard, Reference | All resources |

Note: "Reference" for SecurityTier designates resources with paid Defender for Cloud licenses, such as dc01 (Windows server), soc01 (Linux box), and pg01 (database). This allows us to experience Defender for Cloud capabilities for approximately $30/month.

### **3.2 Technical Configuration Tags**

| **Tag Name** | **Description** | **Example Values** | **Applied To** |
|--------------|----------------|-------------------|---------------|
| ClusterRole | Role within a cluster | Manager, Worker | Kubernetes nodes |
| ProxmoxNode | Physical host identification | node01, node02, node03 | VMs, containers |
| VLAN | Network segment | VLAN10, VLAN20 | Network resources |
| Database | Database type | PostgreSQL, TimescaleDB | Database resources |
| Microservice | Portainer microservice enablement | true, false | Portainer nodes (e.g., lab-apps01) |
| BackupPolicy | Backup schedule identifier | Daily, Weekly-Full | Data resources |

### **3.3 Research-Specific Tags**

| **Tag Name** | **Description** | **Example Values** | **Applied To** |
|--------------|----------------|-------------------|---------------|
| ResearchProject | Associated research initiative | h1line, lsbg, snr | Research resources |
| DataType | Type of scientific data | HydrogenLine, Calibration, Reference | Data resources |
| SignalSource | Radio signal origin | 1420MHz-Parabolic, RTL-SDR-UV | Signal processing resources |
| ProcessingStage | Data processing phase | Raw, Filtered, Analyzed | Data pipeline resources |

### **3.4 Cloud-Specific Tags**

| **Tag Name** | **Description** | **Example Values** | **Applied To** |
|--------------|----------------|-------------------|---------------|
| CWP_Servers | Cloud workload protection for servers | Enabled, Disabled | Azure VMs |
| CWP_Databases | Cloud workload protection for databases | Enabled, Disabled | Azure Databases |
| CWP_KeyVault | Cloud workload protection for key vaults | Enabled, Disabled | Azure Key Vaults |
| CWP_ResourceManager | Cloud workload protection for resource management | Enabled, Disabled | Azure resources |
| CWP_AI_Workloads | Cloud workload protection for AI services | Enabled, Disabled | Azure AI services |
| Defender_CSPM | Defender CSPM enablement flag | Enabled, Disabled | Azure subscriptions |
| DefenderForCloud | Defender for Cloud enablement | Enabled, Disabled | Azure resources |

---

## **4. Tagging Implementation**

### **4.1 Azure Resource Tagging**

Azure resources are tagged through:

- **Azure Policy**: Enforces required tags and default values
- **Terraform Templates**: Tag definitions in IaC deployments
- **Resource Groups**: Inheritance from resource group tags where appropriate
- **Automation Scripts**: Validation and enforcement scripts

Example Azure Policy definition for enforcing the Owner tag:

```json
{
  "policyRule": {
    "if": {
      "field": "tags['Owner']",
      "exists": "false"
    },
    "then": {
      "effect": "deny"
    }
  },
  "parameters": {}
}
```

### **4.2 Proxmox Resource Tagging**

On-premises Proxmox resources are tagged through:

- **Ansible Automation**: Standardized tag application during provisioning
- **Proxmox Templates**: Pre-defined tag sets in VM/LXC templates
- **GLPI Integration**: Synchronization between CMDB and infrastructure tags
- **Tag Validation Scripts**: Regular auditing of tag compliance

Example Ansible playbook snippet for applying tags to a Proxmox VM:

```yaml
- name: Apply standard tags to Proxmox VM
  community.general.proxmox_vm:
    api_user: "{{ proxmox_api_user }}"
    api_password: "{{ proxmox_api_password }}"
    api_host: "{{ proxmox_api_host }}"
    vmid: "{{ vmid }}"
    description: "
      Tags: 
      CISComplianceLevel:L2;
      Environment:Prod;
      Owner:LabOperations;
      SecurityTier:T2;
      VLAN:VLAN20;
      Lifecycle:Active;
      ServiceCatalogItem:K8s-Platform;
      ProxmoxNode:node01
    "
    state: present
```

### **4.3 Tag Governance**

The following processes ensure ongoing tag compliance:

- **Weekly Tag Audits**: Automated scanning of resources for tag compliance
- **Non-Compliance Alerts**: Notification of tag policy violations
- **Remediation Workflows**: Documented processes for fixing tag issues
- **Tag Usage Reports**: Regular analysis of tag utilization and coverage

---

## **5. Reporting and Usage**

### **5.1 Cost Management**

Tags support the following cost management functions:

- **Cost Allocation**: Attribution of costs to teams, projects, and environments
- **Budget Tracking**: Monitoring expenditure against budgeted amounts
- **Usage Optimization**: Identifying underutilized resources
- **Chargeback/Showback**: Internal cost allocation and reporting

### **5.2 Operational Reporting**

Operational insights enabled by the tagging strategy include:

- **Environment Distribution**: Resources by environment type
- **Security Coverage**: Resources by security tier and compliance level
- **Service Mapping**: Resource allocation per service
- **Research Alignment**: Infrastructure supporting specific research initiatives

### **5.3 Tag-Based Automation**

Tags enable automated processes including:

- **Scheduled Operations**: Start/stop schedules based on Environment tag
- **Backup Procedures**: Backup frequency based on BackupPolicy tag
- **Compliance Checks**: Security scans based on SecurityTier tag
- **Resource Cleanup**: Lifecycle management based on Lifecycle tag

---

## **6. References and Related Resources**

### **6.1 Related GLPI Items**

| **GLPI Item Type** | **ID** | **Name** | **Relationship** |
|--------------------|-------|----------|-----------------|
| Service | SVC-001 | Infrastructure Governance | Parent service |
| KB Article | KB-025 | CIS Compliance Framework | Referenced compliance scheme |
| KB Article | KB-032 | ITIL Service Management | Process alignment |

### **6.2 External References**

| **Reference Type** | **Title** | **Location** |
|--------------------|----------|-------------|
| Documentation | Azure Cloud Adoption Framework - Tagging Strategy | Azure Documentation |
| Documentation | CIS Benchmarks | CIS Website |
| Tool | Azure Policy for Tag Governance | Azure Portal |

### **6.3 Related KB Articles**

| **Article Title** | **Article ID** | **Relationship** |
|-------------------|---------------|-----------------|
| Infrastructure Architecture | KB-003 | Parent architecture |
| ITIL-Aligned Simulation Approach | KB-012 | Process framework |
| Azure Resource Governance | KB-027 | Related governance area |

---

## **7. Process Integration**

### **7.1 ITIL Process Relationship**

This tagging strategy integrates with the following ITIL processes:

- **Service Asset & Configuration Management**: Tags define and classify CIs
- **Financial Management**: Tags enable cost allocation and reporting
- **Service Level Management**: Tags support SLA monitoring and reporting
- **Information Security Management**: Tags enforce security classifications
- **Change Management**: Tags identify resources affected by changes

### **7.2 Role Responsibilities**

| **Role** | **Responsibility Related to Tagging** |
|----------|--------------------------------------|
| Lab Owner | Approving tag taxonomy and policy exceptions |
| Engineer | Implementing tagging in templates and automation |
| Operations | Monitoring tag compliance and enforcement |
| Security Administrator | Validating security-related tags |
| Change Management | Ensuring changes include proper tag updates |
| Service Desk | Using tags to route and prioritize issues |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lab Owner | 2025-03-13 | Approved |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-13 | Initial version | VintageDon |
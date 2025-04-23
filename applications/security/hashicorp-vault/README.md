<!-- 
---
title: "HashiCorp Vault with Azure Key Vault Integration"
description: "Documentation for the HashiCorp Vault service providing secure secrets management with Azure Key Vault integration for auto-unlock capability in the Proxmox Astronomy Lab."
author: "VintageDon"
tags: ["hashicorp-vault", "azure-key-vault", "secrets-management", "security", "credentials", "encryption", "identity", "tokens"]
category: "Security"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-23"
related_services: ["Azure Key Vault", "Entra ID", "Kubernetes Secrets", "Terraform"]
implements_policies: ["Secrets Management Policy", "Secure Development Policy", "Access Control Policy", "Data Protection Policy"]
phase: "phase-2"
cis_controls: ["CIS.3.11", "CIS.4.1", "CIS.4.8", "CIS.5.4", "CIS.16.1", "CIS.16.2"]
iso27001_controls: ["A.8.2.1", "A.8.2.3", "A.9.2.3", "A.9.2.5", "A.10.1.1", "A.10.1.2"]
nist_controls: ["SC-12", "SC-13", "SC-28", "IA-5", "AC-3", "AC-6"]
---
-->

# 🔐 **HashiCorp Vault Service**

This document provides the authoritative reference for the HashiCorp Vault service in the Proxmox Astronomy Lab, documenting its implementation as a secrets management solution with Azure Key Vault integration for auto-unlock capability.

## 📋 **1. Introduction**

### **1.1 Purpose**

This document defines the HashiCorp Vault service, its configuration, security implementation, and operational procedures. It serves as the definitive reference for secrets management within the Proxmox Astronomy Lab environment, including its integration with Azure Key Vault for automated unsealing.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Vault server configuration and architecture | Detailed application integration procedures |
| Azure Key Vault integration for auto-unsealing | Cloud-only secrets management |
| Security controls and access policies | Certificate Authority configuration (covered separately) |
| Management procedures and operational processes | Application-specific credential rotation |
| Backup and recovery procedures | Key management for non-Vault systems |

### **1.3 Target Audience**

This document is intended for:

- Infrastructure Administrators
- Security Engineers
- DevOps Engineers
- Application Developers (for integration)
- Security Auditors

## 🔍 **2. Service Overview**

This section establishes the foundational characteristics of the HashiCorp Vault service within our operational framework.

### **2.1 Service Description**

HashiCorp Vault provides a centralized secrets management platform for the Proxmox Astronomy Lab, offering secure storage of sensitive credentials, certificates, encryption keys, and other secrets. It is integrated with Azure Key Vault for auto-unsealing capability, eliminating the need for manual intervention during service restarts while maintaining security. Vault serves as the single source of truth for all service credentials and sensitive configuration data.

### **2.2 Service Classification**

The following table defines how this service is categorized within our service management framework:

| **Attribute** | **Value** |
|--------------|-----------|
| **Service ID** | SEC-SEC-002 |
| **Service Type** | Core |
| **Service Category** | Security |
| **Business Criticality** | Critical |
| **Service Owner** | Security Team |

### **2.3 Service Hours**

This table defines when the service is operational and supported:

| **Hours Type** | **Details** |
|---------------|------------|
| **Standard Service Hours** | 24x7x365 |
| **Support Hours** | 8x5 (Mon-Fri, 9AM-5PM EST) |
| **Maintenance Windows** | Fourth Sunday of each month, 2AM-4AM EST |

## 📊 **3. Service Level Parameters**

This section documents the committed performance levels and monitoring approaches for the service.

### **3.1 Service Level Targets**

The following performance metrics define our operational commitments:

| **Metric** | **Target** | **Measurement Method** |
|------------|----------|------------------------|
| **Availability** | 99.9% | Uptime monitoring via Prometheus |
| **Secret Retrieval Time** | <100ms | Performance metrics |
| **Auto-Unseal Time** | <2 minutes | Service restart monitoring |
| **Secret Creation Time** | <500ms | Performance metrics |

### **3.2 Monitoring and Reporting**

Vault health and performance monitoring is implemented through:

- **Prometheus metrics** for service health and performance
- **Grafana dashboard** for visualization and alerting
- **Log forwarding** to centralized logging platform
- **Audit logs** sent to SIEM for security monitoring
- **Synthetic transactions** to verify service availability

Monthly service reports include metrics for secret usage, authentication methods, and performance trends.

## 🖥️ **4. Technical Architecture**

This section documents the technical implementation and infrastructure components of the service.

### **4.1 Architecture Overview**

HashiCorp Vault is deployed in a high-availability configuration using the integrated storage backend. The service is configured with Azure Key Vault integration for auto-unsealing, which securely stores the unseal keys needed to decrypt the encrypted storage. This architecture eliminates the need for manual unsealing procedures while maintaining security by leveraging Azure's key management capabilities.

Key design elements include:

- High-availability deployment for resilience
- Azure Key Vault integration for auto-unsealing
- Integrated audit logging and monitoring
- Role-based access control aligned with organizational structure
- Multiple authentication methods with Entra ID as the primary identity source

### **4.2 Infrastructure Components**

The following components comprise the HashiCorp Vault infrastructure:

| **Component** | **Description** | **CMDB ID** |
|---------------|----------------|------------|
| **Vault Servers** | Primary Vault service cluster | SEC-VAULT-001 |
| **Azure Key Vault** | kv-onprem-radio (East US) | AZURE-KV-001 |
| **Consul (Optional)** | Service discovery (if used) | SEC-CONSUL-001 |
| **Vault Agent Injector** | Kubernetes integration | K8S-VAULT-001 |
| **Vault CLI Tools** | Administrative utilities | TOOLS-VAULT-001 |

### **4.3 Azure Key Vault Configuration**

The Azure Key Vault used for auto-unsealing has the following configuration:

| **Setting** | **Value** | **Purpose** |
|-------------|----------|------------|
| **Resource Group** | radioastronomyio | Organizational grouping |
| **Location** | East US | Geographic deployment |
| **Subscription** | radioastronomyio (8f84fa89-f4b2-4d16-9245-a38b44bb6130) | Billing and management |
| **Vault URI** | <https://kv-onprem-radio.vault.azure.net/> | Endpoint for API access |
| **SKU** | Standard | Service tier |
| **Directory ID** | 0fa216d7-bb90-4927-a651-6e197fc37044 | Entra ID tenant |
| **Directory Name** | radioastronomy.io | Organization name |
| **Soft-delete** | Enabled | Protects against accidental deletion |
| **Purge protection** | Disabled | Allows recovery of deleted vault |

### **4.4 Dependencies**

This table maps the service dependencies and impact relationships:

| **Dependency Type** | **Service/Component** | **Impact if Unavailable** |
|---------------------|----------------------|---------------------------|
| **Requires** | Azure Key Vault | Auto-unseal failure during restart |
| **Requires** | Entra ID | Authentication failure for cloud components |
| **Required By** | Kubernetes services | Secrets injection failure |
| **Required By** | CI/CD pipelines | Pipeline failure for credential access |
| **Required By** | Infrastructure automation | Configuration management disruption |
| **Required By** | Database services | Credential rotation failure |

### **4.5 Backup and Recovery**

The following parameters define our resilience strategy for HashiCorp Vault:

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Daily at 1AM |
| **Backup Method** | Integrated storage snapshot + encrypted backup |
| **Recovery Time Objective (RTO)** | 1 hour |
| **Recovery Point Objective (RPO)** | 24 hours |
| **Recovery Procedure** | [Link to Vault recovery procedure document] |

## 🔄 **5. Service Management**

This section documents the operational processes for managing the service throughout its lifecycle.

### **5.1 Access Management**

The following access control framework governs Vault administration and usage:

| **User Role** | **Access Level** | **Authorization Process** |
|---------------|----------------|---------------------------|
| **Vault Admin** | Full administrative access | Security team approval + dedicated admin identity |
| **Security Team** | Policy management, audit | Security team membership + Entra ID group |
| **Application Team** | Namespace-specific access | Team lead approval + application service account |
| **CI/CD Pipeline** | Automated secret access | DevOps approval + service account |

### **5.2 Incident Management**

These parameters define how incidents affecting this service are handled:

| **Category** | **Impact** | **Priority** | **Initial Response** | **Resolution Target** |
|--------------|----------|------------|---------------------|----------------------|
| **Service Outage** | Critical | P1 | 15 minutes | 2 hours |
| **Performance Degradation** | High | P2 | 30 minutes | 4 hours |
| **Security Event** | Critical | P1 | 15 minutes | Depends on event |
| **Azure Integration Failure** | High | P2 | 30 minutes | 4 hours |

### **5.3 Change Management**

The following framework governs changes to the HashiCorp Vault service:

| **Change Type** | **CAB Required** | **Approval Process** | **Implementation Window** |
|----------------|-----------------|---------------------|---------------------------|
| **Version Upgrade** | Yes | CAB approval + security review | Maintenance window |
| **Policy Changes** | No | Security team approval | Business hours |
| **Authentication Changes** | Yes | CAB + security approval | Maintenance window |
| **Secret Engine Changes** | No | Security team approval | Business hours |

## 🛠️ **6. Operational Procedures**

This section documents the procedures for maintaining service health and resolving issues.

### **6.1 Routine Procedures**

The following procedures are performed to maintain service operation:

| **Procedure** | **Frequency** | **Role Responsible** | **Procedure Document** |
|---------------|--------------|----------------------|------------------------|
| **Health Check** | Daily | Operations Team | [VAULT-PROC-001] |
| **Token/Lease Cleanup** | Weekly | Security Team | [VAULT-PROC-002] |
| **Audit Log Review** | Weekly | Security Team | [VAULT-PROC-003] |
| **Backup Verification** | Monthly | Operations Team | [VAULT-PROC-004] |
| **DR Test** | Quarterly | Operations + Security | [VAULT-PROC-005] |

### **6.2 Troubleshooting**

Common issues and their resolution approaches:

| **Common Issue** | **Symptoms** | **Resolution Steps** | **KEDB ID** |
|------------------|------------|---------------------|------------|
| **Auto-unseal Failure** | Vault remains sealed after restart | Verify Azure Key Vault connectivity, check permissions | KEDB-VAULT-001 |
| **Authentication Failure** | Unable to authenticate to Vault | Check auth method status, verify identity source | KEDB-VAULT-002 |
| **Performance Degradation** | Slow secret retrieval | Check resource utilization, verify storage performance | KEDB-VAULT-003 |
| **Audit Log Disruption** | Missing audit entries | Verify logging configuration, check storage capacity | KEDB-VAULT-004 |

## 🔐 **7. Security & Compliance**

This section documents the security controls and compliance requirements for this service.

### **7.1 Security Controls**

The following controls protect the HashiCorp Vault service:

| **Control Category** | **Implementation** | **Verification Method** |
|----------------------|-------------------|-------------------------|
| **Encryption at Rest** | AES-256 | Configuration verification |
| **Encryption in Transit** | TLS 1.3 | TLS configuration audit |
| **Access Control** | RBAC with namespace isolation | Policy review, access audit |
| **Key Management** | Azure Key Vault integration | Integration testing |
| **Authentication** | MFA, Entra ID integration | Authentication audit |
| **Audit Logging** | Comprehensive logging to SIEM | Log verification |

### **7.2 CISv8.1 Compliance Mapping**

This section documents how the HashiCorp Vault implementation satisfies specific CIS Controls:

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| **CIS.3.11** | Encrypt sensitive data at rest | Vault encryption configuration | Compliant |
| **CIS.4.1** | Establish and maintain secure configuration process | Vault configuration as code | Compliant |
| **CIS.4.8** | Uninstall or disable unnecessary services | Minimal service installation | Compliant |
| **CIS.5.4** | Restrict administrator privileges to dedicated admin accounts | Dedicated admin identities | Compliant |
| **CIS.16.1** | Establish and maintain a secure network architecture | Segmented vault access | Compliant |
| **CIS.16.2** | Establish and maintain a secure configuration management process | Infrastructure as code | Compliant |

### **7.3 Related Framework Mappings**

This subsection shows how controls map across multiple compliance frameworks:

| **CIS Control** | **ISO 27001** | **NIST 800-53** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| **CIS.3.11** | A.8.2.3 | SC-28 | Data-at-rest encryption |
| **CIS.4.1** | A.8.2.1 | CM-6 | Secure configuration baseline |
| **CIS.5.4** | A.9.2.3 | AC-6 | Privileged access management |
| **CIS.16.1** | A.13.1.3 | SC-7 | Network segmentation |

### **7.4 Risk Assessment**

The following table identifies key risks associated with the HashiCorp Vault service and their mitigations:

| **Risk** | **Likelihood** | **Impact** | **Mitigation** |
|----------|--------------|-----------|---------------|
| **Root token compromise** | Low | Critical | Root token revocation after initial setup, PIM for emergency access |
| **Seal key compromise** | Very Low | Critical | Azure Key Vault integration, access controls on cloud resources |
| **Data path compromise** | Low | High | TLS encryption, network segmentation, access controls |
| **Audit failure** | Low | Medium | Redundant audit logging, monitoring for audit failures |

## 🔄 **8. Secret Management Architecture**

This section documents the logical architecture for secrets management across the environment.

### **8.1 Secret Engine Configuration**

The following secret engines are configured in Vault:

| **Secret Engine** | **Path** | **Purpose** |
|-------------------|---------|------------|
| **KV v2** | `/kv` | General key-value secrets |
| **Database** | `/database` | Dynamic database credentials |
| **PKI** | `/pki` | Certificate issuance and management |
| **Transit** | `/transit` | Encryption as a service |
| **SSH** | `/ssh` | SSH key signing and management |
| **Kubernetes** | `/kubernetes` | Kubernetes authentication |

### **8.2 Namespace Structure**

Vault is organized using namespaces to provide logical isolation:

| **Namespace** | **Purpose** | **Access Control** |
|---------------|-----------|-------------------|
| **root** | System-level configuration | Vault admins only |
| **infrastructure/** | Infrastructure secrets | Infrastructure team |
| **applications/** | Application credentials | Application teams |
| **security/** | Security-specific secrets | Security team |
| **development/** | Non-production secrets | Development teams |

### **8.3 Authentication Methods**

Multiple authentication methods are configured for different use cases:

| **Auth Method** | **Purpose** | **Primary Users** |
|----------------|-----------|-------------------|
| **Entra ID** | Primary user authentication | Human operators |
| **Kubernetes** | Service account authentication | Containerized applications |
| **AppRole** | Application authentication | Service-to-service |
| **TLS Certificates** | System authentication | Infrastructure components |
| **Token** | Programmatic access | Automation tools |

## 🌐 **9. Azure Key Vault Integration**

This section documents the specific configuration for Azure Key Vault integration.

### **9.1 Auto-Unseal Configuration**

HashiCorp Vault is configured to use Azure Key Vault for auto-unsealing:

| **Configuration** | **Value** | **Purpose** |
|-------------------|----------|------------|
| **Key Vault URL** | <https://kv-onprem-radio.vault.azure.net/> | Endpoint for unseal key storage |
| **Key Name** | vault-unseal-key | Name of the key used for unsealing |
| **Authentication** | Managed Identity | Authentication to Azure services |
| **Key Type** | RSA-2048 | Encryption algorithm for seal |

The configuration in Vault's configuration file:

```hcl
seal "azurekeyvault" {
  tenant_id     = "0fa216d7-bb90-4927-a651-6e197fc37044"
  client_id     = "[MANAGED_IDENTITY_CLIENT_ID]"
  vault_name    = "kv-onprem-radio"
  key_name      = "vault-unseal-key"
}
```

### **9.2 Key Rotation Schedule**

Azure Key Vault keys used for unsealing are rotated according to this schedule:

| **Key Type** | **Rotation Frequency** | **Process Owner** | **Procedure** |
|--------------|----------------------|-------------------|--------------|
| **Unseal Key** | Annually | Security Team | [VAULT-AZURE-PROC-001] |
| **TLS Certificate** | Quarterly | Security Team | [VAULT-AZURE-PROC-002] |
| **Backup Encryption Key** | Annually | Operations Team | [VAULT-AZURE-PROC-003] |

## 🔗 **10. Integration With Other Services**

This section documents how Vault integrates with other key services in the environment.

### **10.1 Kubernetes Integration**

Vault integrates with Kubernetes for secrets injection:

| **Component** | **Purpose** | **Configuration** |
|---------------|-----------|-------------------|
| **Vault Agent Injector** | Kubernetes sidecar injection | Deployed via Helm chart |
| **ServiceAccount Authentication** | Kubernetes authentication | Configured in auth/kubernetes path |
| **Secret Injection** | Pod secret delivery | Annotations on pod manifests |

### **10.2 CI/CD Pipeline Integration**

Vault is integrated with CI/CD pipelines for secure credential handling:

| **Pipeline System** | **Integration Method** | **Credential Type** |
|--------------------|----------------------|-------------------|
| **GitHub Actions** | Vault GitHub Action | Short-lived tokens |
| **Terraform** | Terraform Vault Provider | Dynamic credentials |
| **Ansible** | Ansible Vault Lookup | Task-specific credentials |

## ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-23 | ✅ Approved |

## 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-23 | Initial documentation | VintageDon |

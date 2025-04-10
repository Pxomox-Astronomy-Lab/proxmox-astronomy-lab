I'll rewrite the documentation with TailScale replacing Entra Private Access.

<!-- 
---
title: "Entra Hybrid Cloud Integration"
description: "Documentation for the Entra Hybrid Cloud architecture in the Proxmox Astronomy Lab, detailing the integration between on-premises infrastructure and cloud identity services"
author: "VintageDon"
tags: ["entra", "azure", "hybrid-cloud", "identity", "security", "tenant", "tailscale"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.1"
status: "Published"
last_updated: "2025-04-05"
---
-->

# 🔐 **Entra Hybrid Cloud Integration**

# 🔍 **1. Overview**

The **Entra Hybrid Cloud** integration within the Proxmox Astronomy Lab extends Azure's control plane to **on-premises infrastructure**, ensuring a **secure, seamless, and manageable hybrid identity environment**. This infrastructure enables **unified identity management**, **standardized access controls**, and **enterprise-grade security** for both cloud and on-premises resources.

This design leverages **Azure Arc, Entra ID, and TailScale** to create a comprehensive hybrid management layer that extends cloud governance capabilities to the lab's physical and virtual resources. The architecture emphasizes **practical security integration** while maintaining operational flexibility for research activities.

---

# 🌐 **2. Hybrid Identity Architecture**

## **2.1 Core Identity Domains & Licensing**

The lab operates under a structured identity framework, utilizing a dedicated Entra ID tenant for all identity services with a tiered licensing approach.

| **Component** | **Details** |
|--------------|------------|
| **Primary Tenant Domain** | radioastronomy.io |
| **Local Active Directory Domain** | RADIO |

### **2.1.1 License Distribution**

The licensing structure is tailored for cost-effectiveness while ensuring appropriate security capabilities.

| **License Type** | **Assigned To** | **Purpose** |
|-----------------|----------------|------------|
| **Microsoft 365 E5** | VintageDon | Advanced security and compliance capabilities |
| **Microsoft 365 F3** | Engineering Team (FarmerBoy, WhereIsMyNam, Glitch) | Core productivity and collaboration |
| **Entra ID Suite** | Tenant-wide | Enhanced identity protection, PAM, and governance |
| **Unlicensed** | Primary GA account, Break Glass account | Emergency access management |

This dedicated tenant structure provides **complete organizational separation** and **enhanced management autonomy** for the research infrastructure, while the targeted licensing ensures advanced security capabilities where needed.

## **2.2 Hybrid AD Synchronization & Management**

Identity synchronization extends across both on-prem and cloud environments, enforcing secure authentication and access control.

| **Component** | **Function** |
|--------------|-------------|
| **On-Prem AD (DC01/DC02 - Server 2025)** | Core Active Directory domain controllers |
| **AD Connect Sync** | Synchronizes on-prem identities to Entra ID |
| **SSPR, Seamless SSO, Password Hash Sync** | Enables full hybrid identity experience |
| **Security Groups → Entra Groups Mapping** | Ensures consistent role-based access across on-prem & cloud |
| **Ubuntu VMs AD-Joined** | Linux systems authenticated via Active Directory |

This integration allows on-prem systems **to be controlled via Entra ID-based security policies**, ensuring role-based access governance across all managed resources.

---

# 🔄 **3. Extending Azure Control Plane to On-Prem**

## **3.1 Azure Arc - 100% Asset Coverage**

Azure Arc is leveraged to ensure unified governance and policy enforcement across all infrastructure components.

| **Asset Type** | **Azure Arc Coverage** |
|--------------|-------------------|
| **Proxmox Nodes** | Fully onboarded to Azure Arc |
| **VMs (Linux & Windows)** | 100% onboarded to Azure Arc |
| **On-Prem Windows Shares** | Planned integration, currently undergoing data mapping |

This extends capabilities like **policy compliance, audit logging, and monitoring** to on-prem infrastructure using free-tier Azure services.

---

# 🔒 **4. Secure Network Access: TailScale Integration**

## **4.1 TailScale Zero-Trust Network**

TailScale provides secure, identity-based access to the lab's resources, replacing traditional VPN approaches with a modern zero-trust network solution.

| **Feature** | **Description** |
|------------|----------------|
| **Entra ID Integration** | TailScale authenticates users via Entra ID credentials |
| **Conditional Access Enforcement** | Enforces Entra conditional access policies for network connections |
| **Edge Node Connectivity** | Securely connects remote data collection nodes to the lab infrastructure |
| **Zero-Trust Architecture** | Identity-based access control for all network resources |
| **Multi-Platform Support** | Consistent connectivity across Windows, Linux, macOS, and mobile devices |

## **4.2 Network Segmentation**

TailScale enables fine-grained network segmentation while maintaining seamless access.

| **Segment** | **Access Control** | **Resources** |
|------------|-------------------|--------------|
| **Control Plane** | Infrastructure Administrators | Core infrastructure services |
| **Research Resources** | Research Team | Data processing systems, analysis tools |
| **Edge Collectors** | Data Collection Team | Remote SDR and sensing equipment |
| **Management Layer** | System Administrators | Management interfaces, monitoring systems |

---

# 🔐 **5. Conditional Access Policies**

Conditional access policies are the backbone of identity security in the lab. These policies enforce **strict authentication requirements** and **risk-based security measures**.

| **Policy Name** | **Purpose** |
|---------------|------------|
| **Baseline Access Geofencing** | Restricts access to U.S. locations only, blocking all foreign IPs |
| **Baseline Block Legacy Authentication** | Prevents outdated, insecure authentication methods |
| **Baseline MFA Requirement** | Enforces passwordless MFA for all logins |
| **Baseline Risk-Based Sign-In Enforcement** | Requires MFA for any sign-in flagged as high risk |
| **Baseline Device Join & Registration MFA** | Ensures all newly registered devices require MFA authentication |
| **Baseline Security Info MFA** | Requires MFA for any changes to security settings |

These policies collectively **prevent unauthorized access**, enforce **phishing-resistant authentication**, and ensure **only compliant devices and users can access resources** through both direct cloud access and TailScale network connections.

---

# 🔗 **6. Extending Entra ID to Non-Native Applications**

## **6.1 Zitadel - Entra Integration for GUI & Legacy Apps**

- **Extends Entra ID authentication** to services that lack native Entra support.
- **No public endpoint passback required** → Avoids exposing authentication URLs externally.
- **Used for local GUI-based authentication needs.**

This allows **Entra-based authentication across all core applications** without unnecessary public exposure.

---

# 🖥️ **7. On-Prem VDI/RDS Deployment**

## **7.1 Windows RDS with Licensed Office Access**

The lab deploys **Windows Server 2025 RDS** as a Virtual Desktop Infrastructure (VDI) solution with built-in licensing support.

| **Component** | **Purpose** |
|-------------|------------|
| **RDS01** | Windows Server 2025 RDS, serving as the primary remote desktop host |
| **Office 2024 Pro LTSC** | Installed with a MAK license, ensuring licensed access for both internal users and external guests |
| **VDI Sessions Managed via Entra ID** | Secure authentication enforced through Entra ID policies |

This setup allows for **secure, compliant remote access** while ensuring **external users do not require additional licensing.**

---

# 🔑 **8. Storage, Vaults, and Cost Optimization**

## **8.1 Azure Key Vault & HashiCorp Vault Integration**

- **HashiCorp Vault on-prem unlocks automatically via Azure Key Vault.**
- **Both are backed up to Azure Blob Storage (leveraging free-tier storage).**
- **Ensures redundancy while leveraging cost-free cloud services where possible.**

## **8.2 Azure Container Registry**

- **Used instead of Harbor** for container image storage.
- **Integrated with Kubernetes deployments via RKE2.**

---

# 🔍 **9. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **9.1 Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **azure-arc** | Azure Arc configuration | [Azure Arc Integration](/entra-hybrid-cloud/azure-arc/README.md) |
| **conditional-access-policies** | Entra access policies | [CA Policies](/entra-hybrid-cloud/conditional-access-policies/README.md) |
| **key-vaults** | Vault integration | [Key Vault Configuration](/entra-hybrid-cloud/key-vaults/README.md) |
| **storage-services** | Azure storage integration | [Storage Services](/entra-hybrid-cloud/storage-services/README.md) |
| **tailscale** | TailScale configuration | [TailScale Implementation](/entra-hybrid-cloud/tailscale/README.md) |

## **9.2 Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Azure Tagging Strategy** | Resource tagging standards | [Tagging Strategy](/entra-hybrid-cloud/azure-tagging-strategy.md) |
| **Conditional Access Baseline** | Core security policies | [CA Baseline](/entra-hybrid-cloud/private/baseline-mfa-require-globally.md) |
| **TailScale Network Design** | Network architecture | [TailScale Design](/entra-hybrid-cloud/tailscale/network-design.md) |

---

# 🔄 **10. Related Resources**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure Overview** | Parent architecture | [Infrastructure Overview](/infrastructure/README.md) |
| **Control Plane** | Managed services | [Control Plane Services](/docs/Control-Plane/Services/README.md) |
| **Security & Compliance** | Security framework | [Security Documentation](/docs/Compliance-Security/README.md) |
| **Research Projects** | Protected resources | [Research Projects](/docs/Research-Projects/README.md) |
| **Observability** | Monitoring integration | [Observability](/docs/Control-Plane/Observability/README.md) |

---

# ✅ **11. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-05 | ✅ Approved |

---

# 📜 **12. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.1 | 2025-04-05 | Updated to reflect radioastronomy.io tenant migration and TailScale implementation | VintageDon |
| 1.0 | 2025-03-01 | Initial documentation | VintageDon |

# **Entra Hybrid Cloud - Proxmox Astronomy Lab**

## **1. Overview**

The **Entra Hybrid Cloud** integration within the Proxmox Astronomy Lab extends Azure’s control plane to **on-premises infrastructure**, ensuring a **secure, seamless, and manageable hybrid identity environment**. This approach enables **full asset visibility, conditional access enforcement, and deep security integrations** across both cloud and on-prem resources.

The focus is on **practical hybrid identity and security**, leveraging **Azure Arc, Entra ID, and secure external access via Entra Private Access (EPA)**. While technical details are included, this document primarily highlights **the integration of hybrid identity services into the research lab’s architecture**.

---

## **2. Hybrid Identity Architecture**

### **Core Identity Domains & Licensing**

The lab operates under a structured identity framework, leveraging a hybrid identity model.

| **Domain** | **Description** |
|-----------|----------------|
| **Primary Domain** | `beardinthe.cloud` |
| **Secondary Domain** | `radioastronomy.io` |
| **License Level** | Business Premium, P1 + P2 + Entra Suite |

### **Hybrid AD Synchronization & Management**

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

## **3. Extending Azure Control Plane to On-Prem**

### **Azure Arc - 100% Asset Coverage**

Azure Arc is leveraged to ensure unified governance and policy enforcement across all infrastructure components.

| **Asset Type** | **Azure Arc Coverage** |
|--------------|-------------------|
| **Proxmox Nodes** | Fully onboarded to Azure Arc |
| **VMs (Linux & Windows)** | 100% onboarded to Azure Arc |
| **On-Prem Windows Shares** | Planned integration, currently undergoing data mapping |

This extends capabilities like **policy compliance, audit logging, and monitoring** to on-prem infrastructure using free-tier Azure services.

---

## **4. Secure External Access: Entra Private Access (EPA)**

### **Enforcing Secure Lab Access**

EPA serves as the **sole method of external access** to the lab.

| **Feature** | **Description** |
|------------|----------------|
| **Gates all remote access via Entra tenancy authentication** | Ensures security compliance with MFA and Conditional Access policies |
| **Controls Kasm Workspaces & RDP access** | Enforces strict session authentication for all external researchers and staff |
| **No public endpoints** | Prevents unauthorized access by restricting authentication to Entra-approved pathways |

This setup **eliminates VPN-based access** while enforcing **Azure-native security controls** for remote connections.

---

## **5. Conditional Access Policies**

Conditional access policies are the backbone of identity security in the lab. These policies enforce **strict authentication requirements** and **risk-based security measures**.

| **Policy Name** | **Purpose** |
|---------------|------------|
| **Baseline Access Geofencing** | Restricts access to U.S. locations only, blocking all foreign IPs |
| **Baseline Block Legacy Authentication** | Prevents outdated, insecure authentication methods |
| **Baseline MFA Requirement** | Enforces passwordless MFA for all logins |
| **Baseline Risk-Based Sign-In Enforcement** | Requires MFA for any sign-in flagged as high risk |
| **Baseline Device Join & Registration MFA** | Ensures all newly registered devices require MFA authentication |
| **Baseline Security Info MFA** | Requires MFA for any changes to security settings |

These policies collectively **prevent unauthorized access**, enforce **phishing-resistant authentication**, and ensure **only compliant devices and users can access resources**.

---

## **6. Extending Entra ID to Non-Native Applications**

### **Zitadel - Entra Integration for GUI & Legacy Apps**

- **Extends Entra ID authentication** to services that lack native Entra support.
- **No public endpoint passback required** → Avoids exposing authentication URLs externally.
- **Used for local GUI-based authentication needs.**

This allows **Entra-based authentication across all core applications** without unnecessary public exposure.

---

## **7. On-Prem VDI/RDS Deployment**

### **Windows RDS with Licensed Office Access**

The lab deploys **Windows Server 2025 RDS** as a Virtual Desktop Infrastructure (VDI) solution with built-in licensing support.

| **Component** | **Purpose** |
|-------------|------------|
| **RDS01** | Windows Server 2025 RDS, serving as the primary remote desktop host |
| **Office 2024 Pro LTSC** | Installed with a MAK license, ensuring licensed access for both internal users and external guests |
| **VDI Sessions Managed via Entra ID** | Secure authentication enforced through Entra Private Access |

This setup allows for **secure, compliant remote access** while ensuring **external users do not require additional licensing.**

---

## **8. Storage, Vaults, and Cost Optimization**

### **Azure Key Vault & HashiCorp Vault Integration**

- **HashiCorp Vault on-prem unlocks automatically via Azure Key Vault.**
- **Both are backed up to Azure Blob Storage (leveraging free-tier storage).**
- **Ensures redundancy while leveraging cost-free cloud services where possible.**

### **Azure Container Registry**

- **Used instead of Harbor** for container image storage.
- **Integrated with Kubernetes deployments via RKE2.**

---

## **9. Conclusion**

The **Entra Hybrid Cloud model** provides a **secure, scalable, and identity-integrated research environment**, allowing full **Azure governance over on-prem resources** while ensuring a **seamless hybrid experience** for both infrastructure and user access.

This approach:

- **Extends Azure’s control plane** to **all lab resources** (100% Azure Arc coverage).
- **Eliminates VPNs & public authentication endpoints**, enforcing **MFA & conditional access** through **EPA**.
- **Leverages Entra ID for identity governance**, including **non-native applications via Zitadel**.
- **Optimizes costs by using free-tier Azure services where applicable.**

📌 **This document will be expanded as further integrations and enhancements evolve within the lab’s hybrid cloud infrastructure.**

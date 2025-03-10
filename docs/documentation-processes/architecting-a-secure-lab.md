<!-- ---
title: "Architecting a Secure, Compliance-Driven Hybrid Research Lab"
description: "Overview of the Proxmox Astronomy Lab's security, access control, and compliance strategy, leveraging hybrid identity, Entra Private Access, and structured IT governance."
author: "VintageDon"
tags: ["Compliance", "Security", "Hybrid Identity", "Entra", "Access Control", "Research Lab"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Draft"
last_updated: "2025-03-02"
---
 -->

# **🔍 Architecting a Secure, Compliance-Driven Hybrid Research Lab**

## **1. Introduction**

Citizen science is often viewed as an **open, collaborative, but loosely governed field**—typically lacking the rigor of corporate IT environments. The **Proxmox Astronomy Lab**, however, takes a different approach: a research-driven citizen science project built on **enterprise-grade IT security and compliance principles**.

This document outlines the **secure architecture of the lab**, covering:

- **Hybrid identity and centralized authentication.**
- **External user access via controlled VDI environments.**
- **Structured enforcement of security policies using Entra, Azure Arc, and other tools.**
- **How this model satisfies compliance frameworks like CISv8, NIST, and ISO 27001.**

---

## **2. Key Principles of the Lab’s Secure Architecture**

The lab follows a **Zero Trust approach**, enforcing:
✅ **Centralized identity & access management (IAM).**  
✅ **Strictly controlled external access.**  
✅ **Fully segmented, auditable research environments.**  
✅ **Data protection measures preventing unauthorized exfiltration.**  

Each component of the **hybrid research model** has been designed to balance **accessibility, usability, and security**.

---

## **3. Hybrid Identity: Centralized Authentication & Access**

| **Component** | **Implementation** | **Security/Compliance Benefit** |
|--------------|--------------------|--------------------------------|
| **Windows Servers & VMs** | **All on-prem Windows 2025 servers and VMs are Entra Hybrid Joined.** | ✅ **Centrally managed authentication & policy enforcement (CIS 5, 6).** |
| **Linux Servers** | **Joined to AD, SSO enforced via group-based sudo policies (e.g., `SG_Linux_sudoers`).** | ✅ **Ensures Linux systems adhere to the same IAM standards as Windows.** |
| **Seamless SSO** | **Users authenticate once and access all approved resources based on identity.** | ✅ **Eliminates shared credentials and enforces strict RBAC (CIS 5, 6).** |

This **unified identity model** ensures **all authentication is managed centrally**, reducing attack surfaces and enforcing **strong, policy-driven security**.

---

## **4. External User Access: Controlled Research Environments**

External users **never get raw access to the lab environment**. Instead, access is **fully contained** via:

### **🔹 Secure Research VDIs**

| **Workspace** | **Purpose** | **Security Model** |
|--------------|------------|--------------------|
| **RDS01 (Server 2025 RDS)** | Admin/Engineer VDI w/Office 2024 Plus, **RDP via Entra Private Access (EPA).** | ✅ **Full Entra security applies (MFA, CA, risk detection, logging).** |
| **Kasm Workspaces** | **Ephemeral desktops with persistent home directories, streamed over EPA.** | ✅ **No direct access to the lab—only controlled, logged workspaces.** |
| **NFS Home Directories & Research Data** | **Mapped into Kasm workspaces for controlled access.** | ✅ **Prevents direct data manipulation, ensuring full traceability.** |

### **🔹 Why This Model Works**

✅ **No direct access to the network.** External users interact **only through RDP or Kasm Workspaces**.  
✅ **Kasm ensures strict data controls** (e.g., copy/paste restrictions, app sandboxing).  
✅ **All sessions are fully logged**—violations can trigger automated security actions.  

This approach **replicates the security posture of corporate remote access environments**, applying **least privilege principles** to external collaborators.

---

## **5. Data Security: Preventing Unauthorized Access & Exfiltration**

| **Component** | **Implementation** | **Security/Compliance Benefit** |
|--------------|--------------------|--------------------------------|
| **SMB Shares via Azure Arc** | **SMB shares are served from a Windows Server managed via Azure Arc.** | ✅ **Qualifies for Azure security policies, including DLP (CIS 13, 15).** |
| **Kasm-Based File Access** | **Users interact with files only within controlled Kasm sessions.** | ✅ **Prevents unauthorized exfiltration (CIS 15 – Data Exfiltration).** |
| **Windows & Linux File Access Controls** | **File permissions enforced via AD and Linux group policies.** | ✅ **Ensures granular access control (CIS 6 – Access Management).** |

If **Azure DLP applies to Arc-managed SMB shares**, this **further strengthens data protection**, allowing **policy-driven restrictions** on **file access, transfer, and sharing**.

---

## **6. Compliance Impact: How This Model Satisfies CISv8**

This model satisfies **dozens of CISv8 controls** **without excessive complexity**.

| **CIS Control** | **How This Architecture Satisfies It** |
|---------------|--------------------------------|
| **CIS 1 – Inventory & Asset Control** | **Hybrid-joined systems & tracked assets (Snipe-IT, Netbox, Intune).** |
| **CIS 3 – Data Protection** | **Logged access, controlled workspaces, SMB share security.** |
| **CIS 5 – Account Management** | **Entra Hybrid Join, AD-based access control, PIM potential.** |
| **CIS 6 – Access Control** | **MFA, CA policies, restricted network segmentation.** |
| **CIS 12 – Network Monitoring** | **EPA logs all external access, Alertmanager + Wazuh for detection.** |
| **CIS 13 – Data Security** | **Azure DLP (if applicable), Kasm workspace restrictions.** |
| **CIS 15 – Data Exfiltration** | **No direct access, logs monitor & prevent unauthorized actions.** |

---

## **7. Summary: A Blueprint for Secure, Compliant Research**

The **Proxmox Astronomy Lab** is **one of the most security-focused citizen science projects in existence**. The architecture:
✅ **Maintains a secure, hybrid identity model.**  
✅ **Restricts external access to fully controlled, logged research workspaces.**  
✅ **Implements enterprise-grade security practices, enforceable via CISv8 and Azure policies.**  
✅ **Serves as a repeatable model for future research labs.**

This approach **proves that high-level IT security is not limited to corporations**—it can be applied **even in the realm of citizen science and research collaborations**. 🚀  

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-02 | ✅ Approved |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-02 | Initial version | VintageDon |



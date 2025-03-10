<!-- ---
title: "CIS Control 2: Inventory and Control of Software Assets in the Proxmox Astronomy Lab"
description: "Overview of CIS Control 2, which focuses on maintaining an inventory of software assets, ensuring only authorized and supported software is used, and mitigating security risks associated with unauthorized applications."
author: "VintageDon"
tags: ["CISv8.1", "Software Inventory", "Security", "Compliance", "Proxmox", "Asset Management"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---
 -->

# **📦 CIS Control 2: Inventory and Control of Software Assets in the Proxmox Astronomy Lab**

## **1. Introduction**

Tracking installed software is **critical for security, compliance, and operational stability**. **CIS Control 2** mandates that organizations establish and maintain an **inventory of all software**, remove unauthorized applications, and **enforce execution policies** to reduce security risks.

In the **Proxmox Astronomy Lab**, this control is enforced using **Snipe-IT, Osquery, Ansible Playbooks, AppArmor, Group Policy, and automated ticketing (Zammad)**. This **fully automated and auditable software inventory system** ensures that only **authorized and supported software** is installed, while **unauthorized applications are detected and removed**.

📌 **See also:**  

- [Software Asset Management Policy](../cisv81-controls/cisv81-02-software-asset-management-policy.md)  
- [Software Asset Management Policy Template](../cisv81-policy-templates/cisv81-02-inventory-and-control-of-software-assets-template.md)  

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All software running on lab-managed **servers, workstations, VMs, and containers**. |
| **Out-of-Scope** | Temporary test environments and personal user applications. |
| **Compliance Mapping** | CIS Control 2, NIST SP 800-53 (CM-8, SI-7), ISO/IEC 27001 (A.12.5.1). |

---

## **3. Sub-Control Implementation**

This section outlines **how each sub-control** of CIS Control 2 is enforced in the Proxmox Astronomy Lab.

### **2.1: Establish and Maintain a Software Inventory**

✅ **Requirement:** Maintain a complete, regularly updated inventory of all software in the environment, including dependencies.

✅ **Implementation in the Lab:**

- **Snipe-IT**: Tracks all **installed software as 'applications' and 'services'**.
- **Software dependencies** are mapped in **Snipe-IT** for transparency.
- **All software installations are tied to specific assets (VMs, servers, or workstations).**

---

### **2.2: Ensure Authorized Software is Currently Supported**

✅ **Requirement:** Ensure that only **vendor-supported** and **actively maintained** software is used.

✅ **Implementation in the Lab:**

- **Recurring Ticket in Zammad (Support Desk)**:
  - **Monthly task** to review software inventory and ensure **all software is vendor-supported**.
  - If unsupported software is found, **decommission or replace it**.
- **Automated Ansible Playbooks track unsupported software** (e.g., outdated packages, end-of-life (EOL) versions).

---

### **2.3: Address Unauthorized Software**

✅ **Requirement:** Detect and remove any **unauthorized** software from systems.

✅ **Implementation in the Lab:**

- **Osquery runs on all systems**, continuously scanning for **installed software**.
- **Monthly software inventory reviews** verify compliance.
- **Ansible Playbooks automate the process**:
  - **Automated scans** detect unauthorized software.
  - **API integration with Zammad** creates tickets for manual review.
  - **Non-approved software is automatically removed** where applicable.
- **Third-party software is installed via Winget**, ensuring software is from **trusted sources**.

---

### **2.4: Utilize Automated Software Inventory Tools**

✅ **Requirement:** Use **automated tools** to inventory software across all managed systems.

✅ **Implementation in the Lab:**

- **Osquery is deployed to all managed systems** to **inventory installed software**.
- **Winget manages third-party software installations**, ensuring proper documentation.
- **Software installations are logged**, allowing full traceability.

---

### **2.5, 2.6, and 2.7: Enforce Execution Restrictions on Unauthorized Software**

✅ **Requirement:** Restrict **unauthorized software execution**, enforce **application control policies**, and monitor application usage.

✅ **Implementation in the Lab:**

- **Windows (Group Policy)**:  
  - Software execution rules restrict **non-authorized applications**.
- **Linux (AppArmor)**:  
  - Controls which applications can execute and what **resources they can access**.
- **Logging & Alerting**:  
  - Unauthorized execution attempts trigger alerts via:
    - **Osquery** (real-time detection).
    - **Alertmanager** (alerts on violations).
    - **Wazuh SIEM** (correlates software usage logs for security monitoring).

---

## **4. Compliance Evidence**

To verify compliance, refer to the **implementation KB**:

📜 **File:** [`02-inventory-and-control-of-software-assets.md`](../docs/compliance-security/cisv8/2/)  

📌 **Related Policies**:  

- [Software Asset Management Policy](../cisv81-controls/cisv81-02-software-asset-management-policy.md)  
- [Software Asset Management Policy Template](../cisv81-policy-templates/cisv81-02-inventory-and-control-of-software-assets-template.md)  

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ DRAFT |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |


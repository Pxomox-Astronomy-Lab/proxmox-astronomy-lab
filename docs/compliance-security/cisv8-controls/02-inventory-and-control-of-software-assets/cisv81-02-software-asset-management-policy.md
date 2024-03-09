---
title: "CIS Control 2: Inventory and Control of Software Assets in the Proxmox Astronomy Lab"
description: "Overview of CIS Control 2, which focuses on maintaining an inventory of software assets, ensuring only authorized and supported software is used, and mitigating security risks associated with unauthorized applications."
author: "VintageDon"
tags: ["CISv8.1", "Software Inventory", "Security", "Compliance", "Proxmox", "Asset Management"]
category: "Compliance"
kb_type: "Reference"
version: "1.1"
status: "Draft"
last_updated: "2025-03-04"
---

# **ðŸ“¦ CIS Control 2: Inventory and Control of Software Assets in the Proxmox Astronomy Lab**

## **1. Introduction**

Tracking installed software is **critical for security, compliance, and operational stability**. **CIS Control 2** mandates that organizations establish and maintain an **inventory of all software**, remove unauthorized applications, and **enforce execution policies** to reduce security risks.

The **Proxmox Astronomy Lab** enforces this control through automated inventory tracking, execution restrictions, and policy enforcement.

| **Software Inventory Solution** | **Purpose** |
|--------------------------------|-------------|
| **Snipe-IT** | Tracks installed software as applications and services. |
| **Osquery** | Monitors installed software and detects unauthorized applications. |
| **Ansible Playbooks** | Automates compliance checks and software removal. |
| **Group Policy (Windows)** | Enforces execution restrictions on unauthorized applications. |
| **AppArmor (Linux)** | Limits execution of unauthorized applications and access to system resources. |
| **Zammad (Ticketing System)** | Automates software review and compliance tracking. |

ðŸ“Œ **See also:**

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

### **Software Inventory and Monitoring**

Software tracking and enforcement ensure only authorized applications are installed and executed.

| **Control** | **Implementation** |
|------------|--------------------|
| **Maintain an Inventory** | Snipe-IT tracks installed software and dependencies. |
| **Monitor Software Usage** | Osquery logs installed applications for compliance audits. |
| **Automate Software Checks** | Ansible Playbooks scan for outdated or unauthorized software. |
| **Review Unsupported Software** | Zammad generates recurring tickets for compliance reviews. |
| **Restrict Unauthorized Applications** | Group Policy (Windows) and AppArmor (Linux) enforce execution policies. |

### **Automated Software Management**

Ensuring software remains updated and unauthorized applications are removed enhances security posture.

| **Process** | **Enforcement Mechanism** |
|------------|--------------------------|
| **Identify Unsupported Software** | Monthly compliance checks via Zammad ticketing system. |
| **Remove Unauthorized Applications** | Automated Ansible Playbooks enforce compliance. |
| **Manage Third-Party Software** | Winget (Windows) and package managers (Linux) ensure controlled installations. |
| **Alert on Unauthorized Execution** | Wazuh SIEM, Alertmanager, and Osquery provide real-time detection. |

### **Execution Control and Policy Enforcement**

Restricting execution of unauthorized applications ensures compliance and security.

| **Platform** | **Execution Control Method** |
|------------|----------------------------|
| **Windows** | Group Policy restricts execution of non-authorized applications. |
| **Linux** | AppArmor enforces process and file access restrictions. |
| **Monitoring** | Osquery detects software execution attempts and logs violations. |

---

## **4. Compliance Evidence**

To verify compliance, refer to the **implementation KB**:

| **Compliance Document** | **Location** |
|------------------------|-------------|
| Implementation KB | [`02-inventory-and-control-of-software-assets.md`](../docs/compliance-security/cisv8/2/) |
| Software Asset Management Policy | [Policy Document](../cisv81-controls/cisv81-02-software-asset-management-policy.md) |
| Policy Template | [Policy Template](../cisv81-policy-templates/cisv81-02-inventory-and-control-of-software-assets-template.md) |

---

## **âœ… Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | âœ… DRAFT |

---

## **ðŸ“ Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.1 | 2025-03-04 | Standardized KBFormatv1 applied. Article interlinking. | VintageDon |


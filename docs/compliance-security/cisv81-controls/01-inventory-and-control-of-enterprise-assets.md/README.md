---
title: "CIS Control 1: Inventory and Control of Enterprise Assets in the Proxmox Astronomy Lab"
description: "Overview of CIS Control 1, which focuses on maintaining an inventory of all enterprise assets and ensuring unauthorized devices are detected and managed."
author: "VintageDon"
tags: ["CISv8.1", "Asset Management", "Inventory", "Security", "Compliance"]
category: "Compliance"
kb_type: "Reference"
version: "1.1"
status: "Draft"
last_updated: "2025-03-04"
---

# **📋 CIS Control 1: Inventory and Control of Enterprise Assets in the Proxmox Astronomy Lab**

## **1. Introduction**

Maintaining an accurate and up-to-date inventory of **enterprise assets** is critical for security, compliance, and operational integrity. **CIS Control 1** mandates organizations to **track, manage, and monitor** all hardware and virtual assets within their environment, ensuring that **unauthorized devices are promptly identified and remediated**.

The **Proxmox Astronomy Lab** enforces asset control using automated tracking tools, active monitoring solutions, and network enforcement mechanisms.

| **Asset Management Solutions** | **Purpose** |
|--------------------------------|-------------|
| **Snipe-IT** | Tracks and manages physical and virtual assets, maintaining metadata. |
| **Active Directory Hybrid Join** | Ensures Windows VMs and workstations are hybrid-joined to Entra ID via Azure Arc. |
| **Intune** | Manages mobile devices and Windows endpoints. |
| **Linux AD Integration** | Registers Linux servers in Active Directory for authentication and policy compliance. |
| **Azure Key Vault & Cloud Services** | Tracks Wasabi, AWS, and Azure-based assets as managed services. |

📌 **See also:**

- [Enterprise Asset Management Policy](../cisv81-controls/cisv81-01-enterprise-asset-management-policy.md)
- [Enterprise Asset Management Policy Template](../cisv81-policy-templates/cisv81-01-inventory-and-control-of-enterprise-assets-template.md)

---

## **2. Scope**

The **scope of this control** defines which assets are covered under the policy and how compliance is mapped to relevant frameworks.

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All compute, storage, and network assets within the Proxmox Astronomy Lab (on-prem, hybrid, and cloud). |
| **Out-of-Scope** | Personal devices not part of the lab’s infrastructure. |
| **Compliance Mapping** | CIS Control 1, NIST SP 800-53 (CM-8, CA-7), ISO/IEC 27001 (A.8.1.1). |

---

## **3. Sub-Control Implementation**

### **Asset Inventory and Monitoring**

Enterprise assets are continuously tracked using centralized inventory tools, active monitoring solutions, and automated network enforcement.

| **Control** | **Implementation** |
|------------|--------------------|
| **Maintain an Inventory** | Automated asset tracking via Snipe-IT and Active Directory hybrid join. |
| **Monitor Unauthorized Devices** | Network logs are ingested into Wazuh, and alerts are triggered on unauthorized assets. |
| **Enforce Network Restrictions** | Unauthorized devices are moved to a quarantine VLAN and blocked via firewall policies. |
| **Active Monitoring** | Osquery collects installed software, user activity, and system integrity logs. |
| **Automated Asset Discovery** | Netbox continuously scans the network and triggers alerts for unknown devices. |

### **DHCP Logging and Network Scanning**

Maintaining DHCP logs is essential for tracking device connections and detecting rogue assets.

| **Log Source** | **Purpose** |
|--------------|-------------|
| **Windows Server 2025 Domain Controllers** | Centralized DHCP logging. |
| **Promtail & Grafana Alloy** | Stores and visualizes DHCP logs. |
| **Wazuh Integration** | Detects unauthorized DHCP leases in real time. |

Automated network scanning is performed to ensure all active devices are known and accounted for.

| **Scanning Mechanism** | **Function** |
|----------------------|------------|
| **Netbox Network Scans** | Detects and catalogs new devices in real-time. |
| **Alertmanager Triggers** | Notifies when unknown devices appear or unexpected changes occur. |

---

## **4. Compliance Evidence**

To verify compliance with CIS Control 1, evidence is documented and maintained.

| **Compliance Document** | **Location** |
|------------------------|-------------|
| Implementation KB | [`01-inventory-and-control-of-enterprise-assets.md`](../docs/compliance-security/cisv8/1/) |
| Enterprise Asset Management Policy | [Policy Document](../cisv81-controls/cisv81-01-enterprise-asset-management-policy.md) |
| Policy Template | [Policy Template](../cisv81-policy-templates/cisv81-01-inventory-and-control-of-enterprise-assets-template.md) |

---

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |

---

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.1 | 2025-03-04 | Standardized KBFormatv1 applied. Article interlinking. | VintageDon |

<!-- ---
title: "CISv8-01 Enterprise Asset Management Policy"
description: "Defines the asset management policy for the Proxmox Astronomy Lab, ensuring accurate tracking, monitoring, and security of all IT assets in compliance with CISv8, NIST 800-53, and ISO 27001."
author: "VintageDon"
tags: ["CISv8", "Asset Management", "Security Policy", "Compliance", "IT Inventory"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---
 -->

# **📜 CISv8-01 Enterprise Asset Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Enterprise asset management is critical for maintaining **real-time visibility, security, and compliance** within the **Proxmox Astronomy Lab**. This policy establishes processes for **tracking, managing, and removing unauthorized assets**, aligning with **CISv8, NIST 800-53, and ISO 27001**.

### **Key Objectives**

The following key objectives define the **scope and implementation** of asset management within the lab:

| **Objective** | **Description** |
|--------------|----------------|
| **Accurate Asset Inventory** | Use Snipe-IT, Netbox, and Azure Arc to track assets. |
| **Automated Monitoring** | Utilize Wazuh, Osquery, and AD logs for real-time tracking. |
| **Unauthorized Asset Quarantine** | Isolate non-compliant devices using Fortigate 40F firewall. |
| **Regular Compliance Audits** | Conduct bi-annual asset verification. |

This policy applies to **all IT assets** within the **Proxmox Astronomy Lab**, categorized as follows:

| **Asset Type** | **Examples** |
|--------------|-------------|
| **Compute** | Proxmox, Kubernetes, Windows, Linux servers |
| **Storage** | NAS solutions, cloud storage (Azure, AWS, Wasabi) |
| **Network** | Firewalls, switches, wireless APs |
| **Endpoints** | Authorized workstations & mobile devices |

---

## **2. Compliance Mapping**

This policy aligns with industry compliance frameworks to ensure best practices in asset management:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 1 – Inventory & Control of Enterprise Assets |
| **NIST 800-53** | CM-8, CM-9 – Asset Management & Monitoring |
| **ISO 27001** | A.8.1 – Asset Inventory & Classification |

---

## **3. Responsibilities**

Roles and responsibilities are defined to ensure **clear accountability** in managing IT assets:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Infrastructure Engineers (L2/L3)** | Maintain inventory, conduct audits, enforce compliance via Wazuh and Osquery. |
| **Administrators (L1/L2-Lite)** | Record and configure new assets, perform compliance checks, manage user onboarding/offboarding. |
| **External Users** | Use only approved assets, report lost or stolen equipment immediately. |

---

## **4. Policy Implementation**

### **4.1 Asset Acquisition & Inventory Management**

Asset tracking is maintained through **automated and manual processes** to ensure consistency and accuracy:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Unique Asset Identification** | Assign asset IDs in Snipe-IT or Netbox. |
| **Comprehensive Inventory Records** | Track purchase date, cost, owner, MAC/IP, location, warranty, and licensing. |
| **Bi-Annual Audits** | Validate inventory accuracy every six months. |
| **Virtual Asset Tracking** | Monitor VMs and Kubernetes nodes dynamically. |

#### **Automated Asset Discovery**

Automated discovery ensures that all assets are accounted for and unauthorized devices are detected:

| **System** | **Discovery Method** | **Frequency** |
|------------|---------------------|--------------|
| Proxmox VMs | Wazuh SIEM & Osquery | Daily |
| Kubernetes Cluster | RKE2 Asset Scanning | Weekly |
| Windows & Linux VMs | AD Hybrid Join via Azure Arc | Continuous |
| Network Devices | Netbox API + Nmap | Monthly |

---

### **4.2 Unauthorized Asset Discovery & Response**

Detection and quarantine processes are in place to **identify and isolate** unauthorized assets:

| **Requirement** | **Action** |
|--------------|------------------|
| **Unregistered Assets** | Remove if not lab-owned, register if missing from inventory. |
| **Quarantine Process** | Isolate unauthorized assets weekly via Fortigate 40F API. |
| **Connection Requirement** | Enterprise assets must connect to the lab network at least weekly. |
| **Air-Gapped Systems** | Require explicit IT approval and documentation. |

---

### **4.3 Active Asset Monitoring**

Continuous monitoring ensures that **unauthorized modifications and deviations** are detected:

| **Monitoring Tool** | **Function** |
|-----------------|----------------|
| **Osquery** | Tracks software, system state, and unauthorized changes. |
| **Netbox** | Continuously scans networks for unknown devices. |
| **Wazuh SIEM** | Monitors AD & DHCP logs for policy deviations. |

#### **Example Osquery Queries**

Below are practical **Osquery queries** for detecting **unauthorized activities** in the lab environment:

- Identify **unauthorized devices** connected to the network:

    ```sql
    SELECT name, ip_address, mac_address FROM network_interfaces WHERE mac_address NOT IN (SELECT mac_address FROM known_devices);
    ```

- Find **inactive assets** that haven't reported in 30 days:

    ```sql
    SELECT name, last_seen FROM assets WHERE last_seen < date_sub(NOW(), INTERVAL 30 DAY);
    ```

- Detect **unauthorized software installations**:

    ```sql
    SELECT name, version FROM installed_software WHERE name NOT IN (SELECT name FROM approved_software_list);
    ```

---

### **4.4 Quarantine & Removal of Unauthorized Assets**

Quarantine processes **restrict network access** for devices that fail compliance checks:

| **Requirement** | **Action** |
|--------------|------------------|
| **Unrecognized Devices** | Quarantine immediately in Netbox, AD, or Snipe-IT. |
| **Network Access Restriction** | Block quarantined devices from production networks. |
| **Automated Enforcement** | Apply Wazuh-based firewall rules to isolate threats. |

---

### **4.5 Controlled Disposal & Decommissioning**

Proper decommissioning ensures that **assets are securely retired** without security risks:

| **Step** | **Action** |
|---------|------------------|
| **Return to IT** | Retired assets must be processed by IT. |
| **Data Backup** | Securely back up relevant user data. |
| **Secure Erasure** | Wipe primary storage before disposal. |
| **Record Retention** | Maintain decommissioning logs for compliance. |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

🚀 **This policy ensures that enterprise asset management remains a structured, actively enforced, and auditable process in the Proxmox Astronomy Lab.**



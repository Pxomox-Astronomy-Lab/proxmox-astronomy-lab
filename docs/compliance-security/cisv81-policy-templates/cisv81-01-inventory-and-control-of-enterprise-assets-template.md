---
title: "CIS Enterprise Asset Management Policy"
description: "Outlines the lifecycle management of enterprise-owned IT assets, including acquisition, usage, tracking, and disposal."
author: "VintageDon"
tags: ["CISv8", "Asset Management", "IT Inventory", "Compliance"]
category: "Compliance"
kb_type: "Policy"
version: "1.0"
status: "Approved"
last_updated: "2025-03-03"
---

# **Enterprise Asset Management Policy â€“ Proxmox Astronomy Lab**  

# **1. Overview**  

Effective asset management ensures that all IT and operational resources within the **Proxmox Astronomy Lab** are **properly inventoried, maintained, tracked, and disposed of securely**. **CIS Control 1 (Enterprise Asset Management)** provides guidelines for identifying, governing, and monitoring enterprise assets to **mitigate security risks, prevent unauthorized access, and optimize resource utilization**.  

This document **incorporates the CIS-provided Enterprise Asset Management Policy template** with additional **context and compliance mapping** relevant to the **labâ€™s infrastructure**.  

## **2. Compliance Mapping**  

| **Framework**      | **Control Mapping** |
|--------------------|--------------------|
| **CIS Controls**   | CIS Control 1 â€“ Enterprise Asset Management |
| **NIST 800-53**    | CM-8 (System Component Inventory), CM-3 (Configuration Change Control) |
| **ISO 27001**      | A.8 (Asset Management), A.12 (Operations Security) |

---

## **3. Policy Implementation in the Lab**  

Asset management in the **Proxmox Astronomy Lab** applies to **physical and virtual assets**, including:  

- **Workstations, servers, and networking equipment**.  
- **Virtualized infrastructure within Proxmox and Kubernetes**.  
- **SDRs, sensors, and other scientific equipment**.  
- **Cloud resources managed via Azure Arc**.  

This policy ensures **full asset lifecycle tracking**, from **acquisition to disposal**.

---

## **4. CIS Enterprise Asset Management Policy Template**  

```markdown
# Enterprise Asset Management Policy Template

## **Purpose**  
Enterprise asset management is the process of procuring, identifying, tracking, maintaining, and disposing of an asset owned by an enterprise. The Enterprise Asset Management Policy provides the processes and procedures for governing the enterprise asset lifecycle while an enterprise is using an asset. An inventory must be created and maintained to support the enterpriseâ€™s mission. This inventory must be current and reflect the current assets owned and operated by the enterprise.  

## **Responsibility**  
The IT business unit is responsible for all enterprise asset management functions. This information is relayed to other business units within the enterprise such as finance, accounting, and cybersecurity as required or needed. IT is responsible for informing all users of their responsibilities in the use of any enterprise assets assigned to them.  

---

## **Policy**  

### **4.1 Acquisition**  
1. The IT business unit shall assign unique identifiers to all existing and newly acquired enterprise assets.  
2. Each enterprise asset (e.g., desktops, laptops, servers, tablets), where applicable, must have an enterprise asset tag affixed to the device with this identifier.  
3. Record the enterprise asset identifier alongside other relevant information within the IT inventory. This includes:  
   - **Enterprise asset identifier**  
   - **Date of purchase**  
   - **Purchase price**  
   - **Item description**  
   - **Manufacturer**  
   - **Model number**  
   - **Serial number**  
   - **Enterprise asset owner (user, administrator, or business unit)**  
   - **Physical location (if applicable)**  
   - **MAC address**  
   - **IP address**  
   - **Warranty expiration date**  
   - **Any relevant licensing information**  
4. IT must verify the enterprise asset inventory **every six months** or more frequently.  

---

### **4.2 Discovery**  
1. Enterprise assets **not included in the inventory** must be investigated, as they may be unauthorized.  
   - **Assets not owned by the enterprise** must be removed from the network unless temporary access is granted by IT.  
   - **Enterprise-owned assets missing from the inventory** must be added to the inventory.  
2. Users must connect their **enterprise-assigned assets to the enterprise network at least weekly**, where practical.  
3. **Permanently air-gapped systems require IT approval.**  
4. IT must **review unauthorized assets weekly** and take appropriate action:  
   - Remove the asset from the network.  
   - Deny remote connection attempts.  
   - Quarantine the asset for further investigation.  

---

### **4.3 Usage**  
This section aligns with the **Acceptable Use Policy** but includes additional asset-specific considerations:  
1. Users must **handle all enterprise assets with care**.  
2. **Bi-annual verification of all assets** must be conducted remotely or in person.  
3. Asset owners must:  
   - Maintain control over the assigned asset.  
   - **Report malfunctions, required repairs, or lost equipment to IT**.  
   - Return unused or underutilized equipment for reassignment.  

---

### **4.4 Controlled Disposal**  
1. **Enterprise assets that are being decommissioned must be returned to IT.**  
2. IT will:  
   - Make **backups of user data, if necessary**.  
   - Securely erase all primary storage devices on the asset before disposal.  
   - Update the **enterprise asset inventory** to reflect the assetâ€™s retirement.  
   - Ensure records are retained according to the **Record Retention Policy**.  

---

### **4.5 Uncontrolled Disposal & Loss Prevention**  
1. **Lost or stolen assets must be reported immediately to IT, cybersecurity, and finance.**  
2. A **stolen enterprise asset requires a formal police report**.  
3. **IT must revoke access for any lost or stolen device** as soon as possible.  
   - This includes **revoking network access, resetting credentials, and wiping devices remotely**.  
   - The device must be marked as **"decommissioned"** in the asset inventory.  
```

---

## **5. Additional Implementation Notes for the Lab**  

### **5.1 Automated Asset Management**

- The **Proxmox Astronomy Lab uses Snipe-IT** for **tracking physical and virtual assets**.
- **Ansible and OSQuery automate asset discovery**, ensuring compliance with inventory policies.

### **5.2 Enhancements Beyond CIS Baselines**

ðŸ”¹ **Extended Asset Tracking** â€“ Includes **SDRs, IoT devices, and scientific instrumentation**.  
ðŸ”¹ **Cloud Integration** â€“ **Azure Arc tracks cloud-based assets alongside on-prem infrastructure**.  
ðŸ”¹ **Compliance and Auditing** â€“ **Automated inventory checks trigger alerts for missing assets**.  

---

## **6. Summary and Next Steps**  

âœ… **CIS Control 1 is fully implemented in the Proxmox Astronomy Lab**.  
âœ… **All IT and scientific assets are tagged, tracked, and reviewed regularly**.  
âœ… **Unauthorized assets are identified and removed from the network**.  
âœ… **Lifecycle management ensures secure asset disposal and data protection**.  

ðŸ“Œ **Actionable Next Steps:**  

- **Verify all assets are properly documented in Snipe-IT.**  
- **Ensure air-gapped systems have formal approval and tracking.**  
- **Integrate automated compliance checks via Ansible and OSQuery.**  

ðŸš€ **With these measures, the Proxmox Astronomy Lab maintains a robust, secure, and auditable asset management process.**

---

## **âœ… Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | âœ… Approved |

---

## **ðŸ“œ Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |


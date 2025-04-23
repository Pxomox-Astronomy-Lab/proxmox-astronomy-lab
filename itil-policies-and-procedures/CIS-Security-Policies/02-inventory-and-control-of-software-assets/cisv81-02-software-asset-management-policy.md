<!-- ---
title: "CISv8-02 Software Asset Management Policy"
description: "Defines the software asset management policy for the Proxmox Astronomy Lab, ensuring accurate tracking, authorization, and security of all software assets in compliance with CISv8, NIST 800-53, and ISO 27001."
author: "VintageDon"
tags: ["CISv8", "Software Asset Management", "Security Policy", "Compliance", "Application Control"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
 -->

# **📜 CISv8-02 Software Asset Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Software asset management is critical for maintaining **security, compliance, and operational stability** within the **Proxmox Astronomy Lab**. This policy establishes processes for **tracking, authorizing, and controlling software assets**, aligning with **CISv8, NIST 800-53, and ISO 27001**.

### **Key Objectives**

The following key objectives define the **scope and implementation** of software asset management within the lab:

| **Objective** | **Description** |
|--------------|----------------|
| **Complete Software Inventory** | Use GLPI and Osquery to track all installed software. |
| **Vendor Support Validation** | Ensure all software is currently supported by vendors. |
| **Unauthorized Software Prevention** | Detect and remove unauthorized software. |
| **Application Control Enforcement** | Restrict execution to only authorized applications. |

This policy applies to **all software** within the **Proxmox Astronomy Lab**, categorized as follows:

| **Software Type** | **Examples** |
|-----------------|-------------|
| **Operating Systems** | Windows Server, Ubuntu Server, Container OS images |
| **Applications** | Commercial software, open-source tools, custom applications |
| **Services** | Web servers, databases, monitoring services |
| **Utilities** | Administrative tools, system utilities, scripts |
| **Development Tools** | Compilers, IDEs, version control systems |

---

## **2. Compliance Mapping**

This policy aligns with industry compliance frameworks to ensure best practices in software management:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 2 – Inventory & Control of Software Assets |
| **NIST 800-53** | CM-7, CM-8, SI-7 – Software Control, Inventory, Integrity |
| **ISO 27001** | A.8.1, A.12.5.1 – Asset Management, Software Installation Control |

---

## **3. Responsibilities**

Roles and responsibilities are defined to ensure **clear accountability** in managing software assets:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Lab Owner** | Final approval for software acquisition, policy exceptions |
| **Security Administrator** | Security review, execution control configuration |
| **Systems Administrator** | Software installation, patch management, inventory maintenance |
| **End Users** | Request submission, proper software usage, reporting unauthorized software |

---

## **4. Policy Implementation**

### **4.1 Software Inventory Management**

Software tracking is maintained through **automated and manual processes** to ensure consistency and accuracy:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Unique Software Identification** | Record applications and services in GLPI. |
| **Comprehensive Inventory Records** | Track vendor, version, support status, installation location, and licensing. |
| **Quarterly Inventory Audits** | Reconcile detected software with authorized inventory. |
| **Dependency Tracking** | Document and manage software dependencies. |

#### **Automated Software Discovery**

Automated discovery ensures that all software is accounted for and unauthorized applications are detected:

| **System** | **Discovery Method** | **Frequency** |
|------------|---------------------|--------------|
| **Osquery** | Real-time monitoring of installed software | Continuous |
| **Ansible** | Scheduled scans for installed packages | Quarterly |
| **Wazuh** | File integrity monitoring and event detection | Continuous |

---

### **4.2 Software Authorization Process**

All software must go through a formal authorization process before installation:

| **Step** | **Description** | **Responsible Role** |
|---------|----------------|----------------------|
| **Request Submission** | Document business need, intended use, and scope | Requestor |
| **Security Review** | Assess security implications and risks | Security Administrator |
| **Support Verification** | Confirm vendor support status and lifecycle | Systems Administrator |
| **Approval Decision** | Formal approval or denial with documentation | Lab Owner |
| **Inventory Update** | Add to approved software list in GLPI | Systems Administrator |

---

### **4.3 Vendor Support Requirements**

All software must maintain active vendor support:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Vendor Support Verification** | Document support status, expiration dates, and support contacts. |
| **End-of-Life (EOL) Management** | Track approaching EOL dates and plan replacements. |
| **Support Compliance Review** | Conduct quarterly reviews of support status for all software. |
| **Exception Documentation** | Formally document risk acceptance for any exceptions. |

---

### **4.4 Unauthorized Software Detection & Removal**

Processes for detecting and addressing unauthorized software:

| **Action** | **Implementation** |
|----------|-------------------|
| **Continuous Monitoring** | Use Osquery and Wazuh to detect unauthorized software. |
| **Automated Alerting** | Generate alerts for unauthorized installation attempts. |
| **Removal Procedures** | Remove unauthorized software through automated scripts. |
| **Documentation** | Maintain records of unauthorized software incidents. |

---

### **4.5 Application Control Implementation**

Strict execution controls restrict usage to only authorized software:

| **Platform** | **Control Mechanism** | **Implementation** |
|--------------|---------------------|-------------------|
| **Windows Systems** | AppLocker/Group Policy | Whitelist-based execution control |
| **Linux Systems** | AppArmor Profiles | Process and resource access restrictions |
| **Container Environments** | Pod Security Policies | Image validation and admission control |

---

### **4.6 Software Acquisition & Installation**

Procedures for secure software acquisition and installation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Trusted Sources** | Software obtained only from verified sources. |
| **Integrity Verification** | Verify checksums or signatures before installation. |
| **Controlled Installation** | Software installed only by authorized personnel. |
| **Documentation** | Record all installation details in GLPI. |

---

### **4.7 Software Removal & Decommissioning**

Procedures for secure software removal:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Data Preservation** | Back up relevant data before removal. |
| **Complete Removal** | Remove all components, dependencies, and configurations. |
| **Inventory Update** | Update GLPI to reflect software removal. |
| **Post-Removal Verification** | Verify successful removal and system stability. |

---

## **5. Compliance Monitoring & Enforcement**

Regular verification ensures policy adherence:

| **Activity** | **Frequency** | **Method** | **Responsible Role** |
|--------------|--------------|-----------|----------------------|
| **Software Inventory Audit** | Quarterly | Automated reconciliation | Systems Administrator |
| **Unauthorized Software Scan** | Quarterly | Osquery and Ansible scans | Security Administrator |
| **Support Status Review** | Quarterly | GLPI reports and vendor verification | Systems Administrator |
| **Execution Control Testing** | Quarterly | Attempt to execute unauthorized software | Security Administrator |

---

## **6. Exception Management**

Formal procedures for handling exceptional cases:

| **Exception Type** | **Approval Requirements** | **Required Documentation** |
|-------------------|--------------------------|---------------------------|
| **Unsupported Software** | Lab Owner approval, risk assessment | Risk acceptance, compensating controls |
| **Unauthorized Installation** | Security review, temporary approval | Business justification, mitigation plan |
| **Execution Restriction Bypass** | Lab Owner approval, security review | Risk assessment, time limitation |

All exceptions must be **documented, time-limited, and include compensating controls** to mitigate potential risks.

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |

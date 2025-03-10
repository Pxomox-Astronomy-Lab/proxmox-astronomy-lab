<!-- ---
title: "README - CIS Control 15: Service Provider Management"
description: "An overview of CIS Control 15 and its implementation within the Proxmox Astronomy Lab, ensuring structured vendor management and compliance."
author: "VintageDon"
tags: ["CISv8.1", "Service Provider Management", "Third-Party Security", "Compliance", "Vendor Management"]
category: "Compliance"
kb_type: "README"
version: "1.0"
status: "Draft"
last_updated: "2025-03-04"
---
 -->

# **📜 README - CIS Control 15: Service Provider Management**

## **1. Introduction**

Service providers, including **cloud platforms, software vendors, and third-party service providers**, must be **properly managed and monitored** to ensure **security, compliance, and service continuity**. **CIS Control 15** mandates a **structured approach** to **vendor classification, onboarding, security reviews, and decommissioning** to protect enterprise data.

The **Proxmox Astronomy Lab** maintains an **inventory of service providers**, performs **annual security reviews**, and ensures **proper access controls** for all third-party services in compliance with **CISv8, NIST 800-53, and ISO 27001**.

| **Key Service Provider Management Features** | **Implementation** |
|--------------------------------------------|------------------|
| **Service Provider Inventory** | All vendors tracked in **Snipe-IT** with security classifications. |
| **Onboarding & Offboarding Policies** | Documented processes for vendor approval and decommissioning. |
| **Primary Cloud Providers** | **Azure is the primary cloud provider** with limited AWS use. |
| **Annual Security & Compliance Review** | Vendors reviewed for compliance with enterprise security policies. |
| **Access Control & Monitoring** | Vendor access tracked via **Azure, Loki, and other security tools**. |

📌 **See also:**

- [Service Provider Management Policy](../cisv81-controls/cisv81-15-service-provider-management-policy.md)
- [Service Provider Management Policy Template](../cisv81-policy-templates/cisv81-15-service-provider-management-template.md)

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All vendors, cloud providers, and third-party services used within the lab. |
| **Out-of-Scope** | Non-production test environments and temporary research tools. |
| **Compliance Mapping** | CIS Control 15, NIST 800-53 (SA-9), ISO/IEC 27001 (A.15). |

---

## **3. Service Provider Security Implementation**

### **Service Provider Inventory & Classification**

All third-party providers are **classified and reviewed** to ensure security compliance.

| **Security Measure** | **Implementation** |
|----------------------|----------------|
| **Inventory Tracking** | All service providers documented in **Snipe-IT**. |
| **Classification & Risk Assessment** | Vendors categorized based on service type and security posture. |
| **Annual Compliance Review** | Security certifications and policies reviewed yearly. |

### **Onboarding & Offboarding Policies**

All service providers must undergo **formal onboarding and decommissioning**.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Onboarding Review** | Security, compliance, and business justification required. |
| **Contractual Agreements** | Vendors must adhere to security and privacy standards. |
| **Offboarding & Decommissioning** | Secure removal of provider access and data verification. |

### **Compliance & Monitoring**

Service providers must align with **enterprise security policies** and be **continuously monitored**.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Annual Compliance Review** | All providers evaluated for security and performance. |
| **Service Monitoring** | Logging and alerting via **Azure, Loki, and Wazuh**. |
| **Vendor Risk Assessment** | Continuous assessment of provider security posture. |

### **Restricting Unauthorized Service Providers**

Only **approved vendors** may be used for enterprise services.

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Unauthorized Provider Policy** | Unapproved platforms are prohibited for enterprise data storage. |
| **Access Controls** | Strict security policies enforced for all vendor interactions. |
| **Review & Enforcement** | Non-compliant vendors flagged for remediation or decommissioning. |

---

## **4. Compliance Evidence**

| **Control** | **Implementation Details** | **Reference Document** |
|------------|----------------------|------------------|
| **15.1** | Service provider inventory and classification tracking. | [CISv8 15.1 Implementation](./15.1.md) |
| **15.2** | Vendor onboarding, contractual agreements, and risk assessment. | [CISv8 15.2 Implementation](./15.2.md) |
| **15.3** | Continuous monitoring and compliance review. | [CISv8 15.3 Implementation](./15.3.md) |
| **15.4** | Enforcing access control and decommissioning policies. | [CISv8 15.4 Compliance](./15.4.md) |

📌 **Each sub-control has a dedicated document outlining its enforcement and validation.**

---

## **5. Summary**

✅ **CIS Control 15 is fully implemented in the Proxmox Astronomy Lab, ensuring structured vendor management.**  
✅ **Service providers are inventoried, classified, and reviewed for security compliance.**  
✅ **Strict onboarding, offboarding, and monitoring processes protect enterprise data.**  

---

## ✅ Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-04 | ✅ DRAFT |

---

## 📜 Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |


<!-- 
---
title: "CIS Control 15: Service Provider Management"
description: "An overview of CIS Control 15 and its implementation within the Proxmox Astronomy Lab, ensuring structured vendor management and compliance."
author: "VintageDon"
tags: ["CISv8.1", "Service Provider Management", "Third-Party Security", "Compliance", "Vendor Management"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🤝 **CIS Control 15: Service Provider Management**

## 🔍 **1. Introduction**

CIS Control 15 forms a critical component of our third-party risk management strategy, establishing comprehensive oversight of all external service providers. This control ensures that security risks associated with vendors and cloud services are appropriately identified, assessed, and mitigated throughout the relationship lifecycle.

Service providers, including **cloud platforms, software vendors, and third-party service providers**, must be **properly managed and monitored** to ensure **security, compliance, and service continuity**. **CIS Control 15** mandates a **structured approach** to **vendor classification, onboarding, security reviews, and decommissioning** to protect enterprise data.

The **Proxmox Astronomy Lab** maintains an **inventory of service providers**, performs **annual security reviews**, and ensures **proper access controls** for all third-party services in compliance with **CISv8, NIST 800-53, and ISO 27001**.

The following table outlines our key service provider management components and their implementation:

| **Key Service Provider Management Features** | **Implementation** |
|--------------------------------------------|------------------|
| **Service Provider Inventory** | All vendors tracked in **Snipe-IT** with security classifications. |
| **Onboarding & Offboarding Policies** | Documented processes for vendor approval and decommissioning. |
| **Primary Cloud Providers** | **Azure is the primary cloud provider** with limited AWS use. |
| **Annual Security & Compliance Review** | Vendors reviewed for compliance with enterprise security policies. |
| **Access Control & Monitoring** | Vendor access tracked via **Azure, Loki, and other security tools**. |

This integrated approach ensures comprehensive oversight of all service provider relationships throughout their lifecycle.

📌 **See also:**

- [Service Provider Management Policy](../cisv81-controls/cisv81-15-service-provider-management-policy.md)
- [Service Provider Management Policy Template](../cisv81-policy-templates/cisv81-15-service-provider-management-template.md)

---

## 🎯 **2. Scope**

This control applies to all third-party relationships within the Proxmox Astronomy Lab environment, establishing clear requirements for service provider oversight while acknowledging practical limitations.

The following table outlines the scope boundaries for our service provider management:

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All vendors, cloud providers, and third-party services used within the lab. |
| **Out-of-Scope** | Non-production test environments and temporary research tools. |
| **Compliance Mapping** | CIS Control 15, NIST 800-53 (SA-9), ISO/IEC 27001 (A.15). |

This defined scope ensures that security resources are focused on the most critical service provider relationships while maintaining compliance with applicable frameworks.

---

## 📋 **3. Service Provider Security Implementation**

### **3.1 Service Provider Inventory & Classification**

Maintaining an accurate inventory of all service providers is essential for effective security management. This inventory includes appropriate classification and risk assessment information.

The following table details our inventory and classification implementation:

| **Security Measure** | **Implementation** |
|----------------------|----------------|
| **Inventory Tracking** | All service providers documented in **Snipe-IT**. |
| **Classification & Risk Assessment** | Vendors categorized based on service type and security posture. |
| **Annual Compliance Review** | Security certifications and policies reviewed yearly. |

This structured inventory provides visibility into all service provider relationships and forms the foundation for our security assessment and monitoring activities.

### **3.2 Onboarding & Offboarding Policies**

Structured processes for both onboarding and decommissioning service providers are essential for maintaining security throughout the service lifecycle.

The following table outlines our onboarding and offboarding implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Onboarding Review** | Security, compliance, and business justification required. |
| **Contractual Agreements** | Vendors must adhere to security and privacy standards. |
| **Offboarding & Decommissioning** | Secure removal of provider access and data verification. |

These structured processes ensure that security is maintained from the initial engagement through the end of the service relationship.

### **3.3 Compliance & Monitoring**

Continuous monitoring of service provider security is essential to ensure ongoing compliance with our requirements.

The following table outlines our compliance and monitoring implementation:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Annual Compliance Review** | All providers evaluated for security and performance. |
| **Service Monitoring** | Logging and alerting via **Azure, Loki, and Wazuh**. |
| **Vendor Risk Assessment** | Continuous assessment of provider security posture. |

This ongoing monitoring ensures that security issues are promptly identified and addressed throughout the service relationship.

### **3.4 Restricting Unauthorized Service Providers**

To maintain a secure environment, we must ensure that only approved service providers are used for enterprise data and operations.

The following table outlines our approach to unauthorized providers:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Unauthorized Provider Policy** | Unapproved platforms are prohibited for enterprise data storage. |
| **Access Controls** | Strict security policies enforced for all vendor interactions. |
| **Review & Enforcement** | Non-compliant vendors flagged for remediation or decommissioning. |

These controls prevent the proliferation of unauthorized service providers that could introduce security risks to the environment.

---

## 📊 **4. Compliance Evidence**

Maintaining evidence of control implementation is essential for demonstrating compliance and ensuring continued effectiveness. Our documentation provides comprehensive coverage of each sub-control's implementation.

The following table maps CIS Control 15 sub-controls to our implementation documentation:

| **Control** | **Implementation Details** | **Reference Document** |
|------------|----------------------|------------------|
| **15.1** | Service provider inventory and classification tracking. | [CISv8 15.1 Implementation](./15.1.md) |
| **15.2** | Vendor onboarding, contractual agreements, and risk assessment. | [CISv8 15.2 Implementation](./15.2.md) |
| **15.3** | Continuous monitoring and compliance review. | [CISv8 15.3 Implementation](./15.3.md) |
| **15.4** | Enforcing access control and decommissioning policies. | [CISv8 15.4 Compliance](./15.4.md) |

This structured documentation approach ensures that all aspects of the control are properly addressed and verified through regular assessment.

---

## 📈 **5. Summary**

CIS Control 15 provides a comprehensive framework for managing third-party risk through structured service provider oversight. Our implementation ensures continuous protection while maintaining operational efficiency.

Key implementation achievements:

✅ **CIS Control 15 is fully implemented in the Proxmox Astronomy Lab, ensuring structured vendor management.**  
✅ **Service providers are inventoried, classified, and reviewed for security compliance.**  
✅ **Strict onboarding, offboarding, and monitoring processes protect enterprise data.**  

This systematic approach significantly reduces the risks associated with third-party service providers while maintaining visibility throughout the relationship lifecycle.

---

## ✅ **Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

---

## 📜 **Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial version | VintageDon |
| 1.1 | 2025-03-16 | Standardized formatting | VintageDon |

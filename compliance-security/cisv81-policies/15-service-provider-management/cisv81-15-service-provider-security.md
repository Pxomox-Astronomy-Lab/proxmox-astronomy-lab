---
title: "CISv8-15 Service Provider Management Policy"
description: "Defines the service provider management policy for the Proxmox Astronomy Lab, ensuring all vendors, cloud providers, and service platforms are inventoried, monitored, and decommissioned securely."
author: "VintageDon"
tags: ["CISv8", "Service Provider Management", "Third-Party Security", "Compliance", "Vendor Management"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---

# **📜 CISv8-15 Service Provider Management Policy**

## **1. Overview**

### **Why This Policy Matters**

Service providers, including **cloud platforms, software vendors, and external service providers**, play a critical role in enterprise operations. Proper management of these providers ensures that **enterprise data is protected, compliance is maintained, and service continuity is assured**. This policy establishes a **structured approach to inventory, classification, monitoring, and decommissioning** of third-party service providers for the **Proxmox Astronomy Lab**.

### **Key Objectives**

This policy enforces **secure service provider management** through:

| **Objective** | **Description** |
|--------------|----------------|
| **Service Provider Inventory** | Maintained through **Snipe-IT**, with vendors, applications, and services classified. |
| **Defined Onboarding & Offboarding** | Onboarding and decommissioning policies documented and tracked. |
| **Primary Cloud Providers** | **Azure is the primary provider**, with some AWS usage, both known for extensive compliance frameworks. |
| **Annual Review & Compliance Tracking** | Service provider relationships reviewed annually. |

This policy aligns with **CISv8, NIST 800-53, and ISO 27001**, ensuring **proper vendor and service provider security practices**.

---

## **2. Compliance Mapping**

This policy aligns with **industry security frameworks** to maintain best practices:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 15 – Service Provider Management |
| **NIST 800-53** | SA-9 – External System Services |
| **ISO 27001** | A.15 – Supplier Relationships |

---

## **3. Responsibilities**

Roles and responsibilities ensure **proper enforcement of service provider security policies**:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Infrastructure Engineers (L2/L3)** | Maintain service provider inventory, review compliance documents, and ensure secure configurations. |
| **Administrators (L1/L2-Lite)** | Ensure vendors follow proper onboarding/offboarding processes and maintain compliance records. |
| **Business Unit Owners** | Ensure that service providers align with enterprise security and regulatory requirements. |

---

## **4. Policy Implementation**

### **4.1 Service Provider Inventory & Classification**

A comprehensive **inventory of service providers** must be maintained and updated **annually or upon major changes**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Inventory Management** | All service providers tracked in **Snipe-IT**. |
| **Service Provider Classifications** | Vendors, Applications, and Services categorized. |
| **Compliance & Security Review** | Service providers evaluated for compliance risks. |

---

### **4.2 Service Provider Compliance & Security Reviews**

Service providers must align with **enterprise security policies and compliance requirements**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Primary Cloud Providers** | **Azure (primary) and AWS (limited use)**, both with extensive compliance frameworks. |
| **Compliance Documentation** | Service provider security and compliance certifications reviewed annually. |
| **Access Control & Security Policies** | Providers must support MFA, encryption, and logging. |

---

### **4.3 Service Provider Onboarding & Offboarding**

New service providers must be **formally assessed before onboarding**, and decommissioning must follow a **secure removal process**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Onboarding Policies** | New vendors reviewed for security, compliance, and business needs. |
| **Contractual Agreements** | Security expectations outlined in contracts. |
| **Offboarding & Decommissioning** | Service providers removed securely, ensuring no residual access to enterprise data. |

---

### **4.4 Monitoring & Ongoing Verification**

Service provider compliance and security **must be reviewed regularly**:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Annual Compliance Review** | All providers reviewed for security and performance. |
| **Service Monitoring** | Logging and alerting via **Azure, Loki, and other security tools**. |
| **Vendor Risk Assessment** | Service providers evaluated for changes in security posture. |

---

### **4.5 Restricting Unauthorized Service Providers**

Only **approved** service providers may be used for enterprise data and services:

| **Requirement** | **Implementation** |
|--------------|------------------|
| **Unauthorized Provider Policy** | Users prohibited from storing enterprise data on unapproved platforms. |
| **Access Controls & Logging** | Enterprise security policies applied to all service provider access points. |
| **Review & Enforcement** | Non-compliant vendors flagged for review and decommissioning. |

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

🚀 **This policy ensures that service provider management remains a structured, actively enforced, and auditable process in the Proxmox Astronomy Lab.**

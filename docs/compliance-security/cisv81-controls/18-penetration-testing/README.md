<!-- ---
title: "README - CIS Control 18: Penetration Testing & Red Team Exercises"
description: "An overview of CIS Control 18 and its implementation within the Proxmox Astronomy Lab, ensuring proactive security validation and risk mitigation."
author: "VintageDon"
tags: ["CISv8.1", "Penetration Testing", "Security Assessment", "Compliance", "Network Hardening"]
category: "Compliance"
kb_type: "README"
version: "1.0"
status: "Draft"
last_updated: "2025-03-04"
---
 -->

# **📜 README - CIS Control 18: Penetration Testing & Red Team Exercises**

## **1. Introduction**

Penetration testing and security assessments are critical for identifying and mitigating vulnerabilities **before they can be exploited**. **CIS Control 18** mandates structured security testing procedures to ensure **resilience against threats and proactive risk mitigation**.

The **Proxmox Astronomy Lab** follows a **layered security model** that incorporates **Zero Trust principles, network segmentation, and internal security reviews**, aligning with **CISv8, NIST 800-53, and ISO 27001**.

| **Key Security Testing Features** | **Implementation** |
|----------------------------------|------------------|
| **No Externally Exposed Services** | All inbound traffic **restricted via Entra Private Access (EPA)**. |
| **Strict Firewall Policies** | FortiGate firewall enforces **default deny** inbound access. |
| **Internal Security Validation** | Monthly **network segmentation & firewall policy reviews**. |
| **Container & Kubernetes Security** | Hardened **Docker configurations, RBAC policies, and Helm security** in RKE2. |
| **Threat Monitoring & Logging** | **Wazuh + Loki** for anomaly detection and continuous monitoring. |

📌 **See also:**

- [Penetration Testing & Red Team Exercises Policy](../cisv81-controls/cisv81-18-penetration-testing-policy.md)
- [Penetration Testing & Red Team Exercises Policy Template](../cisv81-policy-templates/cisv81-18-penetration-testing-template.md)

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | Internal infrastructure, firewall policies, identity security, and container security. |
| **Out-of-Scope** | External penetration testing (as no public-facing assets exist). |
| **Compliance Mapping** | CIS Control 18, NIST 800-53 (CA-8), ISO/IEC 27001 (A.12.6). |

---

## **3. Security Testing Implementation**

### **Internal Security Reviews & Threat Simulation**

Given the **low external exposure**, penetration testing focuses on **internal security validation**.

| **Testing Type** | **Implementation** |
|--------------|------------------|
| **Firewall & Network Policy Review** | Monthly **FortiGate and VLAN segmentation policy analysis**. |
| **Endpoint Security Validation** | **Wazuh scans** for misconfigurations and vulnerabilities. |
| **Configuration Audits** | Regular reviews of **container security, RBAC, and IAM policies**. |

### **Internal Penetration Testing & Security Assessments**

| **Assessment Type** | **Implementation** |
|--------------|------------------|
| **External Penetration Test** | **Not required**, as no public-facing assets exist. |
| **Internal Penetration Test** | Focuses on **network segmentation and access control testing**. |
| **Cloud Security Review** | Ensures **Azure & AWS security configurations remain compliant**. |

### **Continuous Security Monitoring & Incident Detection**

| **Security Measure** | **Implementation** |
|--------------|------------------|
| **SIEM & Threat Detection** | **Wazuh + Loki** for real-time anomaly detection. |
| **Firewall Log Analysis** | Monthly **FortiGate review for misconfigurations**. |
| **Access Logs & Identity Protection** | **Entra ID monitors all authentication attempts**. |

---

## **4. Compliance Evidence**

| **Control** | **Implementation Details** | **Reference Document** |
|------------|----------------------|------------------|
| **18.1** | Internal penetration testing and security validation. | [CISv8 18.1 Implementation](./18.1.md) |
| **18.2** | Continuous monitoring and threat analysis. | [CISv8 18.2 Implementation](./18.2.md) |
| **18.3** | Firewall segmentation review and network hardening. | [CISv8 18.3 Implementation](./18.3.md) |
| **18.4** | Role-based access control and IAM security testing. | [CISv8 18.4 Compliance](./18.4.md) |

📌 **Each sub-control has a dedicated document outlining its enforcement and validation.**

---

## **5. Summary**

✅ **CIS Control 18 is fully implemented in the Proxmox Astronomy Lab, ensuring structured penetration testing and security validation.**  
✅ **Internal security assessments focus on network segmentation, IAM security, and firewall policy reviews.**  
✅ **Continuous monitoring and threat detection enhance proactive security defenses.**  

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


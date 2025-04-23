<!-- 
---
title: "CISv8-18 Penetration Testing & Red Team Exercises Policy"
description: "Defines the penetration testing and security assessment policy for the Proxmox Astronomy Lab, ensuring proactive security validation and risk mitigation."
author: "VintageDon"
tags: ["CISv8", "Penetration Testing", "Security Assessment", "Compliance", "Network Hardening"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 🔍 **CISv8-18 Penetration Testing & Red Team Exercises Policy**

## 🎯 **1. Purpose**

This policy establishes the framework for security testing within the Proxmox Astronomy Lab. By implementing structured security assessments and validation procedures, we identify and address vulnerabilities before they can be exploited, maintaining the integrity and security of our environment.

Penetration testing and security assessments are critical for identifying and mitigating vulnerabilities **before they can be exploited**. This policy defines **structured security testing procedures, risk assessments, and proactive mitigation strategies** for the **Proxmox Astronomy Lab**.

---

## 🔭 **2. Scope**

This policy governs security testing activities across the lab environment, establishing clear requirements for validating security controls while acknowledging the lab's unique architecture.

This policy applies to **all IT assets, networks, and services** operating within the **Proxmox Astronomy Lab**, including:

- **Physical and virtual infrastructure (Proxmox, Kubernetes, Windows/Linux servers)**
- **Cloud environments (Azure, AWS)**
- **Edge security controls (FortiGate firewall, Entra Private Access)**
- **Internal applications, data pipelines, and SDR-based research workflows**

### **2.1 Key Considerations for the Lab**

The lab's architecture creates a unique security testing context that must be considered when implementing this policy:

- **No externally exposed assets**: All inbound traffic **restricted via Entra Private Access (EPA)**.
- **Strict firewall policies**: FortiGate firewall at the edge **blocks all unauthorized access**.
- **No DNAT rules or public-facing services**.
- **Residential/SMB-grade internet with no external attack surface**.
- **Internal security posture already hardened with Zero Trust principles**.

These architectural features significantly reduce the external attack surface while focusing security testing needs on internal validation.

---

## 📊 **3. Compliance Mapping**

Our penetration testing and security assessment strategy aligns with multiple industry frameworks to ensure comprehensive coverage and best practices implementation. These mappings help demonstrate our security posture to stakeholders and ensure regulatory compliance.

The following table shows how this policy maps to established security frameworks:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 18 – Penetration Testing & Red Team Exercises |
| **NIST 800-53** | CA-8 – Penetration Testing |
| **ISO 27001** | A.12.6 – Technical Vulnerability Management |

By aligning with these frameworks, we ensure our security testing approach meets industry standards while adapting to our specific environment.

---

## 👥 **4. Responsibilities**

Effective security testing requires clear role definition and accountability across the organization. Each role has specific responsibilities that contribute to our overall security posture.

The following table outlines the primary responsibilities for implementing and maintaining our security testing program:

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Lead Engineer (Security Lead)** | Oversees security testing, implements mitigations, and ensures compliance. |
| **Infrastructure Engineers (L2/L3)** | Conduct internal security reviews and validate configurations. |
| **Administrators (L1/L2-Lite)** | Monitor security logs, enforce firewall rules, and manage vulnerability reports. |

This clear delineation of responsibilities ensures that security testing remains a priority with appropriate oversight and execution.

---

## 🛡️ **5. Policy Implementation**

### **5.1 Security Testing Strategy**

The lab's security architecture requires a tailored testing approach that focuses on internal validation rather than traditional external penetration testing.

The following table outlines our security testing strategy:

| **Testing Type** | **Implementation** |
|--------------|------------------|
| **External Network Testing** | Limited scope—no public-facing services to assess. |
| **Internal Security Reviews** | Conducted by **Infrastructure Engineers** for misconfigurations. |
| **Firewall & Network Policy Review** | Monthly review of **FortiGate firewall and VLAN segmentation policies**. |
| **Endpoint Security Validation** | Regular **Wazuh scans** for anomalies and vulnerabilities. |

This approach ensures appropriate security validation while acknowledging the limited external attack surface.

---

### **5.2 Fortified Security Architecture**

Our security architecture establishes multiple defensive layers that reduce the need for traditional penetration testing while requiring focused internal validation.

The following table outlines our security architecture components:

| **Security Feature** | **Implementation** |
|--------------|------------------|
| **No Public-Facing Services** | All access via **Entra Private Access (EPA)** with **MFA**. |
| **Edge Firewall Protection** | FortiGate firewall **blocks inbound connections by default**. |
| **Zero Trust Model** | **No automatic trust** between VLANs, access controlled strictly. |
| **Encrypted Traffic** | **All traffic is TLS-secured** with no unencrypted services. |

These architectural features create a security posture that shifts testing priorities toward internal validation.

---

### **5.3 Internal Security Validation & Threat Simulation**

Given our limited external exposure, internal security validation forms the core of our testing strategy.

The following table outlines our internal validation approach:

| **Assessment Type** | **Implementation** |
|--------------|------------------|
| **Vulnerability Scanning** | Regular scans using **Wazuh + Loki** for anomaly detection. |
| **Configuration Audits** | Monthly review of **firewall rules, segmentation policies, and logs**. |
| **Container & Kubernetes Security** | Ensuring **hardened Docker configurations, RBAC policies, and Helm security** in RKE2. |

This focus on internal validation ensures that our security controls are properly implemented and maintained.

---

### **5.4 Penetration Testing & Security Assessments**

While traditional external penetration testing has limited applicability, we maintain appropriate security assessment capabilities.

The following table outlines our penetration testing approach:

| **Penetration Testing Scope** | **Implementation** |
|--------------|------------------|
| **External Penetration Test** | **Not required**, as no public-facing assets exist. |
| **Internal Penetration Test** | Available if needed, focusing on **Kubernetes security, container scanning, and endpoint hardening**. |
| **Cheap External Scan Option** | A **low-cost external pen test** can be arranged if compliance requires proof. |

This approach ensures appropriate security validation while efficiently allocating security resources.

---

### **5.5 Continuous Security Monitoring & Incident Detection**

Continuous monitoring complements our security testing by providing ongoing validation of security controls.

The following table outlines our security monitoring approach:

| **Security Measure** | **Implementation** |
|--------------|------------------|
| **SIEM & Threat Detection** | **Wazuh + Loki** continuously monitor logs for anomalies. |
| **Firewall Log Analysis** | **FortiGate logs reviewed monthly** for misconfigurations. |
| **Access Logs & Identity Protection** | **Entra ID logs all access attempts** to enforce Zero Trust. |

This continuous monitoring ensures that security issues are identified and addressed promptly between formal security assessments.

---

## 🚫 **6. Exception Handling**

In certain scenarios, exceptions to this policy may be required. All exceptions must follow a structured review and approval process to ensure security risks are properly managed.

Exceptions to this policy must be **requested in writing** and include:

- **Justification for the request**
- **Risk assessment of non-compliance**
- **Proposed alternative mitigations**
- **Technical challenges preventing compliance**
- **Planned review date for reevaluation**

This structured approach ensures that any policy exceptions are properly documented and regularly reevaluated.

---

## 🔒 **7. Enforcement & Non-Compliance**

Enforcement mechanisms are essential for ensuring policy compliance. When violations are detected, a structured response process will be followed.

Failure to comply with this policy may result in:

- Restricted access to lab network resources
- Security review escalation
- Required remedial actions to restore compliance

These enforcement measures ensure that policy violations are addressed promptly and appropriately.

---

## ✅ **Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |  

---

## 📜 **Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |
| 1.1 | 2025-03-16 | Standardized formatting | VintageDon |

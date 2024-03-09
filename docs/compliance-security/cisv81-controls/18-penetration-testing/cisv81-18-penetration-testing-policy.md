---
title: "CISv8-18 Penetration Testing & Red Team Exercises Policy"
description: "Defines the penetration testing and security assessment policy for the Proxmox Astronomy Lab, ensuring proactive security validation and risk mitigation."
author: "VintageDon"
tags: ["CISv8", "Penetration Testing", "Security Assessment", "Compliance", "Network Hardening"]
category: "Compliance"
kb_type: "Policy Document"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---

# **ðŸ“œ CISv8-18 Penetration Testing & Red Team Exercises Policy**

## **1. Purpose**

Penetration testing and security assessments are critical for identifying and mitigating vulnerabilities **before they can be exploited**. This policy defines **structured security testing procedures, risk assessments, and proactive mitigation strategies** for the **Proxmox Astronomy Lab**.

## **2. Scope**

This policy applies to **all IT assets, networks, and services** operating within the **Proxmox Astronomy Lab**, including:

- **Physical and virtual infrastructure (Proxmox, Kubernetes, Windows/Linux servers)**
- **Cloud environments (Azure, AWS)**
- **Edge security controls (FortiGate firewall, Entra Private Access)**
- **Internal applications, data pipelines, and SDR-based research workflows**

### **Key Considerations for the Lab**

- **No externally exposed assets**: All inbound traffic **restricted via Entra Private Access (EPA)**.
- **Strict firewall policies**: FortiGate firewall at the edge **blocks all unauthorized access**.
- **No DNAT rules or public-facing services**.
- **Residential/SMB-grade internet with no external attack surface**.
- **Internal security posture already hardened with Zero Trust principles**.

---

## **3. Compliance Mapping**

This policy aligns with **industry security frameworks** to maintain best practices:

| **Framework** | **Control Mapping** |
|--------------|------------------|
| **CISv8** | CIS Control 18 â€“ Penetration Testing & Red Team Exercises |
| **NIST 800-53** | CA-8 â€“ Penetration Testing |
| **ISO 27001** | A.12.6 â€“ Technical Vulnerability Management |

---

## **4. Responsibilities**

| **Role** | **Responsibilities** |
|---------|----------------------|
| **Lead Engineer (Security Lead)** | Oversees security testing, implements mitigations, and ensures compliance. |
| **Infrastructure Engineers (L2/L3)** | Conduct internal security reviews and validate configurations. |
| **Administrators (L1/L2-Lite)** | Monitor security logs, enforce firewall rules, and manage vulnerability reports. |

---

## **5. Policy Implementation**

### **5.1 Security Testing Strategy**

Due to the **lack of externally exposed services**, penetration testing will **focus on internal assets**:

| **Testing Type** | **Implementation** |
|--------------|------------------|
| **External Network Testing** | Limited scopeâ€”no public-facing services to assess. |
| **Internal Security Reviews** | Conducted by **Infrastructure Engineers** for misconfigurations. |
| **Firewall & Network Policy Review** | Monthly review of **FortiGate firewall and VLAN segmentation policies**. |
| **Endpoint Security Validation** | Regular **Wazuh scans** for anomalies and vulnerabilities. |

---

### **5.2 Fortified Security Architecture**

The labâ€™s **security architecture inherently limits the need for extensive external testing**:

| **Security Feature** | **Implementation** |
|--------------|------------------|
| **No Public-Facing Services** | All access via **Entra Private Access (EPA)** with **MFA**. |
| **Edge Firewall Protection** | FortiGate firewall **blocks inbound connections by default**. |
| **Zero Trust Model** | **No automatic trust** between VLANs, access controlled strictly. |
| **Encrypted Traffic** | **All traffic is TLS-secured** with no unencrypted services. |

---

### **5.3 Internal Security Validation & Threat Simulation**

| **Assessment Type** | **Implementation** |
|--------------|------------------|
| **Vulnerability Scanning** | Regular scans using **Wazuh + Loki** for anomaly detection. |
| **Configuration Audits** | Monthly review of **firewall rules, segmentation policies, and logs**. |
| **Container & Kubernetes Security** | Ensuring **hardened Docker configurations, RBAC policies, and Helm security** in RKE2. |

---

### **5.4 Penetration Testing & Security Assessments**

Given the lab's **low-risk external footprint**, penetration testing is **optional** but available:

| **Penetration Testing Scope** | **Implementation** |
|--------------|------------------|
| **External Penetration Test** | **Not required**, as no public-facing assets exist. |
| **Internal Penetration Test** | Available if needed, focusing on **Kubernetes security, container scanning, and endpoint hardening**. |
| **Cheap External Scan Option** | A **low-cost external pen test** can be arranged if compliance requires proof. |

---

### **5.5 Continuous Security Monitoring & Incident Detection**

| **Security Measure** | **Implementation** |
|--------------|------------------|
| **SIEM & Threat Detection** | **Wazuh + Loki** continuously monitor logs for anomalies. |
| **Firewall Log Analysis** | **FortiGate logs reviewed monthly** for misconfigurations. |
| **Access Logs & Identity Protection** | **Entra ID logs all access attempts** to enforce Zero Trust. |

---

## **6. Exception Handling**

Exceptions to this policy must be **requested in writing** and include:

- **Justification for the request**
- **Risk assessment of non-compliance**
- **Proposed alternative mitigations**
- **Technical challenges preventing compliance**
- **Planned review date for reevaluation**

---

## **7. Enforcement & Non-Compliance**

Failure to comply with this policy may result in:

- Restricted access to lab network resources
- Security review escalation
- Required remedial actions to restore compliance

---

## **âœ… Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | âœ… DRAFT |  

---

## **ðŸ“œ Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

ðŸš€ **This policy ensures that penetration testing and security assessments remain a structured, actively enforced, and auditable process in the Proxmox Astronomy Lab.**


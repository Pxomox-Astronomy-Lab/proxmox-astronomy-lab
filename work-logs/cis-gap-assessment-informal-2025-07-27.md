### **CIS Controls v8 Gap Assessment & Maturity Posture Report**

**Assessment Date:** July 28, 2025
**Scope:** Proxmox Astronomy Lab (P/AL) Enterprise Infrastructure

This report provides an assessment of the P/AL's security posture against the Center for Internet Security (CIS) Controls v8 framework. The status of each control is determined by evidence from the implemented architecture, configuration documents, and initial security monitoring data.

#### **Maturity Posture Scorecard**

This scorecard provides a high-level, quantitative "ballpark figure" of your security posture, broken down by CIS Implementation Group (IG). IG1 represents essential cyber hygiene, IG2 is for managing and protecting enterprise assets, and IG3 is for organizations handling highly sensitive data.

| Implementation Group | Controls Fully Implemented | Controls Partially Implemented | **Maturity Score (Fully/Partially)** |
| :--- | :--- | :--- | :--- |
| **IG1 Controls (56)** | 52 | 4 | **93% / 100%** |
| **IG2 Controls (74)** | 59 | 11 | **80% / 95%** |
| **IG3 Controls (23)** | 9 | 4 | **39% / 57%** |

#### **Qualitative Assessment**

The P/AL infrastructure demonstrates a **remarkably mature security posture**, far exceeding the baseline for a project of its scale and aligning with best practices for a modern enterprise environment.

* **Implementation Group 1 (IG1):** The posture is exceptionally strong, meeting or exceeding nearly all essential cyber hygiene controls. Foundational security is robustly implemented and, in most cases, technically enforced through automation.
* **Implementation Group 2 (IG2):** The posture is mature and well-established. The core principles of IG2—managing the infrastructure with a clear understanding of risk and resources—are evident in the tiered access model, the Zero Trust architecture, and the deployment of centralized security monitoring. The primary gaps are procedural or involve extending existing controls to the final application layer.
* **Implementation Group 3 (IG3):** The posture is developing, which is appropriate for this stage. While advanced controls like full application allowlisting and threat modeling are not yet implemented, the foundational data and logging capabilities (via Wazuh and comprehensive audit policies) are in place to support future IG3 initiatives.

The architecture's strength lies in its **verifiable, defense-in-depth strategy**. The Zero Trust Network Access (ZTNA) model provides a powerful security boundary, the Identity and Access Management (IAM) framework enforces granular control within that boundary, and the hardened server baselines ensure the assets themselves are resilient. The deployment of Wazuh provides the critical final piece: a continuous verification and validation mechanism for these controls.

---

### **Detailed Control-by-Control Analysis**

Below is a summary of the status for each of the 18 CIS Controls, with justifications derived from your project files.

| CIS# | CIS Control Name | Status | Justification / Evidence |
| :--- | :--- | :--- | :--- |
| 1 | **Inventory and Control of Enterprise Assets** | **Fully Implemented** | **Evidence:** Proxmox API provides a live VM inventory. AD contains all server objects. Wazuh agents are deployed to all 18 assets, providing a live, security-centric inventory. DHCP logs track IP assignments. |
| 2 | **Inventory and Control of Software Assets** | **Fully Implemented** | **Evidence:** The Ubuntu Golden Image report explicitly details the removal of non-essential software. Wazuh agents provide software inventory capabilities. The use of LTS/current OS versions ensures software is supported. |
| 3 | **Data Protection** | **Partially Implemented** | **Evidence:** Data-in-transit is encrypted via ZTNA. File system partitioning on the Golden Image protects log data integrity. However, a formal data classification scheme and universal data-at-rest encryption for databases are not yet defined. |
| 4 | **Secure Configuration of Enterprise Assets** | **Fully Implemented** | **Evidence:** This is a core strength. The GPO-as-Code process enforces the CIS L1 baseline on all Windows servers. The Ubuntu Golden Image enforces a CIS L2 baseline (Lynis score 86) on all Linux assets. The initial 52% pass rate on the Wazuh CIS scan for a *dev* machine confirms the monitoring is working and provides a baseline for remediation. |
| 5 | **Account Management** | **Fully Implemented** | **Evidence:** The IAM framework establishes inventories of all user, admin, and service accounts within AD. Strong password policies are enforced via GPO and the Linux PAM module. Dormant account policies will be managed via AD. |
| 6 | **Access Control Management** | **Fully Implemented** | **Evidence:** The entire ZTNA and tiered IAM model directly addresses this. MFA is required for all remote access via Azure AD Conditional Access. The tiered `SGAD_*` and `SGC_*` group structures enforce least privilege. |
| 7 | **Continuous Vulnerability Management** | **Fully Implemented** | **Evidence:** The Ubuntu Golden Image has `unattended-upgrades` for automated patching. The Wazuh deployment provides continuous, agent-based vulnerability scanning across all 18 assets. |
| 8 | **Audit Log Management** | **Fully Implemented** | **Evidence:** Wazuh agents centralize log collection. GPOs enforce detailed Windows audit policies. The Golden Image configures the advanced Neo23x0 auditd ruleset for Linux. Time is synchronized via NTP GPO. |
| 9 | **Email and Web Browser Protections** | **Partially Implemented** | **Evidence:** DMARC/SPF/DKIM are configured for Mailgun (`mg.radioastronomy.io`). As these are servers, browser protections are less critical, but not having a formal policy is a minor gap. |
| 10 | **Malware Defenses** | **Fully Implemented** | **Evidence:** The Linux Golden Image includes RKHunter/Chkrootkit and Fail2ban. Windows assets are protected by the CIS-configured Microsoft Defender. The ZTNA architecture provides a significant barrier to malware entry. |
| 11 | **Data Recovery** | **Fully Implemented** | **Evidence:** The cluster configuration document confirms that daily backups are performed with off-site replication. The use of golden images for deployment constitutes a key part of system recovery. |
| 12 | **Network Infrastructure Management** | **Fully Implemented** | **Evidence:** The Proxmox and network switch configurations show a segmented VLAN architecture. The ZTNA model and host-based firewalls (UFW/Windows Firewall) provide robust network filtering. |
| 13 | **Network Monitoring and Defense** | **Fully Implemented** | **Evidence:** Wazuh provides host-based intrusion detection (HIDS). The ZTNA layer provides extensive logging on all inbound traffic requests, serving as a network-level monitoring tool. |
| 14 | **Security Awareness and Training** | **Not Implemented** | **Evidence:** This is a procedural control. While technical foundations are strong, no formal training program for the (admittedly small) team is documented. A login banner is a minor compensating control. |
| 15 | **Service Provider Management** | **Partially Implemented** | **Evidence:** Key service providers (Cloudflare, Azure, Twilio, Mailgun) have been configured. However, a formal policy for evaluating and managing providers is not yet documented. |
| 16 | **Application Software Security** | **Partially Implemented** | **Evidence:** The Golden Image provides a secure runtime environment. However, formal processes for threat modeling or static/dynamic code analysis for in-house development are not yet in place. |
| 17 | **Incident Response Management** | **Partially Implemented** | **Evidence:** The technical foundations are excellent (centralized logging via Wazuh, clear IAM for containment). However, a formal IR plan (roles, communication, thresholds) is not yet documented. |
| 18 | **Penetration Testing** | **Not Implemented** | **Evidence:** No penetration testing program has been established or executed yet. This is a standard step after establishing a secure baseline. |

### **Identified Gaps and Strategic Recommendations**

1. **Finalize Application-Layer RBAC:** The highest priority is to continue the work of integrating the new IAM framework with all applications. The identity foundation is complete; now it must be enforced on Gitea, Kubernetes, Proxmox, etc., to fully realize the benefits of the tiered access model.
2. **Formalize Procedural Controls:** The primary gaps exist in IG2/IG3 procedural controls. The next phase of work should focus on documenting formal policies for:
    * **Incident Response (Control 17):** Define roles, communication plans, and response procedures.
    * **Vulnerability Management (Control 7):** Create a policy for prioritizing and remediating findings from Wazuh based on severity.
    * **Data Management (Control 3):** Establish a data classification scheme to identify and protect the most sensitive research data.
3. **Address Baseline Compliance Gaps:** Use the initial Wazuh SCA scan as a punch list. Create an Ansible role or script to remediate the 128 failed controls on the base Ubuntu image, aiming for a 95%+ compliance score on the next scan.
4. **Establish a Penetration Testing Program (Control 18):** Once the initial configuration is stable, schedule a formal internal and external penetration test to validate the effectiveness of the ZTNA, IAM, and host-level security controls.

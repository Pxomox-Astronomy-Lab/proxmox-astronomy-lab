<!-- 
---
Title: Compliance & Security - Proxmox Astronomy Lab
Description: Documentation for security policies, compliance frameworks, and security monitoring in the Proxmox Astronomy Lab. Adheres to CISv8.1 while mapping to NIST, ISO27001, and MITRE ATT&CK frameworks.
Tags: compliance, security, CISv8.1, NIST, ISO27001, MITRE ATT&CK, Wazuh, monitoring
Version: 1.0
LastUpdated: 2025-03-09
Author: Don [L3 Engineer | Proxmox Astronomy Lab]
Status: Active
Visibility: Public
---
-->

# **🔐 Compliance & Security - Proxmox Astronomy Lab**

## **1. Overview**

This section documents the **security policies, compliance frameworks, and security monitoring** implemented within the **Proxmox Astronomy Lab**. The lab follows **CIS Controls v8.1** as a baseline while mapping to **higher-level frameworks** such as **NIST and ISO27001** for best practices.

---

## **2. Folder Structure**

The compliance and security documentation is categorized as follows:

```
compliance-security/
│── README.md  # This file
│
├── cisv8-controls/          # Detailed breakdown of CIS v8.1 controls applied in the lab
├── cisv8-policy-templates/  # Standardized CISv8.1 policy templates for lab compliance
├── cisv81-controls/         # Tracking CISv8.1 implementation per control
├── cisv81-policy-templates/ # Templates for CISv8.1-specific compliance policies
├── hardening-guides/        # System hardening best practices and CIS benchmarks
├── incident-response/       # Lab-specific incident response policies & playbooks
├── lab-security-policies/   # General lab security governance, policies & enforcement
├── security-monitoring/     # Security event monitoring, Wazuh integration & alerts
```

### **Key Sections**

- **`cisv8-controls/`** → Documents how each **CISv8.1 control** is implemented.
- **`cisv8-policy-templates/`** → **Prebuilt templates** for security policies based on **CISv8.1**.
- **`hardening-guides/`** → Covers **Ubuntu 24.04 CIS L2 hardening, Windows Server 2025 CIS L1**.
- **`incident-response/`** → Playbooks & documentation for **incident detection & handling**.
- **`security-monitoring/`** → Logs, alerts, and **Wazuh SIEM integrations**.

---

## **3. Compliance & Security Frameworks**

### **3.1 CIS v8.1 Compliance**

🚀 **The lab adheres to CISv8.1 controls**, ensuring a **secure-by-default architecture**.  
Each **CIS control** is documented under `cisv8-controls/` with mappings to **lab policies**.

✅ **Baseline Compliance Measures**

- **Ubuntu 24.04 CIS Level 2** applied to all Linux servers.
- **Windows Server 2025 CIS Level 1** applied to domain controllers.
- **Automated daily compliance scans** with **Lynis, CIS-CAT, and Wazuh**.

### **3.2 Additional Security Standards**

The lab **references higher frameworks** for **long-term security goals**, including:

- **NIST 800-53 & ISO27001 mappings** for **lab-wide security best practices**.
- **NIST CSF (Cybersecurity Framework)** for **incident response alignment**.
- **MITRE ATT&CK framework** for **threat detection** via Wazuh integration.

---

## **4. Security Monitoring & Incident Response**

### **4.1 Security Monitoring Stack**

🔎 **The lab integrates real-time security monitoring** using:

- **Wazuh SIEM** → Logs, compliance scans, real-time alerts.
- **Prometheus + Loki** → System-wide log aggregation.
- **SNMP & NetFlow monitoring** → Network security insights.

### **4.2 Incident Response Process**

📌 **Key Playbooks & Escalation Procedures**:

- **Security Incident Response Playbook** (`incident-response/`)
- **Automated Threat Detection via Wazuh SIEM**
- **Regular Security Audits & Compliance Checks**

---

## **5. How to Use This Section**

🔹 **Looking for CISv8.1 control implementations?** → Check **`cisv8-controls/`**  
🔹 **Need policy templates?** → See **`cisv8-policy-templates/`**  
🔹 **Want to understand lab security architecture?** → Refer to **`lab-security-policies/`**  
🔹 **Need guidance on security event monitoring?** → Visit **`security-monitoring/`**  

📖 **Related Documentation**

- **[CIS v8.1 Policy Templates](cisv81-policy-templates/)**
- **[Ubuntu 24.04 LTS CIS L2 Hardening Guide](hardening-guides/)**
- **[Security Monitoring & Wazuh Integration](security-monitoring/)**

---

## **6. Contribution & Maintenance**

🔹 **Contributors:** Follow **structured documentation updates**.  
🔹 **Issues:** Security-related issues should be **tracked in the Git repository**.  
🔹 **Updates:** Ensure **all new policies align with CISv8.1 and document changes clearly**.  

---

🚀 **Ensuring security through structured compliance!**

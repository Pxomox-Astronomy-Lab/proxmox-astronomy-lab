---
title: "CIS Control 4: Secure Configuration Management in the Proxmox Astronomy Lab"
description: "Overview of CIS Control 4, ensuring all systems in the lab follow secure configuration practices through golden templates, automation, and continuous monitoring."
author: "VintageDon"
tags: ["CISv8.1", "Secure Configuration", "Hardening", "Compliance", "Proxmox"]
category: "Compliance"
kb_type: "Reference"
version: "1.0"
status: "Draft"
last_updated: "2025-03-03"
---

# **🛠 CIS Control 4: Secure Configuration Management in the Proxmox Astronomy Lab**

## **1. Introduction**

A **secure configuration baseline** is critical for **minimizing attack surfaces, reducing misconfigurations, and enforcing security best practices**. **CIS Control 4** focuses on **establishing, maintaining, and enforcing hardened configurations** across all enterprise assets.

The **Proxmox Astronomy Lab** enforces **secure configurations through:**
✅ **Golden Templates** for all OS deployments.  
✅ **Automated Configuration Management** via **Ansible & Group Policy**.  
✅ **Continuous Monitoring & Alerting** using **Wazuh, Lynis, and Prometheus**.  
✅ **Policy-Based Firewall & Network Security Controls**.  
✅ **Strict Application Control & Execution Policies**.  

📌 **See also:**  

- [Secure Configuration Management Policy](../cisv81-controls/cisv81-04-secure-configuration-management-policy.md)  
- [Secure Configuration Management Policy Template](../cisv81-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md)  

---

## **2. Scope**

| **Category**  | **Description** |
|--------------|----------------|
| **In-Scope** | All Windows & Linux-based servers, network devices, and security configurations. |
| **Out-of-Scope** | Temporary or testing environments without compliance requirements. |
| **Compliance Mapping** | CIS Control 4, NIST 800-53 (CM-6, SI-2), ISO/IEC 27001 (A.12.1.2, A.14.2.4). |

---

## **3. Sub-Control Implementation**

This section outlines **how each sub-control** of CIS Control 4 is implemented in the Proxmox Astronomy Lab.

### **4.1: Establish and Maintain a Secure Configuration Process**

✅ **Requirement:** Ensure all systems are deployed using **hardened configurations** and follow a **documented, repeatable process**.  

✅ **Implementation in the Lab:**  

- **Golden Templates:**  
  - **Ubuntu 24 Server** – CISv8 Level 2 **Lynis base score: 87**.  
  - **Ubuntu 24 Desktop** – CISv8 Level 2 **Lynis base score: 81**.  
  - **Windows Server 2025 Standard** – CISv9 Level 1 (**Awaiting benchmark verification**).  
- **Automation & Enforcement:**  
  - **Ansible Playbooks** enforce CIS hardening standards.  
  - **Daily Wazuh CIS Scans** detect misconfigurations.  
  - **Weekly Lynis Scans** validate security posture.  
  - **Real-time alerting via Alertmanager** on critical misconfigurations.  

---

### **4.2: Change Control and Secure Network Configurations**

✅ **Requirement:** Ensure network configurations are **documented, controlled, and reviewed**.  

✅ **Implementation in the Lab:**  

- **FortiGate 40F Edge Firewall**:  
  - **Firewall policies are documented** and reviewed **quarterly**.  
  - **Automatic configuration backups** stored both **on-site & off-site**.  
- **Managed Network Switches (labswitch01/02)**:  
  - VLAN and port assignments are **tracked in Netbox**.  
  - Unauthorized changes trigger **Wazuh alerts**.  

---

### **4.3: Secure System Configuration Enforcement**

✅ **Requirement:** Ensure configurations remain in compliance with security baselines.  

✅ **Implementation in the Lab:**  

- **Group Policy & Ansible** enforce OS hardening.  
- **Deviation detection via Wazuh**, triggering alerts.  

---

### **4.4 & 4.5: Host-Based Firewall Enforcement**

✅ **Requirement:** Ensure **host-based firewalls** are configured and actively enforced.  

✅ **Implementation in the Lab:**  

- **Windows Firewall (GPO Managed)**:  
  - Default policies: **Block all inbound traffic, allow essential services**.  
- **Linux UFW (Ansible Managed)**:  
  - Default policies: **Deny inbound, allow outbound, restrict services by host**.  

---

### **4.6: Use Only Secure Network Protocols**

✅ **Requirement:** Disable legacy and insecure protocols.  

✅ **Implementation in the Lab:**  

- **Secure traffic enforcement:**  
  - **SSH (Key-based auth)**, **TLS 1.2+**, **RDP with EPA**.  
- **Disabled insecure protocols:**  
  - **Telnet, SMBv1, TLS 1.0, weak ciphers in OpenSSH & RDP**.  

---

### **4.7: Disable Default Accounts & Enforce Strong Authentication**

✅ **Requirement:** Default accounts should be **disabled, renamed, or secured**.  

✅ **Implementation in the Lab:**  

- **All default accounts disabled or renamed**.  
- **Privileged accounts require 30+ character passphrases**.  

---

### **4.8: Securely Manage Configuration Deviations**

✅ **Requirement:** Detect unauthorized configuration changes.  

✅ **Implementation in the Lab:**  

- **Ansible and Wazuh monitor configuration drift**.  
- **Alertmanager generates real-time alerts** for detected deviations.  

---

### **4.9: Secure DNS Configuration**

✅ **Requirement:** Ensure DNS configurations are hardened and monitored.  

✅ **Implementation in the Lab:**  

- **Technitium DNS (lab-dns01 & lab-dns02)**:  
  - **Conditional forwarders for Active Directory integration**.  
  - **DNS filtering with security blocklists**.  
  - **DNS logs stored in Loki, alerting via Alertmanager**.  
  - **Automated DNS record injection via Kubernetes API**.  

---

### **4.10 - 4.12: Secure Mobile, Portable, and IoT Devices**

✅ **Requirement:** Enforce **secure configurations for mobile and IoT devices**.  

✅ **Implementation in the Lab:**  
🔹 **No mobile, portable, or IoT devices exist in the lab environment**, so these controls are **not applicable**.  

---

## **4. Compliance Evidence**

To verify compliance, refer to the **implementation KB**:

📜 **File:** [`04-secure-configuration-management.md`](../docs/compliance-security/cisv8/4/)  

📌 **Related Policies**:  

- [Secure Configuration Management Policy](../cisv81-controls/cisv81-04-secure-configuration-management-policy.md)  
- [Secure Configuration Management Policy Template](../cisv81-policy-templates/cisv81-04-secure-configuration-of-enterprise-assets-and-software-template.md)  

---

## **5. Summary**

✅ **CIS Control 4 is fully implemented in the Proxmox Astronomy Lab to ensure hardened configurations across all assets**.  
✅ **Golden templates, automation, and monitoring tools maintain a secure baseline**.  
✅ **Firewall, DNS, and system configuration policies provide structured enforcement**.  

---

## ✅ Approval & Review

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ DRAFT |

---

## 📜 Change Log

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

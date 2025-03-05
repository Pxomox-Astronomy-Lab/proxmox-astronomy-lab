# **📖 Proxmox Astronomy Lab KB Template & Style Guide**  

## **1. Purpose**  

This document defines the **standardized format and style** for all Proxmox Astronomy Lab Knowledge Base (KB) articles. The goal is to ensure **clarity, consistency, and usability**, making technical documentation **structured, professional, and easy to navigate**.  

---  

## **2. KB Article Template**  

Each KB must follow this **structured format**:  

```yaml
---
title: "Descriptive KB Title"
description: "A brief summary of the KB article's content."
author: "VintageDon"
tags: ["tag1", "tag2", "tag3"]
category: "Main Category"
kb_type: "Reference | Implementation | Troubleshooting"
version: "1.0"
status: "Draft | Published"
last_updated: "YYYY-MM-DD"
---
```

### **2.1 Introduction**  

A brief, **concise** summary of the topic. Clearly state **what the article covers and why it’s important**.  

✅ Keep it **concise and to the point**.  
✅ Avoid unnecessary background information—**link to external resources instead**.  

🔹 *Example:*  

> This article provides a **step-by-step guide** for configuring **Proxmox Firewall Rules** to enforce **CISv8-compliant network segmentation**.  

---

### **2.2 Scope**  

Clearly define what is **in scope** and what is **out of scope**.  

| **Category** | **Description** |
|-------------|----------------|
| **In-Scope** | Proxmox firewall rules, CISv8 hardening, cluster security. |
| **Out-of-Scope** | Advanced SDN routing, external hardware firewalls. |
| **Compliance Mapping** | CISv8, NIST 800-53, ISO 27001. |

---

### **2.3 Implementation Steps**  

✅ **Use numbered lists** for structured, repeatable steps.  
✅ **Include exact commands and configurations** in **code blocks**.  

#### **Step 1: Enable Proxmox Firewall**  

```bash
pve-firewall start
pve-firewall enable
```

#### **Step 2: Define Rule Sets**  

Modify `/etc/pve/firewall/cluster.fw`:

```bash
[RULES]
IN ACCEPT -source 192.168.1.100 -comment "Allow SSH from admin workstation"
IN DROP -source 0.0.0.0/0 -comment "Deny all other SSH traffic"
```

🔹 **Tables can be used for firewall rules**:  

| **Rule** | **Action** | **Source** | **Destination** | **Comment** |
|---------|-----------|------------|----------------|-------------|
| Allow SSH | Accept | 192.168.1.100 | Proxmox Nodes | Admin access only |
| Block SSH | Drop | 0.0.0.0/0 | Proxmox Nodes | Block external SSH |

---

### **2.4 Automation & Monitoring**  

If applicable, include **automation** (e.g., Ansible, Terraform) and **monitoring** steps.  

```yaml
- name: Enforce Proxmox firewall rules
  hosts: proxmox
  tasks:
    - name: Apply firewall rules
      command: pve-firewall restart
```

| **Monitoring Tool** | **Purpose** |
|--------------------|------------|
| Prometheus        | Firewall logs and rule enforcement tracking. |
| Wazuh SIEM        | Detect unauthorized changes to firewall configs. |

---

### **2.5 Compliance & Security Considerations**  

Provide clear **security mappings** and compliance alignment:  

| **Framework** | **Requirement** | **Implementation** |
|--------------|----------------|---------------------|
| CIS 3.4 | Restrict SSH access | Firewall rules to allow only trusted sources |
| NIST AC-4 | Network Access Controls | Segmentation using firewall policies |

---

### **2.6 Incident Response & Troubleshooting**  

✅ **Include common issues and solutions** in a structured format.  
✅ **Use tables for quick reference troubleshooting**.  

| **Issue** | **Possible Cause** | **Solution** |
|----------|-------------------|-------------|
| SSH Blocked | Firewall misconfiguration | Verify `pve-firewall status` |
| Rules Not Applying | `pve-firewall` not enabled | Run `pve-firewall enable` |

🔹 **Provide relevant logs and diagnostic commands:**  

```bash
journalctl -u pve-firewall --since "1 hour ago"
```

---

### **2.7 Documentation & Revision Control**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | YYYY-MM-DD | Initial KB version | VintageDon |

---

## **3. KB Style Guide**  

### **3.1 Formatting Standards**  

✅ **Use tables** for structured information (firewall rules, compliance mappings, automation).  
✅ **Use numbered lists** for step-by-step instructions.  
✅ **Use proper Markdown syntax** for readability.  

### **3.2 Clarity & Consistency**  

- **Define technical terms on first use**.  
- **Use standardized terminology** (e.g., "Proxmox Node," not "VM Server").  
- **Use direct, active voice** for clarity.  

---

### **3.3 Do’s & Don’ts**  

#### ✅ **Do:**  

| **Best Practice** | **Example** |
|------------------|------------|
| Use structured sections | Every KB follows `Introduction → Steps → Security → Troubleshooting`. |
| Provide automation | Include Ansible/Terraform examples when applicable. |
| Link related docs | Cross-reference related KBs instead of repeating content. |

#### ❌ **Don’t:**  

| **Bad Practice** | **Example** |
|----------------|------------|
| Long text walls | Avoid excessive narrative—use **concise, structured content**. |
| Undefined acronyms | "Use CIS hardening" → ✅ "Use CISv8 Level 2 hardening." |
| Poor troubleshooting | ✅ "Check `pve-firewall status`" instead of vague "Verify settings." |

---

## **4. Folder Structure & Repository Organization**  

Each KB article must be stored in the **appropriate category** in the documentation repository:  

```plaintext
proxmox-astronomy-lab/
│── docs/
│   ├── README.md
│   ├── security/
│   │   ├── proxmox-firewall-hardening.md
│   │   ├── cisv8-compliance-overview.md
│   ├── kubernetes/
│   │   ├── rke2-setup-guide.md
│   ├── observatory-projects/
│   │   ├── hydrogen-line-hvc.md
```

🔹 *KBs should be cross-referenced within the repository to avoid duplication.*  

---


## ✅ Approval & Review  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-01 | ✅ Approved |

---

## 📜 Change Log  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-01 | Initial version | VintageDon |
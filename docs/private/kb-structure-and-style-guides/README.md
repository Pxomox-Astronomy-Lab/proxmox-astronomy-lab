---
title: "Knowledge Base Structure, Style Guide, and Policy Templates"
description: "Overview of the documentation structure, KB formatting, metadata tagging for AI-driven search, and available policy templates."
author: "VintageDon"
tags: ["Documentation", "KB Structure", "Style Guide", "Markdown", "ITIL", "CIS Policies"]
category: "General"
kb_type: "Reference"
version: "1.1"
status: "Published"
last_updated: "2025-03-03"
---

# **📖 Knowledge Base Structure, Style Guide, and Policy Templates**  

## **1. Introduction**  

The **Proxmox Astronomy Lab Knowledge Base (KB)** is designed as a **living documentation system**, following structured writing practices that enable **rapid search, retrieval, and compliance alignment**.  

Key features include:  
✅ **ITIL-aligned documentation** ensuring structured knowledge management.  
✅ **Markdown-based authoring** with YAML frontmatter for metadata tagging.  
✅ **Early metadata tagging for vector database ingestion** to support **Retrieval-Augmented Generation (RAG)** AI-driven search.  
✅ **Standardized templates** for compliance, security, and IT governance.  
✅ **Version-controlled documentation** ensuring accuracy and consistency across updates.  

This ensures that all documentation remains **structured, professional, and easily searchable** using modern AI-enhanced retrieval methods.

---

## **2. Living Documentation & AI-Driven Search**  

All KBs are structured as **living documents**, continuously updated based on **infrastructure changes, compliance requirements, and emerging best practices**.  

🔹 **Markdown + Frontmatter for AI Indexing**  

- Every KB **begins with structured YAML frontmatter**.  
- This metadata allows for **early tagging and vector database ingestion**, enhancing **searchability in AI-driven systems (e.g., OpenWebUI + Milvus for RAG)**.  
- AI-powered indexing ensures that **documentation remains accessible in natural language queries**.

🔹 **Version Control & Continuous Updates**  

- All documentation follows **Git-based versioning**.  
- Updates are **logged in a change history**, ensuring **transparency in modifications**.  
- **Automated pipelines** can push **sanitized versions** for external publishing.

🔹 **Ingestion into AI Models**  

- **Vector database indexing** ensures **semantic searchability** of compliance policies.  
- AI-driven querying (via OpenWebUI) enables **natural language-based compliance lookups**.

---

## **3. Folder Structure & Contents**  

| **Folder** | **Description** |
|------------|----------------|
| `style-guide/` | Defines writing standards, terminology, and Markdown best practices. |
| `kb-templates/` | Predefined KB templates for reference, troubleshooting, and implementation guides. |
| `cis-policy-templates/` | Standardized policy templates aligned with **CISv8 compliance controls**. |
| `general-policy-templates/` | Other security and operational policies used in the lab. |

---

## **4. Documentation Formatting & Markdown Best Practices**  

### **4.1 YAML Frontmatter for Metadata Tagging**  

Each KB **must begin** with structured metadata, ensuring proper indexing in both **human-readable and AI-driven environments**.

```yaml
---
title: "Example KB Title"
description: "A brief summary of the KB article's content."
author: "VintageDon"
tags: ["Example", "KB Template", "Markdown", "RAG"]
category: "Reference"
kb_type: "Reference | Implementation | Troubleshooting"
version: "1.0"
status: "Published | Draft"
last_updated: "YYYY-MM-DD"
---
```

🔹 **Why is this important?**  

- **Allows filtering and structured querying.**  
- **Enhances AI-driven search by vectorizing metadata for embedding models.**  
- **Supports dynamic documentation updates without content duplication.**  

---

### **4.2 Markdown Formatting Standards**  

🔹 **Heading Structure**  
✅ **All `#` and `##` headings must have an informational blurb** describing the section’s purpose.  
✅ **Use `###` headings for sub-sections** with minimal formatting overhead.  

**Example:**

```markdown
## **1. Introduction**  
_(Provides an overview of the topic, defining its purpose and importance.)_  
```

✅ **Tables for structured data**  
Use tables for **compliance mappings, feature lists, and structured comparisons**.  
Example:

| **Feature** | **CIS Control** | **Implementation** |
|------------|--------------|------------------|
| MFA | 6.3, 6.4, 6.5 | Enforced via Entra Conditional Access |
| Passwordless Authentication | 6.5 | FIDO2 keys, Passkeys |

✅ **Code Blocks for Configurations**  
All configurations and commands should be formatted in **fenced code blocks** (` ``` `).

Example:

```bash
az ad user list --filter "accountEnabled eq true"
```

---

## **5. ITIL Alignment & Documentation Process**  

The lab follows **ITIL-aligned knowledge management** for **structured documentation updates, reviews, and approvals**.

🔹 **Key ITIL Knowledge Management Principles Applied**  
✅ **Knowledge Categorization** – Each KB **fits into predefined categories** (Reference, Troubleshooting, Implementation).  
✅ **Lifecycle Management** – Regular **updates, deprecations, and versioning** ensure consistency.  
✅ **Role-Based Access** – Enforced using **Git & WikiJS version tracking** for controlled edits.  

🔹 **Documentation Review & Publishing Workflow**  

- **Draft Phase** → KB is reviewed internally.  
- **Approval Phase** → Compliance validation & technical sign-off.  
- **Publishing Phase** → KB is indexed for AI-based search and made available for users.  

---

## **6. Available CIS Policy Templates**  

The **`cis-policy-templates/`** directory contains predefined **CISv8-aligned security policy templates**, covering:  

| **Template Name** | **Description** |
|-------------------|----------------|
| **Acceptable Use Policy Template** | Defines acceptable use of IT assets per CIS controls. |
| **Enterprise Asset Management Policy (CIS 1)** | Covers tracking and managing enterprise assets. |
| **Software Asset Management Policy (CIS 2)** | Governs procurement, usage, and inventory of software. |
| **Data Management Policy (CIS 3)** | Defines data classification, retention, and disposal rules. |
| **Secure Configuration Management Policy (CIS 4, 9, 12)** | Covers system hardening, patching, and monitoring. |
| **Account and Credential Management Policy (CIS 5, 6)** | Enforces identity security, MFA, and access controls. |
| **Vulnerability Management Policy (CIS 7)** | Governs vulnerability assessments and patching. |
| **Audit Log Management Policy (CIS 8)** | Defines logging and SIEM retention requirements. |
| **Malware Defense Policy (CIS 10)** | Governs endpoint security and anti-malware strategies. |
| **Data Recovery Policy (CIS 11)** | Defines backup, disaster recovery, and continuity planning. |
| **Security Awareness Training Policy (CIS 14)** | Enforces periodic user security training programs. |
| **Service Provider Management Policy (CIS 15)** | Governs third-party access and supply chain security. |
| **Incident Response Policy (CIS 17)** | Defines structured incident handling procedures. |

---

## **7. Related Documentation & Resources**  

📜 **Related KBs:**  
📍 `docs/compliance-security/cisv8/` – CIS compliance policies.  
📍 `docs/security/` – General security best practices and hardening guides.  
📍 `docs/architecture/` – Infrastructure topology and configuration details.  

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-03 | ✅ Approved |

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-03 | Initial version | VintageDon |

---

🚀 **This directory ensures all documentation remains structured, ITIL-aligned, AI-searchable, and compliant with security frameworks.**

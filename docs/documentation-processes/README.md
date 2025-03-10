<!-- 
---
Title: Documentation Standards & Processes - Proxmox Astronomy Lab
Description: Defines the documentation workflows, Markdown standards, frontmatter metadata, iteration process, and AI indexing strategies used in the Proxmox Astronomy Lab.
Tags: documentation, markdown, frontmatter, KB standardization, ITIL, version control, AI indexing, Milvus
Version: 1.0
LastUpdated: 2025-03-09
Author: Don [L3 Engineer | Proxmox Astronomy Lab]
Status: Active
Visibility: Public
---
-->

# **📖 Documentation Standards & Processes - Proxmox Astronomy Lab**

## **1. Overview**

This section outlines the **structured approach to documentation** within the **Proxmox Astronomy Lab**. The goal is to maintain **clear, structured, and standardized knowledge bases (KBs)** while ensuring **easy iteration, AI-assisted retrieval, and compliance with ITIL-lite principles**.

🔹 **All documentation follows a standardized Markdown format with frontmatter metadata.**  
🔹 **Version control is managed via Git** to track changes effectively.  
🔹 **AI/ML indexing is enabled** using **Milvus for RAG-based retrieval** of documentation.  

---

## **2. Documentation Folder Structure**

```
documentation-processes/
│── README.md  # This file
│
├── architecting-a-secure-lab.md  # Secure documentation strategies
├── template-kb-general.md        # Standardized general KB template
├── template-kb-service.md        # Standardized service documentation template
```

### **Key Sections**

- **`architecting-a-secure-lab.md`** → Covers security-conscious documentation.
- **`template-kb-general.md`** → A structured **general KB article template**.
- **`template-kb-service.md`** → A structured **service documentation template**.

---

## **3. Markdown & Standardization Practices**

### **3.1 Markdown Formatting**

✅ **Use `#` for primary titles, `##` for subsections, `###` for details.**  
✅ **Always include a table of contents for long documents.**  
✅ **Use fenced code blocks (` ``` `) for commands and configs.**  
✅ **Diagrams are stored in `assets/` and linked via Markdown.**  

Example:

```markdown
## **2. System Configuration**
To set up the service, run:
```bash
sudo apt update && sudo apt install example-package
```

```

### **3.2 Frontmatter Metadata**
Each document **must** include **frontmatter metadata** for indexing and retrieval.

```yaml
---
title: "Kubernetes RKE2 Setup Guide"
description: "Step-by-step guide to deploying an RKE2 Kubernetes cluster."
tags: ["kubernetes", "rke2", "deployment", "cluster"]
version: "1.2"
lastUpdated: "2025-03-09"
author: "Don"
status: "Active"
visibility: "Public"
---
```

💡 **Why?**  

- **Enhances AI/ML indexing** (Milvus RAG).  
- **Tracks documentation versions.**  
- **Improves retrieval speed in structured searches.**  

---

## **4. Iteration & Versioning**

🔹 **All documentation is stored in Git** for **version control**.  
🔹 **Each update must be committed with a meaningful message** (e.g., `Updated RKE2 deployment guide for Ubuntu 24.04`).  
🔹 **Major revisions require a version bump** (`1.1 → 1.2`).  

Example Git workflow:

```bash
git add docs/documentation-processes/README.md
git commit -m "Updated documentation standards for KB articles"
git push origin main
```

---

## **5. AI & ML Indexing for Documentation**

### **5.1 AI-Powered Search**

🚀 **Documents are indexed in Milvus for AI-powered retrieval**.  
💡 **Markdown metadata enables RAG-based queries** in OpenWebUI.  

### **5.2 AI Query Example**

Using OpenWebUI:

```
User: "How do I deploy an RKE2 cluster?"
AI Response: "Refer to the 'Kubernetes RKE2 Setup Guide' in docs/k8s-rancher-rke2."
```

🔹 **This allows structured, fact-based AI retrieval with no hallucinations.**  

---

## **6. Related Documentation**

📖 **[ITIL Lite - Change Management](../itil/change-management.md)**  
📖 **[Standardized Service Documentation Template](template-kb-service.md)**  
📖 **[Markdown Security Practices](architecting-a-secure-lab.md)**  

---

## **7. Contribution & Maintenance**

🔹 **Follow structured commit messages when updating docs.**  
🔹 **Use frontmatter in all Markdown files for AI indexing.**  
🔹 **Ensure documentation follows KB style guidelines.**  

🚀 **Maintaining structured, AI-powered documentation for the future!**

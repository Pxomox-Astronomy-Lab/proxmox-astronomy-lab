<!-- 
---
title: "README Style Guide for Category Directories"
description: "Guidelines for creating consistent, navigable README files for category-level directories in the Proxmox Astronomy Lab repository"
author: "Knowledge Management Team"
tags: ["documentation", "style-guide", "readme", "github", "navigation"]
kb_type: "Reference"
version: "1.0"
status: "Active"
last_updated: "2025-04-03"
---
-->

# Category-Level README Style Guide

## Purpose

This style guide defines standards for creating consistent, structured README files for category-level directories in the Proxmox Astronomy Lab repository. Each README serves as a navigation nexus that provides context about its current level while linking to subdirectories and related content.

## Structure Template

Every category-level README should follow this structure:

```markdown
# 🔑 **[Category Name]**

# 🔍 **1. Overview**

[2-3 paragraphs introducing the category, explaining its purpose and importance in the overall project. This section provides context about what exists at this level and how it relates to the broader Proxmox Astronomy Lab.]

---

# 📂 **2. [Primary Subcategory Name]**

## **2.1 [Component Group]**

[Brief explanation of this component group and its purpose]

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **[Component Name]** | [Brief description] | [Link to documentation](path/to/doc.md) |
| **[Component Name]** | [Brief description] | [Link to documentation](path/to/doc.md) |
| **[Component Name]** | [Brief description] | [Link to documentation](path/to/doc.md) |

## **2.2 [Another Component Group]**

[Brief explanation of this component group and its purpose]

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **[Component Name]** | [Brief description] | [Link to documentation](path/to/doc.md) |
| **[Component Name]** | [Brief description] | [Link to documentation](path/to/doc.md) |

---

# 🛠️ **3. [Another Primary Subcategory]**

[Additional primary subcategories follow the same pattern as above]

---

# 🔗 **4. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **[Subdirectory Name]** | [Brief description] | [Link to README](subdirectory/README.md) |
| **[Subdirectory Name]** | [Brief description] | [Link to README](subdirectory/README.md) |
| **[Subdirectory Name]** | [Brief description] | [Link to README](subdirectory/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **[Document Name]** | [Brief description] | [Link to document](document.md) |
| **[Document Name]** | [Brief description] | [Link to document](document.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **[Category Name]** | [How it relates to this category] | [Link to README](../category/README.md) |
| **[Category Name]** | [How it relates to this category] | [Link to README](../category/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| [Name] | [Role] | [YYYY-MM-DD] | [Approved/Pending] |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | YYYY-MM-DD | Initial version | [Author] |
```

# Key Elements

## 1. Markdown Frontmatter

- Include YAML frontmatter enclosed in HTML comment tags
- This will be invisible on GitHub but useful for internal processing
- Include title, description, author, tags, and metadata

## 2. Emoji Usage

Use consistent emojis to enhance scanability:

| Section | Emoji |
|---------|-------|
| Category title | Topic-specific (e.g., 🔐 for security, 🖥️ for infrastructure) |
| Overview | 🔍 |
| Directory contents | 📂 |
| Tables | Topic-specific |
| Related categories | 🔄 |
| Approval & review | ✅ |
| Change log | 📜 |

## 3. Section Numbering

- Use sequential section numbering (1, 2, 3...)
- Use subsection numbering (2.1, 2.2...) for component groups
- Each section should have a descriptive title beside its number

## 4. Table Format

- Always use three-column tables with headers in bold
- First column should be the name of the item
- Second column should explain function/purpose
- Third column should link to documentation
- Include brief explanatory text before each table

## 5. Directory Navigation

- Include a specific "Directory Contents" section
- Split into "Subdirectories" and "Key Documents" tables
- Provide direct links to all child READMEs and important files
- Include brief descriptions of each linked item

## 6. Formatting

- Use **bold** for component/directory names
- Use inline links with descriptive text
- Maintain consistent spacing with horizontal rules between major sections
- Keep tables consistently structured for visual cohesion

# Writing Guidelines

## Content Level

- **Top Level**: Provide high-level context and connections
- **Mid-Level**: Explain purpose and organization
- **Detail Level**: Brief but informative descriptions

## Tone and Style

- Professional but accessible
- Consistent technical terminology
- Present tense, active voice
- Concise but informative descriptions

## Length Guidelines

- Overview: 2-3 paragraphs (100-150 words)
- Component explanations: 1-2 sentences (20-40 words)
- Table descriptions: 1 sentence per item (10-20 words)

# Implementation Examples

## Infrastructure README Example

```markdown
# 🖥️ **Infrastructure**

# 🔍 **1. Overview**

The Infrastructure category documents the foundational hardware, virtualization, networking, and storage systems that support the Proxmox Astronomy Lab. This includes both physical and virtual components designed for high availability, security, and performance to enable astronomical research and data processing.

Infrastructure components are organized into layers, beginning with physical hardware, extending through virtualization platforms, and culminating in the networking and storage systems that interconnect them.

---

# 🏗️ **2. Compute Resources**

## **2.1 Physical Nodes**

The lab is built on a cluster of physical nodes that provide compute resources for the virtualized infrastructure.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Node01-03** | SFF Ryzen nodes with 2.5G networking | [Node Hardware](proxmox/node01-proxmox-compute.md) |
| **Node04** | High-performance GPU node with 10G | [GPU Node](proxmox/node04-proxmox-gpu-hpc.md) |
| **Node05** | Storage-focused node with 10G | [Storage Node](proxmox/node05-proxmox-zfs-storage.md) |

## **2.2 Virtualization Platform**

The Proxmox VE hypervisor provides the virtualization layer for all compute resources.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Proxmox Cluster** | 5-node HA virtualization cluster | [Cluster Configuration](proxmox/proxmox-cluster-configuration.md) |
| **VM Templates** | CISv8-hardened OS templates | [VM Templates](proxmox/vm-templates.md) |
| **Resource Pools** | Logical resource grouping | [Resource Pools](proxmox/resource-pools.md) |

[additional sections follow...]
```

## Vector Retrieval Optimization

When creating category-level READMEs:

1. **Semantic Sections**: Each section should be semantically self-contained
2. **Descriptive Titles**: Use clear, specific section headings
3. **Structured Data**: Use tables to organize related information
4. **Explicit Links**: Create direct connections to related content
5. **Consistent Formatting**: Maintain the same structure across all category READMEs

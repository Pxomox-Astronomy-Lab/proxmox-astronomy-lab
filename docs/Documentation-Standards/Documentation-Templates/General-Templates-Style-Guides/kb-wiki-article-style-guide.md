<!-- 
---
title: "Knowledge Base Style Guide"
description: "Comprehensive guidelines for creating consistent, structured, and accessible documentation in the Proxmox Astronomy Lab knowledge base"
author: "VintageDon"
tags: ["documentation", "style-guide", "templates", "standards", "formatting"]
category: "Documentation"
kb_type: "Reference"
version: "1.5"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 📝 **Knowledge Base Style Guide**

This document defines the standardized approach for all documentation in the Proxmox Astronomy Lab knowledge base, ensuring consistency, accessibility, and effective information retrieval.

## 🎯 **1. Core Principles**

Our documentation follows these fundamental principles to ensure quality and usability:

### **1.1 Audience-Focused**

All documentation should be written with a clear understanding of its intended audience. Consider the reader's:

- Technical expertise
- Familiarity with the lab environment
- Information needs and goals

### **1.2 Structured for Retrieval**

Documentation is designed for both human readers and AI-assisted retrieval:

- Consistent metadata (frontmatter)
- Logical section organization
- Clear headings and subheadings
- Explicit relationships between documents

### **1.3 Evidence-Based**

Documentation should:

- Provide specific, verifiable information
- Include examples, commands, and configurations
- Reference source materials where appropriate
- Avoid ambiguity and generalization

## 🔤 **2. Document Structure**

### **2.1 Frontmatter**

All documents must include YAML frontmatter within HTML comment blocks to ensure proper metadata while not disrupting GitHub rendering:

```markdown
<!-- 
---
title: "Document Title"
description: "Concise description of content and purpose"
author: "Author Name"
tags: ["primary-category", "subcategory", "additional-tags"]
category: "Main Category"
kb_type: "Reference/Procedure/Policy/Tutorial"
version: "1.0"
status: "Draft/Published/Under Review"
last_updated: "YYYY-MM-DD"
---
-->
```

### **2.2 Headings and Sections**

The following heading structure ensures consistent document organization:

| **Level** | **Purpose** | **Format** |
|-----------|-------------|------------|
| # (H1) | Document title | Always includes an emoji and introductory blurb |
| ## (H2) | Main sections | Always includes an emoji and introductory blurb |
| ### (H3) | Subsections | No emoji required, but clear descriptive titles |
| #### (H4) | Component details | Use sparingly for deeply nested content |

Every document should maintain this hierarchical structure for consistency and navigability.

### **2.3 Required Sections**

All knowledge base articles must include:

- Overview/Introduction
- Main content sections
- References/Related Resources
- Approval & Review
- Change Log

## 🎨 **3. Formatting and Style**

### **3.1 Text Formatting**

| **Element** | **Format** | **Example** |
|-------------|------------|-------------|
| **Emphasis** | Bold | **important concept** |
| *Secondary emphasis* | Italic | *supplementary information* |
| `Code elements` | Backticks | `command` or `parameter` |
| Hyperlinks | Markdown links | [Link text](URL) |

### **3.2 Lists**

Use bulleted lists for unordered items and numbered lists for sequential steps:

- Bulleted list for general items
- With consistent capitalization
- And punctuation style

1. Numbered list for procedures
2. Each step begins with a verb
3. Clear, concise instructions

### **3.3 Tables**

Every table must have:

- An introductory blurb explaining its purpose
- Clear, descriptive headers
- Consistent formatting
- Logical organization of information

The table's introductory text should explain what information is presented and how to interpret it.

### **3.4 Visual Elements**

Images and diagrams should:

- Have descriptive filenames (e.g., `network-topology-diagram.png`)
- Be stored in an `assets` directory
- Include alt text for accessibility
- Be accompanied by explanatory text

## 🎭 **4. Section-Specific Guidelines**

### **4.1 Main Headings with Emojis**

All # and ## level headings must:

- Include a relevant emoji at the beginning
- Have a descriptive blurb explaining the section's purpose
- Use clear, concise language

This approach improves navigation, visual scanning, and content understanding.

### **4.2 Tables with Context**

All tables require an explanatory blurb that provides:

- What information the table presents
- How to interpret the table's contents
- Why this information is relevant
- Any key insights to note

This context ensures tables are meaningful and actionable.

### **4.3 Code Blocks**

Code blocks should:

- Specify the language for syntax highlighting
- Include comments explaining complex operations
- Be tested for accuracy before inclusion
- Focus on reusable, production-ready examples

```bash
# Example of a well-formatted code block
sudo apt update        # Update package lists
sudo apt upgrade -y    # Perform system upgrade
```

## 🔍 **5. Content Optimization**

### **5.1 Search Optimization**

To improve findability:

- Use descriptive titles that include specific technical terms
- Include variations of key terms where appropriate
- Maintain consistent terminology throughout
- Use structured data in tables and lists

### **5.2 AI Retrieval Optimization**

For effective RAG (Retrieval-Augmented Generation):

- Maintain clear semantic relationships between concepts
- Structure content in focused, atomic sections
- Use explicit cross-references to related documents
- Include specific examples rather than generalizations

## ⚙️ **6. Document Lifecycle**

### **6.1 Review and Approval**

All documents must go through:

1. Initial authoring
2. Technical review
3. Editorial review
4. Formal approval
5. Regular revision cycles

The Approval & Review section must be completed with actual reviewers and dates.

### **6.2 Versioning**

Version numbering follows semantic versioning principles:

- 1.0: Initial published version
- 1.x: Minor updates and corrections
- 2.0: Major revisions or restructuring

The Change Log must document all substantive changes.

## 📚 **7. Examples of Excellence**

### **7.1 Example: Well-Structured Heading**

```markdown
## 🔐 **Security & Compliance**

Our multi-layered security framework implements defense-in-depth principles to protect both infrastructure and research data while maintaining compliance with established standards.
```

### **7.2 Example: Table with Context**

```markdown
The following table outlines our primary research focuses and their current status:

| **Research Area** | **Description** | **Status** |
|----------------|---------------|-----------|
| **Hydrogen Line Studies** | Detection and analysis of neutral hydrogen emissions | Active |
| **High-Velocity Clouds** | Time-series tracking of HVC movement | Planning |

This research portfolio balances active projects with planned initiatives to maximize our observatory capabilities while maintaining focus on core scientific objectives.
```

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-01-15 | Initial version | VintageDon |
| 1.5 | 2025-03-16 | Updated with emoji standards and blurb requirements | VintageDon |

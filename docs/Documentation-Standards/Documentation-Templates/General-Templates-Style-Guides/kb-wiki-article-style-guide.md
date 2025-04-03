<!-- 
---
title: "Documentation Style Guide for Proxmox Astronomy Lab"
description: "Comprehensive guidelines for creating structured documentation that supports RAGGraph-based knowledge retrieval"
author: "Knowledge Management Team"
tags: ["documentation", "style-guide", "knowledge-base", "rag", "standards", "metadata"]
kb_type: "Process"
version: "1.0"
status: "Active"
last_updated: "2025-04-03"
related_services: ["Documentation", "Knowledge Management", "RAGGraph"]
implements_policies: ["Documentation Standards Policy", "Knowledge Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.14.1", "CIS.14.2"]
iso27001_controls: ["A.8.1.1", "A.8.1.2"]
nist_controls: ["PM-5", "SA-5"]
---
-->

# Style Guide for Proxmox Astronomy Lab Documentation

## Introduction

This style guide outlines the required structure, formatting, and content conventions for all Proxmox Astronomy Lab knowledge base documentation. Following these standards ensures compatibility with our RAGGraph-based retrieval system, maintaining consistent document relationships, and enabling effective information discovery across our knowledge base.

## Core Principles

1. **Structural Consistency**: All documents follow the same numbered heading structure
2. **Self-Contained Sections**: Each section should be semantically complete on its own
3. **Explicit Relationships**: Cross-references must be clearly defined and linked
4. **Complete Metadata**: All documents require proper frontmatter tags
5. **Semantic Clarity**: Sentences should be clear, concise, and optimized for embedding

## Document Structure Requirements

### Heading Numbering System

**CRITICAL**: The heading numbering system is fixed and must be maintained across all documents, even when sections are omitted.

- If a document doesn't require a particular section (e.g., section 6 - Backup & Recovery), the numbering must still go from 5 to 7, skipping 6 entirely
- **Section 5 is ALWAYS "Security & Compliance"**
- Numbers are assigned to specific content types and cannot be reassigned

### Required Document Structure

Every document MUST include the following structure:

1. **Title**: A descriptive H1 title with the document name
2. **Introduction Paragraph**: A concise overview of the document
3. **Numbered Level 1 Headings**: Main sections using # (H1)
4. **Numbered Level 2 Headings**: Subsections using ## (H2)
5. **Section Blurbs**: Descriptive text for each heading and before tables
6. **Explicit Cross-References**: Clear links to related documents

### Heading Explanatory Blurbs

Every heading (H1 and H2) MUST include a descriptive blurb that:

- Explains the purpose of the section
- Provides context for the reader
- Is semantically self-contained
- Helps the RAGGraph system understand section content

### Table Blurbs

All tables MUST be preceded by explanatory text that:

- Describes the table's purpose
- Explains key columns or data
- Provides context for interpretation
- Is followed by the table itself

Tables should also be followed by a brief paragraph that explains their significance or how to use the information presented.

## Fixed Section Numbering

The following section numbers are fixed and must be maintained across ALL documents:

| Section Number | Section Title | Required Content |
|----------------|---------------|------------------|
| **1** | **Overview** | Purpose, scope, audience |
| **2** | **Dependencies & Relationships** | Related services, policies, responsibilities |
| **3** | **Technical Documentation** | Architecture, configuration, implementation |  
| **4** | **Management & Operations** | Procedures, troubleshooting, monitoring |
| **5** | **Security & Compliance** | Controls, mappings, risk assessment |
| **6** | **Backup & Recovery** | Backup procedures, recovery steps |
| **7** | **References & Related Resources** | Internal/external references, change requests |
| **8** | **Approval & Review** | Reviewer details, approval status |
| **9** | **Change Log** | Version history |

These section numbers CANNOT be changed, reordered, or reassigned. If a section is not relevant for a particular document, skip its number entirely while maintaining the sequence.

## Section Blurb Requirements

Each section requires a specific type of blurb:

### H1 (Level 1) Headings

Level 1 heading blurbs should:

- Be 2-3 sentences in length
- Explain the overall purpose of the section
- Highlight key information the reader will find
- Stand alone as a semantic summary

Example:

```text
# 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.
```

### H2 (Level 2) Headings

Level 2 heading blurbs should:

- Be 1-2 sentences in length
- Describe the specific function of the subsection
- Clarify what type of information follows
- Relate to the parent section's purpose

Example:

```text
## 5.1 Security Controls

This subsection documents specific security measures implemented, how they are verified, and which compliance controls they satisfy.
```

### Table Blurbs

Table blurbs should appear both before and after tables:

**Before the table**:

- Explain what the table contains
- Describe key columns
- Indicate how the data should be interpreted

**After the table**:

- Summarize the significance of the data
- Indicate how it relates to the section
- Provide any necessary caveats or limitations

Example:

```text
The security controls table below documents implemented safeguards, providing evidence for security assessments and compliance audits.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| [Control type] | [How implemented] | [How verified] | [CIS/NIST ID] |
| [Control type] | [How implemented] | [How verified] | [CIS/NIST ID] |

The table above documents technical and administrative controls implemented to satisfy security requirements, including how each control is verified for effectiveness.
```

## Frontmatter Requirements

All documents MUST include properly formatted YAML frontmatter wrapped in HTML comment tags with the following fields:

```html
<!-- 
---
title: "[Document Title]" 
description: "[Concise single-sentence description of document purpose]"
author: "[Author Name]"
tags: ["[primary-category-tag]", "[domain-tag]", "[component-tag]", "[phase-tag]", "[CISv8.1-tag]"]
kb_type: "General"
version: "3.0" 
status: "[Active/Draft/Archived]"
last_updated: "YYYY-MM-DD"
related_services: ["[service-1]", "[service-2]"]
implements_policies: ["[policy-1]", "[policy-2]"]
phase: "[phase-1/phase-2/phase-3/phase-4]"
cis_controls: ["[CIS.1.1]", "[CIS.1.2]"]
iso27001_controls: ["[A.8.1]", "[A.8.2]"]
nist_controls: ["[AC-1]", "[AC-2]"]
---
-->
```

## Cross-References and Relationships

To properly support graph relationships, all document cross-references must:

1. Use specific Markdown link syntax: `[Document Name](path/to/document.md)`
2. Include section references where applicable: `[Document Name](path/to/document.md#5-security-compliance)`
3. Use consistent naming for services, policies, and other entities

Example of proper cross-referencing:

```text
This component integrates with the [PostgreSQL Database](../infrastructure/proj-pg01-postgresql.md#3-technical-documentation) and implements the [Data Protection Policy](../compliance-security/security-policies/CIS-Security-Policies/03-data-protection/cisv81-03-data-protection-policy.md).
```

## Formatting Guidelines

### Tables

- Tables should use pipe syntax
- Include header row with bold formatting
- Align columns consistently
- Use consistent naming conventions for column headers

### Code Blocks

- Specify the language for syntax highlighting
- Keep code blocks focused and concise
- Add comments to explain complex operations
- Use consistent indentation and formatting

### Lists

- Use numbered lists for sequential steps
- Use bulleted lists for non-sequential items
- Maintain consistent capitalization and punctuation
- Keep list items concise and parallel in structure

## Example Document Section

The following example demonstrates proper formatting for a document section:

```markdown
# 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

## 5.1 Security Controls

This subsection documents specific security measures implemented, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Role-based access via Active Directory groups | Quarterly access review | CIS.6.1 |
| Authentication | MFA enforced via Entra ID Conditional Access | Daily sign-in risk reports | CIS.6.3 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps implementation details to CIS Controls, documenting compliance status and evidence location.

[Content continues...]
```

## Documentation Quality Checklist

Before submitting documentation, verify:

- [ ] All required sections are present with correct numbering
- [ ] Each heading has an appropriate explanatory blurb
- [ ] All tables have preceding and following explanatory text
- [ ] Cross-references use proper Markdown linking syntax
- [ ] Frontmatter includes all required fields
- [ ] Technical details are accurate and complete
- [ ] Sentences are clear and optimized for semantic retrieval
- [ ] All relationships to other documents are explicitly stated

## Summary

This style guide ensures our documentation supports both human readers and our RAGGraph-based retrieval system. By maintaining consistent structure, explicit relationships, and semantic clarity, we enable effective knowledge discovery across our technical documentation ecosystem.

Remember that section numbering is fixed and must be maintained—section 5 is ALWAYS "Security & Compliance"—even when sections are omitted. Following these standards ensures our documentation remains aligned with our knowledge management strategy and supports efficient information retrieval.

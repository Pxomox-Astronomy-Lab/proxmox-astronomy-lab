<!-- 
---
title: "Service Documentation Style Guide"
description: "Standards and guidelines for creating consistent, ITIL-aligned service documentation in the Proxmox Astronomy Lab knowledge base"
author: "VintageDon"
tags: ["documentation", "style-guide", "services", "itil", "itsm"]
category: "Documentation"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 📋 **Service Documentation Style Guide**

This guide defines standards for creating consistent, ITIL-aligned service documentation that integrates with our ITSM processes.

## 🎯 **1. Purpose and Scope**

### **1.1 Purpose**

This document establishes documentation standards for IT services in the Proxmox Astronomy Lab, ensuring consistency, completeness, and integration with ITSM practices.

### **1.2 Scope**

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Service documentation structure and format | Project documentation |
| Required content elements | Implementation guides |
| ITSM integration requirements | Detailed technical procedures |
| Classification and metadata standards | User training materials |
| Documentation lifecycle management | Individual system configurations |

## 📝 **2. Document Structure**

### **2.1 Required Sections**

All service documentation must include these sections in the specified order:

1. **Introduction** - Purpose, scope, and audience
2. **Service Overview** - Description and classification
3. **Service Level Parameters** - SLAs and monitoring
4. **Technical Architecture** - Components and dependencies
5. **Service Management** - Operational processes
6. **Operational Procedures** - Routine maintenance and troubleshooting
7. **Lifecycle Management** - Current status and future plans
8. **Security and Compliance** - Controls and requirements
9. **References** - Related documentation

### **2.2 Section Formatting**

Each main section must include:

- Level 2 heading with descriptive emoji
- Brief introductory paragraph explaining the section's purpose
- Consistent subsection structure
- Tables with descriptive blurbs

## 🏷️ **3. Classification and Metadata**

### **3.1 Service Classification**

Services must be classified using these standardized attributes:

| **Attribute** | **Permitted Values** |
|--------------|----------------------|
| **Service Type** | Core, Supporting, Enabling |
| **Service Category** | Infrastructure, Application, Business |
| **Business Criticality** | Critical, High, Medium, Low |

### **3.2 Required Metadata**

All service documents must include complete frontmatter with:

- Accurate service title
- Concise description
- Appropriate tags, including service type
- Current status (Draft/Published/Under Review)
- Version number and last updated date

## 📊 **4. Table Standards**

### **4.1 Required Tables**

The following tables must be included in all service documentation:

1. Scope definition table
2. Service classification table
3. Service hours table
4. SLA metrics table
5. Infrastructure components table
6. Dependencies table
7. Backup and recovery parameters table

### **4.2 Table Formatting**

All tables must:

- Include a brief descriptive blurb before the table
- Use bold text for column headers
- Maintain consistent column ordering across similar tables
- Align content appropriately (left for text, center for status indicators)
- Use consistent terminology for similar concepts

## 📚 **5. ITSM Integration**

### **5.1 GLPI References**

All service documents must reference corresponding ITSM items:

| **ITSM Element** | **Required Reference** |
|-----------------|------------------------|
| Service ID | GLPI Service Catalog ID |
| Components | CMDB Configuration Item IDs |
| Procedures | Knowledge Base Article IDs |
| Common Issues | Known Error Database (KEDB) IDs |

### **5.2 Process Alignment**

Service documentation must align with these ITIL processes:

- Service Level Management
- Incident Management
- Problem Management
- Change Management
- Configuration Management
- Availability Management

## 🔄 **6. Documentation Lifecycle**

### **6.1 Review Frequency**

Service documentation must be reviewed:

| **Criticality** | **Review Frequency** |
|----------------|---------------------|
| Critical | Quarterly |
| High | Bi-annually |
| Medium | Annually |
| Low | Annually |

### **6.2 Change Tracking**

All document revisions must be recorded in the Change Log with:

- Incremented version number
- Date of change
- Description of significant changes
- Author name

## ✅ **7. Quality Checklist**

Before publishing, verify that service documentation:

- Includes all required sections and tables
- Contains accurate GLPI/CMDB references
- Specifies clear service owner and responsibilities
- Documents all dependencies and impact relationships
- Defines SLAs and monitoring approaches
- Includes security controls and compliance requirements
- Has been reviewed by service owner and technical stakeholders

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial version | VintageDon |

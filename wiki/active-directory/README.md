# 👥 **Active Directory**

This wiki section provides practical PowerShell scripts and procedures for gathering information from Active Directory domains that integrate with the Proxmox Astronomy Lab infrastructure. The documentation focuses on essential AD information gathering scripts used for user management, group analysis, and infrastructure integration planning.

## **Overview**

Active Directory integration represents a critical component for enterprise-grade identity and access management within research computing environments. While the Proxmox Astronomy Lab operates primarily with local authentication, understanding and interfacing with institutional AD environments is essential for user onboarding, group-based access controls, and compliance with organizational identity management policies.

This wiki provides practical PowerShell scripts specifically designed for gathering AD information needed for lab integration planning, user lifecycle management, and group-based resource allocation. Each script is tested and focused on specific information gathering tasks commonly required for research computing infrastructure integration.

---

## **📂 Directory Contents**

This section provides navigation to all Active Directory information gathering scripts and procedures.

### **📋 Information Gathering Scripts**

| **Script** | **Purpose** | **Use Case** |
|------------|-------------|--------------|
| **[get-ad-users.md](get-ad-users.md)** | PowerShell script to extract user information from AD | User account discovery and analysis |
| **[get-ad-groups.md](get-ad-groups.md)** | PowerShell script to enumerate AD groups and memberships | Group-based access planning |
| **[get-ad-computers.md](get-ad-computers.md)** | PowerShell script to inventory AD computer objects | Infrastructure inventory and integration |

### **📖 Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[ad-integration-planning.md](ad-integration-planning.md)** | Planning AD integration with lab infrastructure | System administrators |
| **[powershell-ad-setup.md](powershell-ad-setup.md)** | Setting up PowerShell for AD management | Infrastructure engineers |

---

## **🏗️ Repository Structure**

```markdown
wiki/active-directory/
├── README.md                                    # This overview document
├── get-ad-users.md                             # User information gathering script
├── get-ad-groups.md                            # Group enumeration script  
├── get-ad-computers.md                         # Computer object inventory script
├── ad-integration-planning.md                  # Integration planning guide
```

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **AD Integration** |
|--------------|------------------|------------------|
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Automated user provisioning | AD-driven user lifecycle automation |
| **[k8s/](../k8s/README.md)** | Kubernetes RBAC integration | AD group-based K8s access controls |

### **Platform Integration**

| **Category** | **Relationship** | **AD Integration** |
|--------------|------------------|------------------|
| **[security/](../../security/README.md)** | Identity and access management | AD-based authentication and authorization |
| **[projects/](../../projects/README.md)** | Research project access controls | Project-based AD group management |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within Active Directory integration.

### **For System Administrators**

**Start Here:** [powershell-ad-setup.md](powershell-ad-setup.md)  
**User Discovery:** [get-ad-users.md](get-ad-users.md)  
**Group Analysis:** [get-ad-groups.md](get-ad-groups.md)  
**Planning:** [ad-integration-planning.md](ad-integration-planning.md)

### **For Infrastructure Engineers**

**Start Here:** [ad-integration-planning.md](ad-integration-planning.md)  
**Inventory Scripts:** [get-ad-computers.md](get-ad-computers.md)  
**User Management:** [get-ad-users.md](get-ad-users.md)  
**PowerShell Setup:** [powershell-ad-setup.md](powershell-ad-setup.md)

### **For Security Administrators**

**Start Here:** [get-ad-groups.md](get-ad-groups.md)  
**Access Planning:** [ad-integration-planning.md](ad-integration-planning.md)  
**User Analysis:** [get-ad-users.md](get-ad-users.md)  
**Setup Guide:** [powershell-ad-setup.md](powershell-ad-setup.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: active-directory, powershell, identity-management, user-administration, information-gathering

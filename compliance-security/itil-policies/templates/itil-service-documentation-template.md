---
title: "PostgreSQL-TimescaleDB Service Overview"
description: "Defines the PostgreSQL-TimescaleDB service, including dependencies, access, monitoring, compliance alignment, and change management."
author: "VintageDon"
tags: ["Storage", "Database", "PostgreSQL", "CISv8", "NIST", "ITIL"]
category: "Storage Services"
kb_type: "Service Documentation"
version: "1.0"
status: "Published"
last_updated: "2025-03-04"
---

## **1. Purpose**
This document defines the **PostgreSQL-TimescaleDB service** used for **time-series data storage** in the lab’s research infrastructure. It provides **clear implementation details, dependencies, compliance alignment, and ITIL-lite service management considerations**.

### **Key Objectives:**
✅ **Ensure structured documentation for service lifecycle tracking.**  
✅ **Map dependencies and compliance for governance.**  
✅ **Establish change management and ITIL-lite best practices.**  

---

## **2. Scope**
| **Category**  | **Details** |
|--------------|------------|
| **Service Type**  | Storage & Data |
| **Primary Function** | Provides **time-series optimized database services**. |
| **Key Dependencies** | Virtual Machine (`proj-pgts01`), Object Storage, NVMe Volumes. |
| **Compliance Mapping** | CISv8, NIST 800-53, ISO 27001. |
| **Lifecycle Coverage** | Deployment, Configuration, Security, Monitoring. |
| **Change Management** | Version tracking, structured updates, ITIL-lite changes. |

🔹 **Out of Scope:** This document does not cover **application-specific data models or query optimizations**.

---

## **3. Service Overview**
PostgreSQL-TimescaleDB is a **high-performance time-series database** optimized for research workloads, providing:
- **Scalable time-series storage** with automatic partitioning.
- **Retention policies for efficient data lifecycle management**.
- **Integration with analytical tools (e.g., Grafana, AI pipelines)**.

### **3.1 Dependencies & Infrastructure**
| **Component**   | **Details** |
|---------------|------------|
| **Primary VM** | `proj-pgts01` (Ubuntu 24.04, 4 vCPUs, 16GB RAM, 500GB NVMe) |
| **Storage** | NVMe Storage (500GB) dedicated to time-series data. |
| **Networking** | VLAN 20 (Dedicated Database Network). |
| **Authentication** | Entra ID (Role-based Access Control). |

---

## **4. Compliance & Security Alignment**
### **4.1 Compliance Frameworks**
| **Framework** | **Control** | **Implementation** |
|--------------|------------|-------------------|
| **CISv8** | 2.2 - Secure Config | Hardened PostgreSQL settings. |
| **NIST 800-53** | AC-4 - Access Control | Enforced RBAC using Entra ID. |
| **ISO 27001** | A.9.4.1 - Secure Access | Encryption and authentication policies applied. |

### **4.2 Security Considerations**
✅ **TLS encryption enabled for all connections**.  
✅ **Role-based access controls enforced via Entra ID**.  
✅ **Automated monitoring for unauthorized access attempts**.  

---

## **5. Change Management (ITIL-Lite)**
5.1 Service Lifecycle
Phase	Description
Design	PostgreSQL-TimescaleDB is deployed on proj-pgts01 with CISv8 compliance in mind.
Implementation	Installed using Ansible playbooks; hardened per CISv8 benchmarks.
Operations	Ongoing monitoring via Prometheus & Grafana; security updates automated.
Decommissioning	Data is offloaded to long-term storage before service shutdown.
5.2 Change Request Process (Tracked in Zammad)
1️⃣ Change Request Creation – A recurring Zammad ticket is generated for planned updates (e.g., security patches, schema changes).
2️⃣ Review & Approval – Requests are evaluated for security, compliance, and operational impact.
3️⃣ Testing & Validation – Changes are staged and validated in a testing environment before production deployment.
4️⃣ Deployment & Monitoring – Approved changes are implemented, and metrics/logs are monitored for issues.
5️⃣ Post-Implementation Review – Review conducted via Zammad; documented in the GitHub repo.

✅ Change history is stored in Zammad for traceability.
✅ Future automation potential (Zammad + GitHub API integration).

### **5.2 Change Request Process**
1️⃣ **Request Submission** – Changes are logged in the GitHub repo (issues & PRs).  
2️⃣ **Review & Approval** – Proposed updates are reviewed against compliance & security.  
3️⃣ **Testing & Validation** – Staging tests ensure no impact to production data.  
4️⃣ **Deployment & Monitoring** – Changes are implemented and monitored via Prometheus.  

---

## **6. Monitoring & Automation**
| **Component** | **Tool** | **Details** |
|--------------|---------|------------|
| **Logging** | Wazuh SIEM | Tracks PostgreSQL access logs. |
| **Metrics** | Prometheus | Uses `pgExporter` for real-time monitoring. |
| **Backup** | Ansible | Automated daily backups using `pgBackRest`. |

✅ **Automated alerts are configured for service degradation**.  
✅ **Security misconfigurations trigger automated remediation playbooks**.  

---

## **7. Incident Response & Troubleshooting**
| **Issue** | **Possible Cause** | **Solution** |
|----------|------------------|------------|
| **Database not responding** | High CPU load, I/O bottleneck | Restart PostgreSQL, check logs. |
| **Data inconsistency** | Unclean shutdown | Run `pg_checksums` and restore from backup. |
| **Unauthorized access attempt** | Brute force attempt detected | Review Wazuh alerts & update firewall rules. |

**Diagnostic Commands:**
```bash
systemctl status postgresql
journalctl -u postgresql --since "1 hour ago"
pg_isready
```

---

## **8. Documentation & Revision Control**
| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-04 | Initial documentation | VintageDon |

---

# **🔹 How This Improves Lab Operations**
✅ **Fully structured documentation following your style guide.**  
✅ **Aligns to ITIL-lite without unnecessary complexity.**  
✅ **CISv8 as a baseline, with higher mappings (NIST, ISO) for learning.**  
✅ **Includes proper change management for real-world maintainability.**  
✅ **Future-proofed for Snipe-IT and ML ingestion.**  

---

# **🚀 Next Steps**
✅ **Adopt this format for all applications/services in `/docs/` repo.**  
✅ **Use the ITIL-lite change process for structured updates.**  
✅ **Integrate with Snipe-IT later using structured tags.**  
✅ **Ensure all major services have clear dependencies mapped.**  

---

### **💡 Training & Takeaways**
- **This format mirrors real ITIL/NIST documentation but in a lightweight way.**
- **Change management ensures all modifications are tracked.**
- **Compliance mapping shows how each service meets CISv8 and beyond.**
- **Dependencies are mapped for easy troubleshooting and infrastructure scaling.**

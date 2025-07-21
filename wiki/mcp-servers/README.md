# 🔌 **MCP Servers**

This wiki section provides practical how-to guides for Model Context Protocol (MCP) server implementation and management across the Proxmox Astronomy Lab infrastructure. The documentation covers essential MCP concepts, specific server implementations used in the lab environment, and security considerations for enterprise-grade MCP deployments supporting AI-driven infrastructure and research workflows.

## **Overview**

Model Context Protocol (MCP) represents a critical component of the AI-driven infrastructure management strategy, providing standardized communication between AI applications and external tools, data sources, and systems. The Proxmox Astronomy Lab implements a comprehensive MCP server ecosystem including official servers for Git operations (Gitea), container management (Portainer), database operations (PostgreSQL), observability (Grafana), and specialized servers for vector databases (Milvus) and graph databases (Neo4j). This implementation supports the "Glass Crucible" framework with transparent, auditable AI-human collaboration.

This wiki provides hands-on procedures for AI engineers, infrastructure teams, and security administrators implementing MCP server integrations. Each guide covers tested procedures specific to the lab's MCP deployment with considerations for enterprise security, protocol compliance, and integration with astronomical research workflows and infrastructure automation.

---

## **📂 Directory Contents**

This section provides navigation to all MCP server implementation guides and procedures.

### **📋 Core MCP Implementation**

| **Guide** | **Purpose** | **Use Case** |
|-----------|-------------|--------------|
| **[mcp-protocol-overview.md](mcp-protocol-overview.md)** | Understanding MCP architecture, transport layers, and protocol fundamentals | Foundation knowledge for MCP implementation |
| **[lab-mcp-servers-overview.md](lab-mcp-servers-overview.md)** | Overview of MCP servers deployed in the Proxmox Astronomy Lab | Understanding the lab's MCP ecosystem |
| **[mcp-server-basic-security.md](mcp-server-basic-security.md)** | Basic security considerations and hardening for MCP server deployments | Secure MCP implementation practices |

### **📖 Supporting Procedures**

| **Guide** | **Purpose** | **Audience** |
|-----------|-------------|--------------|
| **[mcp-troubleshooting-guide.md](mcp-troubleshooting-guide.md)** | Common MCP server issues and resolution procedures | MCP administrators |
| **[mcp-server-monitoring.md](mcp-server-monitoring.md)** | Monitoring and observability for MCP server deployments | Infrastructure engineers |

---

## **🏗️ Repository Structure**

```markdown
wiki/mcp-servers/
├── README.md                                    # This overview document
├── mcp-protocol-overview.md                    # MCP architecture and protocol fundamentals
├── lab-mcp-servers-overview.md                 # Lab-specific MCP server implementations
├── mcp-server-basic-security.md                # MCP security best practices
├── mcp-troubleshooting-guide.md                # MCP server troubleshooting
└── mcp-server-monitoring.md                    # MCP server observability
```

---

## **🔧 Lab MCP Server Ecosystem**

Based on the comprehensive MCP Server Research Plan, the lab implements the following enterprise-grade MCP servers:

### **Core Infrastructure Servers**

| **Server** | **Provider** | **Purpose** | **Status** |
|------------|--------------|-------------|------------|
| **gitea/gitea-mcp** | Official Gitea | Git operations, repository management, issue tracking | Production |
| **portainer/portainer-mcp** | Official Portainer | Container orchestration, Docker/K8s management | Production |
| **gldc/mcp-postgres** | Community | PostgreSQL database operations and queries | Production |
| **grafana/mcp-grafana** | Official Grafana | Observability, metrics, and monitoring integration | Production |

### **Specialized Data Servers**

| **Server** | **Provider** | **Purpose** | **Status** |
|------------|--------------|-------------|------------|
| **zilliztech/mcp-server-milvus** | Official Milvus | Vector database operations for AI/ML workloads | Production |
| **da-okazaki/mcp-neo4j-server** | Community | Graph database operations and knowledge graphs | Planned |
| **farhankaz/redis-mcp** | Community | In-memory data operations (DragonyDB compatible) | Planned |

### **Security and Operations**

| **Server** | **Provider** | **Purpose** | **Status** |
|------------|--------------|-------------|------------|
| **Custom Wazuh MCP** | Internal Development | Security monitoring and SIEM integration | Development |
| **DesktopCommanderMCP** | Community | Controlled system operations with audit logging | Evaluation |

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **MCP Integration** |
|--------------|------------------|-------------------|
| **[gitops-portainer/](../gitops-portainer/README.md)** | GitOps automation | MCP-driven automated deployments |
| **[databases/](../databases/README.md)** | Database operations | PostgreSQL MCP server integration |
| **[observability/](../observability/README.md)** | Monitoring integration | Grafana MCP server for AI-driven observability |

### **Platform Integration**

| **Category** | **Relationship** | **MCP Integration** |
|--------------|------------------|-------------------|
| **[ai-and-machine-learning/](../../ai-and-machine-learning/README.md)** | AI/ML workflows | Vector and graph database MCP integration |
| **[security/](../../security/README.md)** | Security automation | Wazuh MCP server and security monitoring |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Infrastructure automation | MCP-driven infrastructure management |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within MCP server implementation.

### **For AI Engineers**

**Start Here:** [mcp-protocol-overview.md](mcp-protocol-overview.md)  
**Lab Implementation:** [lab-mcp-servers-overview.md](lab-mcp-servers-overview.md)  
**Security Practices:** [mcp-server-basic-security.md](mcp-server-basic-security.md)  
**Monitoring:** [mcp-server-monitoring.md](mcp-server-monitoring.md)

### **For Infrastructure Engineers**

**Start Here:** [lab-mcp-servers-overview.md](lab-mcp-servers-overview.md)  
**Protocol Understanding:** [mcp-protocol-overview.md](mcp-protocol-overview.md)  
**Security Implementation:** [mcp-server-basic-security.md](mcp-server-basic-security.md)  
**Troubleshooting:** [mcp-troubleshooting-guide.md](mcp-troubleshooting-guide.md)

### **For Security Administrators**

**Start Here:** [mcp-server-basic-security.md](mcp-server-basic-security.md)  
**Protocol Security:** [mcp-protocol-overview.md](mcp-protocol-overview.md)  
**Server Assessment:** [lab-mcp-servers-overview.md](lab-mcp-servers-overview.md)  
**Security Monitoring:** [mcp-server-monitoring.md](mcp-server-monitoring.md)

### **For Platform Administrators**

**Start Here:** [lab-mcp-servers-overview.md](lab-mcp-servers-overview.md)  
**Implementation Guide:** [mcp-protocol-overview.md](mcp-protocol-overview.md)  
**Issue Resolution:** [mcp-troubleshooting-guide.md](mcp-troubleshooting-guide.md)  
**Observability:** [mcp-server-monitoring.md](mcp-server-monitoring.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: mcp-protocol, model-context-protocol, ai-infrastructure, gitea-mcp, portainer-mcp, enterprise-ai

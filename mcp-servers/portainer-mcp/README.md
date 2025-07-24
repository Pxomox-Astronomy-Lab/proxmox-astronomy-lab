<!--
---
title: "Portainer MCP Server - Container Orchestration Management for AI Agents"
description: "Official Portainer Model Context Protocol server providing comprehensive container and Kubernetes management through AI interfaces. Features secure-by-design architecture with read-only safety mode and proxy capabilities for Docker and Kubernetes APIs."
author: "Portainer - https://github.com/portainer"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: mcp-server-overview
- domain: container-orchestration-management
- tech: [portainer-mcp, docker-proxy, kubernetes-proxy, container-management]
- phase: production-integration
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Container Orchestration](../infrastructure/orchestration/README.md)"
- "[Kubernetes Management](../infrastructure/k8s/README.md)"
---
-->

# 🐳 **Portainer MCP Server - Container Orchestration Management for AI Agents**

Official Portainer Model Context Protocol server providing comprehensive container and Kubernetes management through AI chat interfaces. Features secure-by-design architecture with critical read-only safety mode, powerful proxy capabilities for Docker and Kubernetes APIs, and complete environment lifecycle management for AI-driven infrastructure operations.

## **🎯 Core Capabilities**

**Environment Management:** Complete lifecycle operations for Docker and Kubernetes environments including listing, configuration, and management of container orchestration platforms through centralized Portainer administration.

**Proxy Capabilities:** Direct API access through DockerProxy and KubernetesProxy tools enabling AI agents to perform any action the Portainer server can execute, with granular control and security boundaries.

**Security-First Design:** Built-in read-only mode completely disables write operations and proxy tools, providing essential safety mechanisms for AI agent interactions with critical infrastructure components.

## **🔧 Installation & Configuration**

### **Binary Installation (Recommended)**

```bash
# Download latest release
wget https://github.com/portainer/portainer-mcp/releases/latest/download/portainer-mcp-linux-amd64
chmod +x portainer-mcp-linux-amd64

# Configure Portainer connection
export PORTAINER_URL="https://portainer.your-domain.com"
export PORTAINER_TOKEN="your-access-token"

# Run in read-only mode (recommended)
./portainer-mcp-linux-amd64 -read-only
```

### **Docker Deployment**

```bash
# Run with Docker in read-only mode
docker run -d \
  --name portainer-mcp \
  -e PORTAINER_URL="https://portainer.your-domain.com" \
  -e PORTAINER_TOKEN="your-access-token" \
  portainer/portainer-mcp:latest \
  -read-only
```

### **Claude Desktop Configuration**

```json
{
  "mcpServers": {
    "portainer": {
      "command": "/path/to/portainer-mcp-linux-amd64",
      "args": ["-read-only"],
      "env": {
        "PORTAINER_URL": "https://portainer.your-domain.com",
        "PORTAINER_TOKEN": "your-access-token",
        "PORTAINER_TEAM_ID": "1"
      }
    }
  }
}
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Environments** | `list_environments`, `get_environment`, `manage_environment` | Container orchestration platform management |
| **Docker Operations** | `list_containers`, `inspect_container`, `container_logs` | Docker container lifecycle and monitoring |
| **Kubernetes Management** | `list_namespaces`, `get_pods`, `describe_resources` | Kubernetes cluster operations and resource management |
| **Stacks & Compose** | `list_stacks`, `deploy_stack`, `update_stack` | Docker Compose and stack deployment management |
| **User Management** | `list_teams`, `manage_users`, `access_control` | RBAC and access control administration |
| **Proxy Access** | `DockerProxy`, `KubernetesProxy` | Raw API access to Docker and Kubernetes (write mode only) |

## **⚠️ Security Modes**

### **Read-Only Mode (Production Recommended)**

```bash
# Safe by default - observation only
./portainer-mcp-linux-amd64 -read-only

# Capabilities in read-only mode:
# ✅ List and inspect resources
# ✅ View logs and metrics
# ✅ Query cluster state
# ❌ Create or modify resources
# ❌ DockerProxy/KubernetesProxy disabled
```

### **Write Mode (Restricted Use)**

```bash
# Full capabilities - high privilege
./portainer-mcp-linux-amd64

# Additional capabilities in write mode:
# ✅ All read-only features
# ✅ Create and modify resources
# ✅ Deploy and update stacks
# ✅ DockerProxy/KubernetesProxy enabled
# ⚠️  Requires rigorous auditing
```

## **🔄 Infrastructure Operations**

### **Environment Discovery**

```javascript
// Discover available container environments
const environments = await list_environments()

// Get detailed environment information
const dockerEnv = await get_environment({
  id: "docker-local",
  include_status: true
})
```

### **Container Management**

```javascript
// Monitor running containers
const containers = await list_containers({
  environment_id: "docker-local",
  status: "running"
})

// Inspect container details and logs
const containerInfo = await inspect_container({
  id: "container-id",
  include_logs: true
})
```

### **Kubernetes Operations**

```javascript
// Explore Kubernetes cluster
const namespaces = await list_namespaces({
  environment_id: "k8s-cluster"
})

// Get pod status and details
const pods = await get_pods({
  namespace: "production",
  include_metrics: true
})
```

## **🚀 Advanced Proxy Operations**

### **Docker API Proxy (Write Mode Only)**

```javascript
// Direct Docker API access through Portainer
const apiResponse = await DockerProxy({
  environment_id: "docker-local",
  method: "GET",
  path: "/containers/json",
  params: { "all": true }
})

// Create container via proxy
const createResponse = await DockerProxy({
  environment_id: "docker-local",
  method: "POST",
  path: "/containers/create",
  body: containerSpec
})
```

### **Kubernetes API Proxy (Write Mode Only)**

```javascript
// Raw Kubernetes API operations
const k8sResponse = await KubernetesProxy({
  environment_id: "k8s-cluster",
  method: "GET",
  path: "/api/v1/pods",
  params: { "namespace": "default" }
})

// Deploy resources via proxy
const deployResponse = await KubernetesProxy({
  environment_id: "k8s-cluster",
  method: "POST",
  path: "/apis/apps/v1/namespaces/default/deployments",
  body: deploymentManifest
})
```

## **🔐 Security Best Practices**

**Principle of Least Privilege:** Default to read-only mode for AI agent interactions. Enable write mode only for specific, highly-vetted, and audited agentic workflows where infrastructure modification is explicitly required.

**Token Management:** Use Portainer access tokens with minimal required permissions. Configure team-based access control and regularly rotate authentication credentials.

**Audit Logging:** Enable comprehensive audit logging for all MCP server interactions, particularly when operating in write mode with proxy capabilities enabled.

## **🏗️ Enterprise Architecture**

**Multi-Environment Support:** Seamless management of multiple Docker and Kubernetes environments through unified Portainer interface, enabling hybrid cloud and multi-cluster operations.

**RBAC Integration:** Full integration with Portainer's role-based access control system, ensuring AI agents operate within defined permission boundaries and organizational policies.

**High Availability:** Support for Portainer cluster deployments with failover capabilities and distributed management for enterprise-scale container orchestration.

---

**Repository:** [github.com/portainer/portainer-mcp](https://github.com/portainer/portainer-mcp)  
**Official:** Portainer Team Maintained and Supported  
**Integration:** Model Context Protocol for AI-Driven Container Operations

## **⚖️ Operational Governance**

**Glass Crucible Alignment:** Read-only mode perfectly supports radical transparency by enabling AI agents to observe and analyze infrastructure state without risk of unintended modifications.

**Change Management:** Write mode operations should be integrated with formal change management processes, ensuring all infrastructure modifications are tracked, approved, and auditable.

**Risk Mitigation:** The read-only flag provides essential safeguards against accidental or malicious actions, allowing safe AI exploration of infrastructure state while preventing unauthorized changes.

## **📊 Monitoring & Observability**

**Performance Tracking:** Integration with Portainer's built-in monitoring capabilities enables comprehensive tracking of AI-driven infrastructure operations and resource utilization patterns.

**Alert Integration:** Seamless connection to observability stacks (Grafana/Prometheus) for monitoring AI agent interactions and detecting anomalous infrastructure access patterns.

**Compliance Reporting:** Comprehensive audit trails and access logging support regulatory compliance requirements and security governance frameworks.

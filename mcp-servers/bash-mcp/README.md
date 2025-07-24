<!--
---
title: "DesktopCommanderMCP - Secure Shell Access for AI Agents"
description: "Advanced Model Context Protocol server providing secure shell command execution, filesystem operations, and process management with comprehensive security controls, audit logging, and sandboxing capabilities for AI-driven system operations"
author: "wonderwhy-er - https://github.com/wonderwhy-er"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published - Production Configured"
tags:
- type: mcp-server-overview
- domain: secure-shell-access
- tech: [desktop-commander-mcp, bash-execution, filesystem-operations, security-controls]
- phase: production-deployed
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Security Controls](../../security/README.md)"
- "[Bash MCP Configuration](./bash-mcp/README.md)"
---
-->

# 🖥️ **DesktopCommanderMCP - Secure Shell Access for AI Agents**

Advanced TypeScript-based Model Context Protocol server providing comprehensive shell command execution, filesystem operations, and process management through AI chat interfaces. Features enterprise-grade security controls including command blocking, directory restrictions, audit logging, and configurable sandboxing for safe AI-driven system operations.

## **🎯 Core Capabilities**

**Secure Command Execution:** Advanced shell command execution with configurable timeouts, background execution, session management, and comprehensive security controls including command blacklisting and directory restrictions.

**Comprehensive Filesystem Operations:** Full suite of file and directory operations including reading, writing, searching, editing, and navigation with configurable access restrictions and safety boundaries.

**Process Management:** System process monitoring, management, and control capabilities with tools to list running processes, monitor system resources, and manage application lifecycle.

## **🔧 Production Configuration**

### **Current Deployment Status: ✅ CONFIGURED**

This server is already deployed and configured with production-grade security controls in the project environment:

```yaml
# Current deployment via Docker Compose
Container: desktop-commander-mcp
Status: Production configured with security controls
Security: Jailed execution, command blocking, audit logging
```

### **Security Configuration**

```json
{
  "blockedCommands": [
    "sudo", "su", "passwd", "shutdown", "reboot", "halt",
    "rm -rf /", "mkfs", "fdisk", "mount", "umount",
    "iptables", "ufw", "systemctl", "service",
    "apt", "yum", "pacman", "pip install", "npm install -g",
    "docker", "kubectl", "helm", "terraform"
  ],
  "allowedDirectories": ["/app/mcp-testing-jail"],
  "security": {
    "restrictToJail": true,
    "jailDirectory": "/app/mcp-testing-jail",
    "allowSystemCommands": false,
    "maxConcurrentCommands": 5
  }
}
```

### **Claude Desktop Integration**

```json
{
  "mcpServers": {
    "desktop-commander": {
      "command": "docker",
      "args": ["exec", "-i", "desktop-commander-mcp", "node", "/usr/local/lib/node_modules/@wonderwhy-er/desktop-commander/dist/index.js"],
      "env": {
        "MCP_LOG_LEVEL": "info"
      }
    }
  }
}
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Command Execution** | `execute_command`, `run_background`, `kill_process` | Secure shell command execution with timeout controls |
| **File Operations** | `read_file`, `write_file`, `search_files`, `edit_file` | Comprehensive filesystem manipulation within security boundaries |
| **Directory Management** | `list_directory`, `create_directory`, `change_directory` | Directory navigation and management with access controls |
| **Process Control** | `list_processes`, `monitor_system`, `process_status` | System process monitoring and management capabilities |
| **Session Management** | `session_info`, `environment_vars`, `working_directory` | Shell session state and environment management |
| **Code Operations** | `code_editor`, `syntax_check`, `file_templates` | Advanced code editing and development workflow support |

## **🔐 Security Architecture**

### **Multi-Layer Security Controls**

**Command Blocking:** Comprehensive blacklist of dangerous system commands including privileged operations, package managers, container tools, and infrastructure management utilities to prevent unauthorized system modifications.

**Directory Restrictions:** Strict filesystem access controls limiting operations to designated jail directories with configurable allowed paths and automatic path validation for all file operations.

**Resource Limits:** Built-in protections including command timeouts, concurrent execution limits, file size restrictions, and memory usage controls to prevent resource exhaustion attacks.

### **Audit and Compliance**

```json
{
  "auditLog": {
    "enabled": true,
    "logFile": "/app/logs/audit/mcp-audit.log",
    "logLevel": "info",
    "includeOutput": true
  }
}
```

**Comprehensive Audit Trail:** All command executions, file operations, and system interactions are logged with timestamps, arguments, outputs, and user context for complete operational transparency.

**Compliance Monitoring:** Automatic logging of security violations, blocked command attempts, and unauthorized access patterns enabling proactive security monitoring and incident response.

## **🚀 Advanced Features**

### **Intelligent Command Processing**

```javascript
// Safe command execution with automatic validation
const result = await execute_command({
  command: "ls -la /app/mcp-testing-jail",
  timeout: 30000,
  validate_safety: true
})

// Background process management
const process = await run_background({
  command: "python analysis_script.py",
  working_directory: "/app/mcp-testing-jail/projects"
})
```

### **Filesystem Intelligence**

```javascript
// Secure file operations within jail
const content = await read_file({
  path: "/app/mcp-testing-jail/data/analysis.csv",
  line_limit: 1000
})

// Safe file editing with validation
await write_file({
  path: "/app/mcp-testing-jail/output/results.json",
  content: JSON.stringify(results),
  validate_path: true
})
```

### **Process Monitoring**

```javascript
// System resource monitoring
const processes = await list_processes({
  filter: "python",
  include_system: false
})

// Resource usage analysis
const system_info = await monitor_system({
  include_memory: true,
  include_cpu: true,
  include_disk: false
})
```

## **📊 Production Benefits**

**Glass Crucible Alignment:** Perfect alignment with radical transparency principles through comprehensive audit logging, command validation, and security boundary enforcement enabling safe AI system operations.

**Risk Mitigation:** Advanced security controls transform inherently dangerous shell access into a controlled, auditable, and safe capability for AI agents while maintaining operational flexibility.

**Operational Intelligence:** Beyond basic command execution, provides sophisticated system analysis, process management, and development workflow capabilities that enable advanced AI-driven operations.

## **🔄 Container Security**

### **Docker Hardening**

```yaml
security_opt:
  - no-new-privileges:true
deploy:
  resources:
    limits:
      cpus: '1.0'
      memory: 512M
user: node  # Non-root execution
```

**Container Isolation:** Runs in hardened Docker container with resource limits, non-root user execution, and security constraints preventing privilege escalation and system compromise.

**Network Isolation:** No exposed ports, stdio-only transport, and isolated execution environment ensuring minimal attack surface and controlled communication channels.

## **⚠️ Operational Considerations**

**Continuous Monitoring:** Security controls must be continuously monitored and updated. Audit logs should be regularly reviewed for suspicious patterns or attempted security violations.

**Configuration Management:** Security configurations should be version controlled, reviewed, and tested. Changes to blocked commands or allowed directories require security impact assessment.

**Incident Response:** Established procedures for responding to security violations, including automatic alerting, log analysis, and containment strategies for compromised operations.

---

**Repository:** [github.com/wonderwhy-er/DesktopCommanderMCP](https://github.com/wonderwhy-er/DesktopCommanderMCP)  
**Community:** Advanced TypeScript implementation with security focus  
**Integration:** Model Context Protocol for AI-Driven Secure Shell Operations

## **🎯 Strategic Advantages**

**Security-First Design:** Unlike minimalist bash servers, provides built-in security controls, audit logging, and sandboxing capabilities essential for safe AI agent interactions with system resources.

**Enterprise Readiness:** Comprehensive configuration options, audit trails, and security boundaries make this suitable for production environments where shell access is required but must be controlled.

**Operational Excellence:** Advanced features beyond basic command execution enable sophisticated AI workflows including development operations, system analysis, and automated maintenance tasks within security boundaries.

## **📈 Deployment Success**

**Production Status:** Successfully deployed and configured with comprehensive security controls, demonstrating practical viability for enterprise AI agent operations requiring controlled system access.

**Proven Configuration:** Current deployment validates the security model and operational procedures, providing a foundation for expanded AI-driven system operations within established safety boundaries.

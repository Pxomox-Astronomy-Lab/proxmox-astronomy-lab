<!--
---
title: "Gitea MCP Server - Git Repository Management for AI Agents"
description: "Official Model Context Protocol server for Gitea providing comprehensive repository management, issue tracking, and pull request operations through AI chat interfaces"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: mcp-server-overview
- domain: git-repository-management
- tech: [gitea-mcp, git-operations, model-context-protocol]
- phase: production-integration
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Git Repository Platform](../applications-and-services/gitea01-project-repository/README.md)"
- "[Infrastructure Overview](../infrastructure/README.md)"
---
-->

# 🦌 **Gitea MCP Server - Git Repository Management for AI Agents**

Official Model Context Protocol server providing comprehensive Gitea repository management through AI chat interfaces. Enables seamless command execution for repository operations, issue tracking, pull requests, and file management with both stdio and SSE transport support for development and production environments.

## **🎯 Core Capabilities**

**Repository Management:** Complete lifecycle operations including creation, forking, branch management, and file operations through natural language commands.

**Issue & PR Workflow:** Full issue tracking and pull request management enabling collaborative development through AI-assisted workflows.

**Enterprise Integration:** Official Gitea server supporting both self-hosted instances and gitea.com with secure token-based authentication and comprehensive tool coverage.

## **🔧 Installation & Configuration**

### **Docker Deployment**

```json
{
  "mcpServers": {
    "gitea": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-e", "GITEA_ACCESS_TOKEN", "docker.gitea.com/gitea-mcp-server"],
      "env": {
        "GITEA_ACCESS_TOKEN": "<your_token>"
      }
    }
  }
}
```

### **Binary Installation**

```bash
# Download official release
git clone https://gitea.com/gitea/gitea-mcp.git
make install
cp gitea-mcp /usr/local/bin/
```

### **SSE Transport (Multi-Client)**

```json
{
  "mcpServers": {
    "gitea": {
      "url": "http://localhost:8080/sse"
    }
  }
}
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Repository** | `create_repo`, `fork_repo`, `list_my_repos`, `search_repos` | Repository lifecycle management |
| **Files** | `get_file_content`, `create_file`, `update_file`, `delete_file` | File operations and content management |
| **Issues** | `create_issue`, `edit_issue`, `create_issue_comment`, `list_repo_issues` | Issue tracking and management |
| **Pull Requests** | `create_pull_request`, `list_repo_pull_requests`, `get_pull_request_by_index` | Code review and collaboration |
| **Branches/Tags** | `create_branch`, `delete_branch`, `list_branches`, `create_tag`, `list_tags` | Version control operations |
| **Releases** | `create_release`, `delete_release`, `get_latest_release`, `list_releases` | Release management |

---

**Repository:** [gitea.com/gitea/gitea-mcp](https://gitea.com/gitea/gitea-mcp)  
**Official:** Gitea Organization Maintained  
**Integration:** Model Context Protocol for AI-Driven Development

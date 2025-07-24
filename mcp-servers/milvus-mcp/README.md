<!--
---
title: "Milvus MCP Server - Vector Database Operations for AI Agents"
description: "Official Model Context Protocol server for Milvus providing comprehensive vector search, collection management, and hybrid search operations through AI interfaces"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: mcp-server-overview
- domain: vector-database-operations
- tech: [milvus-mcp, vector-search, model-context-protocol]
- phase: production-integration
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Vector Database Platform](../applications-and-services/milvus01-attu-milvus-backup/README.md)"
- "[AI/ML Infrastructure](../ai/README.md)"
---
-->

# 🧠 **Milvus MCP Server - Vector Database Operations for AI Agents**

Official Model Context Protocol server by Zilliz providing comprehensive Milvus vector database operations through AI chat interfaces. Enables vector similarity search, text search, hybrid search, and complete collection lifecycle management with both stdio and SSE transport support for development and production environments.

## **🎯 Core Capabilities**

**Vector Operations:** Full vector similarity search with multiple distance metrics (COSINE, L2, IP), hybrid text+vector search, and advanced filtering capabilities for AI-powered semantic search.

**Collection Management:** Complete lifecycle operations including creation with custom schemas, loading/releasing from memory, data insertion/deletion, and comprehensive metadata retrieval.

**Search Modes:** Text search, vector search, hybrid search, and query operations with flexible output field selection and filter expressions for comprehensive data retrieval.

## **🔧 Installation & Configuration**

### **Direct Execution (Recommended)**

```bash
# Clone and run with uv
git clone https://github.com/zilliztech/mcp-server-milvus.git
cd mcp-server-milvus
uv run src/mcp_server_milvus/server.py --milvus-uri http://localhost:19530
```

### **Claude Desktop Configuration**

```json
{
  "mcpServers": {
    "milvus": {
      "command": "/PATH/TO/uv",
      "args": [
        "--directory", "/path/to/mcp-server-milvus/src/mcp_server_milvus",
        "run", "server.py", "--milvus-uri", "http://localhost:19530"
      ]
    }
  }
}
```

### **SSE Transport (Multi-Client)**

```bash
# Start SSE server
uv run src/mcp_server_milvus/server.py --sse --milvus-uri http://localhost:19530 --port 8000
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Search** | `milvus_vector_search`, `milvus_text_search`, `milvus_hybrid_search` | Vector similarity, text, and hybrid search operations |
| **Collections** | `milvus_list_collections`, `milvus_create_collection`, `milvus_get_collection_info` | Collection lifecycle and metadata management |
| **Data** | `milvus_insert_data`, `milvus_delete_entities`, `milvus_query` | Data manipulation and filtering operations |
| **Memory** | `milvus_load_collection`, `milvus_release_collection` | Memory management for search optimization |

---

**Repository:** [github.com/zilliztech/mcp-server-milvus](https://github.com/zilliztech/mcp-server-milvus)  
**Official:** Zilliz (Milvus Creator) Maintained  
**Integration:** Model Context Protocol for AI-Driven Vector Operations

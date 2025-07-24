<!--
---
title: "Neo4j MCP Server - Graph Database Operations for AI Agents"
description: "Community-driven Model Context Protocol server for Neo4j providing essential graph operations including Cypher execution, node creation, and relationship management through AI interfaces"
author: "da-okazaki - https://github.com/da-okazaki"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: mcp-server-overview
- domain: graph-database-operations
- tech: [neo4j-mcp, cypher-queries, graph-operations]
- phase: production-integration
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Graph Database Platform](../applications-and-services/neo4j01-bloom-apoc/README.md)"
- "[Knowledge Graph Infrastructure](../infrastructure/databases/README.md)"
---
-->

# 🕸️ **Neo4j MCP Server - Graph Database Operations for AI Agents**

Community-maintained Model Context Protocol server providing essential Neo4j graph database operations through AI chat interfaces. Enables direct Cypher query execution, node creation, relationship management, and graph traversal operations for AI-powered knowledge graph interactions and GraphRAG implementations.

## **🎯 Core Capabilities**

**Graph Operations:** Execute arbitrary Cypher queries, create nodes with properties and labels, establish relationships between entities, and perform complex graph traversals for knowledge discovery and analysis.

**Query Flexibility:** Direct Cypher execution allows for sophisticated graph patterns, aggregations, path finding, and analytical queries that leverage Neo4j's full graph processing capabilities.

**Entity Management:** Comprehensive node and relationship lifecycle operations including creation, modification, and deletion with support for dynamic properties and multiple labels.

## **🔧 Installation & Configuration**

### **Direct Execution (Recommended)**

```bash
# Clone and install dependencies
git clone https://github.com/da-okazaki/mcp-neo4j-server.git
cd mcp-neo4j-server
npm install

# Configure Neo4j connection
export NEO4J_URI="bolt://localhost:7687"
export NEO4J_USERNAME="neo4j"
export NEO4J_PASSWORD="your-password"

# Run server
npm start
```

### **Claude Desktop Configuration**

```json
{
  "mcpServers": {
    "neo4j": {
      "command": "node",
      "args": ["/path/to/mcp-neo4j-server/dist/index.js"],
      "env": {
        "NEO4J_URI": "bolt://localhost:7687",
        "NEO4J_USERNAME": "neo4j",
        "NEO4J_PASSWORD": "your-password"
      }
    }
  }
}
```

### **Environment Variables**

```bash
# Required connection parameters
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your-secure-password

# Optional configuration
NEO4J_DATABASE=neo4j  # Default database name
NEO4J_MAX_CONNECTIONS=50  # Connection pool size
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Query** | `execute_query` | Execute arbitrary Cypher queries with parameter binding |
| **Nodes** | `create_node` | Create nodes with labels and properties |
| **Relationships** | `create_relationship` | Establish typed relationships between nodes |
| **Schema** | `get_schema`, `list_constraints` | Database schema introspection and validation |

## **📊 Common Usage Patterns**

### **Knowledge Graph Queries**

```cypher
// Find related entities within 2 hops
MATCH (start:Entity {name: 'topic'})-[*1..2]-(related)
RETURN start, related, relationships(path)
```

### **GraphRAG Integration**

```cypher
// Semantic search with vector similarity
MATCH (doc:Document)
WHERE gds.similarity.cosine(doc.embedding, $query_vector) > 0.8
RETURN doc.content, doc.metadata
```

### **Entity Relationship Discovery**

```cypher
// Complex pattern matching for insights
MATCH (person:Person)-[:WORKS_FOR]->(company:Company)-[:OPERATES_IN]->(industry:Industry)
WHERE industry.name = 'Technology'
RETURN person.name, company.name, industry.trends
```

## **🔐 Security & Best Practices**

**Authentication:** Secure credential management through environment variables with support for Neo4j authentication mechanisms including basic auth and custom security providers.

**Query Safety:** While supporting arbitrary Cypher execution for maximum flexibility, production deployments should implement query validation, timeout controls, and resource limits to prevent abuse.

**Connection Security:** SSL/TLS encryption support for secure database connections in production environments with certificate validation and encrypted data transmission.

---

**Repository:** [github.com/da-okazaki/mcp-neo4j-server](https://github.com/da-okazaki/mcp-neo4j-server)  
**Community:** Mature community-maintained project with active development  
**Integration:** Model Context Protocol for AI-Driven Graph Operations

## **🚀 Production Considerations**

**Evolution Path:** While this community server provides excellent initial capabilities, production environments should evaluate migrating to Google's Toolbox for Neo4j, which offers sandboxed, parameterized query execution for enhanced security and controlled access patterns.

**Graph Modeling:** Optimal performance requires thoughtful graph schema design with appropriate indexes, constraints, and relationship patterns that align with query requirements and data access patterns.

**Monitoring:** Integration with Neo4j's built-in monitoring capabilities enables performance tracking, query optimization, and resource utilization analysis for production graph operations.

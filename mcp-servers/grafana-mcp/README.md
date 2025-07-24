<!--
---
title: "Grafana MCP Server - Unified Observability Platform for AI Agents"
description: "Official Grafana Labs Model Context Protocol server providing comprehensive observability operations including Grafana dashboards, Prometheus metrics, Loki logs, and incident management through AI interfaces"
author: "Grafana Labs - https://github.com/grafana"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: mcp-server-overview
- domain: unified-observability-platform
- tech: [grafana-mcp, prometheus-integration, loki-logs, incident-management]
- phase: production-integration
related_documents:
- "[MCP Servers Overview](./README.md)"
- "[Observability Infrastructure](../monitoring/README.md)"
- "[Prometheus/Loki/Grafana Stack](../applications-and-services/monitoring01-prometheus-grafana-loki/README.md)"
---
-->

# 📊 **Grafana MCP Server - Unified Observability Platform for AI Agents**

Official Grafana Labs Model Context Protocol server providing comprehensive observability operations through AI chat interfaces. Unifies Grafana dashboards, Prometheus metrics, Loki logs, and incident management in a single, authoritative interface for AI-driven system analysis, automated diagnostics, and operational intelligence.

## **🎯 Core Capabilities**

**Unified Observability:** Single interface for the entire Grafana-centric observability ecosystem including dashboard management, metric queries, log analysis, and incident response without managing multiple community servers.

**Direct Data Source Access:** Native integration with Prometheus (PromQL queries), Loki (LogQL queries), and other configured data sources providing AI agents direct access to metrics and logs without frontend dependencies.

**Incident Management:** Comprehensive integration with Grafana Incident and Grafana OnCall for automated incident response, on-call schedule management, and SiLo coordination through intelligent alert processing.

## **🔧 Installation & Configuration**

### **Binary Installation (Recommended)**

```bash
# Download latest release
wget https://github.com/grafana/mcp-grafana/releases/latest/download/mcp-grafana-linux-amd64
chmod +x mcp-grafana-linux-amd64

# Configure Grafana connection
export GRAFANA_URL="https://grafana.your-domain.com"
export GRAFANA_TOKEN="your-service-account-token"

# Run server
./mcp-grafana-linux-amd64
```

### **Docker Deployment**

```bash
# Run with Docker
docker run -d \
  --name mcp-grafana \
  -e GRAFANA_URL="https://grafana.your-domain.com" \
  -e GRAFANA_TOKEN="your-service-account-token" \
  -p 8080:8080 \
  grafana/mcp-grafana:latest
```

### **Claude Desktop Configuration**

```json
{
  "mcpServers": {
    "grafana": {
      "command": "/path/to/mcp-grafana-linux-amd64",
      "env": {
        "GRAFANA_URL": "https://grafana.your-domain.com",
        "GRAFANA_TOKEN": "your-service-account-token",
        "GRAFANA_ORG_ID": "1"
      }
    }
  }
}
```

## **🛠️ Available Tools**

| **Category** | **Tools** | **Functionality** |
|--------------|-----------|-------------------|
| **Dashboards** | `search_dashboards`, `get_dashboard`, `create_dashboard`, `update_dashboard` | Complete dashboard lifecycle management |
| **Prometheus** | `query_prometheus`, `query_prometheus_metadata`, `query_prometheus_range` | Direct PromQL execution and metrics analysis |
| **Loki** | `query_loki`, `query_loki_labels`, `query_loki_range` | LogQL queries and log stream analysis |
| **Incidents** | `list_incidents`, `create_incident`, `update_incident` | Incident management and response coordination |
| **OnCall** | `get_oncall_schedule`, `create_escalation`, `manage_shifts` | On-call management and escalation policies |
| **Alerts** | `query_alerts`, `silence_alerts`, `create_alert_rules` | Alert rule management and notification control |

## **📈 Observability Workflows**

### **Automated System Analysis**

```javascript
// Query system performance metrics
const cpuMetrics = await query_prometheus({
  query: "100 - (avg by (instance) (rate(node_cpu_seconds_total{mode='idle'}[5m])) * 100)",
  time: "now"
})

// Correlate with application logs
const errorLogs = await query_loki({
  query: '{job="kubernetes-pods"} |= "ERROR" | json',
  start: "now-1h",
  end: "now"
})
```

### **Intelligent Dashboard Management**

```javascript
// Search for relevant dashboards
const dashboards = await search_dashboards({
  query: "kubernetes",
  tags: ["infrastructure", "monitoring"]
})

// Create custom dashboard for specific analysis
const newDashboard = await create_dashboard({
  title: "AI System Analysis - " + new Date().toISOString(),
  panels: generateAnalysisPanels(metricsData)
})
```

### **Proactive Incident Response**

```javascript
// Detect anomalies and create incidents
const anomalies = await query_prometheus({
  query: "rate(http_requests_total{status=~'5..'}[5m]) > 0.1"
})

if (anomalies.data.result.length > 0) {
  const incident = await create_incident({
    title: "High Error Rate Detected",
    severity: "high",
    description: "Automated detection of elevated 5xx responses"
  })
}
```

## **🔗 Enterprise Integration**

**Service Account Authentication:** Secure API access using Grafana service account tokens with granular permissions and role-based access control for multi-tenant observability environments.

**Data Source Federation:** Unified access to multiple Prometheus instances, Loki deployments, and other data sources configured in Grafana without managing individual connection credentials.

**Alert Manager Integration:** Seamless integration with Prometheus AlertManager, Grafana alerting, and external notification systems for comprehensive alert lifecycle management.

## **🚀 Architectural Advantages**

**Single Point of Integration:** Eliminates the complexity of managing multiple community servers (separate Prometheus, Loki, and Grafana MCP servers) with different codebases, maintenance cycles, and maturity levels.

**Official Support:** Grafana Labs maintenance ensures compatibility with Grafana releases, security updates, and feature alignment with the observability platform roadmap.

**Comprehensive Coverage:** Beyond basic query capabilities, includes advanced features like incident management, on-call scheduling, and alert rule management that individual servers cannot provide.

## **🔐 Security & Configuration**

**TLS Support:** Built-in TLS configuration for secure communication with encrypted data transmission and certificate-based authentication for production deployments.

**Token Management:** Secure service account token handling with automatic rotation support and scope-limited permissions following security best practices.

**Network Security:** Configurable network policies, firewall rules, and access controls enabling secure deployment in enterprise environments with strict security requirements.

---

**Repository:** [github.com/grafana/mcp-grafana](https://github.com/grafana/mcp-grafana)  
**Official:** Grafana Labs Maintained and Supported  
**Integration:** Model Context Protocol for AI-Driven Observability Operations

## **🎯 Strategic Implementation**

**Glass Crucible Alignment:** Perfectly aligns with radical transparency principles by providing AI agents comprehensive visibility into system operations, enabling automated diagnostics and self-reflective system analysis.

**Operational Intelligence:** Transforms observability from reactive monitoring to proactive intelligence, enabling AI systems to understand, analyze, and respond to operational patterns and anomalies autonomously.

**Unified Architecture:** Superior to fragmenting observability access across multiple community servers, providing a single, trusted, and officially supported interface to the complete observability ecosystem.

## **📊 Performance & Scalability**

**Query Optimization:** Built-in query optimization and caching for high-frequency AI-driven analysis with efficient resource utilization and reduced observability system load.

**Concurrent Operations:** Multi-threaded query execution and parallel data source access enabling simultaneous metrics, logs, and dashboard operations for comprehensive system analysis.

**Resource Management:** Intelligent rate limiting, connection pooling, and resource allocation preventing observability system overload during intensive AI analysis operations.

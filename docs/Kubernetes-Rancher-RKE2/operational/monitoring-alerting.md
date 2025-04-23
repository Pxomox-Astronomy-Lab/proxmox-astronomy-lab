<!-- 
---
title: "Monitoring & Alerting for RKE2 Kubernetes Cluster"
description: "Configuration and deployment of monitoring exporters within the RKE2 Kubernetes cluster to integrate with the central monitoring infrastructure"
author: "VintageDon"
tags: ["kubernetes", "monitoring", "exporters", "prometheus", "node-exporter", "liongard", "cmdb"]
category: "Infrastructure"
kb_type: "Service Document"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["RKE2 Kubernetes Cluster", "Liongard CMDB", "lab-mon01 Monitoring Stack"]
implements_policies: ["Monitoring Policy", "Incident Response Policy", "Security Monitoring Policy"]
phase: "phase-3"
cis_controls: ["CIS.8.2", "CIS.8.5", "CIS.8.11"]
iso27001_controls: ["A.12.1.3", "A.16.1.2", "A.12.4.1"]
nist_controls: ["SI-4", "AU-6", "IR-4"]
---
-->

# Monitoring & Alerting for RKE2 Kubernetes Cluster

This document provides the authoritative reference for the monitoring exporters and data collection mechanisms deployed within the RKE2 Kubernetes cluster. These components integrate with the central monitoring stack hosted on lab-mon01 and the Liongard CMDB to provide comprehensive observability of the Kubernetes environment.

## 1. Overview

The RKE2 cluster employs a series of exporters and ServiceMonitors to expose metrics to the centralized monitoring infrastructure. Rather than running a complete monitoring stack within Kubernetes, the cluster acts as a data source for the lab-mon01 server which hosts Prometheus, Loki, Grafana, and AlertManager.

### 1.1 Purpose

This document defines the monitoring exporter configuration, metric collection points, and integration with the central monitoring infrastructure. It serves as the definitive reference for monitoring-related components within the RKE2 Kubernetes cluster.

### 1.2 Scope

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Kubernetes metric exporter deployment | Core monitoring infrastructure (on lab-mon01) |
| ServiceMonitor configuration | Alert rules and notification configuration |
| Prometheus Operator CRDs for discovery | Dashboard development (managed in Grafana) |
| Integration with Liongard CMDB | Application-specific internal metrics |
| Network endpoint configuration | User activity monitoring |

### 1.3 Target Audience

This document is intended for:

- Infrastructure Administrators managing the RKE2 cluster
- Monitoring team maintaining the central monitoring infrastructure
- Operations staff who need to understand metric collection points
- Security personnel reviewing monitoring configurations

## 2. Dependencies & Relationships

This section maps how the cluster monitoring components relate to other elements within the Proxmox Astronomy Lab environment.

### 2.1 Related Services

This document **relates to**:

- [RKE2 Kubernetes Cluster](../../01-rke2-cluster-overview.md) - The environment where exporters are deployed
- [lab-mon01 Monitoring Stack](../../../monitoring/central-monitoring-stack.md) - Central monitoring infrastructure
- [Liongard CMDB](../../../control-plane/liongard-cmdb.md) - Configuration management database integration
- [Network Infrastructure](../../../infrastructure/03-networking.md) - Required for metric transmission

### 2.2 Implements Policies

This document **implements**:

- [Monitoring Policy](../../../compliance-security/monitoring-policy.md) - Establishes monitoring requirements
- [Incident Response Policy](../../../compliance-security/incident-response-policy.md) - Defines alert-triggered response procedures
- [Security Monitoring Policy](../../../compliance-security/security-monitoring-policy.md) - Security-specific monitoring requirements

### 2.3 Responsibility Matrix

| **Activity** | **Infrastructure Team** | **Monitoring Team** | **Security Team** | **Operations** |
|--------------|-------------------|-------------------|--------------|----------------|
| Exporter Deployment & Maintenance | R/A | C | I | I |
| ServiceMonitor Configuration | R/A | C | I | I |
| Network Path Verification | R | C | I | A |
| Liongard CMDB Integration | C | I | I | R/A |
| Metric Availability Verification | C | R/A | I | C |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

## 3. Technical Documentation

This section provides the technical details necessary for implementation, configuration, and troubleshooting of the monitoring components within the RKE2 cluster.

### 3.1 Architecture & Components

The monitoring architecture consists of exporters within the Kubernetes cluster that expose metrics to the lab-mon01 monitoring server:

```markdown
┌───────────────────────────────────────────────────────────────┐
│                    RKE2 Kubernetes Cluster                    │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │              Prometheus Operator CRDs                   │  │
│  │                                                         │  │
│  │  ┌────────────────┐   ┌────────────────┐                │  │
│  │  │ ServiceMonitor │   │ PodMonitor     │                │  │
│  │  │ Resources      │   │ Resources      │                │  │
│  │  └────────────────┘   └────────────────┘                │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                 Monitoring Exporters                    │  │
│  │                                                         │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐     │  │
│  │  │ Node       │  │ kube-state │  │ Custom         │     │  │
│  │  │ Exporter   │  │ Metrics    │  │ Exporters      │     │  │
│  │  └────────────┘  └────────────┘  └────────────────┘     │  │
│  │                                                         │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │              Native Kubernetes Metrics                  │  │
│  │                                                         │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────────┐     │  │
│  │  │ kubelet    │  │ API Server │  │ etcd           │     │  │
│  │  │ Metrics    │  │ Metrics    │  │ Metrics        │     │  │
│  │  └────────────┘  └────────────┘  └────────────────┘     │  │
│  └─────────────────────────────────────────────────────────┘  │
│                              │                                │
└──────────────────────────────┼────────────────────────────────┘
                               │
                               ▼
┌──────────────────────────────────────────────────────────────┐
│                  External Monitoring Systems                 │
│                                                              │
│  ┌────────────────────────────┐  ┌─────────────────────────┐ │
│  │    lab-mon01 Server        │  │     Liongard CMDB       │ │
│  │                            │  │                         │ │
│  │  ┌─────────────────────┐   │  │ ┌─────────────────────┐ │ │
│  │  │ Prometheus          │   │  │ │ Inspector Modules   │ │ │
│  │  │ (Scrapes metrics)   │   │  │ │ (Kubernetes, SSL)   │ │ │
│  │  └─────────────────────┘   │  │ └─────────────────────┘ │ │
│  │  ┌─────────────────────┐   │  │ ┌─────────────────────┐ │ │
│  │  │ Grafana             │   │  │ │ System Inventory    │ │ │
│  │  │ (Visualization)     │   │  │ │ & Timeline          │ │ │
│  │  └─────────────────────┘   │  │ └─────────────────────┘ │ │
│  │  ┌─────────────────────┐   │  │ ┌─────────────────────┐ │ │
│  │  │ AlertManager        │   │  │ │ Compliance          │ │ │
│  │  │ (Alert routing)     │   │  │ │ Reporting           │ │ │
│  │  └─────────────────────┘   │  │ └─────────────────────┘ │ │
│  └────────────────────────────┘  └─────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

The key architectural components within the RKE2 cluster include:

1. **Prometheus Operator CRDs**: Custom Resources that define monitoring targets
   - ServiceMonitor: Defines service endpoints to scrape
   - PodMonitor: Defines pod endpoints to scrape
   - PrometheusRule: Defines alerting rules (stored in Git, applied to lab-mon01)

2. **Monitoring Exporters**: Components that expose metrics
   - Node Exporter: System-level metrics from Kubernetes nodes
   - kube-state-metrics: Kubernetes object metrics
   - Custom Exporters: Application-specific metrics

3. **Native Kubernetes Metrics**: Metrics exposed by core components
   - kubelet: Node-level container and pod metrics
   - API Server: API request metrics
   - etcd: Key-value store metrics

### 3.2 Configuration Details

#### 3.2.1 Prometheus Operator CRDs

The following CRDs are deployed to enable metric discovery:

```yaml
# Example ServiceMonitor for node-exporter
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  endpoints:
  - port: metrics
    interval: 30s
  selector:
    matchLabels:
      app: node-exporter
  namespaceSelector:
    matchNames:
    - monitoring
```

```yaml
# Example ServiceMonitor for kube-state-metrics
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: kube-state-metrics
  namespace: monitoring
spec:
  endpoints:
  - port: http-metrics
    interval: 30s
  selector:
    matchLabels:
      app: kube-state-metrics
  namespaceSelector:
    matchNames:
    - monitoring
```

#### 3.2.2 Node Exporter Configuration

Node Exporter is deployed as a DaemonSet to ensure coverage of all nodes:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
  labels:
    app: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      hostNetwork: true
      hostPID: true
      containers:
      - name: node-exporter
        image: prom/node-exporter:v1.6.0
        args:
        - --path.procfs=/host/proc
        - --path.sysfs=/host/sys
        - --collector.filesystem.ignored-mount-points=^/(dev|proc|sys|var/lib/docker/.+)($|/)
        - --collector.filesystem.ignored-fs-types=^(autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs)$
        ports:
        - name: metrics
          containerPort: 9100
        volumeMounts:
        - name: proc
          mountPath: /host/proc
          readOnly: true
        - name: sys
          mountPath: /host/sys
          readOnly: true
      volumes:
      - name: proc
        hostPath:
          path: /proc
      - name: sys
        hostPath:
          path: /sys
```

#### 3.2.3 kube-state-metrics Configuration

kube-state-metrics is deployed as a Deployment to provide Kubernetes object metrics:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-state-metrics
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: kube-state-metrics
  replicas: 1
  template:
    metadata:
      labels:
        app: kube-state-metrics
    spec:
      containers:
      - name: kube-state-metrics
        image: k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.8.0
        ports:
        - name: http-metrics
          containerPort: 8080
        - name: telemetry
          containerPort: 8081
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 5
          timeoutSeconds: 5
```

#### 3.2.4 Network Configuration for lab-mon01

To allow the central Prometheus server on lab-mon01 to scrape metrics from the RKE2 cluster, the following network configurations are implemented:

1. **Firewall Rules**:
   - Allow inbound traffic from lab-mon01 (10.25.10.13) to all Kubernetes nodes on ports 9100 (node-exporter), 10250 (kubelet), and service ports.
   - Allow outbound traffic from all Kubernetes nodes to lab-mon01 for monitoring data transmission.

2. **DNS Resolution**:
   - Ensure lab-mon01 can resolve Kubernetes service names through proper DNS configuration.
   - Use direct IP address references for critical service endpoints in Prometheus configuration.

#### 3.2.5 Liongard CMDB Integration

Liongard integrates with the RKE2 cluster through:

1. **Kubernetes Inspector**:
   - Utilizes a dedicated read-only ServiceAccount with ClusterRole binding.
   - Inspects cluster configuration, versions, and component health.

2. **SSL Certificate Inspector**:
   - Monitors certificate validity and expiration for ingress resources.
   - Sends alerts for certificates approaching expiration.

3. **Network Configuration Inspector**:
   - Tracks network policies and ingress configurations.
   - Documents changes to network topology and security.

### 3.3 Implementation Steps

1. **Create Monitoring Namespace**:

   ```bash
   kubectl create namespace monitoring
   ```

2. **Deploy Prometheus Operator CRDs**:

   ```bash
   # Apply custom resource definitions
   kubectl apply -f prometheus-operator-crds.yaml
   ```

3. **Set Up Node Exporter**:

   ```bash
   # Deploy Node Exporter DaemonSet
   kubectl apply -f node-exporter.yaml -n monitoring
   
   # Create service for Node Exporter
   kubectl apply -f node-exporter-service.yaml -n monitoring
   
   # Apply ServiceMonitor for Node Exporter
   kubectl apply -f node-exporter-servicemonitor.yaml -n monitoring
   ```

4. **Deploy kube-state-metrics**:

   ```bash
   # Deploy kube-state-metrics
   kubectl apply -f kube-state-metrics.yaml -n monitoring
   
   # Create service for kube-state-metrics
   kubectl apply -f kube-state-metrics-service.yaml -n monitoring
   
   # Apply ServiceMonitor for kube-state-metrics
   kubectl apply -f kube-state-metrics-servicemonitor.yaml -n monitoring
   ```

5. **Configure Liongard Integration**:

   ```bash
   # Create dedicated service account for Liongard
   kubectl apply -f liongard-serviceaccount.yaml
   
   # Apply ClusterRole and binding
   kubectl apply -f liongard-rbac.yaml
   
   # Generate and retrieve token for Liongard configuration
   kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep liongard | awk '{print $1}')
   ```

6. **Verify Metric Endpoints**:

   ```bash
   # Check if metrics are exposed properly
   curl http://NODE_IP:9100/metrics | head
   
   # Verify kube-state-metrics
   kubectl port-forward svc/kube-state-metrics 8080:8080 -n monitoring
   curl http://localhost:8080/metrics | head
   ```

7. **Configure lab-mon01 Prometheus**:
   - Update the Prometheus configuration on lab-mon01 to include the RKE2 cluster targets.
   - Implement proper job naming and labeling to identify RKE2 cluster metrics.

## 4. Management & Operations

This section covers operational procedures, troubleshooting guidance, and monitoring practices for the RKE2 cluster exporters.

### 4.1 Routine Procedures

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Metric Availability Verification | Daily | Operations Team | [Metric Verification Procedure](../../../procedures/metric-verification.md) |
| Exporter Version Updates | Quarterly | Infrastructure Team | [Exporter Update Procedure](../../../procedures/exporter-update.md) |
| Liongard Inspector Verification | Weekly | Operations Team | [CMDB Verification](../../../procedures/cmdb-verification.md) |
| Network Path Testing | Monthly | Infrastructure Team | [Network Path Verification](../../../procedures/network-path-verification.md) |
| Resource Usage Optimization | Quarterly | Infrastructure Team | [Exporter Resource Optimization](../../../procedures/exporter-resource-optimization.md) |

The table above outlines routine procedures that must be performed to maintain monitoring effectiveness and data reliability.

### 4.2 Troubleshooting

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Missing Node Metrics | Node Exporter pod failure | Check DaemonSet status and logs | [Node Exporter Troubleshooting](../../../troubleshooting/node-exporter-issues.md) |
| Missing Kubernetes Object Metrics | kube-state-metrics failure | Verify deployment status and connectivity | [KSM Troubleshooting](../../../troubleshooting/kube-state-metrics-issues.md) |
| Prometheus Target Down | Network connectivity issues | Check firewall rules and network paths | [Prometheus Target Troubleshooting](../../../troubleshooting/prometheus-target-issues.md) |
| Liongard Integration Failure | RBAC or connectivity issues | Verify service account permissions and credentials | [Liongard Integration Troubleshooting](../../../troubleshooting/liongard-integration-issues.md) |
| High Cardinality Metrics | Poorly configured custom exporters | Optimize labels and filtering | [Metric Cardinality Troubleshooting](../../../troubleshooting/metric-cardinality-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

### 4.3 Monitoring & Metrics

Key metrics to monitor regarding the exporter infrastructure itself:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| node_exporter_up | 1 (all nodes reporting) | Any value of 0 for >5 min | [Exporter Health Dashboard](http://lab-mon01:3000/d/exporter-health) |
| kube_state_metrics_up | 1 | 0 for >5 min | [KSM Health Dashboard](http://lab-mon01:3000/d/ksm-health) |
| scrape_duration_seconds | <1s per target | >2s for any target | [Scrape Performance Dashboard](http://lab-mon01:3000/d/scrape-performance) |
| network_receive_errors_total | Near 0 | >10/min rate | [Network Health Dashboard](http://lab-mon01:3000/d/network-health) |
| kube_pod_container_resource_usage | <80% of requests | >90% of requests | [Resource Usage Dashboard](http://lab-mon01:3000/d/resource-usage) |

The metrics table above defines key performance indicators for monitoring the health of the exporters themselves, separate from the cluster metrics they collect.

## 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met for the RKE2 cluster monitoring components.

### 5.1 Security Controls

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Access Control | Read-only RBAC for monitoring accounts | Regular RBAC audits | CIS.5.1 |
| Network Security | Firewall rules limiting metric exposure | Network scanning | CIS.4.8 |
| Resource Isolation | Dedicated monitoring namespace | Namespace inspection | CIS.5.7 |
| Minimal Permissions | Least privilege service accounts | RBAC review | CIS.5.1.5 |
| Secure Configuration | Hardened exporter configurations | Configuration scanning | CIS.5.2 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

### 5.2 CISv8.1 Compliance Mapping

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.8.2 | Collect audit information | Monitoring metrics | Compliant |
| CIS.8.5 | Collect detailed audit logs | kube-state-metrics data | Compliant |
| CIS.8.11 | Collect service account activity | API server metrics | Compliant |
| CIS.12.1 | Maintain network infrastructure | Network path monitoring | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

### 5.3 Related Framework Mappings

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.8.2 | A.12.4.1 | PR.PT-1 | Metric collection and logging |
| CIS.8.5 | A.16.1.2 | DE.CM-1 | Detailed monitoring data collection |
| CIS.8.11 | A.12.4.3 | PR.PT-1 | Service account activity monitoring |
| CIS.12.1 | A.13.1.1 | PR.DS-5 | Network infrastructure monitoring |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 6. Backup & Recovery

This section documents data protection measures and recovery procedures for the monitoring components.

### 6.1 Backup Procedure

| **Aspect** | **Details** |
|------------|------------|
| **Configuration Backup** | All exporter configurations stored in Git repository |
| **Backup Method** | GitOps workflow with version control |
| **Retention Policy** | Indefinite version history in Git |
| **Backup Location** | Infrastructure repository with off-site replication |
| **Verification Process** | Automated CI/CD testing of configurations |

The backup details table above documents critical information about configuration protection measures, ensuring resilience and recoverability.

### 6.2 Recovery Procedure

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| Node Exporter Failure | 15 min | 0 | Redeploy DaemonSet from Git | Infrastructure Team |
| kube-state-metrics Failure | 15 min | 0 | Redeploy from Git configuration | Infrastructure Team |
| ServiceMonitor Misconfiguration | 30 min | 0 | Restore previous configuration from Git | Infrastructure Team |
| Complete Monitoring Loss | 60 min | 0 | Follow [Monitoring Recovery](../../../disaster-recovery/monitoring-recovery.md) | Infrastructure Team |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

## 7. References & Related Resources

This section provides links to related documentation and external resources.

### 7.1 Internal References

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Service | Central Monitoring Stack | [lab-mon01 Documentation](../../../monitoring/central-monitoring-stack.md) | Main monitoring server |
| Infrastructure | RKE2 Cluster Configuration | [RKE2 Config](../../01-rke2-cluster-overview.md) | Target environment |
| Network | Monitoring Network Configuration | [Monitoring Network](../../../infrastructure/monitoring-network.md) | Network paths for metrics |
| Procedure | Metric Collection Process | [Metric Collection](../../../procedures/metric-collection.md) | Operational process |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

### 7.2 External References

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Prometheus Operator | [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) | [Archived Copy](../../../references/archived/prometheus-operator-docs-2025-01.pdf) | 2025-04-01 |
| Node Exporter | [Node Exporter](https://github.com/prometheus/node_exporter) | [Archived Copy](../../../references/archived/node-exporter-docs-2025-01.pdf) | 2025-04-01 |
| kube-state-metrics | [KSM Documentation](https://github.com/kubernetes/kube-state-metrics) | [Archived Copy](../../../references/archived/ksm-docs-2025-01.pdf) | 2025-04-01 |
| Liongard Kubernetes Inspector | [Liongard Docs](https://docs.liongard.com/docs) | [Archived Copy](../../../references/archived/liongard-k8s-inspector-2025-01.pdf) | 2025-03-15 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

### 7.3 Change Request References

| **Change ID** | **Description** | **Implementation Date** | **GLPI Link** |
|--------------|----------------|------------------------|---------------|
| CR-2025-064 | Initial exporters deployment | 2025-03-15 | [GLPI-1264](http://glpi.lab/ticket/1264) |
| CR-2025-072 | ServiceMonitor optimization | 2025-04-05 | [GLPI-1272](http://glpi.lab/ticket/1272) |
| CR-2025-079 | Liongard integration | 2025-04-16 | [GLPI-1279](http://glpi.lab/ticket/1279) |

The change request table above tracks formal changes that have affected this system, supporting troubleshooting and audit activities.

## 8. Approval & Review

This section documents the formal review and approval process for this document.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |
| SecurityAdmin | Security Officer | 2025-04-20 | ✅ Approved |
| OpsManager | Operations Manager | 2025-04-19 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

## 9. Change Log

This section tracks the document's revision history.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.

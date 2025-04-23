<!-- 
---
title: "Networking Configuration in RKE2 Kubernetes Cluster"
description: "Comprehensive documentation of networking architecture, Traefik ingress, Canal CNI, and network security implementation in the Proxmox Astronomy Lab's Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "networking", "traefik", "canal", "ingress", "load-balancing", "infrastructure", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Network Infrastructure", "Proxmox", "Security"]
implements_policies: ["Infrastructure Security Policy", "Network Security Policy"]
phase: "phase-3"
cis_controls: ["CIS.9.1", "CIS.9.2", "CIS.12.1", "CIS.12.3"]
iso27001_controls: ["A.13.1.1", "A.13.1.3", "A.14.1.3"]
nist_controls: ["SC-7", "SC-8", "AC-4", "CM-7"]
---
-->

# Networking Configuration in RKE2 Kubernetes Cluster

This document provides comprehensive information about the networking architecture and configuration implemented in the RKE2 Kubernetes cluster within the Proxmox Astronomy Lab. It details the CNI implementation, ingress controllers, network policies, and related networking components that enable secure and efficient communication within the cluster.

# 1. Overview

This section establishes the foundational context for the Kubernetes networking architecture, explaining its purpose within the broader infrastructure and how it supports application connectivity, security, and exposure in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why the networking configuration exists, what problems it addresses, and what value it delivers to the organization and its research activities.

The Kubernetes networking infrastructure provides secure, isolated, and resilient network connectivity for containerized applications in the Proxmox Astronomy Lab. It ensures proper pod-to-pod communication, controlled external access to services, and network security enforcement to protect sensitive research workloads and data processing pipelines.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| Canal CNI configuration | Physical network infrastructure |
| Traefik ingress controller | External DNS configuration |
| Network policies | Application-specific networking |
| Service mesh capabilities | VPN and external connectivity |
| Load balancing (MetalLB) | WAN optimization |
| Certificate management | Network monitoring tools |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and network engineers managing the Kubernetes network
- **Secondary**: DevOps engineers deploying applications that require network connectivity
- **Tertiary**: Security personnel assessing network controls and isolation
- **Expected Knowledge**: Basic understanding of Kubernetes concepts, TCP/IP networking, and security principles

# 2. Dependencies & Relationships

This section maps how the networking configuration relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the networking configuration, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The underlying Kubernetes platform
- [Node Configuration](02-node-configuration.md) - The base VM networking settings
- [Security & Compliance](05-security-compliance.md) - Network security controls and auditing
- [Load Balancer Configuration](../service-docs/metallb.md) - MetalLB load balancer service
- [DNS Configuration](../infrastructure/internal-dns.md) - Name resolution for services

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Infrastructure Security Policy](../compliance-security/policies/infrastructure-security-policy.md) - Through network segmentation and access controls
- [Network Security Policy](../compliance-security/policies/network-security-policy.md) - Through implementation of network policies and secure communication
- [Data Protection Policy](../compliance-security/policies/data-protection-policy.md) - Through TLS encryption of network traffic

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the networking configuration, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Security Admin** | **Network Engineer** | **Application Owner** |
|--------------|-------------------|-------------------|--------------|----------------|
| CNI Configuration | R/A | C | C | I |
| Ingress Management | R/A | C | C | I |
| Certificate Rotation | R/A | C | I | I |
| Network Policy Design | C | R/A | C | I |
| Service Exposure | C | C | I | R/A |
| Performance Tuning | R/A | I | C | I |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the networking configuration. It serves as the authoritative technical reference for the Kubernetes networking architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the networking configuration implementation.

The RKE2 Kubernetes cluster networking architecture is built around the Canal CNI plugin for pod networking, Traefik v3 for ingress control, and MetalLB for service load balancing (configured but currently disabled). The architecture provides secure, isolated networking for containerized workloads with controlled external access.

Key components include:

- **Canal CNI**: Combined Calico and Flannel implementation for pod networking
  - Network CIDR: 10.42.0.0/16 (pods)
  - Service CIDR: 10.43.0.0/16 (services)
  - Backend: VXLAN encapsulation

- **Traefik v3 Ingress Controller**:
  - Deployed via Helm chart
  - Configured with hostNetwork: true for direct access
  - TLS termination using wildcard certificates
  - Metrics exposed on port 9111

- **MetalLB Load Balancer**:
  - Deployed but currently disabled
  - Assigned address pool: 10.25.10.30-10.25.10.35
  - Layer 2 mode configured for simplicity

- **Network Policies**:
  - Default deny-all policy in production namespaces
  - Explicit allow rules for required communication
  - Egress limiting where appropriate

- **cert-manager**:
  - Manages TLS certificates for ingress endpoints
  - Configured with DNS01 challenge for wildcard certificates
  - Integrated with Cloudflare for DNS validation

This architecture ensures secure pod-to-pod communication, controlled external access, and proper network isolation between different workloads and namespaces.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the networking configuration.

The Kubernetes networking components are configured through a combination of RKE2 configuration files, Helm charts, and Kubernetes manifests. Key configuration details include:

**Canal CNI Configuration**

```yaml
# From RKE2 config.yaml
cni: canal
flannel-backend: vxlan
cluster-cidr: 10.42.0.0/16
service-cidr: 10.43.0.0/16
```

**Traefik Helm Values**

```yaml
# infrastructure/k8s-rancher-rke2/helm/traefik-values.yaml
deployment:
  kind: Deployment
  replicas: 2

ingressClass:
  enabled: true
  isDefaultClass: true

ingressRoute:
  dashboard:
    enabled: false

providers:
  kubernetesCRD:
    enabled: true
    allowCrossNamespace: true
  kubernetesIngress:
    enabled: true
    allowExternalNameServices: true

ports:
  web:
    port: 80
    hostPort: 80
  websecure:
    port: 443
    hostPort: 443
  metrics:
    port: 9111
    expose: true
    exposedPort: 9111

logs:
  general:
    level: INFO
  access:
    enabled: true

hostNetwork: true

tls:
  certificatesResolvers:
    letsencrypt:
      dnsChallenge:
        provider: cloudflare
        resolvers:
          - "1.1.1.1:53"
          - "8.8.8.8:53"
```

**MetalLB Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/manifests/metallb-config.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 10.25.10.30-10.25.10.35

---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2-advert
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
```

**Default Network Policy**

```yaml
# Applied to each namespace by default
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the networking configuration was implemented, including verification steps and expected outcomes.

The networking infrastructure was implemented following this sequence:

1. **CNI Configuration**
   - Applied Canal CNI via RKE2 configuration:

     ```bash
     # Applied in /etc/rancher/rke2/config.yaml
     cni: canal
     flannel-backend: vxlan
     ```

   - Verified CNI with test pods to confirm network connectivity

2. **Traefik Deployment**
   - Added the Traefik Helm repository:

     ```bash
     helm repo add traefik https://helm.traefik.io/traefik
     helm repo update
     ```

   - Deployed Traefik using custom values:

     ```bash
     helm install traefik traefik/traefik \
       -n traefik --create-namespace \
       -f infrastructure/k8s-rancher-rke2/helm/traefik-values.yaml
     ```

   - Verified ingress controller functionality with test services

3. **cert-manager Deployment**
   - Deployed cert-manager via Helm:

     ```bash
     helm install cert-manager jetstack/cert-manager \
       --namespace cert-manager --create-namespace \
       --set installCRDs=true
     ```

   - Created ClusterIssuer for Cloudflare DNS01 challenges
   - Verified certificate issuance with test ingress

4. **MetalLB Deployment**
   - Deployed MetalLB via manifest:

     ```bash
     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml
     ```

   - Applied address pool configuration:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/metallb-config.yaml
     ```

   - Configured but left disabled until needed

5. **Network Policy Implementation**
   - Created default deny-all policies for each namespace
   - Implemented specific allow policies for required communication
   - Tested policy enforcement with connectivity checks

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the networking configuration. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the networking infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Certificate Renewal Check | Monthly | Infrastructure Admin | [Certificate Management Procedure](../procedures/certificate-management.md) |
| Traefik Updates | Quarterly | Infrastructure Admin | [Traefik Update Procedure](../procedures/traefik-update.md) |
| Network Policy Audit | Quarterly | Security Admin | [Network Policy Audit Procedure](../procedures/network-policy-audit.md) |
| CNI Health Check | Weekly | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |
| Load Balancer Failover Test | Semi-annually | Infrastructure Admin | [Load Balancer Failover Procedure](../procedures/load-balancer-failover.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and performance, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the networking configuration, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Pod-to-pod connectivity issues | CNI configuration or Network Policy | Check Canal CNI pods in kube-system namespace, review Network Policies | [Pod Network Troubleshooting](../troubleshooting/pod-network-issues.md) |
| Ingress not working | Traefik configuration or certificate issues | Verify Traefik pods, check certificate status, review ingress resources | [Ingress Troubleshooting](../troubleshooting/ingress-issues.md) |
| Certificate errors | cert-manager or DNS validation issues | Check cert-manager logs, verify DNS records, check Cloudflare API access | [Certificate Troubleshooting](../troubleshooting/certificate-issues.md) |
| Service exposure failures | MetalLB configuration | Verify MetalLB pods, check IP address pool configuration | [Load Balancer Troubleshooting](../troubleshooting/load-balancer-issues.md) |
| Network policy blocking legitimate traffic | Overly restrictive policies | Review and adjust network policies, use network policy analyzer | [Network Policy Troubleshooting](../troubleshooting/network-policy-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the networking configuration should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The networking components are monitored using Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Traefik Request Rate | 0-500 req/min | >1000 req/min for >5 min | [Traefik Dashboard](http://grafana.lab.internal/d/traefik) |
| Traefik Error Rate | 0-1% | >5% for >5 min | [Traefik Errors Dashboard](http://grafana.lab.internal/d/traefik-errors) |
| Traefik Latency | <100ms | >500ms for >5 min | [Traefik Performance Dashboard](http://grafana.lab.internal/d/traefik-performance) |
| CNI Pod Connectivity | 100% success | <95% success for >5 min | [CNI Health Dashboard](http://grafana.lab.internal/d/cni-health) |
| Certificate Expiry | >14 days | <7 days | [Certificate Dashboard](http://grafana.lab.internal/d/certificates) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure networking health and performance.

Additionally, the following network-specific metrics are collected:

- DNS resolution time
- Pod network throughput
- Network policy hit rates
- Load balancer connection states
- TLS handshake times

# 5. Security & Compliance

This section documents how security controls are implemented in the networking configuration and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

The RKE2 cluster networking infrastructure is secured according to security best practices with a focus on isolation, encryption, and least-privilege access. The implementation aligns with CIS Kubernetes Security Benchmark recommendations.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the networking configuration, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Network Segmentation | Network policies by namespace | Validation scripts, manual testing | CIS.12.1, NIST SC-7 |
| Encryption in Transit | TLS for ingress, service mesh | TLS certificate verification | CIS.14.4, NIST SC-8 |
| API Server Network Restriction | Firewall rules, admin CIDR | Connection testing, log review | CIS.1.2, NIST AC-3 |
| Network Policy Enforcement | Default deny-all, explicit allow | Connectivity testing between namespaces | CIS.12.3, NIST AC-4 |
| Ingress Access Control | Traefik middleware, IP whitelisting | Test requests from different sources | CIS.12.6, NIST AC-17 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps networking configuration implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.9.1 | Encrypted network traffic using TLS | Certificate configurations | Compliant |
| CIS.9.2 | Transport encryption for all control plane traffic | RKE2 config.yaml | Compliant |
| CIS.12.1 | Network boundary protection via CNI | NetworkPolicy resources | Compliant |
| CIS.12.3 | Deny by default, allow by exception | Default NetworkPolicy | Compliant |
| CIS.12.6 | Network traffic filtering between domains | Namespace isolation policies | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.9.1 | A.13.2.1 | PR.DS-2 | TLS encryption for all traffic |
| CIS.9.2 | A.14.1.3 | PR.DS-2 | Control plane encryption |
| CIS.12.1 | A.13.1.1 | PR.AC-5 | Network boundary definition and protection |
| CIS.12.3 | A.13.1.3 | PR.PT-4 | Default denial of network traffic |
| CIS.12.6 | A.13.1.3 | PR.AC-5 | Domain-based network filtering |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the networking configuration.

The networking infrastructure has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to services via ingress
   - **Mitigation**: TLS certification, IP whitelisting, and authentication middleware
   - **Residual Risk**: Low - Requires valid credentials and authorized source IP

2. **Risk**: Pod-to-pod lateral movement after compromise
   - **Mitigation**: Default deny network policies, namespace isolation
   - **Residual Risk**: Medium - Some legitimate cross-namespace communication exists

3. **Risk**: TLS certificate compromise or expiration
   - **Mitigation**: Automated rotation via cert-manager, short-lived certificates
   - **Residual Risk**: Low - Monitoring alerts warn before expiration

4. **Risk**: DNS poisoning or spoofing attacks
   - **Mitigation**: DNS security extensions, internal DNS control
   - **Residual Risk**: Low - Limited external DNS dependency

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all networking components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the networking configuration. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Networking configurations: Daily at 01:00 UTC, Certificates: Daily at 01:30 UTC |
| **Backup Method** | GitOps repository for configurations, Kubernetes resource backups via Velero |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

Networking-specific considerations:

- CNI configuration is captured in RKE2 configuration backups
- Traefik and cert-manager configurations are stored in Git and included in configuration backups
- TLS certificates are backed up as Kubernetes secrets
- Network policies are version-controlled in Git

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| CNI Failure | 30 minutes | 24 hours | Restore CNI configuration, restart Canal pods | Infrastructure Admin |
| Traefik Ingress Failure | 15 minutes | 0 data loss | Redeploy Traefik via Helm using backed up values | Infrastructure Admin |
| Certificate Loss | 30 minutes | 24 hours | Restore certificate secrets, trigger re-issuance | Infrastructure Admin |
| Network Policy Corruption | 15 minutes | 0 data loss | Reapply policies from Git repository | Infrastructure Admin |
| Complete Networking Stack Failure | 60 minutes | 24 hours | Restore CNI, deploy ingress, reapply policies | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the networking configuration, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Technical | Node Configuration | [02-node-configuration.md](02-node-configuration.md) | Base VM network settings |
| Technical | Security & Compliance | [05-security-compliance.md](05-security-compliance.md) | Security controls |
| Service | Traefik Configuration | [../service-docs/traefik-ingress.md](../service-docs/traefik-ingress.md) | Ingress controller details |
| Service | cert-manager Configuration | [../service-docs/cert-manager.md](../service-docs/cert-manager.md) | Certificate management details |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the networking configuration.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| Canal CNI Documentation | <https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel> | [canal-docs-2025-04.pdf](../archive/canal-docs-2025-04.pdf) | 2025-04-01 |
| Traefik Documentation | <https://doc.traefik.io/traefik/> | [traefik-docs-2025-04.pdf](../archive/traefik-docs-2025-04.pdf) | 2025-04-01 |
| Kubernetes Network Policies | <https://kubernetes.io/docs/concepts/services-networking/network-policies/> | [k8s-netpol-docs-2025-04.pdf](../archive/k8s-netpol-docs-2025-04.pdf) | 2025-04-01 |
| MetalLB Documentation | <https://metallb.universe.tf/> | [metallb-docs-2025-03.pdf](../archive/metallb-docs-2025-03.pdf) | 2025-03-15 |
| cert-manager Documentation | <https://cert-manager.io/docs/> | [cert-manager-docs-2025-03.pdf](../archive/cert-manager-docs-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the networking configuration, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-042 | Initial RKE2 CNI configuration | 2025-04-10 |
| CR-2025-054 | Deployed Traefik and cert-manager | 2025-04-20 |
| CR-2025-055 | Implemented default network policies | 2025-04-21 |
| CR-2025-056 | Configured MetalLB (disabled) | 2025-04-21 |

The change request table above tracks formal changes that have affected the networking configuration, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the networking configuration documentation. It ensures accountability and tracks who has verified the accuracy of the content.

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-21 | ✅ Approved |

The approval and review table above documents who has verified the accuracy of this document and when, establishing accountability and ensuring quality.

# 9. Change Log

This section tracks the document's revision history. It provides transparency into how the document has evolved over time and who made the changes.

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-21 | Initial version | VintageDon |

The change log table above provides a comprehensive history of document revisions, supporting version control and auditing requirements.

<!-- 
---
title: "Security & Compliance in RKE2 Kubernetes Cluster"
description: "Comprehensive documentation of security controls, compliance frameworks, and hardening practices implemented in the Proxmox Astronomy Lab's RKE2 Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "security", "compliance", "hardening", "cis", "infrastructure", "phase-3"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Security Management", "Compliance", "Audit"]
implements_policies: ["Infrastructure Security Policy", "Data Protection Policy", "Access Control Policy"]
phase: "phase-3"
cis_controls: ["CIS.5.1", "CIS.6.1", "CIS.9.2", "CIS.14.1"]
iso27001_controls: ["A.9.4", "A.12.6", "A.13.1", "A.14.2"]
nist_controls: ["AC-3", "CM-6", "SC-7", "SC-8"]
---
-->

# Security & Compliance in RKE2 Kubernetes Cluster

This document provides comprehensive information about the security controls, compliance frameworks, and hardening practices implemented in the RKE2 Kubernetes cluster within the Proxmox Astronomy Lab. It details the technical measures, policy implementations, and audit procedures that ensure the cluster meets security requirements and compliance standards.

# 1. Overview

This section establishes the foundational context for the Kubernetes security architecture, explaining the security principles, compliance requirements, and threat model that drive the security implementation in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why security and compliance controls exist, what problems they address, and what value they deliver to the organization and its research activities.

The RKE2 cluster security and compliance framework establishes a robust security posture that protects the integrity, confidentiality, and availability of research data and applications. It implements defense-in-depth principles to mitigate risks, demonstrates adherence to industry standards, and provides a verifiable security baseline that enables both internal governance and external collaboration with confidence in the system's security.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| RKE2 cluster security controls | Physical security measures |
| Kubernetes security hardening | Host-level security details |
| CIS and NIST compliance mapping | Detailed security policies |
| Network security controls | External network security |
| Access control implementation | Authentication system design |
| Audit and logging configuration | Detailed SIEM integration |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Security administrators and compliance officers
- **Secondary**: Infrastructure administrators and Kubernetes operators
- **Tertiary**: Auditors and security assessors
- **Expected Knowledge**: Basic understanding of Kubernetes architecture, security concepts, and compliance frameworks

# 2. Dependencies & Relationships

This section maps how the security and compliance configuration relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with the security and compliance configuration, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](01-rke2-cluster-overview.md) - The overall Kubernetes architecture
- [Node Configuration](02-node-configuration.md) - Secure node provisioning and hardening
- [Networking Configuration](03-networking.md) - Network security controls and policies
- [Storage Configuration](04-storage.md) - Data protection and encryption
- [Wazuh SIEM Integration](../security/wazuh-integration.md) - Security monitoring and alerting

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Infrastructure Security Policy](../compliance-security/policies/infrastructure-security-policy.md) - Through secure cluster configuration
- [Data Protection Policy](../compliance-security/policies/data-protection-policy.md) - Through data isolation and encryption
- [Access Control Policy](../compliance-security/policies/access-control-policy.md) - Through RBAC and authentication controls
- [Audit Policy](../compliance-security/policies/audit-policy.md) - Through logging and monitoring

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to the security and compliance configuration, ensuring clear ownership and communication paths.

| **Activity** | **Security Admin** | **Infrastructure Admin** | **Compliance Officer** | **Application Owner** |
|--------------|-------------------|-------------------|--------------|----------------|
| Security Control Implementation | R/A | C | C | I |
| Compliance Verification | C | I | R/A | I |
| Vulnerability Management | R/A | C | I | C |
| Audit Log Review | R/A | C | C | I |
| Security Incident Response | R/A | C | C | C |
| Penetration Testing | R/A | C | I | I |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting the security and compliance configuration. It serves as the authoritative technical reference for the Kubernetes security architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the security and compliance implementation.

The RKE2 Kubernetes cluster security architecture is built around a defense-in-depth approach with multiple security layers protecting infrastructure, network, application, and data components. Security is implemented at each layer of the stack, from the operating system to the application level.

The security architecture includes:

**Base Infrastructure Security**:

- CIS-hardened Ubuntu 24.04 LTS operating system (Level 2) for all nodes
- LUKS-encrypted system volumes for data at rest protection
- Minimized attack surface with essential services only

**Kubernetes Platform Security**:

- RKE2 security-focused Kubernetes distribution with hardened defaults
- Integrated etcd encryption for sensitive data
- Secure TLS communication for all cluster components
- API server authorization mode set to RBAC, Node, ABAC

**Network Security**:

- Network policies enforcing micro-segmentation
- Egress filtering to control outbound traffic
- TLS termination and certificate management via cert-manager
- Private cluster with no direct external access

**Workload Security**:

- Pod Security Standards enforced at namespace level
- Container image scanning and policy enforcement
- Resource isolation and quotas
- Seccomp and AppArmor profiles for container hardening

**Access Control**:

- RBAC with least privilege access model
- Token-based authentication with short-lived credentials
- Service account limitations and token automounting disabled
- Namespace isolation for multi-tenancy

**Audit & Monitoring**:

- Comprehensive API server audit logging
- Node-level security event monitoring
- Workload activity monitoring and anomaly detection
- Integration with Wazuh SIEM for security event management

This multi-layered approach ensures that a compromise of a single layer does not result in a complete security breach, with each layer providing distinct security controls and monitoring capabilities.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing the security and compliance configuration.

The security and compliance components are configured through a combination of RKE2 settings, Kubernetes resources, and infrastructure controls. Key configuration details include:

**API Server Security Configuration**

```yaml
# /etc/rancher/rke2/config.yaml (Control Plane Nodes)
kube-apiserver-arg:
  - "authorization-mode=Node,RBAC"
  - "enable-admission-plugins=NodeRestriction,PodSecurityPolicy,AlwaysPullImages"
  - "audit-log-path=/var/lib/rancher/rke2/server/logs/audit.log"
  - "audit-log-maxage=30"
  - "audit-log-maxbackup=10"
  - "audit-log-maxsize=100"
  - "audit-policy-file=/etc/rancher/rke2/audit-policy.yaml"
  - "encryption-provider-config=/etc/rancher/rke2/encryption-config.yaml"
  - "tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305"
```

**Audit Policy Configuration**

```yaml
# /etc/rancher/rke2/audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  # Log pod changes at RequestResponse level
  - level: RequestResponse
    resources:
    - group: ""
      resources: ["pods"]
  # Log "pods/exec", "pods/portforward", "pods/proxy" at Metadata level
  - level: Metadata
    resources:
    - group: ""
      resources: ["pods/exec", "pods/portforward", "pods/proxy"]
  # Don't log requests to certain non-resource URL paths
  - level: None
    nonResourceURLs:
    - "/healthz*"
    - "/metrics"
    - "/swagger*"
    - "/version"
  # Log everything else at Metadata level
  - level: Metadata
    omitStages:
    - "RequestReceived"
```

**Encryption Configuration**

```yaml
# /etc/rancher/rke2/encryption-config.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <redacted>
      - identity: {}
```

**Default Pod Security Standards**

```yaml
# Applied to namespaces
apiVersion: v1
kind: Namespace
metadata:
  name: application-namespace
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

**Network Policy Example**

```yaml
# Default deny all ingress and egress traffic
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: application-namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

**RBAC Configuration Example**

```yaml
# Minimal role for application namespace
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: application-namespace
  name: application-role
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list"]
```

**Container Security Context Example**

```yaml
# Security context for pods
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 1000
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    drop:
    - ALL
  readOnlyRootFilesystem: true
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how the security and compliance configuration was implemented, including verification steps and expected outcomes.

The security and compliance framework was implemented following this sequence:

1. **Operating System Hardening**
   - Applied CIS Level 2 hardening to Ubuntu 24.04 LTS base image
   - Implemented LUKS encryption for system volumes
   - Configured host-based firewall (ufw) on all nodes
   - Verified hardening with Lynis security scanning:

     ```bash
     lynis audit system --log-file lynis-audit.log
     ```

2. **RKE2 Secure Installation**
   - Installed RKE2 with security-focused configuration:

     ```bash
     curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server sh -
     ```

   - Applied hardened API server configuration:

     ```bash
     mkdir -p /etc/rancher/rke2/
     cp secure-config.yaml /etc/rancher/rke2/config.yaml
     ```

   - Configured audit logging and encryption:

     ```bash
     cp audit-policy.yaml /etc/rancher/rke2/
     cp encryption-config.yaml /etc/rancher/rke2/
     ```

   - Enabled and started the RKE2 server service:

     ```bash
     systemctl enable rke2-server.service
     systemctl start rke2-server.service
     ```

3. **Network Security Implementation**
   - Deployed Canal CNI with network policy enforcement:

     ```bash
     # Included in RKE2 installation
     ```

   - Applied default deny network policies to all namespaces:

     ```bash
     kubectl apply -f network-policies/default-deny.yaml
     ```

   - Deployed Traefik with TLS configuration:

     ```bash
     helm install traefik traefik/traefik \
       -n traefik --create-namespace \
       -f infrastructure/k8s-rancher-rke2/helm/traefik-values.yaml
     ```

   - Deployed cert-manager for certificate management:

     ```bash
     helm install cert-manager jetstack/cert-manager \
       --namespace cert-manager --create-namespace \
       --set installCRDs=true
     ```

4. **Access Control Configuration**
   - Implemented RBAC roles and bindings:

     ```bash
     kubectl apply -f rbac/default-roles.yaml
     ```

   - Configured service account limitations:

     ```bash
     kubectl apply -f rbac/service-account-limits.yaml
     ```

   - Applied namespace isolation:

     ```bash
     kubectl apply -f namespaces/pod-security-standards.yaml
     ```

5. **Monitoring & Logging Setup**
   - Deployed Prometheus and Grafana for monitoring:

     ```bash
     helm install prometheus prometheus-community/prometheus \
       -n monitoring --create-namespace \
       -f monitoring/prometheus-values.yaml
     ```

   - Configured centralized logging with Loki:

     ```bash
     helm install loki grafana/loki-stack \
       -n monitoring \
       -f monitoring/loki-values.yaml
     ```

   - Integrated with Wazuh SIEM:

     ```bash
     kubectl apply -f security/wazuh-agents.yaml
     ```

6. **Security Validation & Testing**
   - Ran CIS Kubernetes benchmark:

     ```bash
     kube-bench --config-dir /path/to/rke2-cis-config
     ```

   - Performed penetration testing and vulnerability scanning
   - Verified audit logging functionality:

     ```bash
     kubectl get pods --as=system:serviceaccount:default:default
     # Check audit logs for this request
     ```

   - Tested network policy enforcement:

     ```bash
     # Deploy test pods to verify isolation
     kubectl apply -f security/network-policy-tests.yaml
     ```

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for the security and compliance configuration. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep the security and compliance infrastructure functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| CIS Benchmark Scan | Monthly | Security Admin | [CIS Benchmark Procedure](../procedures/cis-benchmark-scan.md) |
| Audit Log Review | Weekly | Security Admin | [Audit Log Review Procedure](../procedures/audit-log-review.md) |
| Vulnerability Scanning | Biweekly | Security Admin | [Vulnerability Scanning Procedure](../procedures/vulnerability-scanning.md) |
| Certificate Rotation | Quarterly | Infrastructure Admin | [Certificate Rotation Procedure](../procedures/certificate-rotation.md) |
| Security Patch Application | Monthly | Infrastructure Admin | [Security Patching Procedure](../procedures/security-patching.md) |
| Policy Compliance Review | Quarterly | Compliance Officer | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |

The table above outlines routine procedures that must be performed to maintain operational stability and security, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with the security and compliance configuration, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| API server permission denied | RBAC configuration or PSP restrictions | Review RBAC roles and bindings, check Pod Security Standards, verify service account | [RBAC Troubleshooting](../troubleshooting/rbac-issues.md) |
| Network policy blocking legitimate traffic | Overly restrictive network policies | Review and adjust network policies, use network policy analyzer | [Network Policy Troubleshooting](../troubleshooting/network-policy-issues.md) |
| Certificate errors | cert-manager issues or expired certificates | Check cert-manager logs, verify issuer configuration, manually renew if needed | [Certificate Troubleshooting](../troubleshooting/certificate-issues.md) |
| Security context preventing container start | Container running as root or requiring capabilities | Adjust security context to meet Pod Security Standards, rebuild container image if needed | [Security Context Troubleshooting](../troubleshooting/security-context-issues.md) |
| Missing audit logs | Audit configuration issues | Verify audit policy configuration, check log storage, ensure proper log rotation | [Audit Logging Troubleshooting](../troubleshooting/audit-logging-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of the security and compliance configuration should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

The security infrastructure is monitored using Prometheus, Grafana, and Wazuh SIEM deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Failed API Server Authentications | 0-5 per hour | >10 per 10 minutes | [API Security Dashboard](http://grafana.lab.internal/d/api-security) |
| Network Policy Denials | 0-10 per hour | >50 per 10 minutes | [Network Policy Dashboard](http://grafana.lab.internal/d/network-policy) |
| Pod Security Standard Violations | 0 | Any violation | [Pod Security Dashboard](http://grafana.lab.internal/d/pod-security) |
| Certificate Expiry Time | >14 days | <7 days | [Certificate Dashboard](http://grafana.lab.internal/d/certificates) |
| Security Scan Results | 0 critical findings | Any critical finding | [Vulnerability Dashboard](http://grafana.lab.internal/d/vulnerabilities) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure security health and compliance.

Additionally, the following security-specific metrics are collected:

- RBAC access attempts and denials
- Privileged container executions
- Node-level security events
- API server audit log volume
- Security scan findings over time

# 5. Security & Compliance

This section documents how security controls are implemented and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

The RKE2 cluster comes pre-hardened according to security best practices and has been further hardened following the official RKE2 hardening guide at <https://docs.rke2.io/security/hardening_guide> and assessed using the CIS self-assessment guide at <https://docs.rke2.io/security/cis_self_assessment19>.

## 5.1 Security Controls

This subsection documents specific security measures implemented in the RKE2 cluster, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Authentication & Authorization | RBAC with least privilege model | Access review audits, penetration testing | CIS.5.1, NIST AC-3 |
| Network Security | Network policies, TLS encryption | Network testing, TLS validation | CIS.9.2, NIST SC-7 |
| Data Protection | Etcd encryption, secret management | Encryption verification, secret audits | CIS.14.1, NIST SC-28 |
| System Hardening | CIS-hardened OS, container security | CIS benchmark scanning, vulnerability assessments | CIS.4.1, NIST CM-6 |
| Audit & Logging | Comprehensive API server audit logging | Log review, monitoring alerts | CIS.6.1, NIST AU-2 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps RKE2 cluster implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.5.1 | RBAC with least privilege model | RBAC role definitions, role binding audits | Compliant |
| CIS.6.1 | API server audit logging enabled | Audit policy configuration, log storage | Compliant |
| CIS.9.2 | TLS encryption for all internal and external communication | Certificate configurations, cert-manager setup | Compliant |
| CIS.14.1 | Secret encryption at rest in etcd | Encryption configuration, secret verification | Compliant |
| CIS.16.4 | Security monitoring and alerting | Prometheus and Wazuh configurations | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.5.1 | A.9.4 | PR.AC-4 | RBAC with least privilege model |
| CIS.6.1 | A.12.4 | DE.CM-3 | API server audit logging enabled |
| CIS.9.2 | A.13.1 | PR.DS-2 | TLS encryption for all communication |
| CIS.14.1 | A.8.2.3 | PR.DS-1 | Secret encryption at rest in etcd |
| CIS.16.4 | A.12.4.1 | DE.CM-1 | Security monitoring and alerting |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with the RKE2 cluster.

The RKE2 cluster has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Unauthorized access to Kubernetes API
   - **Mitigation**: Multi-layered access controls, RBAC, network policies, and API server hardening
   - **Residual Risk**: Low - Multi-layered controls significantly reduce likelihood

2. **Risk**: Container escape vulnerabilities
   - **Mitigation**: Pod Security Standards, seccomp profiles, AppArmor, minimized capabilities
   - **Residual Risk**: Medium - Zero-day vulnerabilities remain possible

3. **Risk**: Data exfiltration via compromised application
   - **Mitigation**: Network policies, egress filtering, monitoring
   - **Residual Risk**: Medium - Sophisticated attacks may bypass controls

4. **Risk**: Privilege escalation within cluster
   - **Mitigation**: Least privilege RBAC, preventive admission controls, detection monitoring
   - **Residual Risk**: Low - Multiple layers of preventive and detective controls

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all security-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for the security and compliance configuration. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Security configurations: Daily at 01:00 UTC, Audit logs: Daily at 02:00 UTC, etcd data: Every 6 hours |
| **Backup Method** | Configurations: GitOps repository, Audit logs: Log archiving, etcd: Automated snapshots |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

Security-specific considerations:

- Encryption keys are securely backed up with controlled access
- RBAC configurations are version-controlled in Git
- Audit logs are archived to immutable storage
- Security-critical certificates have automated renewal

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| RBAC configuration corruption | 30 minutes | 24 hours | Restore RBAC configurations from Git | Security Admin |
| Security certificate compromise | 60 minutes | 0 data loss | Revoke compromised certificates, issue new certificates | Security Admin |
| Audit log loss | 15 minutes | Varies | Restore from backup, reconfigure audit logging | Security Admin |
| etcd encryption key compromise | 120 minutes | 6 hours | Rotate encryption keys, re-encrypt secrets | Security Admin |
| Complete security configuration loss | 4 hours | 24 hours | Restore from backups, verify security controls | Security Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to the security and compliance configuration, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [01-rke2-cluster-overview.md](01-rke2-cluster-overview.md) | Parent architecture |
| Policy | Infrastructure Security Policy | [../compliance-security/policies/infrastructure-security-policy.md](../compliance-security/policies/infrastructure-security-policy.md) | Governing policy |
| Technical | RBAC Configuration Guide | [../security/rbac-configuration.md](../security/rbac-configuration.md) | Access control details |
| Technical | Network Policy Guide | [../security/network-policy-guide.md](../security/network-policy-guide.md) | Network security details |
| Operational | Security Incident Response | [../procedures/security-incident-response.md](../procedures/security-incident-response.md) | Incident handling |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for the security and compliance configuration.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| RKE2 Hardening Guide | <https://docs.rke2.io/security/hardening_guide> | [rke2-hardening-docs-2025-04.pdf](../archive/rke2-hardening-docs-2025-04.pdf) | 2025-04-01 |
| CIS Kubernetes Benchmark | <https://www.cisecurity.org/benchmark/kubernetes> | [cis-k8s-benchmark-2025-04.pdf](../archive/cis-k8s-benchmark-2025-04.pdf) | 2025-04-01 |
| Kubernetes Security | <https://kubernetes.io/docs/concepts/security/> | [k8s-security-docs-2025-04.pdf](../archive/k8s-security-docs-2025-04.pdf) | 2025-04-01 |
| Network Policy | <https://kubernetes.io/docs/concepts/services-networking/network-policies/> | [k8s-netpol-docs-2025-03.pdf](../archive/k8s-netpol-docs-2025-03.pdf) | 2025-03-15 |
| Pod Security Standards | <https://kubernetes.io/docs/concepts/security/pod-security-standards/> | [k8s-pss-docs-2025-03.pdf](../archive/k8s-pss-docs-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified the security and compliance configuration, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-042 | Initial RKE2 cluster security baseline | 2025-04-10 |
| CR-2025-045 | Enhanced audit logging configuration | 2025-04-14 |
| CR-2025-048 | Implemented Pod Security Standards | 2025-04-16 |
| CR-2025-058 | Integrated with Wazuh SIEM | 2025-04-21 |

The change request table above tracks formal changes that have affected the security and compliance configuration, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the security and compliance configuration documentation. It ensures accountability and tracks who has verified the accuracy of the content.

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

I'll now provide a document for the `service-docs/cert-manager.md` file following the structured format:

<!-- 
---
title: "Certificate Management with cert-manager"
description: "Detailed documentation of cert-manager deployment, configuration, and management for TLS certificates in the Proxmox Astronomy Lab's RKE2 Kubernetes cluster"
author: "VintageDon"
tags: ["kubernetes", "rke2", "cert-manager", "tls", "certificates", "security", "infrastructure", "phase-3"]
kb_type: "Service"
version: "1.0"
status: "Published"
last_updated: "2025-04-21"
related_services: ["Kubernetes", "Traefik Ingress", "Security", "DNS"]
implements_policies: ["Infrastructure Security Policy", "Data Protection Policy", "Certificate Management Policy"]
phase: "phase-3"
cis_controls: ["CIS.9.2", "CIS.14.4", "CIS.16.5"]
iso27001_controls: ["A.14.1.2", "A.14.1.3", "A.18.1.5"]
nist_controls: ["SC-8", "SC-12", "SC-13"]
---
-->

# Certificate Management with cert-manager

This document provides comprehensive information about cert-manager deployed in the RKE2 Kubernetes cluster within the Proxmox Astronomy Lab. It details the architecture, configuration, and operational procedures necessary to manage TLS certificates for securing communications to applications and services running in the Kubernetes environment.

# 1. Overview

This section establishes the foundational context for cert-manager, explaining its purpose within the broader Kubernetes architecture and how it enables automated certificate management in the Proxmox Astronomy Lab.

## 1.1 Purpose

This subsection clearly defines why cert-manager exists, what problems it addresses, and what value it delivers to the organization and its research activities.

cert-manager provides automated management of TLS certificates in the Kubernetes environment, eliminating manual certificate provisioning and renewal. It ensures secure communications for all exposed services, reducing the risk of certificate expiration events while supporting compliance requirements for encrypted data in transit. By automating the certificate lifecycle, cert-manager reduces administrative overhead and eliminates human error in certificate management, directly supporting the lab's security posture.

## 1.2 Scope

This subsection defines the boundaries of what this document covers and explicitly states what is excluded, helping users understand its limitations and appropriate usage.

| **In Scope** | **Out of Scope** |
|--------------|------------------|
| cert-manager deployment architecture | PKI design and CA hierarchies |
| Certificate issuance configuration | DNS provider implementation details |
| ClusterIssuer and Issuer resources | Application-specific certificate usage |
| Certificate renewal automation | Public CA policies and requirements |
| Wildcard certificate management | Certificate authority implementation |
| Integration with Traefik | External key management systems |

The table above provides a clear delineation between included and excluded topics to prevent misunderstandings about document coverage.

## 1.3 Target Audience

This subsection identifies who should use this document, what prior knowledge they should have, and how different roles might utilize the information presented.

- **Primary**: Infrastructure administrators and security engineers managing certificates
- **Secondary**: Application developers requiring TLS certificates for their services
- **Tertiary**: Compliance officers verifying security controls
- **Expected Knowledge**: Basic understanding of Kubernetes concepts, TLS certificates, and PKI principles

# 2. Dependencies & Relationships

This section maps how cert-manager relates to other elements within the environment, capturing both upstream and downstream dependencies. These relationships form the basis for impact analysis and service maps.

## 2.1 Related Services

This subsection identifies other services that interact with cert-manager, establishing the service ecosystem and integration points.

This document **relates to**:

- [RKE2 Cluster Overview](../01-rke2-cluster-overview.md) - The underlying Kubernetes platform
- [Traefik Ingress Controller](traefik-ingress.md) - Primary consumer of certificates
- [DNS Configuration](../../infrastructure/dns-configuration.md) - Required for DNS-01 challenge validation
- [Security & Compliance](../05-security-compliance.md) - Security controls and compliance framework
- [Cloudflare Integration](../../infrastructure/cloudflare-integration.md) - DNS provider for validation

The list above documents service dependencies that should be considered when making changes or troubleshooting issues.

## 2.2 Implements Policies

This subsection connects this document to the governance framework by identifying which organizational policies it implements or supports.

This document **implements**:

- [Infrastructure Security Policy](../../compliance-security/policies/infrastructure-security-policy.md) - Through encryption of data in transit
- [Data Protection Policy](../../compliance-security/policies/data-protection-policy.md) - Through secure communications
- [Certificate Management Policy](../../compliance-security/policies/certificate-management-policy.md) - Through automated certificate lifecycle

The list above shows how this document contributes to organizational compliance and governance objectives.

## 2.3 Responsibility Matrix

This subsection defines accountabilities and responsibilities for key activities related to cert-manager, ensuring clear ownership and communication paths.

| **Activity** | **Infrastructure Admin** | **Security Admin** | **DNS Admin** | **Application Owner** |
|--------------|-------------------|-------------------|--------------|----------------|
| cert-manager Deployment | R/A | C | I | I |
| Issuer Configuration | R/A | C | C | I |
| Certificate Requests | C | C | I | R/A |
| Certificate Monitoring | R/A | C | I | I |
| Renewal Management | R/A | C | I | I |
| Security Validation | I | R/A | I | I |

*R: Responsible, A: Accountable, C: Consulted, I: Informed*

The RACI matrix above documents the roles and responsibilities for each activity, ensuring clear accountability and preventing confusion during execution.

# 3. Technical Documentation

This section provides the technical details necessary for understanding, managing, and troubleshooting cert-manager. It serves as the authoritative technical reference for the certificate management architecture.

## 3.1 Architecture & Components

This subsection explains the technical architecture, component relationships, and design decisions that shape the cert-manager implementation.

cert-manager is deployed as a Kubernetes deployment in its own namespace, providing automated certificate management for the entire cluster. It integrates with Let's Encrypt as a Certificate Authority and uses DNS-01 challenge validation through Cloudflare for wildcard certificate issuance.

Key components include:

- **cert-manager Controller**: Core component that processes Certificate resources and manages the issuance process
  - Deployed as a Kubernetes Deployment with high availability (2 replicas)
  - Watches for Certificate, CertificateRequest, and Issuer resources

- **cert-manager Webhook**: Provides validation and mutation of cert-manager custom resources
  - Ensures certificates meet required specifications
  - Validates ClusterIssuer and Issuer configurations

- **cert-manager CRDs**: Custom Resource Definitions that extend Kubernetes
  - Certificate: Represents a certificate request and resulting certificate
  - ClusterIssuer: Cluster-wide certificate issuer configurations
  - Issuer: Namespace-scoped certificate issuer configurations
  - CertificateRequest: Low-level resource representing a single request

- **ACME Solver**: Handles ACME protocol challenges for Let's Encrypt
  - Configured to use DNS-01 challenge through Cloudflare
  - Enables wildcard certificate issuance

- **Certificate Store**: Kubernetes Secrets that store issued certificates
  - Accessible to authorized services like Traefik
  - Managed and renewed automatically by cert-manager

This architecture provides automated certificate management with minimal human intervention, supporting the security and compliance requirements of the lab while reducing operational overhead.

## 3.2 Configuration Details

This subsection provides specific configuration parameters, file locations, and settings required for understanding and managing cert-manager.

cert-manager is deployed and configured using Helm with custom values and Kubernetes manifests for ClusterIssuers. Key configuration details include:

**Helm Chart Values**

```yaml
# infrastructure/k8s-rancher-rke2/helm/cert-manager-values.yaml
installCRDs: true
replicaCount: 2

prometheus:
  enabled: true
  servicemonitor:
    enabled: true
    prometheusInstance: monitoring

resources:
  requests:
    cpu: 10m
    memory: 32Mi
  limits:
    cpu: 100m
    memory: 128Mi

securityContext:
  enabled: true
  fsGroup: 1001

ingressShim:
  defaultIssuerName: letsencrypt-cloudflare
  defaultIssuerKind: ClusterIssuer
  defaultIssuerGroup: cert-manager.io

extraArgs:
  - --dns01-recursive-nameservers=1.1.1.1:53,8.8.8.8:53
  - --dns01-recursive-nameservers-only
```

**ClusterIssuer Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/manifests/cert-manager-issuer.yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-cloudflare
spec:
  acme:
    email: admin@radioastronomy.io
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-cloudflare-account-key
    solvers:
    - dns01:
        cloudflare:
          email: admin@radioastronomy.io
          apiTokenSecretRef:
            name: cloudflare-api-token
            key: api-token
      selector:
        dnsZones:
        - "radioastronomy.io"
```

**Wildcard Certificate Configuration**

```yaml
# infrastructure/k8s-rancher-rke2/manifests/wildcard-certificate.yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: traefik
spec:
  secretName: wildcard-cert
  issuerRef:
    name: letsencrypt-cloudflare
    kind: ClusterIssuer
  dnsNames:
  - "radioastronomy.io"
  - "*.radioastronomy.io"
  duration: 2160h # 90 days
  renewBefore: 360h # 15 days
  privateKey:
    algorithm: RSA
    size: 2048
```

**Cloudflare API Token Secret**

```yaml
# Created using kubectl create secret
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token
  namespace: cert-manager
type: Opaque
data:
  api-token: <base64-encoded-token>
```

**Example Application Certificate**

```yaml
# Example of an application-specific certificate
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: app-cert
  namespace: app-namespace
spec:
  secretName: app-tls
  issuerRef:
    name: letsencrypt-cloudflare
    kind: ClusterIssuer
  dnsNames:
  - "app.radioastronomy.io"
  duration: 2160h # 90 days
  renewBefore: 360h # 15 days
```

## 3.3 Implementation Steps

This subsection provides a high-level sequential procedure for understanding how cert-manager was implemented, including verification steps and expected outcomes.

cert-manager was implemented following this sequence:

1. **Preparation and Planning**
   - Documented certificate requirements
   - Selected appropriate validation method (DNS-01 for wildcard support)
   - Prepared Cloudflare API token with appropriate permissions

2. **Namespace Creation**
   - Created dedicated namespace for cert-manager:

     ```bash
     kubectl create namespace cert-manager
     ```

   - Created Cloudflare API token secret:

     ```bash
     kubectl create secret generic cloudflare-api-token \
       --from-literal=api-token=<token-value> \
       -n cert-manager
     ```

3. **Helm Deployment**
   - Added the cert-manager Helm repository:

     ```bash
     helm repo add jetstack https://charts.jetstack.io
     helm repo update
     ```

   - Deployed cert-manager using custom values:

     ```bash
     helm install cert-manager jetstack/cert-manager \
       -n cert-manager \
       -f infrastructure/k8s-rancher-rke2/helm/cert-manager-values.yaml
     ```

   - Verified deployment status:

     ```bash
     kubectl get pods -n cert-manager
     kubectl get crd | grep cert-manager
     ```

4. **ClusterIssuer Configuration**
   - Applied the ClusterIssuer for Let's Encrypt:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/cert-manager-issuer.yaml
     ```

   - Verified issuer status:

     ```bash
     kubectl get clusterissuer letsencrypt-cloudflare -o wide
     ```

5. **Wildcard Certificate Creation**
   - Created the wildcard certificate for the domain:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/wildcard-certificate.yaml
     ```

   - Monitored certificate issuance progress:

     ```bash
     kubectl get certificate -n traefik
     kubectl get certificaterequest -n traefik
     kubectl get challenge -n traefik
     ```

   - Verified final certificate status:

     ```bash
     kubectl get certificate wildcard-cert -n traefik
     kubectl get secret wildcard-cert -n traefik
     ```

6. **Traefik Integration**
   - Configured Traefik to use the wildcard certificate:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/traefik-tls-store.yaml
     ```

   - Verified TLS configuration:

     ```bash
     curl -vI https://test.radioastronomy.io | grep -i "server certificate"
     ```

7. **Automated Renewal Verification**
   - Tested certificate renewal process:

     ```bash
     kubectl annotate certificate wildcard-cert -n traefik \
       cert-manager.io/renew-before="1h"
     ```

   - Monitored renewal process:

     ```bash
     kubectl get events -n traefik --field-selector involvedObject.name=wildcard-cert
     ```

   - Restored normal renewal settings:

     ```bash
     kubectl annotate certificate wildcard-cert -n traefik \
       cert-manager.io/renew-before-
     ```

8. **Monitoring Integration**
   - Applied ServiceMonitor for Prometheus integration:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/cert-manager-service-monitor.yaml
     ```

   - Imported Grafana dashboards:

     ```bash
     kubectl apply -f infrastructure/k8s-rancher-rke2/manifests/cert-manager-grafana-dashboard.yaml
     ```

   - Verified metrics collection:

     ```bash
     curl http://cert-manager-pod-ip:9402/metrics
     ```

Each step included validation testing to ensure proper functionality before proceeding to the next phase.

# 4. Management & Operations

This section covers day-to-day operational procedures, troubleshooting guidance, and monitoring approaches for cert-manager. It provides the practical guidance needed for ongoing maintenance and support.

## 4.1 Routine Procedures

This subsection documents regular maintenance and operational tasks required to keep cert-manager functioning properly, including their frequency and responsible parties.

| **Procedure** | **Frequency** | **Responsible Role** | **Documentation Link** |
|---------------|--------------|----------------------|------------------------|
| Version Updates | Quarterly | Infrastructure Admin | [cert-manager Update Procedure](../../procedures/cert-manager-update.md) |
| Certificate Audit | Monthly | Security Admin | [Certificate Audit Procedure](../../procedures/certificate-audit.md) |
| Expiration Monitoring | Weekly | Infrastructure Admin | Automated Liongard change detection alert via email to <alerts@radioastronomy.io> (monitored by GLPI) |
| ACME Account Validation | Quarterly | Infrastructure Admin | [ACME Account Verification](../../procedures/acme-account-verification.md) |
| DNS Integration Testing | Quarterly | Infrastructure Admin | [DNS Validation Testing](../../procedures/dns-validation-testing.md) |

The table above outlines routine procedures that must be performed to maintain operational stability and security, along with their required cadence.

## 4.2 Troubleshooting

This subsection provides guidance for identifying and resolving common issues with cert-manager, including symptoms, causes, and resolution steps.

| **Symptom** | **Possible Cause** | **Resolution Steps** | **Related KB** |
|-------------|-------------------|----------------------|----------------|
| Certificate in Pending state | DNS validation failure, API token issues | Check Cloudflare API token, verify DNS permissions, examine challenge resources | [Certificate Pending Troubleshooting](../../troubleshooting/certificate-pending.md) |
| Certificate issuance timeout | Rate limiting, network issues, DNS propagation | Check Let's Encrypt rate limits, verify DNS records, restart cert-manager pod | [Certificate Timeout Troubleshooting](../../troubleshooting/certificate-timeout.md) |
| Certificate renewal failure | Expired API tokens, misconfiguration | Verify token validity, check logs, manually trigger renewal | [Renewal Failure Troubleshooting](../../troubleshooting/renewal-failure.md) |
| Invalid certificate warnings | Certificate mismatch, incorrect configuration | Verify certificate domains, check Traefik configuration, reissue certificate | [Invalid Certificate Troubleshooting](../../troubleshooting/invalid-certificate.md) |
| cert-manager pod crashes | Resource constraints, CRD issues | Check resource usage, verify CRD integrity, review logs | [cert-manager Pod Troubleshooting](../../troubleshooting/cert-manager-pod-issues.md) |

The troubleshooting table above helps operators quickly identify and resolve common issues without extensive investigation or escalation.

## 4.3 Monitoring & Metrics

This subsection defines what aspects of cert-manager should be monitored, normal operating parameters, alert thresholds, and how to access monitoring dashboards.

cert-manager is monitored using Prometheus and Grafana deployed on lab-mon01. Key metrics and monitoring parameters include:

| **Metric** | **Normal Range** | **Alert Threshold** | **Dashboard Link** |
|------------|----------------|---------------------|-------------------|
| Certificate Expiry | >15 days | <7 days | [Certificate Expiry Dashboard](http://grafana.lab.internal/d/cert-expiry) |
| Issuance Duration | <5 minutes | >15 minutes | [Issuance Performance Dashboard](http://grafana.lab.internal/d/cert-issuance) |
| Renewal Success Rate | 100% | <100% for >24 hours | [Renewal Success Dashboard](http://grafana.lab.internal/d/cert-renewal) |
| ACME Challenge Duration | <2 minutes | >5 minutes | [ACME Challenge Dashboard](http://grafana.lab.internal/d/acme-challenges) |
| Controller Health | Running | Not running for >2 min | [cert-manager Health Dashboard](http://grafana.lab.internal/d/cert-manager-health) |

The metrics table above defines key performance indicators and operational thresholds that should be monitored to ensure certificate management health and performance.

Additionally, the following cert-manager-specific metrics are collected:

- Certificate request processing time
- Challenge resolution times
- Controller reconciliation metrics
- API call rates to ACME servers
- Certificate counts by state (Ready, Not Ready, etc.)

# 5. Security & Compliance

This section documents how security controls are implemented in cert-manager and how compliance requirements are met. It provides the mapping between security requirements and their practical implementation.

## 5.1 Security Controls

This subsection documents specific security measures implemented in cert-manager, how they are verified, and which compliance controls they satisfy.

| **Control Type** | **Implementation** | **Verification Method** | **Control ID** |
|------------------|-------------------|------------------------|----------------|
| Transport Encryption | TLS certificates for all services | Certificate validation tools, TLS scanning | CIS.9.2, NIST SC-8 |
| Key Management | Secure private key storage in Kubernetes secrets | Secret access review, permission validation | CIS.14.4, NIST SC-12 |
| Certificate Lifecycle | Automated renewal 15 days before expiry | Expiry monitoring, renewal validation | CIS.16.5, NIST SC-12 |
| Authentication | API token-based authentication for DNS providers | Token permission review, authorization testing | CIS.12.1, NIST IA-5 |
| Access Control | RBAC for certificate resources | Access review, permission testing | CIS.5.1, NIST AC-3 |

The security controls table above documents implemented safeguards, providing evidence for security assessments and compliance audits.

## 5.2 CISv8.1 Compliance Mapping

This subsection explicitly maps cert-manager implementation details to CIS Controls, documenting compliance status and evidence location.

| **CIS Control** | **Implementation** | **Evidence Location** | **Compliance Status** |
|-----------------|-------------------|----------------------|----------------------|
| CIS.9.2 | TLS certificates for all exposed services | Certificate objects, TLS scan results | Compliant |
| CIS.14.4 | Secure certificate and key management | Secret objects, RBAC configuration | Compliant |
| CIS.16.5 | Certificate expiry monitoring and alerting | Prometheus alerts, Grafana dashboards | Compliant |
| CIS.14.2 | Encryption using industry standards (RSA 2048) | Certificate specifications | Compliant |
| CIS.16.4 | Certificate event logging and monitoring | Event logs, Prometheus metrics | Compliant |

The compliance mapping table above demonstrates how this implementation satisfies specific CIS Controls requirements, supporting audit and assessment activities.

## 5.3 Related Framework Mappings

This subsection shows how controls map across multiple compliance frameworks, demonstrating the relationships between different standards.

| **CIS Control** | **ISO 27001** | **NIST CSF** | **Implementation** |
|-----------------|--------------|-------------|-------------------|
| CIS.9.2 | A.14.1.3 | PR.DS-2 | TLS certificates for all exposed services |
| CIS.14.4 | A.10.1.1 | PR.DS-5 | Secure certificate and key management |
| CIS.16.5 | A.18.1.3 | PR.DS-5 | Certificate expiry monitoring and alerting |
| CIS.14.2 | A.14.1.2 | PR.DS-2 | Encryption using industry standards (RSA 2048) |
| CIS.16.4 | A.12.4.1 | DE.CM-1 | Certificate event logging and monitoring |

The framework mapping table above shows equivalencies between control frameworks, helping to streamline compliance efforts across multiple standards.

## 5.4 Risk Assessment

This subsection documents identified security risks, implemented mitigations, and any accepted residual risk associated with cert-manager.

cert-manager has undergone a security risk assessment to identify potential vulnerabilities and apply appropriate mitigations:

1. **Risk**: Certificate Private Key Exposure
   - **Mitigation**: Storage in Kubernetes secrets, RBAC controls, restricted access
   - **Residual Risk**: Low - Multiple layers of access controls limit exposure

2. **Risk**: Certificate Expiration
   - **Mitigation**: Automated renewal, monitoring, alerts 15 days before expiry
   - **Residual Risk**: Low - Automated processes with monitoring reduce likelihood

3. **Risk**: DNS Provider API Token Compromise
   - **Mitigation**: Restricted token permissions, secure storage, regular rotation
   - **Residual Risk**: Medium - Token compromise could affect certificate issuance

4. **Risk**: ACME Account Compromise
   - **Mitigation**: Secure storage of account keys, monitoring of certificate issuance
   - **Residual Risk**: Low - Limited attack vectors and monitoring reduce risk

These risks are actively managed through continuous monitoring, regular security scanning, and timely updates to all cert-manager-related components.

# 6. Backup & Recovery

This section documents data protection measures, backup strategies, and recovery procedures for cert-manager. It provides the guidance needed to ensure business continuity and disaster recovery capabilities.

## 6.1 Backup Procedure

This subsection details how data is protected through backups, including schedules, methods, retention policies, and verification processes.

| **Aspect** | **Details** |
|------------|------------|
| **Backup Schedule** | Configuration: Daily at 01:00 UTC, Certificates & Secrets: Daily at 01:30 UTC |
| **Backup Method** | GitOps for configuration, Velero for Kubernetes resources |
| **Retention Policy** | 7 daily, 4 weekly, 3 monthly backups |
| **Backup Location** | Primary: proj-pg01:/backup, Secondary: S3 Glacier Deep Archive |
| **Verification Process** | Every 90 days test restoration to validate backups |

The backup details table above documents critical information about data protection measures, ensuring resilience and recoverability.

cert-manager-specific considerations:

- ACME account private keys are critical and backed up separately
- Certificate private keys are backed up as Kubernetes secrets
- ClusterIssuer and Issuer configurations are version controlled in Git
- Certificate resources are backed up with application namespaces

## 6.2 Recovery Procedure

This subsection provides recovery steps for various failure scenarios, including recovery time and point objectives, and responsible parties.

| **Scenario** | **RTO** | **RPO** | **Recovery Steps** | **Responsible Role** |
|--------------|--------|--------|-------------------|----------------------|
| cert-manager Pod Failure | 5 minutes | 0 data loss | Allow Kubernetes to reschedule pods or manually restart deployment | Infrastructure Admin |
| Configuration Corruption | 30 minutes | 24 hours | Redeploy cert-manager, restore configurations from Git | Infrastructure Admin |
| ACME Account Compromise | 60 minutes | 0 data loss | Revoke account, generate new account keys, reconfigure issuers | Infrastructure Admin |
| Certificate Compromise | 30 minutes | 0 data loss | Revoke certificates, reissue with new private keys | Infrastructure Admin |
| Complete cert-manager Failure | 60 minutes | 24 hours | Redeploy cert-manager from scratch, restore configurations and secrets | Infrastructure Admin |

The recovery procedure table above outlines steps to restore service in different failure scenarios, supporting business continuity objectives.

# 7. References & Related Resources

This section provides links to related documentation and external resources. It establishes the connections between this document and other knowledge sources both internal and external.

## 7.1 Internal References

This subsection identifies other internal documents related to cert-manager, establishing the document ecosystem and knowledge relationships.

| **Document Type** | **Document Name** | **Location** | **Relationship** |
|-------------------|-------------------|------------|-----------------|
| Architecture | RKE2 Cluster Overview | [../01-rke2-cluster-overview.md](../01-rke2-cluster-overview.md) | Parent architecture |
| Technical | Traefik Ingress Controller | [traefik-ingress.md](traefik-ingress.md) | Certificate consumer |
| Technical | Security & Compliance | [../05-security-compliance.md](../05-security-compliance.md) | Security framework |
| Operational | Certificate Audit Procedure | [../../procedures/certificate-audit.md](../../procedures/certificate-audit.md) | Operational procedure |
| Operational | Certificate Emergency Response | [../../procedures/certificate-emergency-response.md](../../procedures/certificate-emergency-response.md) | Incident response |

The internal references table above connects this document to other knowledge base articles, supporting comprehensive understanding and navigation.

## 7.2 External References

This subsection provides links to external resources that provide additional context, technical details, or supporting information for cert-manager.

| **Reference** | **URL** | **Archived Copy** | **Last Verified** |
|--------------|---------|-------------------|-------------------|
| cert-manager Documentation | <https://cert-manager.io/docs/> | [cert-manager-docs-2025-04.pdf](../../archive/cert-manager-docs-2025-04.pdf) | 2025-04-01 |
| Let's Encrypt Documentation | <https://letsencrypt.org/docs/> | [letsencrypt-docs-2025-04.pdf](../../archive/letsencrypt-docs-2025-04.pdf) | 2025-04-01 |
| Cloudflare API Documentation | <https://developers.cloudflare.com/api/> | [cloudflare-api-docs-2025-03.pdf](../../archive/cloudflare-api-docs-2025-03.pdf) | 2025-03-15 |
| ACME Protocol RFC | <https://tools.ietf.org/html/rfc8555> | [acme-rfc-2025-03.pdf](../../archive/acme-rfc-2025-03.pdf) | 2025-03-20 |
| TLS Best Practices | <https://cheatsheetseries.owasp.org/cheatsheets/TLS_Cheat_Sheet.html> | [tls-best-practices-2025-03.pdf](../../archive/tls-best-practices-2025-03.pdf) | 2025-03-20 |

The external references table above documents outside sources that inform or support this document, ensuring knowledge continuity even if external sources change.

## 7.3 Change Request References

This subsection documents formal change requests that have modified cert-manager, providing an audit trail and implementation history.

| **Change ID** | **Description** | **Implementation Date** |
|--------------|----------------|------------------------|
| CR-2025-054 | Initial cert-manager deployment | 2025-04-20 |
| CR-2025-056 | Configured Cloudflare DNS validation | 2025-04-20 |
| CR-2025-057 | Created wildcard certificate | 2025-04-20 |
| CR-2025-058 | Implemented certificate monitoring | 2025-04-21 |

The change request table above tracks formal changes that have affected cert-manager, supporting troubleshooting and audit activities.

# 8. Approval & Review

This section documents the formal review and approval process for the cert-manager documentation. It ensures accountability and tracks who has verified the accuracy of the content.

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

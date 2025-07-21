# 🗄️ **Databases**

This wiki section provides comprehensive documentation for database systems deployed across the Proxmox Astronomy Lab enterprise infrastructure. The database architecture supports production astronomical research workloads including DESI DR1 analysis, large-scale astronomical data processing, and AI/ML model training through optimized PostgreSQL implementations and strategic database deployment patterns.

## **Overview**

The database infrastructure represents a critical component of the astronomical computing platform, providing high-performance data storage, query processing, and analytical capabilities for research projects. The current implementation focuses on PostgreSQL deployments optimized for astronomical workloads, with strategic placement across the 7-node cluster to provide optimal performance, reliability, and scalability for scientific computing requirements. Each database instance is configured with enterprise-grade security, monitoring, and backup procedures ensuring data integrity and operational continuity for production research workflows.

The database architecture supports multiple research domains including cosmic void analysis (30GB+ datasets), AGN outflow studies, anomalous quasar detection, and distributed ML/AI training workflows. Strategic VM-based deployments provide dedicated resources for database operations while integrating seamlessly with the hybrid Kubernetes and container orchestration environment for comprehensive scientific computing capabilities.

---

## **📂 Directory Contents**

This section provides systematic navigation to all database documentation and configuration resources.

### **🏢 Production Database Instances**

| **Database** | **Host** | **Purpose** | **Specifications** | **Documentation** |
|--------------|----------|-------------|-------------------|-------------------|
| **[proj-pg01](proj-pg01/)** | 10.25.20.8 | Primary astronomical research database | 8 vCPU, 48GB RAM, 250GB NVMe, PostgreSQL 16 | [proj-pg01/README.md](proj-pg01/README.md) |
| **[proj-pgsql02](proj-pgsql02/)** | 10.25.20.16 | Secondary research database instance | 4 vCPU, 16GB RAM, 100GB NVMe, PostgreSQL | [proj-pgsql02/README.md](proj-pgsql02/README.md) |

### **📊 Database Architecture**

| **Component** | **Purpose** | **Documentation** |
|---------------|-------------|-------------------|
| **[postgresql-optimization/](postgresql-optimization/)** | PostgreSQL performance tuning for astronomical workloads | [postgresql-optimization/README.md](postgresql-optimization/README.md) |
| **[backup-procedures/](backup-procedures/)** | Database backup and recovery procedures | [backup-procedures/README.md](backup-procedures/README.md) |
| **[monitoring-integration/](monitoring-integration/)** | Database monitoring and alerting configuration | [monitoring-integration/README.md](monitoring-integration/README.md) |
| **[security-configuration/](security-configuration/)** | Database security hardening and access controls | [security-configuration/README.md](security-configuration/README.md) |

### **🔬 Research Data Management**

| **Domain** | **Database Usage** | **Documentation** |
|------------|-------------------|-------------------|
| **[desi-analysis/](desi-analysis/)** | DESI DR1 data storage and analysis procedures | [desi-analysis/README.md](desi-analysis/README.md) |
| **[astronomical-catalogs/](astronomical-catalogs/)** | Value-Added Catalog storage and management | [astronomical-catalogs/README.md](astronomical-catalogs/README.md) |
| **[ml-data-management/](ml-data-management/)** | AI/ML training data and model storage procedures | [ml-data-management/README.md](ml-data-management/README.md) |

### **⚙️ Administration and Operations**

| **Component** | **Purpose** | **Documentation** |
|---------------|-------------|-------------------|
| **[deployment-procedures/](deployment-procedures/)** | Database deployment and configuration procedures | [deployment-procedures/README.md](deployment-procedures/README.md) |
| **[maintenance-procedures/](maintenance-procedures/)** | Routine maintenance and optimization procedures | [maintenance-procedures/README.md](maintenance-procedures/README.md) |
| **[troubleshooting/](troubleshooting/)** | Common issues and resolution procedures | [troubleshooting/README.md](troubleshooting/README.md) |

---

## **🏗️ Repository Structure**

```markdown
wiki/databases/
├── README.md                                    # This overview document
├── proj-pg01/
│   ├── README.md                               # Primary database instance documentation
│   ├── configuration/                         # PostgreSQL configuration files
│   ├── schema-management/                      # Database schema and migration procedures
│   ├── performance-tuning/                    # Performance optimization settings
│   └── backup-configuration/                  # Instance-specific backup procedures
├── proj-pgsql02/
│   ├── README.md                               # Secondary database instance documentation
│   ├── configuration/                         # PostgreSQL configuration files
│   ├── replication-setup/                     # Replication configuration if applicable
│   └── monitoring-setup/                      # Monitoring configuration
├── postgresql-optimization/
│   ├── README.md                               # PostgreSQL optimization overview
│   ├── astronomical-workloads/                # Astronomy-specific optimizations
│   ├── memory-configuration/                  # Memory tuning procedures
│   ├── storage-optimization/                  # Storage and I/O optimization
│   └── query-optimization/                    # Query performance tuning
├── backup-procedures/
│   ├── README.md                               # Backup procedures overview
│   ├── automated-backups/                     # Automated backup configuration
│   ├── manual-procedures/                     # Manual backup procedures
│   ├── recovery-procedures/                   # Database recovery procedures
│   └── disaster-recovery/                     # Disaster recovery planning
├── monitoring-integration/
│   ├── README.md                               # Monitoring integration overview
│   ├── prometheus-integration/                # Prometheus metrics configuration
│   ├── grafana-dashboards/                    # Database monitoring dashboards
│   ├── alerting-rules/                        # Database alerting configuration
│   └── log-management/                        # Database log management
├── security-configuration/
│   ├── README.md                               # Security configuration overview
│   ├── access-controls/                       # User and role management
│   ├── ssl-configuration/                     # SSL/TLS configuration
│   ├── audit-logging/                         # Audit trail configuration
│   └── compliance-validation/                 # Security compliance verification
├── desi-analysis/
│   ├── README.md                               # DESI analysis database usage
│   ├── data-loading/                          # DESI data import procedures
│   ├── schema-design/                         # DESI-specific schema design
│   ├── query-patterns/                        # Common DESI analysis queries
│   └── performance-considerations/            # DESI-specific performance optimization
├── astronomical-catalogs/
│   ├── README.md                               # Astronomical catalog management
│   ├── vac-storage/                           # Value-Added Catalog storage
│   ├── catalog-indexing/                      # Catalog indexing strategies
│   └── cross-matching/                        # Catalog cross-matching procedures
├── ml-data-management/
│   ├── README.md                               # ML data management overview
│   ├── training-data/                         # ML training data procedures
│   ├── model-storage/                         # Model artifact storage
│   └── feature-engineering/                   # Feature engineering database support
├── deployment-procedures/
│   ├── README.md                               # Deployment procedures overview
│   ├── vm-deployment/                         # Database VM deployment
│   ├── postgresql-installation/               # PostgreSQL installation procedures
│   ├── initial-configuration/                 # Initial database configuration
│   └── integration-setup/                     # Integration with other systems
├── maintenance-procedures/
│   ├── README.md                               # Maintenance procedures overview
│   ├── routine-maintenance/                   # Regular maintenance tasks
│   ├── security-updates/                      # Security patch procedures
│   ├── performance-monitoring/                # Performance maintenance
│   └── capacity-planning/                     # Database capacity planning
└── troubleshooting/
    ├── README.md                               # Troubleshooting overview
    ├── common-issues/                          # Common database issues
    ├── performance-issues/                     # Performance troubleshooting
    ├── connectivity-issues/                    # Connection troubleshooting
    └── diagnostic-procedures/                  # Database diagnostic procedures
```

---

## **🔗 Related Categories**

This section establishes connections to other knowledge domains within the Proxmox Astronomy Lab ecosystem.

### **Infrastructure Integration**

| **Category** | **Relationship** | **Database Integration** |
|--------------|------------------|-------------------------|
| **[k8s/](../k8s/README.md)** | Kubernetes service integration | Database connectivity from containerized applications |
| **[fileservices/](../fileservices/README.md)** | Storage backend coordination | Database file storage and backup integration |
| **[automation-and-orchestration/](../automation-and-orchestration/README.md)** | Automated deployment and management | Database lifecycle automation |
| **[portainer/](../portainer/README.md)** | Container orchestration | Database container management and monitoring |

### **Platform Integration**

| **Category** | **Relationship** | **Database Integration** |
|--------------|------------------|-------------------------|
| **[projects/](../../projects/README.md)** | Research data storage | Project-specific database requirements |
| **[ai/](../../ai/README.md)** | ML/AI data storage | Training data and model artifact storage |
| **[monitoring/](../../monitoring/README.md)** | Database monitoring | Performance metrics and alerting integration |
| **[security/](../../security/README.md)** | Database security | Security controls and compliance validation |

---

## **🚀 Getting Started**

This section provides navigation guidance for different audiences and use cases within the database infrastructure.

### **For Database Administrators**

**Start Here:** [proj-pg01/](proj-pg01/README.md)  
**Optimization:** [postgresql-optimization/](postgresql-optimization/README.md)  
**Monitoring:** [monitoring-integration/](monitoring-integration/README.md)  
**Security:** [security-configuration/](security-configuration/README.md)

### **For Research Data Scientists**

**Start Here:** [desi-analysis/](desi-analysis/README.md)  
**Data Management:** [astronomical-catalogs/](astronomical-catalogs/README.md)  
**ML Integration:** [ml-data-management/](ml-data-management/README.md)  
**Query Optimization:** [postgresql-optimization/query-optimization/](postgresql-optimization/query-optimization/README.md)

### **For Infrastructure Engineers**

**Start Here:** [deployment-procedures/](deployment-procedures/README.md)  
**Backup Systems:** [backup-procedures/](backup-procedures/README.md)  
**Integration:** [monitoring-integration/](monitoring-integration/README.md)  
**Troubleshooting:** [troubleshooting/](troubleshooting/README.md)

### **For System Administrators**

**Start Here:** [maintenance-procedures/](maintenance-procedures/README.md)  
**Security Management:** [security-configuration/](security-configuration/README.md)  
**Performance Monitoring:** [monitoring-integration/](monitoring-integration/README.md)  
**Disaster Recovery:** [backup-procedures/disaster-recovery/](backup-procedures/disaster-recovery/README.md)

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-20 |
| **Last Updated** | 2025-07-20 |
| **Version** | 1.0 |

---
Tags: postgresql, database-administration, astronomical-data, enterprise-database, research-infrastructure

<!--
---
title: "Applications and Services"
description: "Comprehensive enterprise application platform ecosystem supporting astronomical research computing with containerized deployments, database services, automation platforms, and security infrastructure"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4 (claude-sonnet-4-20250514)"
date: "2025-07-21"
version: "1.0"
status: "Published"
tags:
- type: directory-overview
- domain: enterprise-application-services
- tech: [docker, postgresql, nginx, automation]
- phase: production-service-deployment
related_documents:
- "[Infrastructure Overview](../infrastructure/README.md)"
- "[Virtual Machines](../virtual-machines/README.md)"
- "[Security Framework](../security/README.md)"
- "[AI Infrastructure](../ai/README.md)"
---
-->

# 🚀 **Applications and Services**

Comprehensive enterprise application platform ecosystem supporting astronomical research computing through distributed services, database platforms, automation systems, and security infrastructure. This directory contains production-ready application services deployed across containerized and VM-based platforms with enterprise-grade security, SSL-secured access, and integrated monitoring.

## **Overview**

The applications-and-services directory represents the core operational services layer of the Proxmox Astronomy Lab enterprise platform. This ecosystem includes AI chat interfaces, PostgreSQL database platforms, cache services, version control systems, automation platforms, password management, and network proxy services. Services are deployed using optimal strategies—containerized applications via Docker on distributed nodes, and high-performance databases as native VM services—ensuring maximum performance and reliability for research computing workloads.

Each service follows enterprise architecture principles with comprehensive documentation, security baselines, backup strategies, and monitoring integration. The platform supports both research-specific workloads like DESI cosmic void analysis and general-purpose application requirements through a hybrid deployment architecture optimized for performance, security, and operational excellence.

---

## **📂 Directory Contents**

This section provides systematic navigation to all application services within the enterprise platform, ensuring complete coverage for knowledge graph connectivity.

### **AI and Chat Services**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[chat01-openwebui/](chat01-openwebui/)** | Enterprise AI chat interface with multi-model integration, RAG capabilities | [chat01-openwebui/README.md](chat01-openwebui/README.md) |

### **Database Services**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[pgsql01-project-workloads/](pgsql01-project-workloads/)** | Primary PostgreSQL research database (DESI 27.6GB dataset) | [pgsql01-project-workloads/README.md](pgsql01-project-workloads/README.md) |
| **[pgsql02-general-workloads/](pgsql02-general-workloads/)** | General-purpose PostgreSQL database platform with monitoring | [pgsql02-general-workloads/README.md](pgsql02-general-workloads/README.md) |
| **[pgadmin01-web-database-interface/](pgadmin01-web-database-interface/)** | PostgreSQL web administration interface (SSL-secured) | [pgadmin01-web-database-interface/README.md](pgadmin01-web-database-interface/README.md) |

### **Cache and Memory Services**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[dragonflydb01-dragonflydb/](dragonflydb01-dragonflydb/)** | High-performance in-memory database with Redis compatibility | [dragonflydb01-dragonflydb/README.md](dragonflydb01-dragonflydb/README.md) |
| **[rcom01-redis-commander-for-dragonflydb/](rcom01-redis-commander-for-dragonflydb/)** | DragonflyDB web management interface (SSL-secured) | [rcom01-redis-commander-for-dragonflydb/README.md](rcom01-redis-commander-for-dragonflydb/README.md) |

### **Development and Version Control**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[gitea01-project-repository/](gitea01-project-repository/)** | Enterprise Git repository platform with collaboration tools | [gitea01-project-repository/README.md](gitea01-project-repository/README.md) |

### **Automation and Infrastructure**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[sema01-project-semaphore-instance/](sema01-project-semaphore-instance/)** | Ansible automation platform with Active Directory integration (SSL-secured) | [sema01-project-semaphore-instance/README.md](sema01-project-semaphore-instance/README.md) |

### **Security Services**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[vw01-vaultwarden-password-repository/](vw01-vaultwarden-password-repository/)** | Enterprise password management platform (SSL-secured) | [vw01-vaultwarden-password-repository/README.md](vw01-vaultwarden-password-repository/README.md) |

### **Network and Proxy Services**

| **Service** | **Purpose** | **Documentation** |
|-------------|-------------|-------------------|
| **[npm01-nginx-proxy-manager/](npm01-nginx-proxy-manager/)** | Reverse proxy and SSL certificate automation platform | [npm01-nginx-proxy-manager/README.md](npm01-nginx-proxy-manager/README.md) |

---

## **📁 Repository Structure**

```markdown
applications-and-services/
├── 🤖 chat01-openwebui/                           # AI chat interface
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── openwebui-configuration-example.json      # Configuration template
├── 🐲 dragonflydb01-dragonflydb/                  # In-memory database
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🔧 gitea01-project-repository/                 # Git repository
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🌐 npm01-nginx-proxy-manager/                  # Reverse proxy
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🗄️ pgadmin01-web-database-interface/          # Database admin (SSL)
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🗄️ pgsql01-project-workloads/                 # DESI research database
│   └── README.md                                  # Service documentation
├── 🗄️ pgsql02-general-workloads/                 # General database
│   └── README.md                                  # Service documentation
├── 🔧 rcom01-redis-commander-for-dragonflydb/     # Cache management (SSL)
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🎭 sema01-project-semaphore-instance/          # Automation platform (SSL)
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 🔒 vw01-vaultwarden-password-repository/       # Password management (SSL)
│   ├── README.md                                  # Service documentation
│   ├── docker-compose.yml                        # Container configuration
│   └── .env.example                              # Environment template
├── 📝 README.md                                   # This file
└── 📋 README-pending.md                           # Future services
```

### **Navigation Guide:**

- **🤖 [AI Services](chat01-openwebui/README.md)** - Conversational AI interfaces and model management
- **🗄️ [Database Services](pgsql01-project-workloads/README.md)** - PostgreSQL research and application databases  
- **🐲 [Cache Services](dragonflydb01-dragonflydb/README.md)** - High-performance in-memory data platforms
- **🔧 [Development Tools](gitea01-project-repository/README.md)** - Version control and collaboration platforms
- **🎭 [Automation](sema01-project-semaphore-instance/README.md)** - Infrastructure automation and orchestration
- **🔒 [Security](vw01-vaultwarden-password-repository/README.md)** - Password management and credential security
- **🌐 [Network Services](npm01-nginx-proxy-manager/README.md)** - Reverse proxy and SSL automation

---

## **🔗 Related Categories**

This section establishes horizontal relationships within the knowledge graph, connecting applications and services to related platform domains.

| **Category** | **Relationship** | **Documentation** |
|--------------|------------------|-------------------|
| **[Infrastructure](../infrastructure/README.md)** | Provides underlying platform services including Docker, databases, networking | [../infrastructure/README.md](../infrastructure/README.md) |
| **[Virtual Machines](../virtual-machines/README.md)** | Hosts application services on distributed VM infrastructure | [../virtual-machines/README.md](../virtual-machines/README.md) |
| **[Security](../security/README.md)** | Implements security frameworks and compliance baselines for all services | [../security/README.md](../security/README.md) |
| **[AI Infrastructure](../ai/README.md)** | Supports AI services with GPU computing and model hosting capabilities | [../ai/README.md](../ai/README.md) |
| **[Projects](../projects/README.md)** | Consumes application services for DESI research and astronomical computing | [../projects/README.md](../projects/README.md) |

---

## **Getting Started**

For new users approaching the applications and services platform:

1. **Start Here:** [Infrastructure Overview](../infrastructure/README.md) - Understand the underlying platform architecture
2. **Database Services:** [PostgreSQL Platforms](pgsql01-project-workloads/README.md) - Core data management services
3. **SSL Services:** [Reverse Proxy](npm01-nginx-proxy-manager/README.md) - Network and certificate management
4. **Security:** [Password Management](vw01-vaultwarden-password-repository/README.md) - Credential security platform

### **Service Access Patterns:**

- **SSL-Secured Services:** pgAdmin, Redis Commander, Semaphore, Vaultwarden (via *.radioastronomy.io)
- **Internal Services:** Chat, Database, Git, Proxy (via container networking or VM access)
- **Database Connections:** Direct PostgreSQL access for applications and research tools

### **Common Tasks:**

- **Database Administration:** Access pgAdmin via <https://pgadmin01.radioastronomy.io>
- **Password Management:** Access Vaultwarden via <https://vw.radioastronomy.io>  
- **Infrastructure Automation:** Access Semaphore via <https://dema01.radioastronomy.io>
- **Cache Management:** Access Redis Commander via <https://rcom01.radioastronomy.io>

---

## **Document Information**

| **Field** | **Value** |
|-----------|-----------|
| **Author** | VintageDon - <https://github.com/vintagedon> |
| **Created** | 2025-07-21 |
| **Last Updated** | 2025-07-21 |
| **Version** | 1.0 |

---
Tags: applications, services, docker, postgresql, automation, security, enterprise-platform

| VM ID | Hostname       | OS                  | IP          |  vCPU  | vRAM |  Node  |  OS  | +Volume |
| ----- | -------------- | ------------------- | ----------- | ------ | ---- | ------ | ---- | ------- |
| 1002  | mgmt-ansible01 | Ubuntu 24.04 Server | 10.25.10.7  |   2    |   4  | node05 |  32G |    N/A  |
| 1003  | radio-dc01     | Server 2025 Stnd    | 10.25.10.2  |   2    |   6  | node01 | 125G |    N/A  |
| 1004  | mgmt-veeam01   | Server 2025 Stnd    | 10.25.10.11 |   4    |  16  | node05 | 125G |  1000G  |
| 1005  | mgmt-docker01  | Ubuntu 24.04 Server | 10.25.10.9  |   4    |  16  | node02 |  32G |   100G  |
| 1006  | mgmt-sec01     | Ubuntu 24.04 Server | 10.25.10.8  |   4    |  12  | node02 |  32G |   100G  |
| 1007  | mgmt-agents01  | Ubuntu 24.04 Server | 10.25.10.10 |   4    |  16  | node02 |  32G |   100G  |
| 2001  | proj-dp01      | Ubuntu 24.04 Server | 10.25.20.3  |   4    |  16  | node07 |  32G |   100G  |
| 2002  | proj-pgsql01   | Ubuntu 24.04 Server | 10.25.20.8  |   8    |  32  | node06 |  32G |   250G  |
| 2003  | radio-dc02     | Server 2025 Stnd    | 10.25.20.2  |   2    |   6  | node03 | 125G |    N/A  |
| 2004  | proj-dev01     | Ubuntu 24.04 Server | 10.25.20.7  |   2    |   8  | node05 |  32G |   100G  |
| 2005  | proj-gpu01     | Ubuntu 24.04 Server | 10.25.20.10 |   8    |  32  | node07 |  32G |   100G  |
| 2007  | proj-fs01      | Ubuntu 24.04 Server | 10.25.20.11 |   2    |   6  | node05 |  32G |  1500G  |
| 2008  | proj-mon01     | Ubuntu 24.04 Server | 10.25.20.9  |   4    |  12  | node05 |  32G |   500G  |
| 2009  | proj-port01    | Ubuntu 24.04 Server | 10.25.20.22 |   2    |   6  | node02 |  32G |    N/A  |
| 2010  | proj-fs03      | Ubuntu 24.04 Server | 10.25.20.17 |   2    |   6  | node02 |  32G |  1500G  |
| 2011  | proj-fs02      | Server 2025 Stnd    | 10.25.20.15 |   4    |   6  | node05 | 125G |   150G  |
| 2012  | proj-pgsql02   | Ubuntu 24.04 Server | 10.25.20.16 |   4    |  16  | node06 |  32G |   100G  |
| 2014  | proj-docker01  | Ubuntu 24.04 Server | 10.25.20.14 |   6    |  24  | node06 |  32G |   100G  |
| 2015  | proj-fs04      | Server 2025 Stnd    | 10.25.20.23 |   4    |   6  | node02 | 125G |    N/A  |
| 2016  | proj-mongo01   | Ubuntu 24.04 Server | 10.25.20.18 |   2    |   4  | node03 |  32G |   100G  |
| 2017  | proj-milvus01  | Ubuntu 24.04 Server | 10.25.20.19 |   6    |  24  | node07 |  32G |   250G  |
| 2018  | proj-node4j01  | Ubuntu 24.04 Server | 10.25.20.21 |   6    |  24  | node06 |  32G |   250G  |
| 2019  | proj-docker02  | Ubuntu 24.04 Server | 10.25.20.24 |   6    |  24  | node05 |  32G |    N/A  |
| 2020  | proj-ztna01    | Ubuntu 24.04 Server | 10.25.20.25 |   2    |   2  | node04 |  32G |    N/A  |
| 2021  | proj-dev02     | Ubuntu 24.04 Server | 10.25.20.26 |   2    |   8  | node04 |  32G |    N/A  |
| 2022  | proj-cisbench  | Ubuntu 24.04 Server | 10.25.20.27 |   2    |   2  | node01 |  32G |    N/A  |
| 2023  | proj-oscal01   | Ubuntu 24.04 Server | 10.25.20.28 |   2    |   8  | node04 |  32G |   100G  |
| 3001  | proj-k8s01     | Ubuntu 24.04 Server | 10.25.20.4  |  16    |  82  | node01 |  32G |  1000G  |
| 3002  | proj-k8s02     | Ubuntu 24.04 Server | 10.25.20.5  |  16    |  82  | node03 |  32G |  1000G  |
| 3003  | proj-k8s03     | Ubuntu 24.04 Server | 10.25.20.6  |  16    |  82  | node04 |  32G |  1000G  |
| 4001  | radio-vdi01    | Windows 11          | 10.25.30.2  |   4    |  16  | node07 | 125G |     N/A |
| 4002  | radio-vdi02    | Windows 11          | 10.25.30.3  |   4    |  16  | node07 | 125G |     N/A |
| 4003  | radio-vdi03    | Windows 11          | 10.25.30.4  |   4    |  16  | node06 | 125G |     N/A |
| 4004  | radio-vdi04    | Windows 11          | 10.25.30.5  |   4    |  16  | node06 | 125G |     N/A |
| 4005  | radio-vdi05    | Windows 11          | 10.25.30.6  |   4    |  16  | node07 | 125G |     N/A |
| 4006  | proj-kasm01    | Ubuntu 24.04 Server | 10.25.30.7  |   8    |  32  | node02 |  32G |   250G  |

## **Node Resource Summary & Oversubscription Analysis**

| Node   | Total vCPU | Total vRAM (GB) | VM Count | Primary Workload Focus |
|--------|------------|-----------------|----------|------------------------|
| node01 | 20         | 90              | 3        | K8s master + domain controller + CIS bench |
| node02 | 28         | 94              | 7        | Management services + KASM + file storage |
| node03 | 20         | 92              | 3        | K8s worker + DC replica + MongoDB |
| node04 | 20         | 92              | 3        | K8s worker + development + ZTNA |
| node05 | 24         | 76              | 7        | Storage + monitoring + backup + Ansible |
| node06 | 32         | 128             | 6        | Databases + containers + VDI |
| node07 | 30         | 120             | 6        | GPU + AI/ML + VDI workloads |

### **Total Cluster Resources:**
- **Total vCPUs Allocated**: 174
- **Total vRAM Allocated**: 692 GB  
- **Total Active VMs**: 35
- **Average CPU per Node**: ~24.9 cores
- **Average RAM per Node**: ~98.9 GB

### **Oversubscription Status:**
- **CPU**: Light strategic oversubscription
- **Memory**: All nodes operating within safe margins
- **Storage**: Distributed across multiple storage pools
- **Network**: Balanced across VLAN segments
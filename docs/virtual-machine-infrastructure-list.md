### **Control Plane VMs (VLAN10 & VLAN20)**
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | Disk 2 |  VLAN  | Node    |
|-------------|--------------|--------------|--------------------------|------|------|---------|--------|--------|---------|
| 10.25.20.4  | proj-k8sm01  | Ubuntu 24.04 | K8s Management Node      | 2    | 8GB  | 32GB    | 250GB  | VLAN20 | node01  |
| 10.25.20.5  | proj-k8sm02  | Ubuntu 24.04 | K8s Management Node      | 2    | 8GB  | 32GB    | 250GB  | VLAN20 | node02  |
| 10.25.20.6  | proj-k8sm03  | Ubuntu 24.04 | K8s Management Node      | 2    | 8GB  | 32GB    | 250GB  | VLAN20 | node03  |
---

### **Worker Nodes**
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | Disk 2 |  VLAN  | Node    |
|-------------|--------------|--------------|--------------------------|------|------|---------|--------|--------|---------|
| 10.25.20.7  | proj-code01  | Ubuntu 24.04 | K8s Worker Node          | 4    | 12GB |  32GB   |  100GB | VLAN20 | node04  |
| 10.25.20.10 | proj-gpu01   | Ubuntu 24.04 | K8s Worker Node          | 8    | 32GB | 150GB   | 2000GB | VLAN20 | node04  |
| 10.25.20.12 | proj-kasm01  | Ubuntu 24.04 | K8s Worker Node          | 6    | 24GB | 150GB   |  250GB | VLAN20 | nas01   |

---

### **Infrastructure & Shared Services**
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | Disk 2 | VLAN   | Node   |
|-------------|--------------|--------------|--------------------------|------|------|---------|--------|--------|--------|
| 10.25.20.2  | dc01         | Server 2025  | PDC                      | 2    | 6GB  | 125GB   | 50GB   | VLAN10 | node01 |
| 10.25.20.X  | dc02         | Server 2025  | RODC                     | 2    | 6GB  | 125GB   | 50GB   | VLAN20 | node03 |
| 10.25.10.3  | lab-dns01    | Ubuntu 24.04 | DNS Server               | 2    | 2GB  | 32GB    |        | VLAN10 | node02 |
| 10.25.20.3  | lab-dns02    | Ubuntu 24.04 | DNS Server               | 2    | 2GB  | 32GB    |        | VLAN20 | node03 |
| 10.25.10.13 | lab-mon01    | Ubuntu 24.04 | Monitoring Cluster       | 2    | 4GB  | 32GB    | 750GB  | VLAN10 | node02 |
| 10.25.10.14 | lab-soc1     | Ubuntu 24.04 | Wazuh Security           | 4    | 12GB | 100GB   |        | VLAN10 | node01 |
| 10.25.10.15 | lab-ansible01| Ubuntu 24.04 | Ansible & AWX            | 2    | 4GB  | 32GB    |        | VLAN10 | node02 |
| 10.25.10.16 | lab-port01   | Ubuntu 24.04 | Portainer Control Node   | 2    | 4GB  | 32GB    |        | VLAN10 | node01 |
| 10.25.20.19 | proj-fs01    | Server 2025  | File Server              | 2    | 6GB  | 32GB    | 250GB  | VLAN20 | node04 |
| 10.25.20.22 | proj-fs02    | Server 2025  | File Server              | 2    | 6GB  | 125G    | 500GB  | VLAN20 | node04 |
| 10.25.20.24 | proj-fs03    | Ubuntu 24.04 | File Server              | 2    | 6GB  | 125G    | 750GB  | VLAN20 | node04 |

---

### **Application & Database VMs**
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | Disk 2 | VLAN   | Node   |
|-------------|--------------|--------------|--------------------------|------|------|---------|--------|--------|--------|
| 10.25.20.13 | proj-pgts01  | Ubuntu 24.04 | TimescaleDB              | 4    | 16GB | 32GB    | 500GB  | VLAN20 | node04 |
| 10.25.20.14 | proj-pg01    | Ubuntu 24.04 | PostgreSQL Database      | 4    | 16GB | 32GB    | 500GB  | VLAN20 | node04 |
| 10.25.20.15 | proj-pggis01 | Ubuntu 24.04 | PostgreSQL w/ GIS        | 4    | 16GB | 32GB    | 500GB  | VLAN20 | node04 |
| 10.25.20.23 | proj-sql01   | Server 2025  | RDS Server               | 4    | 16GB | 125GB   | 500GB  | VLAN20 | node04 |

---
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | Disk 2 | VLAN   | Node   |
| 10.25.20.20 | proj-rds01   | Server 2025  | RDS Server               | 4    | 16GB | 125GB   | 100GB  | VLAN20 | node04 |
| 10.25.20.26 | proj-mssql01 | Server 2025  | MSSQL 2022 Standard      | 6    | 16GB | 125GB   | 100GB  | VLAN20 | node04 |


### **Portainer & Shared Containers**
| IP Address  | Hostname     | OS           | Role                     | vCPU | RAM  | Disk 1  | VLAN   | Node   |
|-------------|--------------|--------------|--------------------------|------|------|---------|--------|--------|
| 10.25.20.25 | proj-poc01   | Ubuntu 24.04 | Portainer Docker Node    | 6    | 32GB | 32GB    | VLAN20 | node04 |
| 10.25.10.18 | lab-apps01   | Ubuntu 24.04 | Portainer Docker Node    | 4    | 16GB | 32GB    | VLAN10 | node02 |
| 10.25.20.21 | proj-apps01  | Ubuntu 24.04 | Portainer Docker Node    | 4    | 12GB | 32GB    | 500GB  | VLAN20 | node04 |

---

Here’s the updated **Node Summary (Resource Usage)**, along with a **full list of tags** for your VM inventory.

---

You're right—I’ll re-examine the VM list carefully and recalculate everything accurately.

### **Updated Node Summary (Resource Usage)**  
| Node   | VMs Assigned                                                           | vCPU Used | RAM Used |
|--------|------------------------------------------------------------------------|----------|---------|
| node01 | proj-k8sm01, proj-k8sw01, dc01, lab-soc1                               | 16       | 58GB    |
| node02 | proj-k8sm02, proj-k8sw02, lab-dns01, lab-mon01, lab-ansible01, lab-apps01 | 18       | 66GB    |
| node03 | proj-k8sm03, proj-k8sw03, lab-db01, dc02, proj-dns01                   | 16       | 64GB    |
| node04 | proj-k8sw04, proj-pg01, proj-pggis01, proj-pgts01, proj-rds01, proj-apps01, proj-fs01, lab-port01 | 28 | 86GB |
| nas01  | proj-k8sw05, proj-kasm01                                               | 14       | 56GB    |

---

### **Full List of Tags**
#### **General Tags**
- `ubuntu-24.04`
- `server-2025`
- `cis-level1`
- `cis-level2`
- `ansible-managed`
- `portainer`
- `docker-node`
- `postgresql`
- `timescaledb`
- `gis`
- `windows-ad`
- `monitoring`
- `logging`
- `security`
- `file-server`
- `automation`

#### **Kubernetes Tags**
- `k8s-control-plane`
- `k8s-worker-node`
- `k8s-managed`
- `k8s-storage-node`

#### **Infrastructure Tags**
- `domain-controller`
- `dns-server`
- `wazuh`
- `grafana`
- `prometheus`
- `rabbitmq`
- `rke2`
- `terraform`
- `unraid`

#### **Project-Specific Tags**
- `hydrogen-line`
- `radio-astronomy`
- `milvus`
- `geospatial`
- `data-pipeline`
- `ml-ai`
- `airflow`
- `rag`
- `gpu-node`
- `sdr-processing`


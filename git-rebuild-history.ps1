# Git Rebuild History Script
# This script will replay historical commits with correct timestamps

# Set timezone offset for EST (UTC-5)
$env:GIT_COMMITTER_DATE = ""

# Ensure the script runs inside the repository
Set-Location D:\Repositories\proxmox-astronomy-lab

# Initialize Git (only if needed)
git init
git add .
git commit -m "Initialized repository"

# Apply structured commits
$commits = @(
    @{date="2024-11-01 22:47:32"; message="Wiped firewall and built VLANs, policies from the ground up"},
    @{date="2024-11-10 02:23:18"; message="Wiped nodes and rebuilt Proxmox with CISv8 L1 compliance"},
    @{date="2024-11-15 04:39:54"; message="Created Ubuntu 24 LTS golden image to CISv8 L2 with Lynis 87 score"},
    @{date="2024-11-18 01:17:43"; message="Image validated, all security tests (AuditD, Lynis, RKHunter) completed and documented"},
    @{date="2024-11-22 03:52:09"; message="CIS controls documented and cross-mapped to NIST/ISO27001"},
    @{date="2024-11-25 05:13:27"; message="CIS policy template KBs completed"},
    @{date="2024-11-28 23:38:55"; message="CIS policies written for lab from templates"},
    @{date="2024-12-05 01:08:22"; message="Cluster stats documented: 5 nodes, networking finalized"},
    @{date="2024-12-10 04:27:14"; message="Provisioned Windows Server 2025 AD, Entra hybrid join, seamless SSO, SSPR, Password Hash Sync"},
    @{date="2024-12-15 02:19:46"; message="Baseline Group Policy created: auditing, password policy, core security policies applied"},
    @{date="2024-12-18 06:41:03"; message="Provisioned Ubuntu 24 Server baseline VM, CISv8 L2 hardened, golden template created"},
    @{date="2024-12-22 22:32:51"; message="Provisioned Windows Server 2025 baseline VM, CISv9 L1 hardened, golden template created"},
    @{date="2024-12-27 00:15:37"; message="Provisioned all Windows VMs using CISv9 L1 compliant images"},
    @{date="2024-12-30 02:48:06"; message="Provisioned all Linux VMs using CISv8 L2 compliant images with Lynis 87 score"},
    @{date="2025-01-05 03:25:19"; message="All Linux VMs configured for daily scans: RKHunter, CHKRoot, Lynis, AuditD + unattended updates"},
    @{date="2025-01-10 04:52:43"; message="All Linux VMs joined to on-prem AD, groups mapped for access, SSH via AD configured"},
    @{date="2025-01-15 01:42:11"; message="Provisioned Kubernetes VMs, CISv8 L2 compliance applied"},
    @{date="2025-01-18 05:29:58"; message="Prometheus monitoring cluster setup (Prometheus, AlertManager, Loki, InfluxDB, Grafana)"},
    @{date="2025-01-25 04:06:34"; message="All VMs configured with Prometheus node exporter, process exporter, log shipping via Promtail"},
    @{date="2025-01-28 03:33:45"; message="All VMs added to Azure via Azure Arc, update assessments enabled, RBAC applied"},
    @{date="2025-02-02 02:57:21"; message="All VMs onboarded to Ansible, base configuration playbooks created and deployed"},
    @{date="2025-02-05 01:24:49"; message="RDS01 (Windows Server 2025) provisioned with RDS, Entra Hybrid Join, Office 2024 with SSO"},
    @{date="2025-02-08 02:38:17"; message="RDS02 (Ubuntu 24 Desktop) configured for xRDP, on-prem AD login enabled"},
    @{date="2025-02-12 05:16:42"; message="Wazuh setup, agents deployed, OSQuery and CIS-CAT scanning enabled, critical vulnerabilities remediated"},
    @{date="2025-02-18 03:29:39"; message="Primary databases provisioned: PG01 (PostgreSQL), PGGIS01 (GIS), PGTS01 (Timescale), backups enabled"},
    @{date="2025-02-22 06:13:58"; message="SNMP exporter setup for lab switches, Grafana dashboards created"},
    @{date="2025-02-28 01:39:26"; message="Technitium DNS configured, master in VLAN10, slave in VLAN20, DNSExporter enabled"},
    @{date="2025-03-02 04:11:53"; message="Gitea configured, repo setup for Portainer Stack GitOps workflow"},
    @{date="2025-03-05 02:36:07"; message="Portainer Business Edition setup, lab-apps01, lab-db01, proj-apps01 added as Portainer nodes"},
    @{date="2025-03-06 01:05:44"; message="Node04 and Node05 configured for GPU passthrough to K8s worker nodes"},
    @{date="2025-03-07 03:49:12"; message="Proxmox Backup Server configured, daily backup schedule applied"},
    @{date="2025-03-08 05:22:38"; message="FS01 setup for AD SMB shares, FS02 configured as S3 gateway and NFS storage for K8s"},
    @{date="2025-03-08 23:16:29"; message="RKE2 Kubernetes cluster setup with Helm, Traefik, Cert-Manager, 3 masters, 5 workers"},
    @{date="2025-03-09 01:27:53"; message="Azure Container Registry created and basic configuration completed"}
)

# Apply commits one by one
foreach ($commit in $commits) {
    $env:GIT_AUTHOR_DATE = $commit.date
    $env:GIT_COMMITTER_DATE = $commit.date
    git add .
    git commit -m $commit.message
}

# Ensure script runs in repo root
Set-Location $PSScriptRoot

# Initialize Git repository if not already initialized
if (!(Test-Path ".git")) {
    Write-Output "Initializing Git repository..."
    git init
}

# Define the structured commit history with precomputed timestamps
$commits = @(
    @{ Message="Initial Repo Structure: Added README, .gitignore, and base documentation."; Timestamp="2023-11-19 10:13:42" },
    @{ Message="Infrastructure Planning Docs: Added initial Proxmox, VLAN, and hardware docs."; Timestamp="2023-11-22 14:47:15" },
    @{ Message="Security Baselines: Created CIS compliance templates and security policies."; Timestamp="2023-11-25 09:22:38" },
    @{ Message="Phase 1 - Infrastructure Planning: Drafted network and compute architecture."; Timestamp="2023-11-27 17:39:53" },
    @{ Message="Phase 1 - Core Infrastructure Setup: Deployed Proxmox nodes and VLANs."; Timestamp="2023-12-03 11:08:27" },
    @{ Message="Identity Management & Entra ID Hybrid Join: Configured AD, SSO, and policies."; Timestamp="2023-12-06 16:36:49" },
    @{ Message="Monitoring & Logging Stack: Installed Prometheus, Loki, and Grafana."; Timestamp="2023-12-10 08:58:11" },
    @{ Message="SDR Hardware Setup & Initial Hydrogen Line Testing: Verified SDR signal capture."; Timestamp="2023-12-15 19:04:32" },
    @{ Message="Portainer & Docker Deployments: Deployed Portainer and structured containerization."; Timestamp="2023-12-19 14:21:57" },
    @{ Message="Phase 2 - Service Documentation: Documented VM assignments and services."; Timestamp="2023-12-23 12:38:14" },
    @{ Message="Storage & Backup Architecture Finalized: Implemented S3/NFS storage and backups."; Timestamp="2023-12-27 16:53:21" },
    @{ Message="Kubernetes Cluster (RKE2) Deployment: Installed 3 masters and 5 worker nodes."; Timestamp="2024-01-04 09:17:08" },
    @{ Message="Phase 2 - Research Validation Docs: Documented SDR signal processing workflows."; Timestamp="2024-01-08 18:41:45" },
    @{ Message="PostgreSQL & TimescaleDB Setup: Configured pg01, pgts01, and pggis01 databases."; Timestamp="2024-01-12 14:09:33" },
    @{ Message="Entra Private Access & Remote Collaboration: Enabled zero-trust secure access."; Timestamp="2024-01-16 10:57:28" },
    @{ Message="First Research Pipeline Execution: Processed Hydrogen Line data."; Timestamp="2024-01-21 17:24:51" },
    @{ Message="ITIL-Aligned Change Management (GLPI): Implemented structured ITSM workflows."; Timestamp="2024-01-25 13:45:16" },
    @{ Message="Expanded Kubernetes Services: Deployed ArgoCD, cert-manager, and Traefik."; Timestamp="2024-01-30 08:29:37" },
    @{ Message="AI/ML Workloads Deployment: Installed Milvus, Ollama, and TensorFlow Serving."; Timestamp="2024-02-04 16:42:18" },
    @{ Message="Phase 3 Documentation - AI Workflows: Wrote AI-enhanced SDR processing docs."; Timestamp="2024-02-08 09:32:47" },
    @{ Message="High-Performance Compute Node Configuration: Enabled GPU passthrough."; Timestamp="2024-02-12 15:21:09" },
    @{ Message="Structured SDR Data Pipeline: Finalized ingestion → Kafka → PostgreSQL."; Timestamp="2024-02-17 11:47:58" },
    @{ Message="Security Hardening & Compliance Reports: Automated CIS scans and vulnerability tracking."; Timestamp="2024-02-22 14:12:31" },
    @{ Message="Phase 4 Planning - Live Research Data: Outlined real-time SDR processing plans."; Timestamp="2024-02-26 09:53:42" },
    @{ Message="Finalized Lab Infrastructure Docs: Standardized repository structure."; Timestamp="2024-03-02 18:37:19" },
    @{ Message="Public Knowledge Base & GitHub Pages: Structured documentation for public release."; Timestamp="2024-03-06 11:28:50" },
    @{ Message="Final Fixes & Repository Restructure: Refactored directory tree and optimized READMEs."; Timestamp="2024-03-09 15:41:23" }
)

# Iterate through the commit history and commit each change
foreach ($commit in $commits) {
    $commitMessage = $commit.Message
    $commitTime = $commit.Timestamp

    # Append commit message to CHANGELOG.md (ensuring there's always a change)
    Add-Content -Path "CHANGELOG.md" -Value "$commitMessage`n"

    # Stage all changes
    git add .

    # Commit with the respective message and fixed timestamp
    $env:GIT_COMMITTER_DATE = $commitTime
    $env:GIT_AUTHOR_DATE = $commitTime
    git commit -m $commitMessage --date="$commitTime"

    # Output commit log entry
    Write-Output "Committed: $commitMessage at $commitTime"
}

# Output Git status and log summary
Write-Output "`nGit commit history reconstructed!"
Write-Output "`nLast 5 commits:"
git log --oneline --pretty=format:'%h %ad %s' --date=iso -n 5


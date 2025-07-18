# Create-ProxmoxLabStructure.ps1
# Creates the complete directory structure and placeholder README files for Proxmox Astronomy Lab
# Run from repository root directory

Write-Host "Creating Proxmox Astronomy Lab directory structure..." -ForegroundColor Green

# Define the directory structure
$directories = @(
    "ai",
    "ai/gpu-node",
    "docs",
    "docs/HowTo", 
    "docs/ITIL-Processes",
    "docs/Policies",
    "hardware",
    "hardware/benchmarks",
    "hardware/diagrams",
    "infrastructure",
    "infrastructure/authentication",
    "infrastructure/databases", 
    "infrastructure/fileservices",
    "infrastructure/k8s",
    "infrastructure/orchestration",
    "monitoring",
    "projects",
    "projects/desi-agn-outflows",
    "projects/desi-cosmic-voids", 
    "projects/desi-qad-anomalous-quasars",
    "publishing",
    "reproducibility",
    "reproducibility/terraform-ansible",
    "security",
    "security/CIS",
    "security/CNKF",
    "security/SSP"
)

# Define README files to create (directory READMEs only)
$readmeFiles = @(
    "README-pending.md",
    "ai/README-pending.md",
    "docs/README-pending.md", 
    "hardware/README-pending.md",
    "infrastructure/README-pending.md",
    "monitoring/README-pending.md",
    "projects/README-pending.md",
    "publishing/README-pending.md",
    "reproducibility/README-pending.md",
    "security/README-pending.md"
)

# Create directories
Write-Host "`nCreating directories..." -ForegroundColor Yellow
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  Created: $dir" -ForegroundColor Gray
    } else {
        Write-Host "  Exists:  $dir" -ForegroundColor DarkGray
    }
}

# Create placeholder README files
Write-Host "`nCreating placeholder README files..." -ForegroundColor Yellow

$placeholderContent = @"
# [PENDING] Documentation Title

**Status**: Pending Documentation  
**Priority**: Directory README  
**Framework**: Golden Template v2.0

## Placeholder Content

This README is pending creation as part of the enterprise documentation refresh.

### Expected Sections
1. Purpose & Overview
2. Dependencies & Relationships  
3. Technical Documentation
4. Management & Operations
5. Security & Compliance

### Documentation Standards
- Follow golden template structure
- Maintain enterprise tone and professional language
- Emphasize hybrid K8s/VM architecture where relevant
- Include appropriate cross-references

---
*This file will be renamed to README.md upon completion*
"@

foreach ($readme in $readmeFiles) {
    if (!(Test-Path $readme)) {
        Set-Content -Path $readme -Value $placeholderContent -Encoding UTF8
        Write-Host "  Created: $readme" -ForegroundColor Gray
    } else {
        Write-Host "  Exists:  $readme" -ForegroundColor DarkGray
    }
}

# Create .gitkeep files for empty subdirectories that don't have READMEs
$emptyDirs = @(
    "ai/gpu-node",
    "docs/HowTo",
    "docs/ITIL-Processes", 
    "docs/Policies",
    "hardware/benchmarks",
    "hardware/diagrams",
    "infrastructure/authentication",
    "infrastructure/databases",
    "infrastructure/fileservices", 
    "infrastructure/k8s",
    "infrastructure/orchestration",
    "projects/desi-agn-outflows",
    "projects/desi-cosmic-voids",
    "projects/desi-qad-anomalous-quasars",
    "reproducibility/terraform-ansible",
    "security/CIS",
    "security/CNKF", 
    "security/SSP"
)

Write-Host "`nCreating .gitkeep files for empty directories..." -ForegroundColor Yellow
foreach ($dir in $emptyDirs) {
    $gitkeepPath = Join-Path $dir ".gitkeep"
    if (!(Test-Path $gitkeepPath)) {
        Set-Content -Path $gitkeepPath -Value "# Placeholder file to maintain directory structure in git" -Encoding UTF8
        Write-Host "  Created: $gitkeepPath" -ForegroundColor Gray
    }
}

Write-Host "`n✅ Structure creation complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Update tree.txt with new structure" -ForegroundColor White
Write-Host "  2. Begin README documentation following golden template" -ForegroundColor White
Write-Host "  3. Rename README-pending.md to README.md as each is completed" -ForegroundColor White

Write-Host "`nDirectory READMEs created:" -ForegroundColor Cyan
foreach ($readme in $readmeFiles) {
    Write-Host "  📄 $readme" -ForegroundColor White
}

Write-Host "`n🎯 Today's goal: Complete all 10 directory READMEs" -ForegroundColor Green
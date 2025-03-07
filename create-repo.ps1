# Create-DirectoryStructure.ps1
# Creates the Proxmox Astronomy Lab documentation directory structure

# Set the base directory to the current directory
$baseDir = "./"

# Array of directory paths to create
$directories = @(
    "docs",
    "docs/simulation-approach",
    "docs/compliance-security",
    "docs/compliance-security/cisv8-controls",
    "docs/compliance-security/cisv8-policy-templates",
    "docs/compliance-security/lab-security-policies",
    "docs/compliance-security/hardening-guides",
    "docs/compliance-security/security-monitoring",
    "docs/compliance-security/incident-response",
    "docs/infrastructure",
    "docs/infrastructure/proxmox",
    "docs/infrastructure/networking",
    "docs/infrastructure/storage",
    "docs/infrastructure/kubernetes",
    "docs/entra-hybrid-cloud",
    "docs/entra-hybrid-cloud/identity-management",
    "docs/entra-hybrid-cloud/access-control",
    "docs/itil-processes",
    "docs/itil-processes/change-management",
    "docs/itil-processes/incident-management",
    "docs/itil-processes/problem-management",
    "docs/itil-processes/service-catalog",
    "docs/applications-services",
    "docs/applications-services/databases",
    "docs/applications-services/monitoring",
    "docs/applications-services/automation",
    "docs/observatory-projects",
    "docs/observatory-projects/hydrogen-line",
    "docs/observatory-projects/sdr-processing",
    "docs/observatory-projects/datasets",
    "docs/troubleshooting-procedures",
    "docs/troubleshooting-procedures/common-issues",
    "assets",
    "assets/images",
    "assets/diagrams",
    "scripts",
    "scripts/setup",
    "scripts/compliance",
    "scripts/maintenance",
    "terraform",
    "terraform/proxmox",
    "terraform/cloud"
)

# Create directories and add README.md to each
foreach ($dir in $directories) {
    $fullPath = Join-Path -Path $baseDir -ChildPath $dir
    
    # Create directory if it doesn't exist
    if (-not (Test-Path -Path $fullPath)) {
        Write-Host "Creating directory: $fullPath"
        New-Item -Path $fullPath -ItemType Directory -Force | Out-Null
    } else {
        Write-Host "Directory already exists: $fullPath"
    }
    
    # Create README.md in each directory
    $readmePath = Join-Path -Path $fullPath -ChildPath "README.md"
    if (-not (Test-Path -Path $readmePath)) {
        Write-Host "Creating README.md in: $fullPath"
        # Add a basic title based on the directory name
        $dirName = Split-Path -Path $dir -Leaf
        $title = ($dirName -split '-' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) }) -join ' '
        
        # Create content for README.md
        $content = @"
# $title

## Overview

Documentation for the $title section of the Proxmox Astronomy Lab project.

"@
        Set-Content -Path $readmePath -Value $content
    } else {
        Write-Host "README.md already exists in: $fullPath"
    }
}

# Create main project files
$mainFiles = @(
    "README.md",
    "SECURITY.md",
    "CONTRIBUTING.md",
    "CHANGELOG.md",
    "LICENSE",
    "ROADMAP.md"
)

foreach ($file in $mainFiles) {
    $filePath = Join-Path -Path $baseDir -ChildPath $file
    if (-not (Test-Path -Path $filePath)) {
        Write-Host "Creating file: $filePath"
        
        # Create content based on file type
        $content = ""
        switch ($file) {
            "README.md" {
                $content = @"
# Proxmox Astronomy Lab

## A Scalable, AI-Enhanced Research Infrastructure for Radio Astronomy and Scientific Computing

The **Proxmox Astronomy Lab** is a **high-performance research environment** designed for **Hydrogen Line Radio Astronomy, AI-driven SDR signal processing, and secure, remote collaboration**. The lab combines **Proxmox, Kubernetes, AI/ML, and modern IT automation** to create a **reproducible, scalable** research platform.

## 🔬 The Simulation Approach

The Proxmox Astronomy Lab is unique in its approach: we're deliberately **simulating enterprise-grade IT practices in a citizen science environment**. While most home labs focus solely on functionality, we've implemented a comprehensive security framework meeting CISv8 standards, enforcing proper change management, and maintaining documentation that would normally be found in corporate environments.

This approach serves multiple purposes:
- **Educational value** for those looking to learn enterprise IT practices
- **Practical demonstrations** of security implementations at scale
- **Real-world validation** of compliance frameworks in non-enterprise settings
- **Transferable skills** development for contributors

Read more about our simulation philosophy in [docs/simulation-approach](docs/simulation-approach).

"@
            }
            "SECURITY.md" {
                $content = @"
# Security Policy

## Reporting a Vulnerability

Security is a core focus of the Proxmox Astronomy Lab project. If you discover a security vulnerability, please report it responsibly.

"@
            }
            "CONTRIBUTING.md" {
                $content = @"
# Contributing to Proxmox Astronomy Lab

Thank you for your interest in contributing to the Proxmox Astronomy Lab project!

"@
            }
            "CHANGELOG.md" {
                $content = @"
# Changelog

All notable changes to the Proxmox Astronomy Lab project will be documented in this file.

## [Unreleased]

"@
            }
            "LICENSE" {
                $content = @"
MIT License

Copyright (c) 2025 Proxmox Astronomy Lab

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@
            }
            "ROADMAP.md" {
                $content = @"
# Project Roadmap

This document outlines the planned development roadmap for the Proxmox Astronomy Lab project.

"@
            }
        }
        
        Set-Content -Path $filePath -Value $content
    } else {
        Write-Host "File already exists: $filePath"
    }
}

Write-Host "Directory structure creation complete!"
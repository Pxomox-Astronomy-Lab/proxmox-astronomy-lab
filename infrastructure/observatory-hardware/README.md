<!-- 
---
title: "Observatory Hardware - Proxmox Astronomy Lab"
description: "Documentation of radio astronomy acquisition hardware, signal chain, and research capabilities for Hydrogen Line studies"
author: "VintageDon"
tags: ["observatory", "hardware", "radio-astronomy", "hydrogen-line", "sdr", "antenna"]
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-04-04"
related_services: ["Data Pipelines", "Storage", "Research Applications"]
implements_policies: ["Research Data Policy", "Equipment Management Policy"]
phase: "phase-2"
---
-->

# 📡 **Observatory Hardware - Proxmox Astronomy Lab**

# 🔍 **1. Overview**

The Observatory Hardware infrastructure represents the data acquisition layer for the Proxmox Astronomy Lab, focusing primarily on radio astronomy observations with an emphasis on Hydrogen Line (1420 MHz) studies. This specialized equipment chain enables the collection, amplification, and preliminary processing of radio signals from cosmic sources before integration with the lab's data processing infrastructure.

This section documents the complete hardware components, signal chain specifications, calibration procedures, and integration points that comprise the radio astronomy observation capabilities of the lab. The hardware selection follows research-grade design principles while remaining accessible for citizen science applications.

---

# 🛰️ **2. Signal Acquisition Hardware**

## **2.1 Antenna Systems**

The primary signal collection infrastructure designed to capture weak cosmic radio signals at the Hydrogen Line frequency.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Nooelec Hydrogen Line Parabolic Antenna** | 20 dBi gain antenna optimized for 1420 MHz observations | [Hydrogen Line Feed Chain](./hydrogen-line-feed-chain.md) |

## **2.2 Amplification & Filtering Chain**

The specialized components that filter, amplify, and condition weak radio signals before digital processing.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **BP-2 Band-Pass Filter** | Filters unwanted RF interference centered on 1420 MHz with 0.7 dB loss | [Components Specifications](./components-specifications.md) |
| **1420 MHz Cavity LNA** | Low-noise amplifier with 0.28 dB noise figure and 34 dB gain | [Components Specifications](./components-specifications.md) |
| **ERB Noise Source** | 10 dB calibrated reference for system temperature verification | [Components Specifications](./components-specifications.md) |

## **2.3 Digital Signal Processing**

The components that convert analog RF signals to digital data for computer processing.

| **Component** | **Function** | **Documentation** |
|--------------|-------------|-------------------|
| **Airspy R2 SDR** | High dynamic range software-defined radio for signal digitization | [Components Specifications](./components-specifications.md) |
| **LBE-1420 GPSDO** | GPS-disciplined oscillator for precise frequency reference | [Components Specifications](./components-specifications.md) |
| **N100 Mini PC** | Edge computing node for initial signal processing | [Components Specifications](./components-specifications.md) |

---

# 🔬 **3. Research Capabilities**

## **3.1 Primary Research Areas**

The hardware infrastructure is optimized for several specific astronomical observations.

| **Research Area** | **Capability** | **Documentation** |
|------------------|---------------|-------------------|
| **Hydrogen Line Studies** | Detection of 1420 MHz emissions from galactic and extragalactic sources | [Hydrogen Line Feed Chain](./hydrogen-line-feed-chain.md) |
| **High-Velocity Clouds** | Doppler shift analysis of HVCs moving through our galaxy | [Hydrogen Line Feed Chain](./hydrogen-line-feed-chain.md) |
| **Supernova Remnants** | Mapping hydrogen distribution in SNRs | [Hydrogen Line Feed Chain](./hydrogen-line-feed-chain.md) |

---

# 🔗 **4. Directory Contents**

This section provides direct navigation to all key documents in this category:

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Hydrogen Line Feed Chain** | Complete signal path documentation | [hydrogen-line-feed-chain.md](./hydrogen-line-feed-chain.md) |
| **Components Specifications** | Detailed technical specifications | [components-specifications.md](./components-specifications.md) |

---

# 🔄 **5. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Research Projects** | Scientific research utilizing this hardware | [Research Projects](/docs/Research-Projects/README.md) |
| **Data Pipelines** | Processing infrastructure for observatory data | [Data Pipelines](/docs/Research-Projects/Data-Pipelines/README.md) |
| **Applications** | Software used with observatory hardware | [Radio Astronomy Applications](/docs/Applications/Radio-Astronomy/README.md) |
| **Infrastructure** | Computing resources supporting data analysis | [Infrastructure Documentation](/infrastructure/README.md) |

---

# ✅ **6. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **7. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-04-04 | Structured README for observatory hardware | VintageDon |

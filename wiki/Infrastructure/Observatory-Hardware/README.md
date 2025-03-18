<!-- 
---
title: "Proxmox Astronomy Lab - Observatory Hardware"
description: "Documentation of the radio astronomy equipment, signal chains, and hardware components used for hydrogen line research"
author: "VintageDon"
tags: ["hardware", "radio-astronomy", "hydrogen-line", "sdr", "antenna"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-16"
---
-->

# 📡 **Proxmox Astronomy Lab - Observatory Hardware**

Our observatory hardware comprises specialized radio astronomy equipment designed for hydrogen line detection, signal processing, and data acquisition in an urban residential environment.

## 🔭 **1. Research Focus**

The hardware infrastructure is optimized for:

- **Hydrogen Line studies** (1.42 GHz)
- **High-Velocity Cloud (HVC) tracking**
- **Supernova Remnant (SNR) detection**
- **Long-term drift scan observations**

Our equipment balances sensitivity requirements with practical constraints of an urban deployment.

## 📊 **2. Feed Chain Architecture**

The radio astronomy signal chain consists of carefully matched components that maximize sensitivity while minimizing noise and interference.

![Feed Chain Diagram](../assets/feed-chain-diagram.png)

### **2.1 Signal Chain Components**

| **Component** | **Model** | **Specifications** | **Documentation** |
|--------------|----------|-------------------|-------------------|
| **Antenna** | Nooelec Hydrogen Line Parabolic | 20 dBi gain, 1.42 GHz | [Details →](hydrogen-line-feed-chain.md#antenna) |
| **Pre-LNA Filter** | BP-2 | 0.7 dB loss, ±30 MHz bandwidth | [Details →](hydrogen-line-feed-chain.md#pre-lna-filter) |
| **Low Noise Amplifier** | 1420 MHz Cavity LNA | 0.28 dB noise figure, 34 dB gain | [Details →](hydrogen-line-feed-chain.md#low-noise-amplifier) |
| **Noise Calibration** | ERB Noise Source | 10 dB output, Kelvin calibrated | [Details →](hydrogen-line-feed-chain.md#calibration) |
| **SDR Receiver** | Airspy R2 | High dynamic range | [Details →](hydrogen-line-feed-chain.md#sdr) |
| **Clock Source** | LBE-1420 GPSDO | GPS-disciplined oscillator | [Details →](hydrogen-line-feed-chain.md#clock) |

This carefully engineered signal chain achieves a system temperature of approximately 70K, enabling citizen science-grade hydrogen line observations.

## 🌐 **3. Deployment Environment**

### **3.1 Site Characteristics**

Our urban deployment presents specific challenges and constraints:

- **Location**: Columbus, OH (40.0059° N, 82.9991° W)
- **Sky Coverage**: Primary focus on Northwest quadrant
- **Mount Height**: 6-8 ft (minimizing visual impact)
- **RFI Environment**: Urban setting with various interference sources

### **3.2 Environmental Mitigation**

The hardware implements several strategies to address environmental challenges:

- **RFI Scanning**: On-demand interference detection and classification
- **Narrow Filtering**: Targeted bandpass filtering at multiple stages
- **Temporal Averaging**: Long-duration observations to improve signal-to-noise ratio
- **Weather Protection**: Appropriate enclosures for outdoor components

## 💻 **4. Data Processing Hardware**

Raw SDR signals are processed through a dedicated hardware chain:

| **Component** | **Specifications** | **Purpose** |
|--------------|-------------------|------------|
| **Edge Node** | N100 Mini PC, 12GB RAM, 1TB SSD | Initial signal processing and forwarding |
| **Processing Server** | Proxmox Node04 (GPU-equipped) | Signal analysis and AI-enhanced processing |
| **Storage Target** | TimescaleDB (proj-pgts01) | Time-series data storage |

For complete specifications of the data processing infrastructure, see the [Data Processing Pipeline documentation](../projects/data-processing-pipeline.md).

## 🧪 **5. Calibration Methodology**

Our equipment undergoes structured calibration to ensure research-grade results:

- **Noise Source Calibration**: Known-temperature reference for system validation
- **Celestial Calibration**: Using Cassiopeia A as a reference source
- **System Temperature Measurement**: Regular verification of overall sensitivity
- **Frequency Verification**: GPSDO-based precision frequency reference

Complete calibration procedures are documented in the [Calibration Methodology guide](calibration-methodology.md).

## 🚀 **6. Future Expansion**

Planned hardware upgrades include:

- **Antenna Upgrade**: Potential 1.2m dish for higher gain
- **Motorized Mount**: Explore Scientific iEXOS-100 for tracking capabilities
- **Additional Feed Options**: Expanded frequency coverage for pulsar observations
- **Distributed Processing**: Additional edge nodes for parallel signal processing

## 📝 **7. Documentation Resources**

Detailed hardware documentation is available:

- [**Hydrogen Line Feed Chain**](hydrogen-line-feed-chain.md) - Complete signal path details
- [**Components Specifications**](components-specifications.md) - Technical specifications
- [**Calibration Methodology**](calibration-methodology.md) - Procedures and standards
- [**SDR Configuration Guide**](sdr-configuration.md) - Software-defined radio setup

## **✅ Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-16 | ✅ Approved |

## **📜 Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-16 | Initial observatory hardware README | VintageDon |

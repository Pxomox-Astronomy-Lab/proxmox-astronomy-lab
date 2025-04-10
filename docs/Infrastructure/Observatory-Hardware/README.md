# 📡 **Observatory Hardware**

# 🔍 **1. Overview**

The Observatory Hardware section documents the specialized radio astronomy equipment deployed in the Proxmox Astronomy Lab, with a primary focus on hydrogen line detection at 1.42 GHz. This hardware forms the foundation of our scientific research capabilities, allowing for detection and analysis of galactic hydrogen emissions, high-velocity clouds (HVCs), and supernova remnants (SNRs) through a carefully engineered signal chain optimized for citizen science-grade observations.

Our observatory hardware is designed to balance scientific capability with practical constraints of an urban residential deployment, implementing specialized filters, amplifiers, and processing systems to achieve research-grade sensitivity while maintaining a minimal physical footprint and aesthetic impact.

---

# 📻 **2. Radio Astronomy Feed Chain**

## **2.1 Antenna System**

The radio telescope's front-end components that capture hydrogen line signals:

| **Component** | **Specifications** | **Documentation** |
|--------------|-------------------|-------------------|
| **Parabolic Antenna** | Nooelec H1 20dBi Gain | [Antenna Details](hydrogen-line-feed-chain.md#antenna) |
| **Mounting System** | Fixed mount, NW quadrant focus | [Mount Configuration](mounting-system.md) |
| **Feed Horn** | 1.42 GHz optimized design | [Feed Design](feed-design.md) |

## **2.2 Signal Processing Chain**

Low-noise amplification and filtering system for hydrogen line detection:

| **Component** | **Specifications** | **Documentation** |
|--------------|-------------------|-------------------|
| **Pre-LNA Filter** | BP-2 Filter (1.42 GHz centered) | [Filter Specifications](hydrogen-line-feed-chain.md#pre-lna-filter) |
| **Low Noise Amplifier** | 1420 MHz Cavity LNA (0.28 dB NF) | [LNA Details](hydrogen-line-feed-chain.md#low-noise-amplifier) |
| **Noise Calibration** | ERB 10 dB Noise Source | [Calibration System](hydrogen-line-feed-chain.md#calibration) |

## **2.3 Receiver Equipment**

Software-defined radio and supporting components:

| **Component** | **Specifications** | **Documentation** |
|--------------|-------------------|-------------------|
| **SDR Receiver** | Airspy R2 | [SDR Configuration](SDR-Equipment/airspy-r2-configuration.md) |
| **Clock Source** | LBE-1420 GPSDO | [GPSDO Setup](hydrogen-line-feed-chain.md#clock) |
| **Edge Processing** | N100 Mini PC (Edge Node) | [Edge Computing](edge-node-configuration.md) |

---

# 🔧 **3. Technical Specifications**

## **3.1 System Performance**

Key technical parameters that define the observatory's capabilities:

| **Parameter** | **Value** | **Significance** |
|--------------|----------|-----------------|
| **System Temperature** | ~70K | Determines sensitivity to weak signals |
| **Total Gain** | ~54 dB | Amplification throughout signal chain |
| **Frequency Range** | 1.4-1.427 GHz | Optimized for hydrogen line (1.42 GHz) |
| **Beamwidth** | ~10° | Angular resolution of observation |

## **3.2 Cabling & Connectivity**

Signal transmission infrastructure:

| **Component** | **Specifications** | **Documentation** |
|--------------|-------------------|-------------------|
| **Primary Coax** | LMR400 (25ft) | [Cable Configuration](cabling-configuration.md) |
| **Connectors** | SMA (Male/Female) | [Connector Types](connector-specifications.md) |
| **Lightning Protection** | Proxicast Arrestor | [Lightning Protection](lightning-protection.md) |

---

# 🌐 **4. Deployment Environment**

## **4.1 Site Characteristics**

Environmental considerations for the observatory:

| **Aspect** | **Details** | **Documentation** |
|-----------|-----------|-------------------|
| **Location** | Columbus, OH (40.0059° N, 82.9991° W) | [Site Survey](site-survey.md) |
| **Sky Coverage** | Northwest Quadrant primary focus | [Observation Window](observation-windows.md) |
| **RFI Environment** | Urban residential, moderate interference | [RFI Analysis](rfi-environment-analysis.md) |

## **4.2 Environmental Controls**

Measures to protect equipment and optimize performance:

| **Control Type** | **Implementation** | **Documentation** |
|-----------------|-------------------|-------------------|
| **Weather Protection** | Weatherproof housing for outdoor components | [Weather Protection](weather-protection.md) |
| **Temperature Management** | Passive cooling for LNA and components | [Thermal Management](thermal-management.md) |
| **RFI Mitigation** | Bandpass filtering, shielding | [RFI Mitigation](rfi-mitigation.md) |

---

# 📈 **5. Security & Compliance**

## **5.1 Security Controls**

Security measures protecting observatory hardware:

| **Control Type** | **Implementation** | **Verification Method** |
|------------------|-------------------|-------------------------|
| **Physical Security** | Secure mounting, tamper-evident seals | Visual inspection |
| **Access Control** | Limited physical access to equipment | Access logging |
| **System Isolation** | Separate network segment for SDR data | Network monitoring |

## **5.2 Compliance Requirements**

Regulatory considerations for radio equipment:

| **Requirement** | **Standard/Framework** | **Verification Evidence** |
|-----------------|----------------------|---------------------------|
| **RF Transmission** | FCC Part 15 (receive only) | Equipment certification |
| **Environmental Impact** | Local regulations for exterior mounting | Installation documentation |
| **Power Safety** | Low voltage DC compliance | Safety inspection |

---

# 🧪 **6. Calibration & Validation**

## **6.1 Calibration Procedures**

Methods to ensure accurate measurements:

| **Procedure** | **Frequency** | **Documentation** |
|---------------|--------------|-------------------|
| **Noise Source Calibration** | Monthly | [Noise Calibration](calibration-procedures.md#noise-source) |
| **Celestial Source Verification** | Quarterly | [Celestial Calibration](calibration-procedures.md#celestial) |
| **System Temperature Validation** | Bi-annually | [System Temp Verification](calibration-procedures.md#system-temp) |

## **6.2 Validation Results**

Performance validation measurements:

| **Test** | **Result** | **Documentation** |
|----------|-----------|-------------------|
| **Hydrogen Line Detection** | Confirmed (Jan 2025) | [Initial Detection](validation-results.md#hydrogen-detection) |
| **Signal-to-Noise Ratio** | 11:1 (typical) | [SNR Analysis](validation-results.md#snr-analysis) |
| **Frequency Accuracy** | Within 0.1 kHz | [Frequency Validation](validation-results.md#frequency) |

---

# 🚀 **7. Future Expansion**

## **7.1 Planned Upgrades**

Equipment upgrades on the roadmap:

| **Upgrade** | **Purpose** | **Timeline** |
|------------|------------|-------------|
| **1.2m Dish** | Increased gain and sensitivity | Q3 2025 |
| **Motorized Mount** | Exploration Scientific iEXOS-100 | Q4 2025 |
| **SDR Upgrade** | Extended bandwidth capabilities | 2026 |

## **7.2 Research Capabilities Expansion**

New scientific capabilities being developed:

| **Capability** | **Equipment Needed** | **Documentation** |
|----------------|----------------------|-------------------|
| **Pulsar Observations** | Wideband feed, higher sample rate SDR | [Pulsar Expansion](expansion-plans.md#pulsar) |
| **Multi-Band Observations** | Additional feed systems | [Multi-Band Plan](expansion-plans.md#multi-band) |
| **Interferometry** | Secondary antenna system | [Interferometry Roadmap](expansion-plans.md#interferometry) |

---

# 🔗 **8. Directory Contents**

This section provides direct navigation to all subdirectories and key documents in this category:

## **Subdirectories**

| **Directory** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Antenna-Systems** | Antenna design and configuration | [Antenna Systems README](Antenna-Systems/README.md) |
| **Hydrogen-Line-Feed** | Hydrogen line detection equipment | [Hydrogen Line Feed README](Hydrogen-Line-Feed/README.md) |
| **SDR-Equipment** | Software-defined radio hardware | [SDR Equipment README](SDR-Equipment/README.md) |

## **Key Documents**

| **Document** | **Purpose** | **Link** |
|--------------|------------|----------|
| **Components Specifications** | Technical details of all hardware components | [Components Specifications](components-specifications.md) |
| **Hydrogen Line Feed Chain** | Complete signal path documentation | [Hydrogen Line Feed Chain](hydrogen-line-feed-chain.md) |
| **Calibration Methodology** | Procedures for system calibration | [Calibration Methodology](calibration-methodology.md) |

---

# 🔄 **9. Related Categories**

| **Category** | **Relationship** | **Link** |
|--------------|----------------|----------|
| **Infrastructure** | Parent directory for observatory hardware | [Infrastructure README](../README.md) |
| **Research-Projects** | Scientific projects using this hardware | [Research Projects](../../Research-Projects/README.md) |
| **Applications/Radio-Astronomy** | Software for radio astronomy observations | [Radio Astronomy Applications](../../Applications/Radio-Astronomy/README.md) |
| **Compute** | Processing resources for SDR data | [Compute Resources](../Compute/README.md) |

---

# ✅ **10. Approval & Review**

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-04-04 | ✅ Approved |

---

# 📜 **11. Change Log**

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 2.0 | 2025-04-04 | Updated to standardized format with expanded sections | VintageDon |
| 1.0 | 2025-03-16 | Initial observatory hardware README | VintageDon |

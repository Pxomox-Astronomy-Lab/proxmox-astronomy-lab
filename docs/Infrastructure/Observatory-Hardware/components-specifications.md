<!-- ---
title: "Component Specifications - Hydrogen Line Observatory"
description: "Detailed technical specifications for all hardware components in the Proxmox Astronomy Lab's Hydrogen Line observation system."
author: "VintageDon"
tags: ["hardware", "specifications", "hydrogen-line", "radio-astronomy", "LNA", "SDR", "antenna"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---
 -->

# **Component Specifications - Hydrogen Line Observatory**

## **1. Overview**

This document provides comprehensive technical specifications for all hardware components used in the Proxmox Astronomy Lab's Hydrogen Line observation system. Each component has been selected based on its technical capabilities, performance characteristics, and suitability for 1420 MHz radio astronomy.

The specifications presented here serve as the authoritative reference for the observatory's hardware configuration, providing critical information for performance analysis, troubleshooting, and future upgrades. All components have been validated to work together as an integrated system optimized for Hydrogen Line observations.

### **1.1 Component Selection Philosophy**

The hardware components for this observatory have been selected following several guiding principles:

- **Research-grade performance** in critical signal path components
- **Certified specifications** from reputable suppliers
- **Appropriate bandwidth and frequency response** for 1420 MHz observations
- **Sufficient sensitivity** for scientific observations
- **Mechanical and environmental durability** for long-term operation
- **Compatibility with digital signal processing infrastructure**

This balanced approach ensures the observatory achieves professional-level performance within the constraints of a citizen science operation.

---

## **2. Antenna System**

### **2.1 Parabolic Antenna**

The primary signal collection device is a parabolic antenna optimized for the Hydrogen Line frequency.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | Nooelec Hydrogen Line Parabolic | Purpose-built for 1420 MHz |
| **Type** | Offset parabolic reflector | Reduces ground noise |
| **Diameter** | ~60 cm | Effective aperture |
| **Focal Length** | 27.5 cm | F/D ratio of 0.458 |
| **Surface Accuracy** | <λ/20 at 1420 MHz | Ensures efficiency at target frequency |
| **Gain** | 20 dBi | At 1420 MHz |
| **Beamwidth (3dB)** | ~10° | Suitable for extended source observations |
| **Front-to-Back Ratio** | >20 dB | Reduces ground noise |
| **Feed Support** | Tripod | Minimizes aperture blockage |
| **Material** | Aluminum | Weather resistant |
| **Weight** | 2.8 kg | Without mounting hardware |
| **Wind Rating** | Up to 60 mph | Without additional support |
| **Temperature Range** | -30°C to +70°C | Operating range |

### **2.2 Feed Element**

The feed element converts electromagnetic waves to guided signals for processing.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Type** | Dipole with reflector | Optimized for 1420 MHz |
| **VSWR** | <1.5:1 at 1420 MHz | Good impedance match |
| **Polarization** | Linear | Horizontal configuration |
| **Connector** | N-type female | Weather resistant |
| **Input Impedance** | 50 ohms | Standard impedance |
| **Material** | Copper and brass | Corrosion resistant |
| **Housing** | UV-resistant ABS | Environmental protection |

### **2.3 Mounting System**

The mounting system holds the antenna in position for observations.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Type** | Fixed mount (Phase 1) | Will be upgraded to motorized in Phase 4 |
| **Azimuth Range** | Fixed NW direction | Optimized for target field |
| **Elevation Range** | Fixed at ~45° | Balance of sky coverage and gain |
| **Material** | Galvanized steel | Weather resistant |
| **Load Capacity** | 15 kg | Sufficient for current antenna |

---

## **3. RF Signal Chain Components**

### **3.1 Band-Pass Filter**

The band-pass filter provides the first stage of frequency selection, attenuating out-of-band interference.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | AGO BP-2 | Specifically for Hydrogen Line |
| **Center Frequency** | 1420 MHz | Hydrogen Line frequency |
| **Passband Loss** | 0.7 dB | Exceptionally low loss |
| **3 dB Bandwidth** | ±30 MHz | 60 MHz total bandwidth |
| **30 dB Bandwidth** | ±100 MHz | Good out-of-band rejection |
| **Maximum Input Power** | +15 dBm | Well above expected signal levels |
| **VSWR** | <1.3:1 in passband | Good impedance match |
| **Connectors** | SMA female | Input and output |
| **Dimensions** | 5.5 × 3.2 × 1.5 cm | Compact form factor |
| **Housing** | Machined aluminum | RF shielding and durability |
| **Temperature Range** | -40°C to +85°C | Wide operating range |

### **3.2 Low Noise Amplifier (LNA)**

The LNA is the most critical component for system sensitivity, providing high gain with minimal added noise.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | AGO 1420 MHz Cavity LNA | Research-grade component |
| **Type** | Cavity LNA | Integrated filter characteristics |
| **Noise Figure** | 0.28 dB | Exceptional performance |
| **Gain** | 34 dB | High gain for weak signals |
| **Frequency Range** | 1350-1450 MHz | Optimized for Hydrogen Line |
| **1dB Compression Point** | >+10 dBm output | Good dynamic range |
| **VSWR Input** | <1.5:1 | Good impedance match |
| **VSWR Output** | <1.5:1 | Good impedance match |
| **DC Power** | 12V @ 150mA | Via bias tee or direct connection |
| **Connectors** | SMA female | Input and output |
| **Dimensions** | 7.6 × 3.8 × 2.2 cm | Compact form factor |
| **Housing** | Machined aluminum | RF shielding and durability |
| **Temperature Range** | -30°C to +60°C | Wide operating range |
| **Stability** | Unconditionally stable | No oscillation risk |

### **3.3 Coaxial Cables**

High-quality coaxial cables connect the various RF components with minimal signal loss.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Type** | LMR400 | Low-loss RF cable |
| **Impedance** | 50 ohms | Standard impedance |
| **Velocity Factor** | 0.85 | For electrical length calculations |
| **Attenuation** | 0.06 dB/ft at 1420 MHz | Low loss characteristic |
| **Maximum Power** | 1100W at 1420 MHz | Well above required levels |
| **Shielding** | >90 dB | Excellent RF isolation |
| **Center Conductor** | Copper-clad aluminum | Good conductivity, light weight |
| **Dielectric** | Foam polyethylene | Low loss |
| **Outer Conductor** | Aluminum tape + braid | Double shielding |
| **Jacket** | UV-resistant polyethylene | Weather resistant |
| **Bend Radius (min)** | 2.5 cm | Maintains performance when bent |
| **Temperature Range** | -40°C to +85°C | Wide operating range |

### **3.4 Calibration Noise Source**

The calibration noise source provides a reference signal for absolute temperature calibration.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | AGO ERB Noise Source | Designed for radio astronomy |
| **Frequency Range** | 1400-1440 MHz | Covers Hydrogen Line |
| **Excess Noise Ratio (ENR)** | 10 dB | Calibrated output level |
| **Output Flatness** | ±1.0 dB | Across frequency range |
| **Impedance** | 50 ohms | Standard impedance |
| **VSWR** | <1.5:1 | Good impedance match |
| **Connector** | SMA female | Standard interface |
| **Power Requirement** | 12V DC @ 200mA | External supply |
| **Temperature Stability** | <0.01 dB/°C | Good calibration stability |
| **Dimensions** | 5.1 × 3.8 × 2.0 cm | Compact form factor |
| **Housing** | Aluminum | RF shielding |
| **Temperature Range** | -10°C to +50°C | Operating range |

### **3.5 RF Accessories**

Various RF accessories complete the signal chain configuration.

| **Component** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Bias Tee** | 10 MHz - 3 GHz, 500mA DC pass | Powers LNA through coax |
| **Lightning Arrestor** | DC - 3 GHz, gas discharge type | Protection for equipment |
| **Attenuators** | 1-10 dB, SMA, 2W | Signal level adjustment |
| **Adapters** | N-to-SMA, SMA-to-BNC | Interface conversion |
| **Terminators** | 50 ohm, 1W | Reference and testing |

---

## **4. Digital Signal Processing Hardware**

### **4.1 Software-Defined Radio (SDR)**

The SDR converts analog RF signals to digital data for computer processing.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | Airspy R2 | High-performance SDR |
| **Architecture** | Direct sampling | Optimized reception |
| **Frequency Range** | 24-1800 MHz | Covers Hydrogen Line (1420 MHz) |
| **Sample Rate** | Up to 10 MSPS | Configurable for requirements |
| **Resolution** | 12-bit ADC | Good dynamic range |
| **Dynamic Range** | 80 dB | Handles weak signals near noise floor |
| **Maximum Bandwidth** | 9 MHz | Sufficient for hydrogen observations |
| **Noise Figure** | 5-6 dB | Acceptable with LNA preamplification |
| **MDS (Sensitivity)** | -140 dBm | With external LNA |
| **External Reference** | 10 MHz input | For precise frequency stability |
| **Interface** | USB 2.0 | High-speed data transfer |
| **Power Consumption** | 2.5W | USB powered |
| **Dimensions** | 8.0 × 6.0 × 1.5 cm | Compact form factor |
| **Operating System Support** | Windows, Linux, macOS | Cross-platform compatibility |
| **Temperature Range** | 0°C to +55°C | Indoor operating range |

### **4.2 Frequency Reference**

A precision frequency reference ensures accurate and stable frequency measurements essential for Doppler studies.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | LBE-1420 GPSDO | GPS-disciplined oscillator |
| **Reference Output** | 10 MHz square wave | Standard reference frequency |
| **Output Level** | 3.3V, 50 ohm | Compatible with SDR input |
| **Accuracy** | <0.1 ppb | When GPS-locked |
| **Stability** | <0.1 ppm | Temperature stability |
| **Phase Noise** | -130 dBc/Hz at 1 kHz offset | Low phase noise for clean signals |
| **Warm-up Time** | <5 minutes to full spec | Quick operational readiness |
| **GPS Antenna** | Active, 3-5V | Included with unit |
| **Lock Indicator** | LED + status output | Visual and electronic status |
| **Power Requirement** | 5V DC @ 350mA | Low power consumption |
| **Connectors** | SMA (RF), USB (power/status) | Standard interfaces |
| **Dimensions** | 7.5 × 5.0 × 2.5 cm | Compact form factor |
| **Temperature Range** | -10°C to +50°C | Indoor operating range |

### **4.3 Edge Computing Node**

The edge computing node performs initial signal processing and data handling at the observatory site.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Make/Model** | Custom N100 Mini PC | Compact edge processing |
| **Processor** | Intel N100 | 4 cores, 4 threads |
| **Clock Speed** | 3.4 GHz max | Good single-thread performance |
| **RAM** | 12 GB DDR5 | Sufficient for SDR processing |
| **Storage** | 1 TB NVMe SSD | Fast local storage |
| **Operating System** | Ubuntu 24.04 LTS | CIS Level 2 hardened |
| **Network** | 2.5 Gigabit Ethernet | Fast data transfer to main infrastructure |
| **USB Ports** | 4× USB 3.2 | For SDR and peripherals |
| **Power Consumption** | 15W typical | Energy efficient |
| **Dimensions** | 12.5 × 11.5 × 4.0 cm | Compact form factor |
| **Cooling** | Passive + small fan | Quiet operation |
| **Mounting** | VESA compatible | Flexible installation options |
| **Operating Temperature** | 0°C to +40°C | Indoor environment |

---

## **5. Power & Environmental Systems**

### **5.1 Power Systems**

Clean, reliable power is essential for consistent performance and equipment protection.

| **Component** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **LNA Power Supply** | 12V DC, 500mA, linear regulated | Low noise for sensitive RF |
| **SDR Power** | USB from edge node | Isolated through USB |
| **GPSDO Power** | 5V DC, 1A, linear regulated | Clean power for stability |
| **Edge Node Power** | 19V DC, 2A, AC adapter | Standard laptop-style supply |
| **UPS** | 600VA / 360W | Battery backup for critical components |
| **Power Distribution** | Surge-protected power strip | Additional protection layer |
| **Grounding** | <10 ohm to earth ground | RF interference reduction |

### **5.2 Environmental Control**

Environmental conditions affect system performance and reliability.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Temperature Range (Indoor)** | 18-25°C | Controlled environment for electronics |
| **Temperature Range (Outdoor)** | -20°C to +40°C | Design operating range |
| **Humidity Control (Indoor)** | <70% RH | Prevents condensation issues |
| **Weather Protection** | IP65 rated enclosures | For outdoor components |
| **Lightning Protection** | Multi-stage | Primary arrestor + secondary protection |
| **Solar Radiation Protection** | UV-resistant materials | For outdoor components |
| **Ventilation** | Passive vents | Prevent moisture buildup in enclosures |

---

## **6. Performance Specifications**

### **6.1 System Performance Parameters**

These integrated system specifications represent the expected performance of the complete observatory system.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **System Temperature (Urban)** | 230-260 K | Typical at 1420 MHz |
| **System Temperature (Dark Sky)** | 160-190 K | With reduced RFI |
| **Sensitivity (4-hour integration)** | ~0.35 mK (urban) | For 10 kHz bandwidth |
| **Sensitivity (6-hour integration)** | ~0.28 mK (urban) | For 10 kHz bandwidth |
| **Frequency Stability** | <0.05 ppm | With GPSDO reference |
| **Dynamic Range** | >70 dB | End-to-end system |
| **Maximum Doppler Resolution** | ~0.2 km/s | Velocity resolution capability |
| **Pointing Accuracy** | ~1° | Fixed mounting precision |
| **Field of View** | ~10° | FWHM beamwidth |
| **RFI Rejection** | >40 dB | For out-of-band signals |
| **Calibration Accuracy** | <5% | Absolute temperature scale |
| **Long-term Stability** | <3% variance | Over 30-day period |

### **6.2 Verification Methods**

The performance specifications are verified through structured testing procedures.

| **Parameter** | **Verification Method** | **Acceptance Criteria** |
|--------------|------------------------|-------------------------|
| **System Temperature** | Y-factor measurement | Within 10% of calculated value |
| **Sensitivity** | Standard source observation | Signal detected at predicted SNR |
| **Frequency Stability** | Allan deviation measurement | Meets or exceeds GPSDO spec |
| **Dynamic Range** | Step attenuator test | Linear response across range |
| **Doppler Resolution** | Known source velocity spread | Resolution of separate velocity components |
| **Pointing Accuracy** | Known source transit timing | Peak signal at predicted time |
| **RFI Rejection** | Out-of-band signal injection | Attenuation matches filter specs |
| **Calibration Accuracy** | Standard source comparison | Measurements match published values |
| **Long-term Stability** | Repeated cold sky measurements | Variance within specification |

---

## **7. Compatibility & Integration**

### **7.1 Interface Specifications**

These specifications ensure proper integration with the broader Proxmox Astronomy Lab infrastructure.

| **Interface** | **Specification** | **Connected System** |
|--------------|-------------------|---------------------|
| **Digital Data Output** | 10-25 MB/min average | Lab-PG01 (PostgreSQL) |
| **Network Protocol** | TCP/IP over Ethernet | Lab Network Infrastructure |
| **Data Format** | SigMF-compatible + Custom HDF5 | Lab Processing Pipeline |
| **Control Interface** | REST API | Kubernetes Orchestration |
| **Timing Synchronization** | NTP, stratum 2 | Lab Timing Infrastructure |
| **Authentication** | Kerberos + Entra ID | Lab Security Infrastructure |
| **Monitoring Interface** | Prometheus metrics | Lab Observability Stack |

### **7.2 Configuration Management**

Component configurations are managed through standardized methods.

| **Component** | **Configuration Method** | **Backup Frequency** |
|--------------|------------------------|----------------------|
| **SDR Settings** | Version-controlled config files | Every change |
| **Processing Parameters** | Kubernetes ConfigMaps | Every change |
| **Observation Schedules** | GitOps managed YAML | Every change |
| **Calibration Data** | Immutable storage in TimescaleDB | Daily |
| **System Firmware** | Change-controlled updates | As-needed basis |

---

## **8. Part Numbers & Sourcing Information**

| **Component** | **Manufacturer Part Number** | **Supplier** | **Estimated Cost** |
|--------------|---------------------------|-------------|------------------|
| **Parabolic Antenna** | NOO-HPAR-01 | Nooelec | $85-110 |
| **Band-Pass Filter** | BP-2-1420 | AGO (Amateur Galileo Observatory) | $75 |
| **Cavity LNA** | RA-1420-34-028 | AGO (Amateur Galileo Observatory) | $325 |
| **Calibration Source** | RA-1420-NS-10 | AGO (Amateur Galileo Observatory) | $135 |
| **Coaxial Cable** | LMR400-UF | Various | $1.25/ft |
| **SDR** | AIRSPY-R2 | Airspy | $169 |
| **GPSDO** | LBE-GPSDO-10 | Various | $145 |
| **Edge Node** | Custom build | Various | $350-450 |

---

## **9. References & Documentation**

| **Document Type** | **Title** | **Location** |
|-------------------|----------|-------------|
| **Manufacturer Documentation** | AGO Product Catalog 9/24 | Internal documentation |
| **Manufacturer Documentation** | Airspy R2 Manual | manufacturer-documentation/ |
| **Manufacturer Documentation** | LMR-400 Datasheet | manufacturer-documentation/ |
| **System Documentation** | Feed Chain Signal Flow | feed-chain-signal-flow.md |
| **System Documentation** | Calibration Procedures | calibration-procedures.md |
| **Academic Reference** | Radio Astronomy at 21 Centimeters | references/ |

---

## **✅ Approval & Review**  

| **Reviewer** | **Role** | **Approval Date** | **Status** |
|-------------|---------|------------------|------------|
| VintageDon | Lead Engineer | 2025-03-08 | ✅ Approved |  

---

## **📜 Change Log**  

| **Version** | **Date** | **Changes** | **Author** |
|------------|---------|-------------|------------|
| 1.0 | 2025-03-08 | Initial version | VintageDon |

<!-- ---
title: "Hydrogen Line Feed Chain - Proxmox Astronomy Lab"
description: "Detailed documentation of the Hydrogen Line feed chain components, configurations, and signal path optimizations for 1420 MHz radio astronomy observations."
author: "VintageDon"
tags: ["feed-chain", "hydrogen-line", "LNA", "filters", "radio-astronomy", "SDR"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---
 -->

# **Hydrogen Line Feed Chain - Proxmox Astronomy Lab**

## **1. Overview**

The Hydrogen Line feed chain is the critical RF signal path that captures, filters, amplifies, and processes the 1420 MHz emission from cosmic hydrogen sources. This document provides comprehensive details on each component in the signal path, their configuration parameters, interconnection methods, and optimization techniques.

A properly designed feed chain is essential for achieving the sensitivity required for meaningful Hydrogen Line observations. Each component has been selected for optimal performance at 1420 MHz, with particular attention to minimizing system temperature while maintaining appropriate filtering for urban RF environments.

### **1.1 Feed Chain Architecture**

The feed chain follows a standard radio astronomy front-end design with specific optimizations for Hydrogen Line observations:

1. **Antenna** → Captures RF signals at 1420 MHz
2. **Coaxial Cable (Pre-LNA)** → Transfers signals to filtering stage
3. **Band-Pass Filter** → Rejects out-of-band interference
4. **Low Noise Amplifier (LNA)** → Amplifies weak signals while adding minimal noise
5. **Coaxial Cable (Post-LNA)** → Transfers amplified signals to receiver
6. **Software-Defined Radio (SDR)** → Digitizes RF signals
7. **Edge Computing Node** → Processes digitized signals

This architecture optimizes sensitivity by placing filtering and low-noise amplification as close to the antenna as practical, minimizing signal loss before amplification.

### **1.2 Design Principles**

The feed chain design follows several key principles for radio astronomy applications:

- **Minimize system noise** by using high-quality LNA with very low noise figure
- **Filter before significant amplification** to prevent amplifier saturation from out-of-band signals
- **Place LNA as close to antenna as practical** to amplify signals before cable losses
- **Use high-quality, low-loss coaxial cable** especially in the pre-LNA segment
- **Provide adequate lightning protection** to safeguard sensitive equipment
- **Include calibration reference** for consistent measurements

---

## **2. Component Specifications**

### **2.1 Antenna System**

The antenna is the first element in the signal chain, converting electromagnetic waves at 1420 MHz into guided RF signals.

| **Parameter** | **Specification** | **Notes** |
|--------------|-------------------|-----------|
| **Type** | Parabolic Dish | Optimized for 1420 MHz |
| **Make/Model** | Nooelec Hydrogen Line Parabolic | Commercially available, modified for optimum performance |
| **Diameter** | ~60 cm | Compromise between gain and beamwidth |
| **Gain** | 20 dBi | At 1420 MHz |
| **Beamwidth** | ~10° | Allows observation of extended structures |
| **Feed Type** | Dipole with reflector | Positioned at focal point |
| **Polarization** | Linear | Horizontal orientation |
| **Mounting** | Fixed (Phase 1) | Positioned for NW sky coverage |
| **Front-to-Back Ratio** | >20 dB | Reduces ground noise |

The antenna is positioned to minimize ground noise and interference from nearby structures, with the feed point at 6-8 feet above ground level. The antenna's physical structure has been optimized to ensure the dish surface accuracy is sufficient for 1420 MHz operation.

### **2.2 Pre-LNA Components**

The components between the antenna and LNA are critical, as any losses in this section directly impact system sensitivity.

| **Component** | **Specification** | **Purpose** |
|--------------|-------------------|------------|
| **Coaxial Cable** | LMR400, 25 ft | Signal transfer from antenna to filter |
| **Cable Loss** | ~1.5 dB | At 1420 MHz (calculated) |
| **Connectors** | N-Type to SMA | Weather-sealed at antenna end |
| **Lightning Arrestor** | Proxicast | Gas discharge type, <0.1 dB insertion loss |

The pre-LNA cable length has been minimized to reduce signal loss before amplification. All connections are weatherproofed using professional-grade sealing tape and silicone sealant.

### **2.3 Filtering System**

Radio frequency filtering is essential, especially in urban environments with significant RF interference.

| **Component** | **Specification** | **Supplier** |
|--------------|-------------------|-------------|
| **Filter Type** | BP-2 Band-Pass | AGO (Amateur Galileo Observatory) |
| **Center Frequency** | 1420 MHz | Hydrogen Line frequency |
| **Insertion Loss** | 0.7 dB | In passband |
| **3 dB Bandwidth** | ±30 MHz | 60 MHz total bandwidth |
| **Attenuation** | -13 dB | At ±100 MHz from center |
| **Connectors** | SMA Female | Input and output |
| **Construction** | Aluminum housing | Shielded against external RF |

The BP-2 filter features a relatively narrow bandwidth, which is ideal for Hydrogen Line observations as it rejects cellular, Wi-Fi, and other common urban RF interference sources while passing the desired 1420 MHz signal with minimal loss.

### **2.4 Low Noise Amplifier (LNA)**

The LNA is perhaps the most critical component in the feed chain, as its noise figure largely determines overall system sensitivity.

| **Component** | **Specification** | **Supplier** |
|--------------|-------------------|-------------|
| **Model** | 1420 MHz Cavity LNA | AGO (Amateur Galileo Observatory) |
| **Type** | Integrated cavity filter + LNA | Professional-grade design |
| **Noise Figure** | 0.28 dB | Exceptional performance without cooling |
| **Gain** | 34 dB | Sufficient to overcome downstream losses |
| **1dB Compression Point** | >10 dBm | Good dynamic range |
| **Power Supply** | 12V DC | Via bias-tee or direct |
| **Current Draw** | ~150 mA | Low power consumption |
| **Operating Temp** | -30°C to +60°C | Wide environmental range |
| **Connectors** | SMA Female | Input and output |

This AGO Cavity LNA represents research-grade performance, with a noise figure comparable to much more expensive commercial units. The integrated cavity design provides additional filtering, further rejecting out-of-band signals.

### **2.5 Post-LNA Components**

After amplification, signal losses are less critical to system noise temperature but still important for maintaining adequate signal levels.

| **Component** | **Specification** | **Purpose** |
|--------------|-------------------|------------|
| **Coaxial Cable** | LMR400, 10 ft | Signal transfer to receiver |
| **Cable Loss** | ~0.6 dB | At 1420 MHz (calculated) |
| **Bias-Tee** | Generic | DC power injection for LNA |
| **Attenuator** | 0-10 dB (as needed) | Prevents SDR overload |
| **Connectors** | SMA | Throughout signal path |

The post-LNA signal path is kept as short and simple as possible to maintain signal integrity. Variable attenuation is available to optimize signal levels for the SDR's dynamic range.

### **2.6 Receiver System**

The receiver digitizes the RF signals for computer processing.

| **Component** | **Specification** | **Features** |
|--------------|-------------------|-------------|
| **SDR Type** | Airspy R2 | High-performance SDR |
| **Frequency Range** | 24-1800 MHz | Covers Hydrogen Line (1420 MHz) |
| **Sample Rate** | Up to 10 MSPS | Configurable for observation needs |
| **Resolution** | 12-bit ADC | Good dynamic range |
| **Interface** | USB 2.0 | Connection to edge computing node |
| **Streaming** | Continuous | For long integration times |
| **Noise Figure** | ~5-6 dB | Acceptable due to prior LNA gain |
| **Clock Reference** | External GPSDO | For precise frequency stability |

The Airspy R2 provides excellent performance for its price point, with sufficient dynamic range and sample rate for Hydrogen Line observations. The external clock reference ensures frequency stability for precise Doppler measurements.

### **2.7 Reference Clock**

Precise frequency reference is essential for accurate Doppler shift measurements and long integration times.

| **Component** | **Specification** | **Purpose** |
|--------------|-------------------|------------|
| **Clock Type** | LBE-1420 GPSDO | GPS-disciplined oscillator |
| **Stability** | <0.1 ppm | Over temperature range |
| **Output** | 10 MHz reference | Standard reference frequency |
| **Connection** | External input on Airspy R2 | Provides stable clock source |

The GPSDO locks to GPS satellite signals to provide exceptional frequency stability, which is essential for accurate Doppler shift measurements of celestial hydrogen sources.

### **2.8 Calibration Source**

A calibration source is included to enable absolute measurements of antenna temperature.

| **Component** | **Specification** | **Supplier** |
|--------------|-------------------|-------------|
| **Type** | ERB Noise Source | AGO (Amateur Galileo Observatory) |
| **Frequency Range** | 1400-1440 MHz | Covers Hydrogen Line |
| **Output Power** | 10 dB ENR | Excess Noise Ratio |
| **Flatness** | ±1.0 dB | Across frequency range |
| **Connection** | Switched into signal path | Via SMA connector |
| **Power** | 12V DC | Via separate supply |

The calibrated noise source allows conversion of receiver units to absolute temperature measurements, which is essential for scientific observations. The calibration process is performed regularly according to the schedule in the calibration plan.

---

## **3. Signal Path Configuration**

### **3.1 Physical Layout**

The physical arrangement of components significantly impacts system performance and reliability.

| **Component** | **Location** | **Mounting** | **Environmental Protection** |
|--------------|-------------|--------------|------------------------------|
| **Antenna** | Exterior | Fixed mount | Weather-resistant construction |
| **Pre-LNA Cable** | Exterior | Secured to support structure | UV-resistant jacket |
| **Filter and LNA** | Transition point | Weather-proof housing | Enclosed case with ventilation |
| **Post-LNA Cable** | Interior | Cable management | Standard indoor rating |
| **SDR and Clock** | Interior rack | 19" rack mount shelf | Climate-controlled environment |
| **Edge Node** | Interior rack | 19" rack mount | Climate-controlled environment |

The physical layout minimizes pre-LNA cable length while providing adequate environmental protection for sensitive components. All exterior connections are weatherproofed, and lightning protection is incorporated at the building entry point.

### **3.2 Signal Flow and Gain Distribution**

Proper gain distribution throughout the signal chain ensures optimal performance.

| **Component** | **Gain/Loss (dB)** | **Cumulative (dB)** | **Notes** |
|--------------|---------------------|---------------------|-----------|
| **Antenna** | +20 | +20 | 20 dBi gain |
| **Pre-LNA Cable** | -1.5 | +18.5 | 25 ft LMR400 loss |
| **Band-Pass Filter** | -0.7 | +17.8 | Insertion loss |
| **LNA** | +34 | +51.8 | Amplification stage |
| **Post-LNA Cable** | -0.6 | +51.2 | 10 ft LMR400 loss |
| **Attenuator** | -3 | +48.2 | Typical setting |
| **SDR Input** | - | +48.2 | Final signal level |

This gain distribution ensures the weak celestial signals are amplified sufficiently to overcome downstream noise contributions while avoiding saturation of the SDR receiver.

### **3.3 Power Distribution**

Reliable power distribution is essential for consistent performance.

| **Component** | **Voltage** | **Current** | **Power Source** |
|--------------|------------|------------|------------------|
| **LNA** | 12V DC | 150 mA | Bias-tee from interior power supply |
| **GPSDO** | 5V DC | 350 mA | Dedicated linear power supply |
| **SDR** | 5V DC | 500 mA | USB from edge node |
| **Edge Node** | 120V AC | 1.5A | UPS-protected outlet |
| **Calibration Source** | 12V DC | 200 mA | Same supply as LNA |

All critical components are powered from regulated, low-noise power supplies to minimize introduction of noise into the signal path. The edge computing node and SDR are protected by an uninterruptible power supply (UPS) to prevent data loss during power fluctuations.

---

## **4. System Temperature Analysis**

### **4.1 Component Noise Contributions**

The system temperature is calculated from the noise contributions of each component, using the Friis formula for cascaded networks.

| **Component** | **Noise Contribution (K)** | **Calculation Method** |
|--------------|----------------------------|------------------------|
| **Sky Noise (Urban)** | 50-80 K | Typical urban sky temperature at 1420 MHz |
| **Antenna Efficiency Loss** | ~20 K | Based on 0.7 efficiency |
| **Pre-LNA Cable** | ~90 K | T = (1.5 dB loss factor - 1) × 290 K |
| **Filter Loss** | ~48 K | T = (0.7 dB loss factor - 1) × 290 K |
| **LNA Noise** | ~19.5 K | T = (0.28 dB NF factor - 1) × 290 K |
| **Post-LNA Chain** | ~1 K | Minimal contribution due to LNA gain |
| **Total System (Urban)** | ~230-260 K | Sum of contributions |
| **Total System (Dark Sky)** | ~160-190 K | With reduced sky noise |

These calculations demonstrate why LNA selection is critical - its noise figure directly impacts system performance. The system temperature could be further reduced by shortening the pre-LNA cable or using a more efficient antenna, but the current configuration represents a good balance of performance and practicality.

### **4.2 Sensitivity Calculations**

The system's sensitivity depends on system temperature, integration time, and bandwidth.

| **Parameter** | **Value** | **Notes** |
|--------------|-----------|-----------|
| **System Temperature (Urban)** | ~230-260 K | From component analysis |
| **System Temperature (Dark Sky)** | ~160-190 K | From component analysis |
| **Integration Time** | 4-6 hours | Typical observation session |
| **Bandwidth** | 10 kHz | Typical for spectral line work |
| **Calculated Sensitivity (Urban)** | ~0.35-0.4 mK | ΔT = Tsys/√(t×B) |
| **Calculated Sensitivity (Dark Sky)** | ~0.24-0.28 mK | ΔT = Tsys/√(t×B) |

These sensitivity levels enable detection of faint hydrogen line structures, including high-velocity clouds and extended low surface brightness features.

---

## **5. Integration with Lab Infrastructure**

### **5.1 Edge Node Processing**

The edge computing node performs initial signal processing before transferring data to the main lab infrastructure.

| **Function** | **Software** | **Output** |
|--------------|-------------|-----------|
| **SDR Control** | GNU Radio | Raw I/Q samples |
| **Spectral Processing** | GNU Radio | Power spectra |
| **Initial RFI Rejection** | Custom filtering | Cleaned spectra |
| **Calibration** | Python scripts | Temperature-calibrated spectra |
| **Data Storage** | Local NVME | Temporary storage |
| **Data Transfer** | Secure network protocol | Transfer to main infrastructure |

The edge node is configured to operate autonomously, following scheduled observation plans and performing initial processing to reduce data volume before transfer.

### **5.2 Data Format and Transfer**

Processed data is transferred to the main lab infrastructure in standardized formats.

| **Data Type** | **Format** | **Approximate Volume** |
|--------------|------------|------------------------|
| **Raw I/Q** | Binary (temporary) | ~144 GB per 4-hour observation |
| **Integrated Spectra** | SigMF compatible | ~70 MB per observation |
| **Calibrated Data** | Custom HDF5 structure | ~50 MB per observation |
| **Metadata** | JSON | ~1 MB per observation |

Data transfer occurs automatically after each observation session using a secure protocol. Checksums ensure data integrity during transfer.

---

## **6. Calibration Procedures**

### **6.1 Noise Source Calibration**

Regular calibration using the noise source ensures consistent measurements over time.

| **Procedure** | **Frequency** | **Expected Results** |
|--------------|--------------|----------------------|
| **Y-factor Measurement** | Weekly | Consistent ratio between noise-on and noise-off measurements |
| **Noise Source Power Check** | Monthly | Within 10% of rated ENR |
| **Temperature Conversion Factor** | Monthly | Stable conversion from ADC units to Kelvin |

The noise source calibration process involves switching the calibrated noise source on and off to establish the system gain and noise baseline.

### **6.2 Astronomical Source Calibration**

Calibration against known astronomical sources verifies overall system performance.

| **Calibration Source** | **Frequency** | **Expected Signal** |
|------------------------|--------------|---------------------|
| **Cassiopeia A** | Quarterly | Strong continuum source, ~7000 Jy |
| **Taurus A** | Quarterly | Strong continuum source, ~1000 Jy |
| **Galactic Plane** | Monthly | Strong Hydrogen Line emission |
| **Cold Sky Reference** | Monthly | Minimum temperature reference |

These astronomical calibrations provide end-to-end verification of the entire system's performance and sensitivity.

---

## **7. Maintenance Procedures**

### **7.1 Routine Maintenance**

Regular maintenance ensures consistent performance and longevity of equipment.

| **Component** | **Maintenance Task** | **Frequency** |
|--------------|----------------------|--------------|
| **Antenna** | Visual inspection | Monthly |
| **Antenna** | Surface cleaning | Quarterly |
| **Connectors** | Weatherproofing check | Quarterly |
| **LNA** | Performance verification | Monthly |
| **Filters** | Insertion loss check | Quarterly |
| **SDR** | Gain stability check | Monthly |
| **Edge Node** | Software updates | As needed |
| **All Cables** | Visual inspection | Quarterly |

Maintenance tasks are scheduled to minimize impact on observation schedules, typically during daylight hours when observations are not in progress.

### **7.2 Troubleshooting Guide**

Common issues and their resolutions are documented for quick reference.

| **Symptom** | **Potential Causes** | **Diagnostic Steps** |
|------------|---------------------|----------------------|
| **Low Signal Strength** | LNA failure, Cable damage | Check voltages, Measure signal at test points |
| **Excessive Noise** | RFI, LNA oscillation | Spectrum analysis, Shield verification |
| **Frequency Drift** | GPSDO lock loss | Check GPS signal, Lock indicators |
| **Data Corruption** | Edge node issues | Check logs, Disk space, CPU load |
| **Calibration Drift** | Component aging | Compare to astronomical standards |

Each troubleshooting scenario is documented with detailed diagnostic procedures and resolution steps in the associated maintenance guide.

---

## **8. Future Improvements**

### **8.1 Planned Component Upgrades**

Future improvements will enhance system performance while maintaining compatibility with existing infrastructure.

| **Component** | **Planned Upgrade** | **Expected Improvement** |
|--------------|---------------------|--------------------------|
| **Antenna** | 1.2m parabolic dish | ~6 dB increased gain |
| **LNA** | Silver-plated cavity version | Further reduced noise figure (~0.22 dB) |
| **Mount** | Motorized tracking mount | Targeted source tracking capability |
| **SDR** | Higher bit-depth device | Improved dynamic range |
| **Edge Node** | GPU-accelerated processing | Real-time advanced filtering |

These upgrades would incrementally improve system performance without requiring wholesale replacement of the existing infrastructure.

### **8.2 Experimental Configurations**

Several experimental configurations are being evaluated for potential implementation.

| **Experiment** | **Purpose** | **Expected Outcome** |
|---------------|------------|----------------------|
| **Dual-Polarization Feed** | Capture both polarizations | Improved sensitivity, polarization studies |
| **Cryogenic Cooling** | Further reduce LNA noise | System temperature reduction of ~15K |
| **Multi-Feed Array** | Primitive interferometry | Improved spatial resolution |
| **Wide-Band Feed** | Multi-frequency observations | Spectral index studies |

These experimental configurations will be tested in phases to evaluate their practicality and scientific return before permanent implementation.

---

## **9. References and Resources**

| **Resource** | **Description** | **Location** |
|--------------|-----------------|-------------|
| **AGO Product Documentation** | Full specifications for LNA and filters | Internal documentation |
| **LMR400 Specifications** | Cable loss tables and specifications | manufacturer-documentation/ |
| **Airspy R2 Manual** | SDR configuration and operation | manufacturer-documentation/ |
| **GNU Radio Flowgraphs** | Signal processing configurations | processing-pipelines/ |
| **Calibration Scripts** | Automated calibration procedures | scripts/ |

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



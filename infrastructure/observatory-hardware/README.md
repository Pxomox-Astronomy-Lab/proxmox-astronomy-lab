---
title: "Observatory Hardware - Proxmox Astronomy Lab"
description: "Documentation of radio astronomy hardware, feed chain components, and signal processing equipment used in the Proxmox Astronomy Lab for Hydrogen Line observations."
author: "VintageDon"
tags: ["observatory", "hardware", "radio-astronomy", "hydrogen-line", "SDR", "LNA"]
category: "Infrastructure"
kb_type: "Reference"
version: "1.0"
status: "Published"
last_updated: "2025-03-08"
---

# **Observatory Hardware - Proxmox Astronomy Lab**

## **1. Overview**

The observatory hardware infrastructure serves as the **radio frequency (RF) acquisition layer** for the Proxmox Astronomy Lab, focused primarily on **Hydrogen Line (1420 MHz) observations, high-velocity cloud studies, and supernova remnant detection**. This documentation details the hardware components, signal chain, sensitivity specifications, and integration with the lab's data processing infrastructure.

The hardware selection follows **research-grade design principles** while remaining accessible for citizen science applications, enabling reliable detection and analysis of Hydrogen Line emissions from cosmic sources.

### **1.1 Primary Research Focus**

This hardware configuration is optimized for several key radio astronomy research areas that balance scientific value with the capabilities of a citizen science observatory.

- **Hydrogen Line (1420 MHz) observations** of galactic and extragalactic sources
- **High-velocity cloud (HVC) detection** and velocity measurements through Doppler shift analysis
- **Low surface brightness galaxy (LSBG)** studies
- **Supernova remnant (SNR) mapping** and characterization
- **Long-term drift scan observations** with potential for motorized tracking

### **1.2 Site Characteristics**

The observatory operates in a typical urban environment with inherent RF challenges, but with strategic access to darker sky locations for specialized observations.

| **Parameter** | **Value** |
|--------------|-----------|
| **Location** | Columbus, OH, USA (40° N, 83° W) |
| **Primary Sky Coverage** | Northwest (NW) Quadrant |
| **Environment** | Urban residential location |
| **Mounting Height** | ~6-8 ft (optimized for sky coverage while minimizing visual impact) |
| **Observation Mode** | Fixed mount drift scans with planned expansion to motorized tracking |

### **1.3 Equipment Classification & Sourcing**

The hardware used in this observatory represents a significant step above typical amateur setups, positioned in the category of **"citizen science-grade research equipment"** that bridges the gap between hobby-level and professional installations.

Key hardware components are sourced from **Amateur Galileo Observatory (AGO)**, a specialized supplier of research-grade radio astronomy equipment. AGO produces certified, calibrated components used by both amateur and professional radio astronomers, with particular expertise in hydrogen line observation equipment.

The AGO components (particularly the 1420 MHz Cavity LNA with 0.28 dB noise figure) provide critical performance advantages:

- **Professional-level noise characteristics** without requiring cryogenic cooling
- **Certified gain and performance specifications** suitable for published research
- **Specialized cavity filters** optimized specifically for hydrogen line frequencies
- **Calibration standards** traceable to known reference values

This sourcing strategy ensures the observatory can achieve sensitivity levels approaching minor research facilities, despite operating without the resources of large academic institutions.

---

## **2. Feed Chain Components**

The feed chain represents the complete signal path from **antenna to processing system**, with each component selected to optimize sensitivity at the Hydrogen Line frequency of 1420 MHz.

### **2.1 Antenna System**

The antenna system is configured to balance gain, beamwidth, and practical deployment considerations in an urban setting.

| **Component** | **Specifications** | **Purpose** |
|--------------|-------------------|------------|
| **Primary Antenna** | Nooelec Hydrogen Line Parabolic Antenna | Captures 1420 MHz radio emissions |
| **Gain** | 20 dBi | Provides sufficient signal amplification while maintaining appropriate beamwidth |
| **Beamwidth** | ~10° | Offers balance between sensitivity and sky coverage |
| **Mount Type** | Fixed (Phase 1), Motorized (Planned Phase 2) | Allows for drift scans and future tracking observations |

### **2.2 Filtering & Amplification**

Signal filtering and amplification are critical components that determine the system's ability to detect faint hydrogen line emissions against background noise and interference.

| **Component** | **Specifications** | **Supplier** |
|--------------|-------------------|-------------|
| **Pre-LNA Band-Pass Filter** | BP-2 Filter, Center frequency: 1420 MHz, Bandpass loss: 0.7 dB, 3 dB bandwidth: ±30 MHz, Attenuation: -13 dB ±100 MHz | AGO (Amateur Galileo Observatory) |
| **Low Noise Amplifier (LNA)** | 1420 MHz Cavity LNA, Noise figure: 0.28 dB, Gain: 34 dB, Design: Integrated cavity filter | AGO Certified Research-Grade Component |
| **Noise Calibration Source** | ERB Noise Source (1420 MHz), Output power: 10 dB, Flatness: ±1.0 dB | AGO Radio Astronomy Component |

### **2.3 Signal Processing Hardware**

The digital signal processing chain converts RF signals to digital data and performs initial processing before integration with the lab's main computing infrastructure.

| **Component** | **Specifications** | **Purpose** |
|--------------|-------------------|------------|
| **Software-Defined Radio (SDR)** | Airspy R2, High dynamic range, USB 2.0 interface | Digitizes RF signals for computer processing |
| **Clock Source** | LBE-1420 GPSDO (GPS Disciplined Oscillator) | Provides precise frequency reference for accurate Doppler measurements |
| **Edge Computing Node** | N100 Mini PC, 12GB RAM, 1TB SSD, Ubuntu 24.04 CISv8L2 | Performs initial signal processing before transfer to central lab infrastructure |

### **2.4 Cabling & Protection**

Proper cabling and protection components ensure signal integrity and equipment safety in various environmental conditions.

| **Component** | **Specifications** | **Purpose** |
|--------------|-------------------|------------|
| **Coaxial Cable** | LMR400, Length: 25 ft (pre-LNA), Low-loss characteristics | Maintains signal integrity between components |
| **Connectors** | SMA (Male/Female) | Provides consistent connections throughout signal chain |
| **Lightning Protection** | Proxicast Lightning Arrestor | Prevents equipment damage during electrical storms |

---

## **3. System Sensitivity & Performance**

### **3.1 System Temperature & Sensitivity Analysis**

The system temperature (Tsys) is a critical measure of the observatory's sensitivity, calculated from component specifications and environmental factors. Lower system temperatures allow detection of fainter hydrogen line emissions.

The feed chain achieves competitive sensitivity through careful component selection:

- **LNA Contribution**: 0.28 dB noise figure converts to approximately 19.5 K noise temperature
- **Filter Contribution**: 0.7 dB loss adds approximately 48 K
- **Cable Loss Contribution**: Minimal due to placement of LNA near the antenna

This yields estimated system temperatures of:

- **Urban environment**: 120-250 K (including RFI contributions)
- **Dark sky sites**: 60-140 K (with reduced RFI)

For planned 4-6 hour integration times with 10 kHz bandwidth, the system can achieve:

- **Urban sensitivity**: 0.25-0.5 mK
- **Dark sky sensitivity**: 0.12-0.29 mK

These sensitivity levels enable scientific observations that would be challenging or impossible with standard amateur equipment.

### **3.2 Observation Capability Example: Smith Cloud**

To illustrate the practical capabilities of this system, consider the Smith Cloud, a high-velocity cloud (HVC) approximately 40,000 light-years from Earth moving toward the Milky Way disk at approximately 73 km/s.

Key characteristics of the Smith Cloud:

- **Brightness temperature**: ~0.5-2 K at peak
- **Angular size**: ~10-15 degrees across
- **Column density**: ~5 × 10^19 atoms/cm²
- **Velocity range**: +100 to +150 km/s LSR

Detection requirements:

1. **Signal-to-noise ratio (SNR)**: For reliable detection, SNR > 5 is desired
2. **Sensitivity needed**: To detect features with brightness temperature ~0.5 K with SNR > 5, sensitivity better than 0.1 K is required

With our system's calculated sensitivity of 0.25-0.5 mK (urban) or 0.12-0.29 mK (dark sky) for 4-6 hour integrations, we exceed the required sensitivity by a factor of 200-400. This allows not just detection, but detailed mapping of velocity structures within the cloud that would be impossible with typical amateur setups having sensitivities of only 2-5 K.

The math shows why this works:

- **Required sensitivity**: 0.5 K ÷ 5 (SNR) = 0.1 K
- **System sensitivity**: 0.25-0.5 mK = 0.00025-0.0005 K
- **Sensitivity margin**: 0.1 K ÷ 0.0005 K = 200× better than required

This capability gap illustrates why this system qualifies as "minor research grade" rather than simply advanced amateur.

### **3.3 Citizen Science-Grade Observatory Classification**

This implementation represents a **Citizen Science-Grade Observatory**, defined by:

- Use of **certified, research-grade components** (AGO-supplied LNA and filters)
- **Calibrated signal chain** with known temperature standards
- **Professional-grade signal processing** and data archiving
- **Reproducible methodology** and open data approach
- **Ongoing calibration** using known astronomical sources

While not fully calibrated yet, the feed line is designed to achieve high sensitivity even in moderate RF environments. The edge node's portability (N100 Mini PC) enables occasional dark sky observations at state parks within an hour's drive, providing supplemental high-sensitivity data for detailed studies.

---

## **4. Integration with Lab Infrastructure**

### **4.1 Data Flow Architecture**

The observatory hardware integrates with the broader Proxmox Astronomy Lab infrastructure to form a complete data acquisition and analysis pipeline.

| **Stage** | **Infrastructure Component** | **Function** |
|-----------|----------------------------|-------------|
| **Acquisition** | Edge Node (N100 Mini PC) | Captures raw SDR data, performs initial filtering |
| **Transfer** | Kubernetes Network | Securely transfers data to lab infrastructure |
| **Processing** | RKE2 Kubernetes Cluster | Executes signal processing pipelines |
| **Storage** | PostgreSQL (proj-pg01) & TimescaleDB (proj-pgts01) | Stores processed observations as time-series data |
| **Analysis** | PostgreSQL with PostGIS (proj-pggis01) | Performs spatial analysis of astronomical data |
| **Visualization** | Grafana Dashboards | Provides real-time and historical data visualization |

### **4.2 Control & Automation**

The observatory hardware connects to lab automation systems that enable sophisticated operation without constant human intervention.

The hardware is integrated with lab automation systems for:

- **Remote observation control** via Kubernetes workloads
- **Automated calibration procedures** on scheduled intervals
- **Environmental monitoring** (temperature, power stability)
- **Alert generation** for anomalous conditions

---

## **5. Calibration & Observation Plan**

### **5.1 Calibration Process**

Proper calibration is essential for meaningful scientific results. The observatory implements a structured calibration regimen to ensure data quality.

| **Calibration Type** | **Timing** | **Reference Source** |
|---------------------|-----------|----------------------|
| **Initial Calibration** | January 2025 | Cassiopeia A (bright, stable source) |
| **Noise Source Calibration** | Weekly | Internal 10dB calibrated source |
| **System Temperature Verification** | Monthly | Cold sky measurements |
| **Full Gain Calibration** | Quarterly | Standard celestial sources |

### **5.2 Observation Schedule**

The observatory follows a structured observation schedule designed to balance different research objectives and optimize time allocation.

| **Observation Type** | **Scheduling** | **Target** |
|---------------------|---------------|-----------|
| **Drift Scans** | Daily | NW sky quadrant |
| **HVC Monitoring** | Weekly | Known high-velocity cloud positions |
| **LSBG Detection** | Monthly | Candidate fields from optical surveys |
| **SNR Mapping** | Quarterly | Known and candidate supernova remnants |

---

## **6. Future Expansion**

### **6.1 Hardware Upgrades**

The observatory design allows for modular upgrades to enhance capabilities without requiring complete system replacement.

| **Component** | **Planned Upgrade** | **Timeline** |
|--------------|---------------------|-------------|
| **Antenna** | 1.2m dish for higher gain | Phase 4 |
| **Mount** | Explore Scientific iEXOS-100 PMC-8 motorized mount | Phase 4 |
| **Additional Feeds** | Multiple 1420 MHz feeds for interferometry | Future consideration |
| **Signal Processing** | GPU-accelerated real-time processing | Phase 4 |

### **6.2 Research Capability Expansion**

Future hardware enhancements will enable new research capabilities:

- **Targeted observations** of specific celestial objects rather than drift scanning only
- **Higher spatial resolution** for mapping detailed hydrogen structures
- **Multi-frequency observations** for spectral index studies
- **Longer integration times** for even greater sensitivity

---

## **7. Summary**

The observatory hardware layer of the Proxmox Astronomy Lab represents a carefully engineered radio astronomy system that balances research-grade capabilities with practical implementation constraints. Key takeaways include:

- **Research-grade components** from AGO provide exceptional sensitivity
- **Complete signal chain** designed specifically for 1420 MHz observations
- **Integration with lab infrastructure** enables sophisticated data processing
- **Modular design** allows component upgrades as research needs evolve
- **Portable capability** enables both urban and dark sky observations

This infrastructure establishes a foundation for meaningful contributions to hydrogen line radio astronomy research within a citizen science context, bridging the gap between amateur efforts and professional facilities.

---

## **8. References**

| **Resource** | **Description** | **URL/Location** |
|--------------|-----------------|------------------|
| **AGO Product Documentation** | Technical specifications for LNA and filters | Internal documentation |
| **Hydrogen Line Observing Guide** | Best practices for 21cm observations | hydrogen-line-observing-guide.md |
| **Feed Chain Diagram** | Signal path visualization | feed-chain-diagram.png |
| **Calibration Procedures** | Detailed calibration steps | calibration-procedures.md |

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

# **Low Surface Brightness Galaxy (LSBG) Search - Proxmox Astronomy Lab**

## **📡 Overview**

Low Surface Brightness Galaxies (LSBGs) are faint, diffuse galaxies that are difficult to detect in optical wavelengths but **rich in neutral hydrogen (HI)**, making them **ideal targets for Hydrogen Line (1420 MHz) observations**. The **Proxmox Astronomy Lab** employs **radio astronomy techniques, AI-enhanced data processing, and multi-wavelength cross-referencing** to identify and study these elusive galaxies.

This project focuses on:

- **Detecting LSBGs through HI emissions** using spectral analysis
- **Characterizing their dynamics** via Doppler velocity mapping
- **Correlating with optical surveys** to confirm detections and study galaxy evolution

---

## **🔬 Observational Strategy**

### **🔹 Why Use the Hydrogen Line for LSBG Detection?**

- LSBGs often **lack strong optical signatures** but emit **HI at 1420 MHz**.
- Their **large dark matter content** influences rotational dynamics, measurable via **Doppler velocity shifts**.
- Detecting them **via radio surveys** provides insights into the **missing baryon problem** and **galaxy formation models**.

### **🔹 Search Criteria for LSBG Candidates**

- **Extended HI structures** with **low integrated brightness**.
- **Minimal association with bright optical counterparts** in SDSS, DESI, or Pan-STARRS data.
- **Velocity dispersion and rotation curves** suggesting stable yet faint mass distributions.

---

## **📡 Data Collection & Processing Pipeline**

The **LSBG detection pipeline** integrates **Hydrogen Line spectroscopy, AI-driven classification, and optical cross-referencing**.

### **🔹 Data Acquisition**

| Component | Specification |
|-----------|--------------|
| **Antenna** | Nooelec GOES Parabolic Mesh (21 dBi gain) |
| **LNA** | RAS 21cm VLNA (0.29 dB noise figure, 32 dB gain) |
| **Filter** | RAS BP 1420 MHz Cavity Filter (2 dB loss, >20 dB rejection at ±100 MHz) |
| **SDR** | Airspy R2 (12-bit ADC, 10 MSPS max sample rate) |
| **Clock Reference** | GooZeeZOO GPSDO (Frequency stability for precise Doppler shifts) |
| **Edge Node** | N100 Mini PC (1TB SSD, Ubuntu 24.04, Airspy SDR software) |

### **🔹 Signal Processing Workflow**

1. **Raw Hydrogen Line Spectrum Capture**
   - SDR collects **I/Q samples** at 2.5 MSPS.
   - Data stored in **high-resolution frequency bins**.

2. **Spectral Feature Extraction**
   - **Doppler correction** for Earth’s rotation.
   - **HI line broadening analysis** to identify extended structures.

3. **AI-Based Classification**
   - **Deep learning models** trained on simulated & archival data.
   - **Anomaly detection** for weak HI signatures.

4. **Cross-Referencing with Optical Data**
   - **Matching HI detections** to SDSS, Pan-STARRS, DESI images.
   - **Analyzing discrepancies** between HI mass and visible structure.

---

## **📊 Expected Sensitivity & Performance**

| Parameter | Value |
|-----------|-------|
| **System Noise Figure** | <1 dB |
| **Detection Threshold (SNR)** | >7 dB for candidate LSBGs |
| **Integration Time per Target** | ~2 hours |
| **Minimum Detectable HI Mass** | ~10⁷ M☉ |
| **Spectral Resolution** | 5 kHz bins (~1 km/s velocity resolution) |

---

## **🌍 Research & Public Data Access**

### **🔹 Live Data & Analysis**

- **Real-time spectral plots** via **Grafana dashboards**.
- **REST API access** for querying HI spectra.

### **🔹 Open Data Collaboration**

- **Cross-verification** with **NRAO, ALMA, and FAST** survey data.
- **Community contributions** via **citizen science radio observatories**.

---

## **🚀 Future Developments**

✅ **Deploying a 1.2m dish** for increased sensitivity to diffuse HI structures.  
✅ **Integrating optical data pipelines** for automatic HI-to-optical matching.  
✅ **Expanding AI models** to detect **fainter, lower-mass galaxies**.  

🔹 **Stay updated by following the main repository!**  

📌 **For full documentation, visit the main [Proxmox Astronomy Lab README](../README.md).**

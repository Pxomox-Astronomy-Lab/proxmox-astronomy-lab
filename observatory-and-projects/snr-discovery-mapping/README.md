# **Supernova Remnant (SNR) Mapping - Proxmox Astronomy Lab**

## **📡 Overview**

Supernova remnants (SNRs) are the expanding remains of stellar explosions, emitting strong **radio emissions** due to interactions between high-energy particles and magnetic fields. The **Proxmox Astronomy Lab** leverages **Hydrogen Line observations, AI-enhanced spectral analysis, and cross-referencing with multi-wavelength datasets** to identify, classify, and track the evolution of SNRs.

This project focuses on:

- **Detecting and characterizing radio emissions from SNRs** in the 1420 MHz band.
- **Mapping velocity dispersion and expansion dynamics** using Doppler analysis.
- **Cross-referencing with X-ray and optical surveys** to build multi-band SNR profiles.

---

## **🔬 Observational Strategy**

### **🔹 Why Study SNRs in the Hydrogen Line Band?**

- SNRs can **sweep up and compress neutral hydrogen gas**, altering **HI emission profiles**.
- The **expanding shock waves** introduce measurable **Doppler shifts** in the HI spectrum.
- Many **known and undiscovered SNRs** exist in regions with strong HI emissions, making spectral analysis crucial for understanding their impact.

### **🔹 SNR Candidate Selection Criteria**

- **Broad HI line profiles** with **asymmetries suggesting expansion shocks**.
- **Velocity dispersion exceeding thermal broadening** (indicating non-thermal effects).
- **Positional correlation with known SNR sites** in Chandra, ROSAT, and VLA surveys.

---

## **📡 Data Collection & Processing Pipeline**

The **SNR detection pipeline** integrates **Hydrogen Line spectral analysis, AI-assisted classification, and cross-referencing with X-ray and optical datasets**.

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
   - SDR collects **I/Q samples** at **2.5 MSPS**.
   - Data stored in **high-resolution frequency bins**.

2. **Spectral Feature Extraction**
   - **Doppler correction** to remove Earth's motion effects.
   - **Velocity dispersion mapping** to identify broadened HI lines.

3. **AI-Based Classification**
   - **Deep learning models** trained on simulated & archival SNR spectra.
   - **Automated anomaly detection** for shock-wave induced HI distortions.

4. **Multi-Wavelength Cross-Referencing**
   - **Comparing detected SNR candidates** with **Chandra X-ray, ROSAT, and VLA radio maps**.
   - **Assessing HI expansion velocities** against known SNR ages.

---

## **📊 Expected Sensitivity & Performance**

| Parameter | Value |
|-----------|-------|
| **System Noise Figure** | <1 dB |
| **Detection Threshold (SNR)** | >7 dB for SNR candidates |
| **Velocity Resolution** | ~1 km/s |
| **Integration Time per Target** | ~2-4 hours |
| **Minimum Detectable HI Distortion** | <5 km/s velocity broadening |

---

## **🌍 Research & Public Data Access**

### **🔹 Live Data & Analysis**

- **Real-time spectral plots** via **Grafana dashboards**.
- **REST API access** for querying Hydrogen Line spectra.

### **🔹 Open Data Collaboration**

- **Comparison with external SNR catalogs** (e.g., Green’s SNR Catalog, NRAO, and ALMA).
- **Community-driven analysis** via citizen science radio astronomy groups.

---

## **🚀 Future Developments**

✅ **Deploying a 1.2m dish** for improved SNR shockwave detection.  
✅ **Enhancing AI models** to classify **HI distortions indicative of SNR expansion**.  
✅ **Expanding cross-referencing with deep-sky X-ray & optical datasets**.  

🔹 **Stay updated by following the main repository!**  

📌 **For full documentation, visit the main [Proxmox Astronomy Lab README](../README.md).**

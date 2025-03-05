# **Proxmox Astronomy Lab - Observatory Projects**

## **📡 Overview**

The **Proxmox Astronomy Lab** hosts multiple **radio astronomy and scientific computing projects**, with a primary focus on **Hydrogen Line observations, Low Surface Brightness Galaxies (LSBGs), Supernova Remnant (SNR) mapping, and high-velocity clouds (HVCs)**. The lab integrates **high-performance computing, AI-enhanced signal processing, and open data pipelines** to facilitate cutting-edge research.

The Proxmox Astronomy Lab cluster is a high-performance hybrid computing environment, featuring over 80 vCPUs and 400GB of RAM across multiple nodes optimized for scientific workloads, data processing, and AI-enhanced signal analysis. The cluster includes high-speed NVMe storage, a dedicated RTX A4000 GPU for ML and spectral analysis, and a Kubernetes infrastructure for containerized research applications. Network performance is maximized through 10Gbps LACP links, ensuring efficient data movement between compute and storage nodes.

![proxmox-astronomy-lab-cluster-summary](proxmox-astronomy-lab-cluster-summary-2025-03.png)

This document provides an overview of the **observatory projects, data collection pipelines, and public data resources**.

---

## **🔬 Observatory Projects**

### **📡 Hydrogen Line Research**

The **Hydrogen Line (1420 MHz) is a key radio emission line** that allows astronomers to study the structure and motion of interstellar hydrogen gas. The lab is dedicated to long-term tracking of the Hydrogen Line to analyze:

- **High-velocity clouds (HVCs)** and their role in galaxy formation
- **Doppler shift-based velocity measurements**
- **Deep spectral mapping of the Milky Way**

🔹 **Key Technologies**:

- **Antenna**: Nooelec GOES Parabolic Mesh (21 dBi gain)
- **Filtering & Amplification**: RAS-1420LNA-CBPF (Low Noise Cavity Filter + LNA)
- **SDR**: Airspy R2 (12-bit ADC, 10 MSPS, SpyVerter support)
- **Data Processing**: AI-driven spectral analysis in **PostgreSQL + TimescaleDB**

📌 **More details available in [Hydrogen Line Project](hydrogen-line-hvc/README.md).**

### **🌌 Low Surface Brightness Galaxies (LSBG) Search**

LSBGs are galaxies with **faint optical emissions** but significant **hydrogen content**, making them detectable via Hydrogen Line observations. The lab aims to identify and map these galaxies using:

- **Deep integration spectral analysis**
- **AI-assisted signal enhancement**
- **Cross-referencing with optical surveys**

📌 **More details available in [LSBG Project](low-surface-brightness-galaxies/README.md).**

### **💥 Supernova Remnant (SNR) Mapping**

SNRs emit strong **radio emissions**, which can be detected in various **radio frequencies**. The lab is involved in mapping SNRs and their expansion dynamics by:

- **Tracking radio emissions from known SNRs**
- **Comparing archival and real-time observations**
- **Machine learning-assisted signal classification**

📌 **More details available in [SNR Project](snr-discovery-mapping/README.md).**

---

## **📡 Data Collection & Processing Pipelines**

The lab operates a **highly automated data collection and processing pipeline** designed for **real-time and batch processing of radio astronomy data**.

### 🔹 **Signal Acquisition & Filtering**

- **Primary Feed Line**: Nooelec GOES Parabolic Mesh → LMR400 → RAS-1420LNA-CBPF Filter → Airspy R2 SDR
- **Noise Filtering**: High-Q cavity bandpass filter with LNA
- **Data Format**: 12-bit I/Q samples at configurable sample rates

📌 **More details available in [Feed Line Configuration](feed_hydrogen_line.txt).**

### 🔹 **Data Ingestion & Storage**

- **SDR Data Acquisition**: Airspy R2 streaming I/Q samples
- **Preprocessing**: Spectral binning and Doppler correction
- **Storage**: TimescaleDB for time-series data
- **Compression & Archival**: Data is compressed using optimized binary formats for efficient long-term storage

### 🔹 **AI-Enhanced Signal Processing**

- **Noise reduction via deep learning models**
- **Anomaly detection in spectral profiles**
- **Automated Doppler shift analysis for velocity mapping**

### 🔹 **Data Access & Public Availability**

- **Public Grafana Dashboards**: Live signal visualizations
- **REST API for Processed Data**: Time-series Hydrogen Line data
- **Periodic Data Releases**: Archived data made available for research use

📌 **More details available in [Data Pipelines](../data-pipelines.md).**

---

## **🌍 External & Public Data Sources**

To enhance research efforts, the lab integrates external datasets, including:

- **NRAO & ALMA Data Archives** for reference observations
- **GEOS-16/17 Weather Data** for RFI monitoring
- **NASA Sky Survey Data** for cross-referencing Hydrogen Line detections
- **Citizen Science Contributions** from amateur radio astronomers worldwide

---

## **🚀 Future Developments**

The lab is actively developing:

- **A larger 1.2m dish for higher-resolution Hydrogen Line studies**
- **Integration with OpenSpace for real-time celestial visualization**
- **Expanded S3-based public dataset hosting** for increased accessibility

🔹 **Stay updated by following the main repository!**

📌 **For full documentation, visit the main [Proxmox Astronomy Lab README](../README.md).**

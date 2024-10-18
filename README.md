# FOOOF_Matlab

This repository contains MATLAB and Python scripts for analyzing neural power spectra using the FOOOF (Fitting Oscillations and One Over F) method. FOOOF decomposes power spectra into aperiodic (1/f) and oscillatory components, allowing for a detailed analysis of neural data.

## Features

- **FOOOF Analysis in MATLAB**: Perform FOOOF fitting on power spectra with `FOOOF_analysis.m`.
- **Preprocessing**: `Matlab-PreProcessing.m` provides tools for data preprocessing.
- **Python Compatibility**: `python_fooofing.py` integrates MATLAB data with Python’s FOOOF library.
- **Power Spectral Density Calculation**: `Calculate_Psd.m` computes the PSD for neural signals.

## Getting Started

### Prerequisites
- MATLAB R2021a or later
- Python 3.7+ (for FOOOF in Python)
- Required packages: `matplotlib`, `numpy`, and `scipy`

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/mahsanaseri1374/FOOOF_Matlab.git
   
2. Install Python dependencies:

bash
    pip install -r requirements.txt

Usage

    Preprocess your data using Matlab-PreProcessing.m.
    Compute the power spectral density with Calculate_Psd.m.
    Run the FOOOF analysis using FOOOF_analysis.m.

Contributing

Feel free to submit issues or pull requests if you'd like to contribute or improve the repository.
License

plaintext

This project is licensed under the MIT License.

vbnet


This formatting keeps everything in code style, ensuring clarity. Let me know if you need further modifications!


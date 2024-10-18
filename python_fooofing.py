import numpy as np
from scipy.io import loadmat
from scipy.io import savemat



# FOOOFGroup
from fooof import FOOOFGroup
import matplotlib.pyplot as plt
from fooof.plts.annotate import plot_annotated_model
from fooof.plts.spectra import plot_spectra
from fooof.plts.annotate import plot_annotated_model
from fooof.plts.aperiodic import plot_aperiodic_params
from fooof.plts.templates import plot_hist
from fooof.plts.spectra import plot_spectra
from fooof.plts.aperiodic import plot_aperiodic_params, plot_aperiodic_fits
import matplotlib.pyplot as plt



# Load the mat file
data = loadmat('Mean_HC_power_spectra.mat')

# Extract the frequency vector and PSD data
freqs = np.squeeze(data['freqs']).astype('float')
psds = np.squeeze(data['psd_data']).astype('float')


# Initialize FOOOFGroup object
fg = FOOOFGroup(max_n_peaks=8, peak_width_limits=(1, 8), min_peak_height=0.1, peak_threshold=0 ,aperiodic_mode='fixed')

# Fit the FOOOF model on all PSDs, and report
fg.fit(freqs, psds , [2, 40])  # Ensure both are numpy arrays

# Generate a report
fg.report()

# Save results
# Extract aperiodic parameters
aps = fg.get_params('aperiodic_params')
exps = fg.get_params('aperiodic_params', 'exponent')

# Extract peak parameters
peaks = fg.get_params('peak_params')
cfs = fg.get_params('peak_params', 'CF')
gaussian = fg.get_params('gaussian_params')

# Extract goodness-of-fit metrics
errors = fg.get_params('error')
r2s = fg.get_params('r_squared')
# print(fg.get_params.__doc__)
savemat('Multifooof_results(HC).mat', {'aperiodic_params': aps ,'gaussian_params': gaussian, 'peak_params': peaks ,'error': errors,'r_squared': r2s})
fg.save_report('Multifooof_results(HC)' )

# --------------------------------------------------------------------------
# single FOOOF
from fooof import FOOOF
from fooof.plts.spectra import plot_spectra
from fooof.plts.annotate import plot_annotated_model
from fooof.plts.aperiodic import plot_aperiodic_params
from fooof.plts.templates import plot_hist
from fooof.plts.spectra import plot_spectra
from fooof.plts.aperiodic import plot_aperiodic_params, plot_aperiodic_fits
import matplotlib.pyplot as plt
# Load the mat file
data = loadmat('spectraPDMEDOFF.mat')

# Unpack data from dictioanry, and squeeze numpy arrays
freqs = np.squeeze(data['f'])
psd = np.squeeze(data['mean_psd'])
# Initialize FOOOF object
fm = FOOOF(max_n_peaks=10, peak_width_limits=(1, 8), min_peak_height=0.1, peak_threshold=0 ,aperiodic_mode='fixed')

# Fit the FOOOF model, and report
fm.report(freqs, psd , [2 , 40])
fm.fit(freqs, psd , [2 , 40])

# Extract FOOOF results from object
fooof_results = fm.get_results()

# Convert FOOOF results to a dictionary
#  This is useful for saving out as a mat file
fooof_results_dict = fooof_results._asdict()
# Save FOOOF results out to a mat file
savemat('fooof_results_PDMEDOFF.mat', fooof_results_dict)
plot_annotated_model(fm, annotate_peaks=True, annotate_aperiodic=True, plt_log=True)
fm.save_report('./Rest/FOOOFResults/FOOOF_report_PDMEDOFF' ,plt_log=True)

plt.show()
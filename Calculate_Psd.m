load('subjectsData_3Condition(1000).mat');

%% calculate mean psd of all subject and channels per group and save it
% # Matlab PreProcessing - Lone PSD


data_labels = {'HC', 'PDMEDOFF', 'PDMEDON'};
colors = {'b', 'r', 'g'};
figure;
hold on;
for dataset = 1:3
    data = subjects_data{dataset};
    fs = 1000; % Assuming the sampling rate is 1000 Hz
    n_subjects = size(data, 1); % Number of subjects
    n_channels = size(data, 2); % Number of channels

    nfft = 4 * fs; % This gives 0.25 Hz resolution (1000 / 4000 = 0.5 Hz)

    % Initialize array to store the mean PSD for this dataset
    mean_psd = zeros(nfft/2 + 1, 1); % Length of PSD array for one-sided spectrum

    % Loop through each subject and each channel
    for subj = 1:n_subjects
        for ch = 1:n_channels
            % Get the time series data for the current subject and channel
            chs_data = data{subj, ch}';

            % Calculate power spectra with Welch's method
            [psd, f] = pwelch(chs_data, hann(nfft), nfft/2, nfft, fs);
            % Add to mean PSD
            mean_psd = mean_psd + psd;
        end
    end

    % Calculate the average by dividing by the total number of PSDs
    mean_psd = mean_psd / (n_subjects * n_channels);

    % Plot the Mean PSD
    plot(f, log10(mean_psd), 'Color', colors{dataset}, 'LineWidth', 1.5);
    % save Mean PSD for per group
    save(['spectra', data_labels{dataset}, '.mat'],  'f', 'mean_psd');
end

% Customize the plot
title('Mean PSD Across All Subjects and Channels');
xlabel('Frequency (Hz)');
ylabel('log(Power µV^2)');
legend(data_labels);
grid on;
xlim([0-40]); % Limit display to 0-40 Hz as in the image

% Add minor gridlines
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on');
grid minor;

hold off;


 %% calculate psd of all subject and channels per group and save it (this code for HC group)
% Matlab PreProcessing - Multiple PSDs

data = subjects_data{1};

% Define parameters
n_subjects = size(data, 1); % Number of subjects
n_channels = size(data, 2); % Number of channels

fs = 1000;  % Sampling frequency (Hz)
nfft = 4 * fs; % This gives 0.25 Hz resolution (1000 / 4000 = 0.5 Hz)
% % Get the number of subjects and channels
[num_subjects, num_channels] = size(data);

% Initialize matrices to store max PSD and frequencies
psd_data = [];
freqs = [];

% Loop over each subject
for r = 1:num_subjects
    % Initialize a matrix to store PSDs for all channels of the current subject
    subject_psd = [];

    % Loop over each channel
    for c = 1:num_channels
        % Get the EEG data for the current subject and channel
        eeg_data = data{r, c};

        % Calculate the power spectral density using Welch's method
        [psd, f] = pwelch(eeg_data,hann(nfft), nfft/2, nfft, fs); 

        % Store the frequency vector (only once, assuming it's the same for all)
        if isempty(freqs)
            freqs = f;
        end

        % Append the current channel PSD to the subject's PSD matrix
        subject_psd = [subject_psd; psd'];
    end

    % Calculate the mean PSD across all channels for this subject

    % max_psd = max(subject_psd, [], 1);
    % min_psd = min(subject_psd, [], 1);
    mean_psd = mean(subject_psd, 1);

    % Append the mean PSD for the current subject to the overall data matrix
    psd_data = [psd_data; mean_psd];
end

% Save the max power spectra and frequency vector to a mat file
save('Mean_HC_power_spectra.mat', 'freqs', 'psd_data');

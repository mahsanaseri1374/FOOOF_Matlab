fooof_results_HC= load('Multifooof_results(HC).mat');
fooof_results_PDMEDOFF= load('Multifooof_results(PDMEDOFF).mat');
fooof_results_PDMEDON =load('Multifooof_results(PDMEDON).mat');
%% Explore FOOOF Results

% Check out FOOOF results
fooof_results_HC
fooof_results_PDMEDOFF
fooof_results_PDMEDON
%% Now you can do anything you want with your FOOOF results

% extract aperiodic parameters
    %exponent
aperiodic_exponent_HC = fooof_results_HC.aperiodic_params(:, 2);
aperiodic_exponent_PDMEDOFF = fooof_results_PDMEDOFF.aperiodic_params(:, 2);
aperiodic_exponent_PDMEDON = fooof_results_PDMEDON.aperiodic_params(:, 2);
    %offset

aperiodic_offset_HC = fooof_results_HC.aperiodic_params(:, 1);
aperiodic_offset_PDMEDOFF = fooof_results_PDMEDOFF.aperiodic_params(:, 1);
aperiodic_offset_PDMEDON = fooof_results_PDMEDON.aperiodic_params(:, 1);
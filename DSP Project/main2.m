clear all;
close all;
clear all;


% Load the signal from a files
[original_signal, fs] = audioread('Noised_Voice_DSP.wav');

Define the cut-off frequency for the low-pass filter
f_cutoff = 500; % 3000 Hz

% Normalized cut-off frequency for the digital filter (from 0 to 1, where 1 is half the sample rate)
f_norm = f_cutoff / (fs / 2);

% Create the coefficients of a Butterworth low-pass filter
[b,a] = butter(2, f_norm, 'low');

% Apply the filter to the signal
filtered_signal = filter(b, a, original_signal);

% Define amplification factor
amp_factor = 2; % Amplification by 2

% Amplify the signal
amplified_signal = amp_factor * filtered_signal;

% It's possible that amplification may cause some values to go beyond the valid range for audio data 
% (which is usually between -1 and 1). So, it's important to ensure that the amplified signal is 
% still within the valid range:

amplified_signal(amplified_signal > 1) = 1;
amplified_signal(amplified_signal < -1) = -1;

% Save the amplified signal to a file
audiowrite('Amplified_Denoised_Audio.wav', amplified_signal, fs);

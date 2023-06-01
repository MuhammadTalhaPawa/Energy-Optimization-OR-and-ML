clc;
clear all;
close all;
%my file

% % Load the signal from a files
% [original_signal, fs] = audioread('Noised_Voice_DSP.wav');

% Define the cut-off frequency for the low-pass filter
% f_cutoff = 500; % 3000 Hz
% 
% % Normalized cut-off frequency for the digital filter (from 0 to 1, where 1 is half the sample rate)
% f_norm = f_cutoff / (fs / 2);
% 
% % Create the coefficients of a Butterworth low-pass filter
% [b,a] = butter(2, f_norm, 'low');
% 
% % Apply the filter to the signal
% filtered_signal = filter(b, a, original_signal);
% 
% % Define amplification factor
% amp_factor = 2; % Amplification by 2
% 
% % Amplify the signal
% amplified_signal = amp_factor * filtered_signal;
% 
% % It's possible that amplification may cause some values to go beyond the valid range for audio data 
% % (which is usually between -1 and 1). So, it's important to ensure that the amplified signal is 
% % still within the valid range:
% 
% amplified_signal(amplified_signal > 1) = 1;
% amplified_signal(amplified_signal < -1) = -1;
% 
% % Save the amplified signal to a file
% audiowrite('Amplified_Denoised_Audio.wav', amplified_signal, fs);


% % Load the WAV file
% filename = 'your_wav_file.wav';
% [y, fs] = audioread(filename);

[original_signal_noise_free, fs1] = audioread('voice-noisefree.wav');
[noise_signal, fs2] = audioread('traffic-noise-2-trunked.wav');

length(original_signal_noise_free)
length(noise_signal)

f_cutoff = 500;
f_norm = f_cutoff / (fs1 / 2);
[b,a] = butter(6, f_norm, 'low');
filtered_signal = filter(b, a, original_signal_noise_free);
[f3,P3] = FreqRes(filtered_signal,fs1);


[f1,P1] = FreqRes(original_signal_noise_free,fs1);
[f2,P2] = FreqRes(noise_signal,fs2);

% audiowrite('voice-noised-1.wav', x1, fs1);

figure(1);
subplot(311);
plot(f1,P1);
subplot(312);
plot(f2,P2);
subplot(313);
plot(f3,P3);

function [f,P1] = FreqRes(y,fs)
    % Compute the single-sided amplitude spectrum
    Y = fft(y);
    L = length(y);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    % Define the frequency axis
    f = fs*(0:(L/2))/L;
end


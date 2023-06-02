
[noised_signal, fs1] = audioread('noised-voiced-aun.wav');

f_cutoff = 1000;
f_norm = f_cutoff / (fs1 / 2);
[b,a] = butter(6, f_norm, 'low');
filtered_signal = filter(b, a, noised_signal);

amplified_signal = filtered_signal.*2;

[f1,P1] = FreqRes(noised_signal*2,fs1);
[f2,P2] = FreqRes(filtered_signal,fs1);

figure(1);
subplot(211);
plot(noised_signal);
title("Time domain Noised Signal");
xlabel("Time");
ylabel("Amplitude");
subplot(212);
plot(filtered_signal);
title("Time domain Denoised Signal");
xlabel("Time");
ylabel("Amplitude");

figure(2);
subplot(211);
plot(f1,P1);
title("Noised Signal Frequency PLot");
xlabel("Frequency");
ylabel("Magnitude");
subplot(212);
plot(f2,P2);
title("Denoised Signal Frequency PLot");
xlabel("Frequency");
ylabel("Magnitude");

audiowrite('filtered-signal-4.wav', amplified_signal, fs1);



%% Function that returns the frequency response of a signal
function [f,P1] = FreqRes(y,fs)
end

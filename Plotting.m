%% SDR DSP Pipeline

clc; close all;

Fs = 2e6;   % Sampling rate



%% 1. Time Domain Signal
figure(Name="Time Domain Signal");
plot(real(z(1:end)));
title('Time Domain Signal');
xlabel('Samples');
ylabel('Amplitude');
grid on;


%% 2. IQ Constellation
figure(Name="IQ Constellation");
plot(I,Q, 'bo');
title('IQ Constellation');
xlabel('I');
ylabel('Q');
grid on;

%% 3. Spectrogram
figure(Name="Spectrogram");
z = I + 1j*Q;

% Parameters for spectrogram
window_size = 1024;        % samples per FFT
overlap = 512;             % overlap between windows
nfft = 1024;               % FFT points

% Compute spectrogram
[S,F,T] = spectrogram(data(:,2), 1024, 512, 1024, Fs);
imagesc(T,F,abs(S));
axis xy;
  
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');

xlim([0 endTime-startTime]);
ylim([4.0e5 4.6e5]);
    
%Show time in range k-1 to k instead of 0 to 1
xticklabels(xticks + startTime)
    
title("Spectrogram");

%% 4. Frequency Spectrum using FFT
Z = fftshift(fft(z));
P = abs(Z).^2 / N;

f = linspace(-Fs/2, Fs/2, N);

figure(Name="Power Spectral Density");
plot(f,10*log10(P + eps))
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
title('Power Spectral Density')
grid on

%% 5. Detect Signal Peaks
threshold = mean(P) + 5*std(P);

peaks = find(P > threshold);

peak_freqs = f(peaks);

disp('Detected signal frequencies:')
disp(unique(round(peak_freqs/1000))*1000)

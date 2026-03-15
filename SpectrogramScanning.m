clear; clc; close all;

folder = 'parsed';
files = dir(fullfile(folder,'*.txt'));

Fs = 2e6;

for k = 71:71

    filename = fullfile(folder, files(k).name);
    data = readmatrix(filename);

    [S,F,T] = spectrogram(data(:,2), 1024, 512, 1024, Fs);
    imagesc(T,F,abs(S));
    axis xy;
  
    xlabel('Time (seconds)');
    
    %Show time in range k-1 to k instead of 0 to 1
    xticklabels(xticks + k - 1)
    
    ylabel('Frequency (Hz)');
    title(files(k).name);

    disp(filename);
    disp("Time = " + k);
    colorbar;

    pause(0.4)
end
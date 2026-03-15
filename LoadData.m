clear; clc; close all;

folder = 'parsed';
files = dir(fullfile(folder,'*.txt'));

data = [];

startTime = 2;
endTime = 10;

for k = startTime+1:endTime
    temp = readmatrix(fullfile(folder,files(k).name));
    data = [data; temp];   % stack vertically
end

I = double(data(:, 1));
Q = double(data(:, 2));

z = I + 1j*Q;
z = z(:);

N = length(z);
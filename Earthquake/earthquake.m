close all, clear, clc
load data.mat

s= 2;
%t= t(1:s:end);
dt= t(2)-t(1);
Es= smooth(E(1:s:end), 500, "sgolay");
hold on, plot(t, E(1:s:end)), plot(t, Es),

%E=Es

% Calculate the length of the data
Ndata = length(E);

% Compute the FFT of the centered data
Y = fft(E);

% Compute the power spectrum (squared absolute value of Y)
Pyy = Y .* conj(Y) / Ndata;

% Compute the frequencies associated with the FFT values
f = (0:Ndata-1) / (Ndata * dt);

% Select the range of frequencies of interest
% Normally, we only display up to the Nyquist frequency, which is half of the sampling rate
f = f(1:Ndata/2+1);
Pyy = Pyy(1:Ndata/2+1);
Pyy= smooth(Pyy, 50)
% Generate a log-log plot of the power spectrum
figure;
loglog(f, Pyy);

xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum of Earthquake Data');

% You may need to adjust the axis limits to properly visualize your data
% For example, you might do something like this:
xlim([min(f) max(f)]);

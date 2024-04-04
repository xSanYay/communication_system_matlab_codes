% Parameters
N = 1000;           % Number of samples
Fs = 1000;          % Sampling frequency (Hz)
T = 1/Fs;           % Sampling period (s)
t = (0:N-1)*T;      % Time vector

% Discrete-Time Sequence (Simple Sinusoidal Signal)
x_discrete = sin(2*pi*10*t); % Simple sinusoidal signal

% Random Process (Gaussian Random Sequence)
x_random = randn(1, N); % Gaussian random sequence

% Autocorrelation function (Discrete-Time Sequence)
autocorr_discrete = xcorr(x_discrete, 'biased'); % Biased autocorrelation estimate

% Power Spectral Density (PSD) estimation using pwelch (Discrete-Time Sequence)
[Pxx_discrete, freq_discrete] = pwelch(x_discrete, [], [], [], Fs);

% Autocorrelation function (Random Process)
autocorr_random = xcorr(x_random, 'biased'); % Biased autocorrelation estimate

% Power Spectral Density (PSD) estimation using pwelch (Random Process)
[Pxx_random, freq_random] = pwelch(x_random, [], [], [], Fs);

% Plot results for Discrete-Time Sequence
figure;
subplot(2,1,1);
plot(t, x_discrete);
title('Discrete-Time Sequence (Simple Sinusoidal Signal)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
plot(autocorr_discrete);
title('Autocorrelation Function (Discrete-Time Sequence)');
xlabel('Lag');
ylabel('Autocorrelation');
grid on;

subplot(2,2,4);
plot(freq_discrete, 10*log10(Pxx_discrete));
title('Power Spectral Density (PSD) (Discrete-Time Sequence)');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;

% Plot results for Random Process
figure;
subplot(2,1,1);
plot(t, x_random);
title('Random Process (Gaussian Random Sequence)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
plot(autocorr_random);
title('Autocorrelation Function (Random Process)');
xlabel('Lag');
ylabel('Autocorrelation');
grid on;

subplot(2,2,4);
plot(freq_random, 10*log10(Pxx_random));
title('Power Spectral Density (PSD) (Random Process)');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;

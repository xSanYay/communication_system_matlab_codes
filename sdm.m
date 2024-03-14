clc;
clear all;
close all;

% Parameters
t = -5:0.01:5;      % Time axis
f = 2;               % Frequency of sinusoidal signal
w = 2*pi*f;          % Angular frequency
osr = 250;           % Oversampling ratio
fs1 = w/pi;          % Ideal sampling frequency
fs = fs1 * osr;      % Actual sampling frequency

% Sampling times
ts = -5:(1/fs):5;    % Sampling times

% Original signal definition
y = @(t) sin(w.*t);  

% Sigma Delta Quantization
[u, q] = SDQ(y(ts), ts);

% Reconstruction algorithm
z = zeros(size(t));
for k = 1:length(ts)
    z = z + q(k) .* sinc(w.*(t - ts(k)));
end
c = max(y(t)) / max(z);  % Scaling
z = z .* c;

% Plotting
figure;
subplot(3,1,1);
plot(t, y(t), 'linewidth', 2);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(3,1,2);
plot(ts, q);
title('SDQ Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, z, 'linewidth', 2);
title('Reconstructed Signal');
xlabel('Time');
ylabel('Amplitude');

% Calculate error
error = immse(z, y(t));

% Sigma Delta Quantization function
function [u, q] = SDQ(y, t)
    q = zeros(1, length(t));
    u = zeros(1, length(t));
    u(1) = 0.9;
    
    for k = 2:length(t)
        q(k) = sign(u(k-1) + y(k));
        u(k) = u(k-1) + y(k) - q(k);
    end
end

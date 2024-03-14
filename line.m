% Input parameters
N = 10;         % Number of input bits
a = floor(2 * rand(1, N));   % Generate random binary sequence (0's and 1's)
A = 5;          % Pulse amplitude
Tb = 1;         % Bit period
fs = 100;       % Number of samples taken in a bit period (even number)

% Unipolar NRZ
U = [];
for k = 1:N
    U = [U, A * a(k) * ones(1, fs)];
end

% Unipolar RZ
U_rz = [];
for k = 1:N
    c = ones(1, fs/2);
    b = zeros(1, fs/2);
    p = [c, b];
    U_rz = [U_rz, A * a(k) * p];
end

% Polar NRZ
P = [];
for k = 1:N
    P = [P, ((-1)^(a(k) + 1)) * A * ones(1, fs)];
end

% Polar RZ
P_rz = [];
for k = 1:N
    c = ones(1, fs/2);
    b = zeros(1, fs/2);
    p = [c, b];
    P_rz = [P_rz, ((-1)^(a(k)+1)) * A * p];
end

% Bipolar NRZ
B = [];
count = -1;
for k = 1:N
    if a(k) == 1
        if count == -1
            B = [B, A * a(k) * ones(1, fs)];
            count = 1;
        else
            B = [B, -A * a(k) * ones(1, fs)];
            count = -1;
        end
    else
        B = [B, A * a(k) * ones(1, fs)];
    end
end

% Bipolar RZ / AMI RZ
B_rz = [];
count = -1;
for k = 1:N
    if a(k) == 1
        if count == -1
            B_rz = [B_rz, A * a(k) * ones(1, fs/2), zeros(1, fs/2)];
            count = 1;
        else
            B_rz = [B_rz, -A * a(k) * ones(1, fs/2), zeros(1, fs/2)];
            count = -1;
        end
    else
        B_rz = [B_rz, A * a(k) * ones(1, fs)];
    end
end

% Split-phase or Manchester code
M = [];
for k = 1:N
    c = ones(1, fs/2);
    b = -1 * ones(1, fs/2);
    p = [c, b];
    M = [M, ((-1)^(a(k)+1)) * A * p];
end

% Time vector
T = linspace(0, N * Tb, length(U));

% Plotting
figure(1)
subplot(4, 1, 1); plot(T, U, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Unipolar NRZ'); grid on;
subplot(4, 1, 2); plot(T, U_rz, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Unipolar RZ'); grid on;
subplot(4, 1, 3); plot(T, P, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Polar NRZ'); grid on;
subplot(4, 1, 4); plot(T, P_rz, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Polar RZ'); grid on;

figure(2)
subplot(3, 1, 1); plot(T, B, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Bipolar NRZ'); grid on;
subplot(3, 1, 2); plot(T, B_rz, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Bipolar RZ / RZ-AMI'); grid on;
subplot(3, 1, 3); plot(T, M, 'LineWidth', 2); axis([0 N * Tb -6 6]); title('Manchester code'); grid on;







v = 1;        % Voltage level of a bit
R = 1;        % Bitrate
T = 1 / R;    % Bit period

f = 0:0.001*R:2*R;  % Frequency vector in terms of bitrate
f = f + 1e-10;      % Add a small value to avoid division by zero

% PSD curves are plotted for Bitrate=1bps and Pulse amplitude=1V

% Unipolar NRZ
s = ((v^2 * T / 4) .* (sin(pi .* f * T) ./ (pi .* f * T)).^2);
s(1) = s(1) + (v^2 / 4);  % Add an impulse function of weight v^2/4 at f=0
stem(0, s(1), '*r', 'LineWidth', 4);  % Impulse at f=0
hold on;
plot(f, s, '-r', 'LineWidth', 2);  % Unipolar NRZ curve

% Manchester code
s = (v.^2 .* T) .* ((sin(pi .* f * T / 2) ./ (pi .* f * T / 2)).^2) .* (sin(pi .* f * T / 2).^2);
plot(f, s, '--g', 'LineWidth', 2);  % Manchester code curve

% Polar NRZ
s = ((v^2 * T) .* (sin(pi .* f * T) ./ (pi .* f * T)).^2);
plot(f, s, '--b', 'LineWidth', 2);  % Polar NRZ curve

% Bipolar RZ / RZ-AMI
s = (v.^2 .* T / 4) .* ((sin(pi .* f * T / 2) ./ (pi .* f * T / 2)).^2) .* (sin(pi .* f * T).^2);
plot(f, s, '--k', 'LineWidth', 2);  % Bipolar RZ curve

% Add legends and labels
legend('Unipolar NRZ: impulse at at f=0', 'Unipolar NRZ', 'Manchester code', 'Polar NRZ', 'Bipolar RZ / RZ-AMI');
xlabel('Normalized frequency');
ylabel('Power spectral density');







% Define the range of Eb/N0 values (SNR per bit) in dB
EbN0_dB = [0:1:25];

% Convert Eb/N0 values to linear scale
EbN0 = 10.^(EbN0_dB/10);

% Calculate the probability of error for Unipolar NRZ
P1 = (1/2) * erfc(sqrt(EbN0/2));

% Calculate the probability of error for Polar NRZ and Manchester code
P2 = (1/2) * erfc(sqrt(EbN0));

% Calculate the probability of error for Bipolar RZ/RZ-AMI
P3 = (3/4) * erfc(sqrt(EbN0/2));

% Plot the results
semilogy(EbN0_dB, P1, '-k', EbN0_dB, P2, '-r', EbN0_dB, P3, '-b', 'LineWidth', 2);
legend('Unipolar NRZ', 'Polar NRZ and Manchester', 'Bipolar RZ/RZ-AMI', 'Location', 'best');
xlabel('SNR per bit, Eb/No (dB)');
ylabel('Bit error probability Pe');











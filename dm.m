% Delta Modulation

% Signal parameters
a = 2;
t = 0:2*pi/50:2*pi;
x = a * sin(t);

% Plot original signal
plot(t, x, 'r');
hold on;

% Delta modulation parameters
delta = 1;
xn = zeros(size(x));

% Apply delta modulation
for i = 1:length(x)
    if x(i) > xn(i)
        d(i) = 1;
        xn(i+1) = xn(i) + delta;
    else
        d(i) = 0;
        xn(i+1) = xn(i) - delta;
    end
end

% Plot delta-modulated signal
stairs(t, xn(1:end-1)); % Adjusted to ensure correct length
legend('Analog signal', 'DM with step size=0.2');
title('Delta Modulation');
xlabel('Time');
ylabel('Amplitude');

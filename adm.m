clc;
clear all;
close all;

% Signal parameters
a = 2;
t = 0:2*pi/50:2*pi; % Signal generation
x = a*sin(t);
l = length(x);

% Delta modulation parameters
delta = 0.2;

% Apply adaptive delta modulation
xn = zeros(1, l); % Initialize the output signal
cnt1 = 0;
cnt2 = 0;
sum = 0;

for i = 1:l
    if x(i) == sum
        % Do nothing
    elseif x(i) > sum
        if cnt1 < 2
            sum = sum + delta; % Step up by delta
        elseif cnt1 == 2
            sum = sum + 2*delta; % Double the step size after first two increases
        elseif cnt1 == 3
            sum = sum + 4*delta; % Double step size
        else
            sum = sum + 8*delta; % Still double and then stop doubling thereon
        end
        cnt1 = cnt1 + 1;
    else
        if cnt2 < 2
            sum = sum - delta;
        elseif cnt2 == 2
            sum = sum - 2*delta;
        elseif cnt2 == 3
            sum = sum - 4*delta;
        else
            sum = sum - 8*delta;
        end
        cnt2 = cnt2 + 1;
    end
    xn(i) = sum;
end

% Plotting
plot(t, x, 'r');
hold on;
plot(t, xn);
legend('Analog signal', 'Adaptive Delta Modulated signal');
title('Adaptive Delta Modulation');
xlabel('Time');
ylabel('Amplitude');


a = 2;
t = 0:2*pi/50:2*pi;
x = a * sin(t);

plot(t, x, 'r');
hold on;

delta = 1;
xn = zeros(size(x));


for i = 1:length(x)
    if x(i) > xn(i)
        d(i) = 1;
        xn(i+1) = xn(i) + delta;
    else
        d(i) = 0;
        xn(i+1) = xn(i) - delta;
    end
end

for i = 1:Lxsig
    if (xsig(i) > sum)
        if (cnt1 < 2)
            sum = sum + delta;
        elseif (cnt1 == 2)
            sum = sum + 2 * delta;
        elseif (cnt1 == 3)
            sum = sum + 4 * delta;
        else
            sum = sum + 8 * delta;
        end
        if (sum < xsig(i))
            cnt1 = cnt1 + 1;
        else
            cnt1 = 0;
        end
    elseif (cnt2 < 2)
        sum = sum - delta;
    elseif (cnt2 == 2)
        sum = sum - 2 * delta;
    elseif (cnt2 == 3)
        sum = sum - 4 * delta;
    else
        sum = sum - 8 * delta;
    end
    if (sum > xsig(i))
        cnt2 = cnt2 + 1;
    else
        cnt2 = 0;
    end
    ADMout(i) = sum;
end

t_downsampled = 0:ts:5;

stairs(t, xn(1:end-1)); % Adjusted to ensure correct length
legend('Analog signal', 'DM with step size=0.2');
title('Delta Modulation');
xlabel('Time');
ylabel('Amplitude');

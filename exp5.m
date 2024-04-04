t= 0:0.01:10;
a=sin(t);

[sqnr8,aquan8] =  u_pcm(a,8);
[sqnr16,aquan16]= u_pcm(a,16);

disp('sqnr8')
disp('sqnr16')

plot(t,a,'-',t,aquan16,'-',t,0);
legend('Original Signal','8 level quantized signal','16 level quantized signal');



function [sqnr, a_quan] = u_pcm(a, n)
    amax = max(abs(a));
    a_quan = a / amax;
    d = 2 / n;
    q = d * (0:n-1) - ((n - 1) / 2) * d;
    
    for i = 1:n
        indices = (q(i) - d / 2 <= a_quan) & (a_quan <= q(i) + d / 2);
        a_quan(indices) = q(i);
    end
    
    a_quan = a_quan * amax;
    
    sqnr = 20 * log10(norm(a) / norm(a - a_quan));
end

t = 0:0.01:10;
a = sin(t);
n = 16;   % Number of quantization levels
mu = 255; % μ parameter
amax = max(abs(a));
a_comp = (log(1 + mu * abs(a / amax)) / log(1 + mu)) .* sign(a);

a_quan = zeros(size(a_comp));
for i = 1:n
    indices = (q(i) - d / 2 <= a_comp) & (a_comp <= q(i) + d / 2);
    a_quan(indices) = q(i);
end

a_reconstructed = (((1 + mu) .^ (abs(a_quan)) - 1) / mu) .* sign(a_quan) * amax;

sqnr = 20 * log10(norm(a) / norm(a - a_reconstructed));


plot(t, a, '-', t, a_reconstructed, '-');

disp(['SQNR: ', num2str(sqnr), ' dB']);




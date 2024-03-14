fs = 1000;
T= 1/fs;
t=0:T:1;

L = length(t);

f_low = 50;
f_center = 200;
f_width = 50;

x_lowpass = randn(1,L);
[b,a] = butter(6,f_low/(fs/2));
x_lowpass = filter(b,a,x_lowpass);

x_bandpass = randn(1,L);
f_low = f_center - f_width/2;
f_high = f_center + f_width/2;
[b,a] = butter(6,[f_low/(fs/2),f_high/(fs/2)],'bandpass');
x_bandpass = filter(b,a,x_bandpass);

figure;
subplot(2,1,1);

plot(t,x_lowpass);
xlabel('T');
ylabel('Amplitude');


subplot(2,1,2);
plot(t, x_bandpass);
title('Bandpass Random Process');
xlabel('Time (s)');
ylabel('Amplitude');
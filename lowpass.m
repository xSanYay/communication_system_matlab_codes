t= 0: 0.0001:0.01;

sig = cos(2*pi*400*t)+cos(2*pi*700*t);

subplot(4,1,1);
plot(t,sig)
%x=time y=amplitude title analog signal

fs = 1400;
tsamp=0:1/fs;
sampled= cos(2*pi*400*tsamp)+ cos(2*pi*700*tsamp);

subplot(4,1,2);
plot(tsamp,sampled,'b*-');
%time amplitude critical sampled signal

%3 times for different values of tsamp >1400 <1400 =1400

% Sampling theorem in frequency domain
tfinal = 0.01;
t = 0 : 0.00001 : tfinal;
xanalog = cos(2*pi*400*t) + cos(2*pi*700*t);
%plotting the analog signal
figure;
subplot(4, 1, 1); plot(t, xanalog); xlabel("time"); ylabel("amplitude"); title("Analog signal");
% Critical sampling (fs = 2*fm)
fs = 1400;
tsamp = 0 : 1/fs : 13/fs;
xsampled = cos(2*pi*400*tsamp) + cos(2*pi*700*tsamp); xsampled_DFT = abs(fft(xsampled));
xsampled_length = 0 : (length(xsampled_DFT) - 1);
subplot(4, 1, 2);
stem(100 * xsampled_length, xsampled_DFT); xlabel("frequency");
ylabel("magnitude"); title("Critical sampling");
xreconstructed = ifft(fft(xsampled)); subplot(4, 1, 3);
plot(tsamp, xreconstructed, "b*-"); xlabel("time");
ylabel("amplitude");
title("Critical sampling");
% Under sampling (fs < 2*fm)
fs = 700;
tsamp = 0 : 1/fs : 6/fs;
xsampled = cos(2*pi*400*tsamp) + cos(2*pi*700*tsamp); xsampled_DFT = abs(fft(xsampled));
xsampled_length = 0 : (length(xsampled_DFT) - 1);
subplot(4, 1, 4);
stem(100 * xsampled_length, xsampled_DFT); xlabel("frequency");
ylabel("magnitude"); title("Under sampling");
xreconstructed = ifft(fft(xsampled));
figure;
subplot(4, 1, 1); plot(t, xanalog); xlabel("time"); ylabel("amplitude");
title("analog signal (400Hz + 700 Hz)");
subplot(4, 1, 2);
plot(tsamp, xreconstructed, "b*-"); xlabel("time");
ylabel("amplitude");
title("Under sampling (fs < 2*fm)");
% Over sampling (fs > 2*fm)
fs = 2000;
tsamp = 0 : 1/fs : 19/fs;
xsampled = cos(2*pi*400*tsamp) + cos(2*pi*700*tsamp); xsampled_DFT = abs(fft(xsampled));
xsampled_length = 0 : (length(xsampled_DFT) - 1);
subplot(4, 1, 3);
stem(100 * xsampled_length, xsampled_DFT); xlabel("frequency");
ylabel("magnitude"); title("Over sampling");
xreconstructed = ifft(fft(xsampled)); subplot(4, 1, 4);
plot(tsamp, xreconstructed, "b*-"); xlabel("Time");
ylabel("Amplitude");
title("Oversampling (fs > 2fm)");
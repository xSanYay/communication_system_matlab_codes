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
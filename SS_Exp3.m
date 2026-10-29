clc;
close all;
clear all;

% Sine and Cosine Signal
t=0:0.0001:1;
f=5;
x1=cos(2*pi*f*t);
x2=sin(2*pi*f*t);
figure,
plot(t,x1,'r',t,x2,'b');
xlabel("Time");
ylabel("Amplitude");
title("Sine and Cosine Signal");
legend("Cosine","Sine");

% Sinc Signal
t1=-5:0.005:5;
x3=sin(pi*t1) ./ (pi*t1);
x3(t1==0)=1;
figure,
plot(t1,x3,'LineWidth',1.5);
xlabel("Time");
ylabel("Amplitude");
title("Sinc Signal");

% Triangular Waveform Signal
t2=-2*pi:0.01:2*pi;
x4=(2/pi)*asin(sin(t2));
figure,
plot(t2,x4,'LineWidth',1.5);
xlabel("Time");
ylabel("Amplitude");
title("Triangular Waveform Signal");

% Sawtooth Waveform Signal
x5=2*((t2/(2*pi))-floor(0.5+(t2/(2*pi))));
figure,
plot(t2,x5,'LineWidth',1.5);
xlabel("Time");
ylabel("Amplitude");
title("Sawtooth Waveform Signal");

% Rectangular Pulse Signal
t3=-1:0.001:1;
x6=double(abs(t3)<=0.5);
figure,
plot(t3,x6,'LineWidth',1.5);
xlabel("Time");
ylabel("Amplitude");
title("Rectangular Pulse Signal");

% Exponential Signal
t=0:0.0001:1;
x7=exp(-0.5*t);
figure,
plot(t,x7,'LineWidth',1.5);
xlabel("Time");
ylabel("Amplitude");
title("Exponential Signal");
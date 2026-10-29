clc;
close all;
clear all;

T=2*pi;
N=20;
w0=2*pi/T;
n=1:N;

odd_n=n(mod(n,2)==1);
w_odd=odd_n*w0;

A_sq=4./(odd_n*pi);

A_st=2./(n*pi);
w_st=n*w0;

A_tr=8./(odd_n.^2*pi^2);

figure,

subplot(3,1,1);
stem(w_odd,A_sq,"filled","LineWidth",1.5);
xlabel("Angular Frequency");
ylabel("Amplitude");
title("Fourier Spectrum of a Square Wave");

subplot(3,1,2);
stem(w_st,A_st,"filled","LineWidth",1.5);
xlabel("Angular Frequency");
ylabel("Amplitude");
title("Fourier Spectrum of a Sawtooth Wave");

subplot(3,1,3);
stem(w_odd,A_tr,"filled","LineWidth",1.5);
xlabel("Angular Frequency");
ylabel("Amplitude");
title("Fourier Spectrum of a Triangular Wave");
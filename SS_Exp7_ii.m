clc;
close all;
clear all;

T=2*pi;
t=linspace(0,4*pi,1000);
N=100;
w=2*pi/T;

st_wave=zeros(size(t));

for n=1:N
        st_wave=st_wave + (2/(n*pi))*((-1)^(n+1))*sin(n*w*t);
        plot(t,st_wave,"LineWidth",1.5);
        xlabel("Time");
        ylabel("Amplitude");
        hold on;
end

figure(2),
plot(t,st_wave,"LineWidth",1.5);
xlabel("Time");
ylabel("Amplitude");
title("Fourier Series of a Sawtooth Wave");
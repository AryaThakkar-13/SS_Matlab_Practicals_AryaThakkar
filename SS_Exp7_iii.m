clc;
close all;
clear all;

T=2*pi;
t=linspace(0,4*pi,1000);
N=100;
w=2*pi/T;

tr_wave=zeros(size(t));

for n=1:N
    if mod(n,2)==1
        tr_wave=tr_wave + (8/(n*pi))*((-1)^((n-1)/2)/(n^2))*sin(n*w*t);
        plot(t,tr_wave,"LineWidth",1.5);
        xlabel("Time");
        ylabel("Amplitude");
        hold on;
    end
end

figure(2),
plot(t,tr_wave,"LineWidth",1.5);
xlabel("Time");
ylabel("Amplitude");
title("Fourier Series of a Triangular Wave");
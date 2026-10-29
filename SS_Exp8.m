clc;
close all;
clear all;

t=0:0.01:5;
w=-4*pi:0.01:4*pi;

% Exponential Signal
x_t1=exp(-3*t);

figure(1),
plot(t,x_t1,"LineWidth",1.5);
xlabel("t");
ylabel("x(t)");
title("Exponential Signal x(t)");

X_w1=zeros(size(w));
for k=1:length(w)
    X_w1(k)=trapz(t,x_t1.*exp(-j*w(k)*t));
end

figure(2),
subplot(2,1,1);
plot(w,abs(X_w1),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("|X(w)|");
title("Magnitude of Exponential Signal : |X(w)|");
subplot(2,1,2);
plot(w,angle(X_w1),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("Phase(rad)");
title("Phase Angle of Exponential Signal X(w)");

% Sine Signal
x_t2=sin(2*pi*t);

figure(3),
plot(t,x_t2,"LineWidth",1.5);
xlabel("t");
ylabel("x(t)");
title("Sine Signal x(t)");

X_w2=zeros(size(w));
for k=1:length(w)
    X_w2(k)=trapz(t,x_t2.*exp(-j*w(k)*t));
end

figure(4),
subplot(2,1,1);
plot(w,abs(X_w2),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("|X(w)|");
title("Magnitude of Sine Signal : |X(w)|");
subplot(2,1,2);
plot(w,angle(X_w2),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("Phase(rad)");
title("Phase Angle of Sine Signal X(w)");

% Rectangular Pulse Signal
x_t3=double(t>=1 & t<=3);

figure(5),
plot(t,x_t3,"LineWidth",1.5);
xlabel("t");
ylabel("x(t)");
title("Rectangular Pulse Signal x(t)");

X_w3=zeros(size(w));
for k=1:length(w)
    X_w3(k)=trapz(t,x_t3.*exp(-j*w(k)*t));
end

figure(6),
subplot(2,1,1);
plot(w,abs(X_w3),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("|X(w)|");
title("Magnitude of Rectangular Pulse Signal : |X(w)|");
subplot(2,1,2);
plot(w,angle(X_w3),"LineWidth",1.5);
xlabel("w(rad/s)");
ylabel("Phase(rad)");
title("Phase Angle of Rectangular Pulse Signal X(w)");
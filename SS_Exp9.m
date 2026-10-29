clc;
close all;
clear all;

n = 0:30;                    
w = linspace(-pi, pi, 1000); 

% Signals
a = 0.8;
x_n1 = (a).^n;

w0 = pi/4;
x_n2 = sin(w0*n);

% Z-Transform Evaluation 
X_z1 = zeros(size(w));
X_z2 = zeros(size(w));

for k = 1:length(w)
    z = exp(j*w(k));
    sum1 = 0;
    sum2 = 0;
    for i = 1:length(n)
        sum1 = sum1 + x_n1(i) * (z^(-n(i)));
        sum2 = sum2 + x_n2(i) * (z^(-n(i)));
    end
    X_z1(k) = sum1;
    X_z2(k) = sum2;
end

figure(1);

subplot(2,2,1);
stem(n, x_n1, "filled", "LineWidth", 1.5);
xlabel("n");
ylabel("x(n)");
title("x(n) = (0.8)^n u(n)");

subplot(2,2,2);
plot(w/pi, abs(X_z1), "LineWidth", 2);
xlabel("Normalized Frequency (\omega/\pi)");
ylabel("|X(z)|");
title("Magnitude Spectrum");

subplot(2,2,3);
stem(n, x_n2, "filled", "LineWidth", 1.5);
xlabel("n");
ylabel("x(n)");
title("x(n) = sin(\omega_0 n) u(n)");

subplot(2,2,4);
plot(w/pi, abs(X_z2), "LineWidth", 2);
xlabel("Normalized Frequency (\omega/\pi)");
ylabel("|X(z)|");
title("Magnitude Spectrum");

figure(2);

subplot(1,2,1);
zplane([1], [1, -0.8]);
title("Pole-Zero Map & ROC for (0.8)^n u(n)");

num = [sin(w0), 0];
den = [1, -2*cos(w0), 1];
subplot(1,2,2);
zplane(num, den);
title("Pole-Zero Map & ROC for sin(\omega_0 n) u(n)");
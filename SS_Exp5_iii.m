clc;
close all;
clear all;

% 3rd Signal
s1=[1,2,3,4,3,2,1,-1,-2,-3,-4,-3,-2,-1];
s2=s1;
y3=Conv_User(s1,s2);

figure,
subplot(3,1,1);
stem(s1);
xlabel("Sample");
ylabel("Amplitude");
title("Signal 1 : x(n)");
subplot(3,1,2);
stem(s2);
xlabel("Sample");
ylabel("Amplitude");
title("Signal 2 : h(n)");
subplot(3,1,3);
stem(y3);
xlabel("Sample");
ylabel("Amplitude");
title("Convolution by User-defined Function : x(n)*h(n)");

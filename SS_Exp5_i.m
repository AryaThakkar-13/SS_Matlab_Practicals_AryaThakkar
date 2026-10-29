clc;
close all;
clear all;

% 1st Signal
s1=[0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];
s2=s1;
y1=Conv_User(s1,s2);

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
stem(y1);
xlabel("Sample");
ylabel("Amplitude");
title("Convolution by User-defined Function : x(n)*h(n)");

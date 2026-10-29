clc;
close all;
clear all;
n=-10:1:10;  %Staring,Increment,Ending values of Samples

%For 1st Signal
x1=1*(n==0);
subplot(2,3,1); 
stem(n,x1);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Unit Impulse Signal");

%For 2nd Signal
x2=1*(n>=0);
subplot(2,3,2);
stem(n,x2);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Unit Step Signal");

%For 3rd Signal
x3=n.*(n>=0);
subplot(2,3,3);
stem(n,x3);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Unit Ramp Signal");

%For 4th Signal
x4=(n.^2/2).*(n>=0);
subplot(2,3,4);
stem(n,x4);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Unit Parabolic Signal");

%For 5th Signal
x5=2*exp(n).*(n>=0);
subplot(2,3,5);
stem(n,x5);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Exponential Signal");

%For 6th Signal
x6=1*(n>=5);
subplot(2,3,6);
stem(n,x6);  %For Discrete Time Signal
xlabel("Samples");
ylabel("Amplitude");
title("Delayed Unit Step Signal");
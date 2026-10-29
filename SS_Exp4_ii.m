clc;
close all;
clear all;
% Check whether the system is Time Invariant or Time Variant

x=[1,1,1,1]; 
x1=[x zeros(1,10)];  %x1=[1,1,1,1,0,0,.......0]
k=input('Enter the shift value:');

x11=[zeros(1,k) x1];
y11=exp(x11);  %y(n,k)
y12=exp(x1);
y12_new=[zeros(1,k) y12];  %y(n-k)

subplot(2,2,1);
stem(x1);
subplot(2,2,2);
stem(x11);
subplot(2,2,3);
stem(y11);
subplot(2,2,4);
stem(y12_new);

if (abs(y11-y12_new)<=0.0001)
    then
    disp('The System is Time Invariant');
else
    disp('The System is Time Variant');
end;
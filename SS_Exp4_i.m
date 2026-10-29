clc;
close all;
clear all;
% Check whether the system is Linear or Non-Linear

x1=[1,0,-1,2]; 
x2=[-2,3,2,-3];
a=input('Enter the value of a:');
b=input('Enter the value of b:');

y1=exp(a*x1);
y2=exp(b*x2);
y11=y1+y2;  %y=f(a*x1)+f(b*x2)
y12=exp(a*x1+b*x2);  %y=f(a*x1+b*x2)

subplot(2,2,1);
stem(x1);
subplot(2,2,2);
stem(x2);
subplot(2,2,3);
stem(y11);
subplot(2,2,4);
stem(y12);

if (abs(y11-y12)<=0.0001)
    then
    disp('The System is Linear');
else
    disp('The System is Non-Linear');
end;
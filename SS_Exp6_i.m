clc;
close all;
clear all;

x=input("Enter the sequence of x:");
h=input("Enter the sequence of h:");
n1=input("Enter the index of x:");
n2=input("Enter the index of h:");

N1=length(n1);
N2=length(n2);

X=[x,zeros(1,N2-1)];
H=[h,zeros(1,N1-1)];

L=N1+N2-1;
disp("The Length of the Convolution is:");
disp(L);

y=zeros(1,L);

for i=1:L
    for j=1:N1
        if (i-j+1>0) && (i-j+1<=N2)
            y(i)=y(i)+X(j)*H(i-j+1);
        end
    end
end

disp("The Convolution of y:");
disp(y);
stem(y,"filled");
xlabel("n");
ylabel("y(n)");
title("The Convolution of y=x(n)*h(n)");
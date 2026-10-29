clc;
close all;
clear all;

x=[1 1 -1];
h=[1 0 1 0];
n1=[-1 0 1];
n2=[0 1 2 3];

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
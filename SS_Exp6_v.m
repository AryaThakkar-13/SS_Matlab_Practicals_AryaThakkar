clc;
close all;
clear all;

x=[1 1 -1 0];
h=[1 0 1 0];
n1=[-1 0 1 2];
n2=[0 1 2 3];

N1=length(n1);
N2=length(n2);

h_rev=zeros(1,N2);
n2_rev=zeros(1,N2);

for k=1:N2
    h_rev(k)=h(N2-k+1);
    n2_rev(k)=-n2(N2-k+1);
end

N2_rev=length(n2_rev);

X=[x,zeros(1,N2_rev-1)];
H=[h_rev,zeros(1,N1-1)];

L=N1+N2_rev-1;
disp("The Length of the Convolution is:");
disp(L);

y=zeros(1,L);

for i=1:L
    for j=1:N1
        if (i-j+1>0) && (i-j+1<=N2_rev)
            y(i)=y(i)+X(j)*H(i-j+1);
        end
    end
end

ny=(n1(1)+n2_rev(1)):(n1(end)+n2_rev(end));

disp("The Convolution of y:");
disp(y);
stem(ny,y,"filled");
xlabel("n");
ylabel("y(n)");
title("The Convolution of y=x(n)*h(-n)");
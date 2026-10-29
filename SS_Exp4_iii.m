clc;
close all;
clear all;

% Compute the Energy of a given signal
x=[1,-1,2,-2,3]; 
E=sum(x.^2);  % E=x2
disp('Energy of a given signal is');
disp(E);
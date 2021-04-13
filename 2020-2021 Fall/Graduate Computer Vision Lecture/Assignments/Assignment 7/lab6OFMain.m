clear; close all; clc;

% Load the mat files given in SUcourse as Seq variable 
load("traffic.mat");
load("rubic.mat");
load("taxi.mat");
load("cars1.mat");
load("cars2.mat");
load("sphere.mat");

Seq = sphere;
[row,col,num]=size(Seq);
% Define k(window size parameter) and Threshold for eigenvalues
k=20;
%Threshold = 2*10^6;
Threshold = 1*10^5;

for j=2:1:num
    ImPrev = Seq(:,:,j-1);
    ImCurr = Seq(:,:,j);
    lab6OF(ImPrev,ImCurr,k,Threshold);
    % For taking three image frames in sequence
    if j == 2 || j == floor(num/2) || j == num
        continue
    end
    %pause(0.1);
end

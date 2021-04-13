%% Part 1: Linar Filtering: Gaussian Filtering
clc;clear;close;
% Let's get jump image
img = imread("jump.png");
% In order to remove orange warning, replace function output with ~ since 
% we'll not use it.
[~] = lab2gaussfilt(img);

%% Part 2: Non-Linear Filtering: Median Filtering
clc;clear;close;
% Let's get tiger image
img = imread("noisyimg.png");
% Filter size parameter
k=5;
[resImg] = lab2medfilt(img, k);
%% Part 3: Sharpening
clc;clear;close;
% Let's get mother image
img = imread("mother.png");
% Scaling factor that controls the influence of the correction signal
limbda = 10;
% For selecting the method of smoothing. 1 for the 3 by 3 local filtering, 
% 2 for the gaussian (given in the first part) filtering, 
% 3 for the 7 by 7 median filtering
Mode = 2;
[Simg] = lab2sharpen(img, limbda, Mode);

%% Part 4: First Derivative, Sobel Filtering 
clc;clear;close;
% Let's get house image
img = imread("house.png");
[x_filtered, y_filtered] = lab2sobelfilt(img);
%% Lab 3 Edge Detection
%% Part 1: Sobel
clc;clear;close;
% Let's get peppers image
img = imread("peppers.png");
% In order to remove orange warning, replace function output with ~ since 
% we'll not use it.
% Threshold for strong edge pixels
Thresh1 = 100;
[~] = lab3sobel(img, Thresh1);

%% Part 2: Prewitt
clc;clear;close;
% Let's get peppers image
img = imread("peppers.png");
% In order to remove orange warning, replace function output with ~ since 
% we'll not use it.
Thresh1 = 100;
[~] = lab3prewitt(img, Thresh1);
%% Part 3: Laplacian of Gaussian (LoG)
clc;clear;close;
% Let's get object contour image
img = imread("Object_contours.jpg");
% In order to remove orange warning, replace function output with ~ since 
% we'll not use it.
Thresh1 = 1; % Threshold for determining zero crossings
Thresh2 = 7; % Threshold for the slope to get strong edge pixels
[~] = lab3log(img, Thresh1, Thresh2);
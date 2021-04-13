%% Assignment 2
%% Ball Image
clc;clear;close;
% Let's get Monastry image
img = imread("ball.jpg");
imshow(rgb2gray(img))
% Set T1 and T2 to 0 in order to not have any threshold for edgels
T1 = 0;
T2 = 0;
edgeDetectComp(img, T1, T2);
% Optimized thresholds for edgels in Canny and LoG respectively
% T1 = 0.5;
% T2 = 0.004;
% edgeDetectComp(img, T1, T2);
%% Rubics Cube Image
% Let's get Rubics Cube image
img = imread("rubicsCube.png");
imshow(rgb2gray(img))
% Set T1 and T2 to 0 in order to not have any threshold for edgels
T1 = 0;
T2 = 0;
edgeDetectComp(img, T1, T2);
% Optimized thresholds for edgels in Canny and LoG respectively
% T1 = 0.5;
% T2 = 0.004;
% edgeDetectComp(img, T1, T2);
%% Valve Image
% Let's get Valve image
img = imread("Valve_original.PNG");
imshow(rgb2gray(img))
% Set T1 and T2 to 0 in order to not have any threshold for edgels
T1 = 0;
T2 = 0;
edgeDetectComp(img, T1, T2);
% Optimized thresholds for edgels in Canny and LoG respectively
% T1 = 0.5;
% T2 = 0.004;
% edgeDetectComp(img, T1, T2);
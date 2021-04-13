%% Lab 4 Corner & Line & Circle Detection
%% Part 1: Corner Detection
clc;clear;close;
tic
% Let's create checker board image
img0 = checkerboard(20);
% checkerboard image is binary, it must be linearly scaled to [0, 255]
[img0] = lab1linscale(img0);
% Let's get Monastry and blocks image
img1 = imread("Monastry.bmp");
img2 = imread("blocks.png");
T0 = 100000;
[corners_filtered0] = lab4ktcorners(img0, T0);
T1 = 200000;
[corners_filtered1] = lab4ktcorners(img1, T1);
T2 = 25000;
[corners_filtered2] = lab4ktcorners(img2, T2);
toc

% Plot corners with the original input images
figure()
subplot(1,3,1)
imshow(img0);
hold on;
plot(corners_filtered0(:,2), corners_filtered0(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")

subplot(1,3,2)
imshow(img1);
hold on;
plot(corners_filtered1(:,2), corners_filtered1(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")

subplot(1,3,3)
imshow(rgb2gray(img2));
hold on;
plot(corners_filtered2(:,2), corners_filtered2(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")
%% Part 2: Lines Detection
clc;clear;close;
tic
% Let's get checker image
img = imread("checker.jpg");
[H, theta, rho] = lab4houghlines(img);
toc
%% Part 3: Circle Detection
clc;clear;close;
tic
% Let's get circlesBrightDark image
img = imread("circlesBrightDark.png");
[centersBright, radiiBright,centersDark, radiiDark] = lab4houghcircles(img);
toc
%% Lab 4 Corner & Line & Circle Detection
%% Part 1: Corner Detection
clc;clear;close;
tic
img0 = imread("wardrobe.jpg");
img0 = imrotate(img0,60);
img1 = imread("house.jpg");
img1 = imrotate(img1,60);
img2 = imread("shapes.gif");
img2 = imresize(img2,2);
T0 = 100000;
%TO = 2*T0;
%TO = T0/2;
[corners_filtered0] = lab4ktcorners(img0, T0);
T1 = 150000;
%T1=2*T1;
%T1=T1/2;
[corners_filtered1] = lab4ktcorners(img1, T1);
T2 = 50000;
%T2 = 2*T2;
%T2 = T2/2;
[corners_filtered2] = lab4ktcorners(img2, T2);
toc

% Plot corners with the original input images
figure()
subplot(1,3,1)
imshow(rgb2gray(img0));
hold on;
plot(corners_filtered0(:,2), corners_filtered0(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")

subplot(1,3,2)
imshow(rgb2gray(img1));
hold on;
plot(corners_filtered1(:,2), corners_filtered1(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")

subplot(1,3,3)
imshow(img2);
hold on;
plot(corners_filtered2(:,2), corners_filtered2(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
title("Kanade-Tomasi Corner Detection")
%% Part 2: Lines Detection
clc;clear;close;
tic
% Let's get checker image
img = imread("road.jpg");
[H, theta, rho] = lab4houghlines(img);
img1 = imread("soccerField.jpeg");
[H, theta, rho] = lab4houghlines(img1);
toc
%% Part 3: Circle Detection
clc;clear;close;
tic
% Let's get circlesBrightDark image
img = imread("circles.jpg");
[centersBright, radiiBright,centersDark, radiiDark] = lab4houghcircles(img);
toc
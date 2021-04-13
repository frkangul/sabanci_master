%% Examples for Lab 3 Edge Detection
%% Part 1: Sobel vs Prewitt
clc;clear;close;
% Let's get ball and rubicks cube image
img = imread("ball.jpg");
img = imgaussfilt(img, 1.5); % smooth for noise before 
%applying derivative since it is sensitive to noise
%img = imread("rubicsCube.png");
% Threshold for strong edge pixels
Thresh1 = 100;
% Do not plot figures in those two functions
set(0,'DefaultFigureVisible','off')
[thSobelGrad] = lab3sobel(img, Thresh1);
[thPrwGrad] = lab3prewitt(img, Thresh1);

Thresh1 = 200;
% Do not plot figures in those two functions
[thSobelGrad2] = lab3sobel(img, Thresh1);
[thPrwGrad2] = lab3prewitt(img, Thresh1);
set(0,'DefaultFigureVisible','on')

figure
subplot(2,3,2)
imshow(thSobelGrad)
title("Sobel Edges")
subplot(2,3,[1,4])
imshow(rgb2gray(img))
title("Gaussian Smoothed Input Image with Standard Deviation of 1.5")
subplot(2,3,3)
imshow(thPrwGrad)
title("Prewitt Edges")

subplot(2,3,5)
imshow(thSobelGrad2)
title("Sobel Edges")
subplot(2,3,6)
imshow(thPrwGrad2)
title("Prewitt Edges")

sgt = sgtitle('Threshold: 100 for Sobel and Prewitt Edge Images in Upper and 200 for Sobel and Prewitt Edge Images in Lower');
%% Part 2: Laplacian of Gaussian (LoG) with Different Thresholds
clc;clear;close;
% Let's get object contour image
img = imread("papatya.jpg");
% Do not plot figures in those two functions
set(0,'DefaultFigureVisible','off')
Thresh1 = 20; % Threshold for determining zero crossings
Thresh2 = 10; % Threshold for the slope to get strong edge pixels
[logEdg1] = lab3log(img, Thresh1, Thresh2);
Thresh2 = 20;
[logEdg2] = lab3log(img, Thresh1, Thresh2);

Thresh1 = 100; % Threshold for determining zero crossings
Thresh2 = 10;
[logEdg3] = lab3log(img, Thresh1, Thresh2);
Thresh1 = 100;
Thresh2 = 20;
[logEdg4] = lab3log(img, Thresh1, Thresh2);
set(0,'DefaultFigureVisible','on')

figure

subplot(2,3,[1,4])
imshow(rgb2gray(img))
title("Original Input Image")

subplot(2,3,2)
imshow(logEdg1)
title("LoG Edge with Thresholds: 20 for zero-crossings & 10 for slope")

subplot(2,3,3)
imshow(logEdg2)
title("LoG Edge with Thresholds: 20 for zero-crossings & 20 for slope")

subplot(2,3,5)
imshow(logEdg3)
title("LoG Edge with Thresholds: 100 for zero-crossings & 10 for slope")

subplot(2,3,6)
imshow(logEdg4)
title("LoG Edge with Thresholds: 100 for zero-crossings & 20 for slope")

%% Part 2: Sobel, Prewitt, LoG Edges Comparison
clc;clear;close;
% Let's get vietnam car image and resize it since it takes too long to
% process
img = imread("vinfast.jpg");
img = imresize(img, 0.25);
% Do not plot figures in those two functions
set(0,'DefaultFigureVisible','off')
Thresh1 = 20; % Threshold for determining zero crossings
Thresh2 = 10; % Threshold for the slope to get strong edge pixels
[logEdg1] = lab3log(img, Thresh1, Thresh2);

Thresh1 = 100;
% Do not plot figures in those two functions
[thSobelGrad2] = lab3sobel(img, Thresh1);
[thPrwGrad2] = lab3prewitt(img, Thresh1);
set(0,'DefaultFigureVisible','on')

figure
subplot(2,2,1)
imshow(img)
title("Original Colored Input Image")

subplot(2,2,2)
imshow(thPrwGrad2)
title("Prewitt Edges with Threshold of 50")

subplot(2,2,3)
imshow(thSobelGrad2)
title("Sobel Edges with Threshold of 50")

subplot(2,2,4)
imshow(logEdg1)
title("LoG Edges with Thresholds 20 and 10 respectively")
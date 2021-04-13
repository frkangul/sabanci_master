%% For conditional scaling examples
clc;clear;close;

Im = imread("B9 Dorm Clear Shot.jpg");
Im = rgb2gray(Im);
Iref1 = imread("blocks.png");
Iref1 = rgb2gray(Iref1);
Iref2 = imread("board.jpg");
Iref2= rgb2gray(Iref2);

% Call the lab1condscale function
[Jnew1] = lab1condscale(Im,Iref1); 
[Jnew2] = lab1condscale(Im,Iref2);

figure()
subplot(3,2,[1 2]);
imshow(Im);
title("Original Image");
xlabel(["\mu = " + mean(double(Im(:)));"\sigma = " + std(double(Im(:)))]);

subplot(3,2,3);
imshow(Iref1);
title("First Reference Image");
xlabel(["\mu = " + mean(double(Iref1(:)));"\sigma = " + std(double(Iref1(:)))]);

subplot(3,2,4);
imshow(uint8(Jnew1));
title("First Processed Image");
xlabel(["\mu = " + mean(Jnew1(:));"\sigma = " + std(Jnew1(:))]);

subplot(3,2,5);
imshow(Iref2);
title("Second Reference Image");
xlabel(["\mu = " + mean(double(Iref2(:)));"\sigma = " + std(double(Iref2(:)))]);

subplot(3,2,6);
imshow(uint8(Jnew2));
title("Second Processed Image");
xlabel(["\mu = " + mean(Jnew2(:));"\sigma = " + std(Jnew2(:))]);

%% For box filtering examples
Im = imread("jump.png");
k = 1;
[Inew1] = lab1locbox(Im, k);
k = 3;
[Inew3] = lab1locbox(Im, k);
k = 5;
[Inew5] = lab1locbox(Im, k);
k = 10;
[Inew10] = lab1locbox(Im, k);
k = 25;
[Inew25] = lab1locbox(Im, k);

figure()
subplot(3,2,1);
imshow(Im);
title("Original Image");

subplot(3,2,2);
imshow(Inew1);
title("Box Filtered Image, k="+ 1);

subplot(3,2,3);
imshow(Inew3);
title("Box Filtered Image, k="+ 3);

subplot(3,2,4);
imshow(Inew5);
title("Box Filtered Image, k="+ 5);

subplot(3,2,5);
imshow(Inew10);
title("Box Filtered Image, k="+ 10);

subplot(3,2,6);
imshow(Inew25);
title("Box Filtered Image, k="+ 25);

%% For local min and max filtering examples

% Let's get the current image
Im = imread("B9 Dorm Hard Blur.jpg");
% It takes almost 5-6 minutes to just run this section since I have very
% high resolution input image. In order to save same time it can be resized
%Im = imresize(Im, 0.25);
Im = rgb2gray(Im);
% Number for window(filter) size
k = 3;
[Imax3, Imin3] = lab1locmaxmin(Im, k);
k = 10;
[Imax10, Imin10] = lab1locmaxmin(Im, k);
k = 30;
[Imax30, Imin30] = lab1locmaxmin(Im, k);

figure()

subplot(3,3,1);
imshow(Imin3);
title("Local Min Filtered Image, k=3");

subplot(3,3,2);
imshow(Im);
title("Original Image");

subplot(3,3,3);
imshow(Imax3);
title("Local Max Filtered Image, k=3");

subplot(3,3,4);
imshow(Imin10);
title("Local Min Filtered Image, k=10");

subplot(3,3,5);
imshow(Im);
title("Original Image");

subplot(3,3,6);
imshow(Imax10);
title("Local Max Filtered Image, k=10");

subplot(3,3,7);
imshow(Imin30);
title("Local Min Filtered Image, k=30");

subplot(3,3,8);
imshow(Im);
title("Original Image");

subplot(3,3,9);
imshow(Imax30);
title("Local Max Filtered Image, k=30");

%% For Linear Scaling Examples
% Let's get the city image
Im = imread("B9 Dorm Clear Shot.jpg");
% Modify the original image so that max pixel value is smaller relatively
Im = rgb2gray(Im);
Im_modif = double(Im)*0.2;
Im_modif = uint8(Im_modif);
% Call the lab1linscale function
[~] = lab1linscale(Im_modif);
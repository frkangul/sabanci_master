%% For Comparison between Gaussian Filtering and Median Filtering
clc;clear;close;
% Let's get noisyimg image
%img = imread("gaussianNoise.png");
img = imread("noisyimg.png");
set(0,'DefaultFigureVisible','off')
[resImg1] = lab2medfilt(img, 1);
[resImg2] = lab2medfilt(img, 2);
[resImg5] = lab2medfilt(img, 5);
gaussImg = lab2gaussfilt(img);
set(0,'DefaultFigureVisible','on')
figure
subplot(3,2,[1,2])
imshow(img)
%title("Input Image with Gaussian Noise", 'FontSize',18)
title("Input Image with Salt & Pepper Noise", 'FontSize',18)
subplot(3,2,3)
imshow(gaussImg)
title("Gaussian Smoothed Image", 'FontSize',18)
subplot(3,2,4)
imshow(resImg1)
title("Median Filtered Image, k=1", 'FontSize',18)
subplot(3,2,5)
imshow(resImg2)
title("Median Filtered Image, k=2", 'FontSize',18)
subplot(3,2,6)
imshow(resImg5)
title("Median Filtered Image, k=5", 'FontSize',18)
%% For Examining Sharpening Filter
clc;clear;close;
% Let's get mother image
img = imread("moon.jpg");
% Scaling factor that controls the influence of the correction signal
limbda = 1;
% For selecting the method of smoothing. 1 for the 3 by 3 local filtering, 
% 2 for the gaussian (given in the first part) filtering, 
% 3 for the 7 by 7 median filtering
Mode = 1;
set(0,'DefaultFigureVisible','off')
[sharp1_1] = lab2sharpen(img, limbda, Mode);
[sharp1_2] = lab2sharpen(img, limbda, 2);
[sharp1_3] = lab2sharpen(img, limbda, 3);
limbda = 5;
[sharp2_1] = lab2sharpen(img, limbda, Mode);
[sharp2_2] = lab2sharpen(img, limbda, 2);
[sharp2_3] = lab2sharpen(img, limbda, 3);
limbda = 10;
[sharp3_1] = lab2sharpen(img, limbda, Mode);
[sharp3_2] = lab2sharpen(img, limbda, 2);
[sharp3_3] = lab2sharpen(img, limbda, 3);
set(0,'DefaultFigureVisible','on')
% figure
% subplot(1,4,1)
% imshow(img)
% title("Original/Input Image")
% subplot(1,4,2)
% imshow(sharp1_1)
% title("Sharpened with Local Filtered Image")
% subplot(1,4,3)
% imshow(sharp1_2)
% title("Sharpened with Gaussian Filtered Image")
% subplot(1,4,4)
% imshow(sharp1_3)
% title("Sharpened with Median Filtered Image")
% figure
% subplot(1,4,1)
% imshow(img)
% title("Original/Input Image")
% subplot(1,4,2)
% imshow(sharp2_1)
% title("Sharpened with Local Filtered Image")
% subplot(1,4,3)
% imshow(sharp2_2)
% title("Sharpened with Gaussian Filtered Image")
% subplot(1,4,4)
% imshow(sharp2_3)
% title("Sharpened with Median Filtered Image")
figure
subplot(1,4,1)
imshow(img)
title("Original/Input Image")
subplot(1,4,2)
imshow(sharp3_1)
title("Sharpened with Local Filtered Image")
subplot(1,4,3)
imshow(sharp3_2)
title("Sharpened with Gaussian Filtered Image")
subplot(1,4,4)
imshow(sharp3_3)
title("Sharpened with Median Filtered Image")
%% Sobel Filtering Closer Looking
clc;clear;close;
% Let's get fruit_color image
img = imread("Valve_original.PNG");
set(0,'DefaultFigureVisible','off')
[x_filtered, y_filtered] = lab2sobelfilt(img);
set(0,'DefaultFigureVisible','on')

figure
subplot(2,2,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(2,2,2);
mag = sqrt(double(x_filtered).^2 + double(y_filtered).^2);
imshow(uint8(mag));
title("Gradient Magnitude", 'FontSize',18);

subplot(2,2,3);
imshow(y_filtered);
title("Sobel Derivative in y Direction Image, Horizontal Edge Pixels", 'FontSize',18);

subplot(2,2,4);
imshow(x_filtered);
title("Sobel Derivative in x Direction Image, Vertical Edge Pixels", 'FontSize',18);
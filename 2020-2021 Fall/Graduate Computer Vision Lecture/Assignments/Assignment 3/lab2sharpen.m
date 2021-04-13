function [Sharpened_img] = lab2sharpen(img, limbda, M)
% Chech the original image if it is RGB or monocolor
[~,~,ch] = size(img);
% If the image is RGB (colored), then convert it to grayscale image
if ch == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

% Let's get smoothed image according to the mode provided from their
% corresponding functions
if M == 1
    Smoothed = lab1locbox(img, 1);
elseif M == 2
    Smoothed = lab2gaussfilt(img);      
elseif M == 3
    Smoothed = lab2medfilt(img, 3);
end

img = double(img);
Smoothed = double(Smoothed); % In order to have proper matrix operations,
% convert datatype from uint8 to double

% Sharpening function
Sharpened_img = img + limbda*(img-Smoothed);

% Change the datatype of the original image and sharpened image from double 
% to uint8 so that it can be displayed without any problem.
img = uint8(img);
Sharpened_img = uint8(Sharpened_img);

% Plot the original, the original and sharpened images via subplot function
figure("NumberTitle", 'off', "Name", 'Sharpening')

subplot(1,2,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(1,2,2);
imshow(Sharpened_img);
title("Sharpened Image, scaling factor="+int2str(limbda), 'FontSize',18);
end


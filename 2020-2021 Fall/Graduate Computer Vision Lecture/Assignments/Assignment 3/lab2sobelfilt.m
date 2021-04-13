function [x_filtered, y_filtered] = lab2sobelfilt(img)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

img = double(img); % In order to have proper matrix operations, convert 
% datatype from uint8 to double

% Define sobel filters for x and y
x_Filter = [-1 0 1;-2 0 2; -1 0 1];
y_Filter = [-1 -2 -1; 0 0 0 ; 1 2 1];

k = 1; % Since we have 3 by 3 sobel filters

% Initialize X and Y sobel derivatives as 0s with the same dimension of 
% the original matrix
x_filtered =  zeros(size(img));
y_filtered =  zeros(size(img));

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.
for i = k+1:h-k
    for j = k+1:w-k
        Window = img(i-k:i+k, j-k:j+k);
        % Calculate the first x and y derivative pixel values of the substracted
        % part of image by multiplying each filter element-wise with window
        Xvalue = sum(sum(Window.*x_Filter));
        Yvalue = sum(sum(Window.*y_Filter));
        x_filtered(i,j) = Xvalue;   
        y_filtered(i,j) = Yvalue;  
    end
end

% Change the datatype of the images from double to uint8 
% so that it can be displayed without any problem.
img = uint8(img);
x_filtered = uint8(x_filtered);
y_filtered = uint8(y_filtered);

% Plot the original, sovel derivative images via subplot function
figure()

subplot(2,2,[1,2]);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(2,2,3);
imshow(y_filtered);
title("Sobel Derivative in y Direction Image, Horizontal Edge Pixels", 'FontSize',18);

subplot(2,2,4);
imshow(x_filtered);
title("Sobel Derivative in x Direction Image, Vertical Edge Pixels", 'FontSize',18);
end


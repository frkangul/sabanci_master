function [threshMag] = lab3sobel(img, T)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

img = double(img); % In order to have proper matrix operations, convert 
% datatype from uint8 to double

% Define sobel filters for x and y directions
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

% Calculate gradient magnitude
mag = sqrt(x_filtered.^2 + y_filtered.^2);

% Threshold mag with T
threshMag = zeros(size(mag));
indices = mag>T;
threshMag(indices) = 255;

% Change the datatype of the images from double to uint8 
% so that it can be displayed without any problem.
img = uint8(img);
x_filtered = uint8(x_filtered);
y_filtered = uint8(y_filtered);
mag = uint8(mag);
threshMag = uint8(threshMag);

% Plot the original, sovel derivatives, magnitude, and edge images via 
% subplot function
figure()

subplot(2,3,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(2,3,2);
imshow(x_filtered);
title("Sobel X Filtered Image", 'FontSize',18);

subplot(2,3,3);
imshow(y_filtered);
title("Sobel Y Filtered Image", 'FontSize',18);

subplot(2,3,5);
imshow(mag);
title("Sobel Gradient", 'FontSize',18);

subplot(2,3,6);
imshow(threshMag);
title("Sobel Edges", 'FontSize',18);

end


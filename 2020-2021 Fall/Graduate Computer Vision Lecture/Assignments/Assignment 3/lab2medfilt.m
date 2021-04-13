function [Filtered_img] = lab2medfilt(img, k)
% Chech the original image if it is RGB or monocolor
[row,col,ch] = size(img);
% If the image is RGB (colored), then convert it to grayscale image
if ch == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

img = double(img); % In order to have proper matrix operations, convert datatype 
% from uint8 to double

% Call lab2gaussfilt function to get the gaussian filtered image
GaussianFiltered = lab2gaussfilt(img);


% Initialize matrices of the filtered image as 0s with the same dimension of 
% the original matrix                                 
Filtered_img = zeros(size(img)); 

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.

for i = k+1:row-k
    for j = k+1:col-k
        Window = img(i-k:i+k, j-k:j+k);
        % Calculate the median of pixel values of the substracted part of image
        % by calling earlier function myMedian
        value = myMedian(Window);
        Filtered_img(i,j) = value;       
    end
end


% Change the datatype of the original image and filtered image from double to 
% uint8 so that it can be displayed without any problem.
img = uint8(img);
Filtered_img = uint8(Filtered_img);

% Plot the original, gaussian filtered, and median filtered images via 
% subplot function
figure()

subplot(1,3,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(1,3,2);
imshow(GaussianFiltered);
title("Gaussian (given by first question) Filtered Image", 'FontSize',18);

subplot(1,3,3);
imshow(Filtered_img);
title("Median Filtered Image, k="+int2str(k), 'FontSize',18);
end


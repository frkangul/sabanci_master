function [Inew] = lab1locbox(Im, k)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(Im);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    Im = rgb2gray(Im);
end

I = double(Im); % In order to have proper matrix operations, convert datatype 
% from uint8 to double

% Initialize matrix of the box filtered image as 0s with the same dimension
% of the original matrix
Inew = zeros(h,w);

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.
for i = k+1:h-k
    for j = k+1:w-k
        wp = I(i-k:i+k, j-k:j+k);
        % Calculate the mean of pixel values of the substracted part of
        % image after making it column vector
        Inew(i,j)= mean(wp(:));    
    end
end

% Change the datatype of image matrix from double to uint8 so that it can be displayed 
% without any problem.
Inew = uint8(Inew);

% Plot the original, and box filtered images via subplot function
figure()

subplot(2,1,1);
imshow(Im);
title("Original Image",'FontSize',18);

subplot(2,1,2);
imshow(Inew);
title("Box Filtered Image, k="+int2str(k),'FontSize',18);
end


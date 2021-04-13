function [Imax, Imin] = lab1locmaxmin(Im, k)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(Im);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    Im = rgb2gray(Im);
end

I = double(Im); % In order to have proper matrix operations, convert datatype 
% from uint8 to double

% Initialize matrices of the local min & max filtered images as 0s with the same 
% dimension of the original matrix
Imax = zeros(h,w);
Imin = zeros(h,w);

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.
for i = k+1:h-k
    for j = k+1:w-k
        wp = I(i-k:i+k, j-k:j+k);
        % Calculate the max & min of pixel values of the substracted part
        % of image after making it column vector
        Imax(i,j)= max(wp(:));
        Imin(i,j)= min(wp(:));        
    end
end

% Change the datatype of the local min & max filtered images from double to uint8 
% so that it can be displayed without any problem.
Imax = uint8(Imax);
Imin = uint8(Imin);

% Plot the original, the local min & max filtered images via subplot function
figure()

subplot(1,3,1);
imshow(Im);
title("Original Image");

subplot(1,3,2);
imshow(Imax);
title("Local Max Filtered Image, k="+int2str(k));

subplot(1,3,3);
imshow(Imin);
title("Local Min Filtered Image, k="+int2str(k));
end


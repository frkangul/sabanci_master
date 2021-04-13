function [Inew] = lab1linscale(Im)
% Chech the image if it is RGB or monocolor
[~, ~, c] = size(Im);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    Im = rgb2gray(Im);
end

% To make math operations on the monocolor image, change type of image matrix to double
I = double(Im);

%%Let's linearly scale the original image using below gradation function (No need to 
% make this line Section, think of it as a heading)

% It will make I matrix to column vector and take min element
a = -min(I(:)); 

Gmax = 255;

b = Gmax/(max(I(:))- min(I(:)));

Inew = b*(I+a);

% Change the datatype of image matrix from double to uint8 so that it can be displayed
% without any problem.
Inew = uint8(Inew);

% Plot the original and scaled images with their corresponding histograms via subplot
% function
figure()

subplot(2,2,1);
imshow(Im);
title("Original Image");

subplot(2,2,2);
imshow(Inew);
title("Linearly Scaled Image");

subplot(2,2,3);
histogram(Im);
imhist(Im); % imhist is better than histogram function. It will give the same result
% in the pdf.
title("Histogram of the Original Image Umin = " + min(I(:)) + " and Umax = " + max(I(:)));

subplot(2,2,4);
imhist(Inew);
title("Histogram of the Original Image Umin = 0 and Umax = 255")

end


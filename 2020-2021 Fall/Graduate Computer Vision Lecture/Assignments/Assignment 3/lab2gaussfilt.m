function [Filtered_img] = lab2gaussfilt(img)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

img = double(img); % In order to have proper matrix operations, convert datatype 
% from uint8 to double

Gaussian_Matrix =  (1/273.)*[    1   4   7   4    1  ;
                                     4   16  26  16   4  ;
                                     7   26  41  26   7  ;
                                     4   16  26  16   4  ; 
                                     1   4   7   4    1  ];


% Initialize matrices of the filtered image as 0s with the same dimension 
% of the original matrix                                 
Filtered_img = zeros(size(img)); 
k = 2; % since we have 5*5 filter

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.

%Method1
for i = k+1:h-k
    for j = k+1:w-k
        Window = img(i-k:i+k, j-k:j+k);
        % Calculate the gaussian weighted image pixels by multiplying
        % element-wise and adding all elements together to get single value
        value = sum(sum(Window.*Gaussian_Matrix));
        Filtered_img(i,j) = value;       
    end
end

%Method2
% Filtered_img = conv2(img, Gaussian_Matrix, "same");


% Change the datatype of the original and gaussian filtered image matrix
% from double to uint8 so that it can be displayed without any problem.
img = uint8(img);
Filtered_img = uint8(Filtered_img);

% Plot the original, gaussian filtered images via subplot function
figure()

subplot(1,2,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(1,2,2);
imshow(Filtered_img);
title("Gaussian Filtered Image", 'FontSize',18);
end


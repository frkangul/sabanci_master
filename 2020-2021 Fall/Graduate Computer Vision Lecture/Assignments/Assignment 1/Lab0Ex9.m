clear all; close all; clc
Im = imread('darkImage.png');
[r,c, ch] = size(Im);

if ch ==3
    Im = rgb2gray(Im);
end

n = r*c;
% imshow(Im)

f = zeros(256,1);

for i=1:1:r
    for j=1:1:c
        value = Im(i,j);
        f(value+1) = f(value+1)+1;
    end
end

pdf = f./n; % Relative Histogram, prob density func
cdf = zeros(256,1); % cumulative density function
out = zeros(256,1);
% figure; plot(pdf);

sum = 0;
for i=1:1:256
    sum = sum + pdf(i);
    cdf(i) = sum;
    out(i) = round(cdf(i)*255); % we put it here just for conveniance, it is the "HISTOGRAM EQUALIZATION"
end

% figure; plot(cdf);

% in order to use out(i) which is just 1D array and return it to image form
histeqIm = uint8(zeros(r,c));
for i = 1:1:r
    for j = 1:1:c
        histeqIm(i,j) = out(Im(i,j)+1);
    end
end

figure;
subplot(1,2,1)
imshow(Im)
title('Original Image')
subplot(1,2,2)
imshow(histeqIm)
title('Histogram Equalized Image')

figure;
subplot(1,2,1)
imhist(Im)
subplot(1,2,2)
imhist(histeqIm)
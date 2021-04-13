%% Exp 6

clear; close; clc;

im = imread('blocks.png');

im_monoch = rgb2gray(im);
imshow(im_monoch);

im2 = zeros(size(im_monoch));
im2 = uint8(im2);
k = find((im_monoch>170) & (im_monoch<200));%it gives indices
im2(k) = 255;
imshow(im2);
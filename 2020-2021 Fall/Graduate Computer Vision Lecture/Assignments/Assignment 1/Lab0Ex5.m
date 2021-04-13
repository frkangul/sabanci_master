%% Exp 5

clear; close; clc;

im = imread('blocks.png');

im_monoch = rgb2gray(im);

% Method1
cropped1 = im_monoch(70:220, 140:240);% (rows, columns)
figure; imshow(im_monoch) % Tools>Data Tips to see where we should cut from

figure; imshow(cropped1);

%% Method 2 [x1, y1, width, height]
cropped2 = imcrop(im_monoch, [140 70 100 150]);
figure; imshow(cropped2);
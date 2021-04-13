%% Exp2

clear; close; clc;

im = imread('board.jpg');

im_monoch = rgb2gray(im);

ax1 = subplot(1,2,1);
ax1 = imshow(im);
title = "Original Image";
ax2 = subplot(1,2,2);

ax2 = imshow(im_monoch);
title = "Gray Scale Version";

imwrite(im_monoch, "monoChrome_board.jpg");
%% Exp2

clear; close; clc;

im = imread('board.jpg');

redChannel = im(:,:,1);
greenChannel = im(:,:,2);
blueChannel = im(:,:,3);

figure
subplot(2,2,1)
imshow(im);
title("Original RGB Image")

subplot(2,2,2)
imshow(redChannel);
title("Red Channel")

subplot(2,2,3)
imshow(greenChannel);
title("Green Channel")

subplot(2,2,4)
imshow(blueChannel);
title("Blue Channel")

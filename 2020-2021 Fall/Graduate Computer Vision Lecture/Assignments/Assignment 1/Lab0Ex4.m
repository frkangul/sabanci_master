%% Exp 4

clear; close; clc;

im = imread('blocks.png');

im_monoch = rgb2gray(im);

figure
imshow(im_monoch);% imshow works with unint not double variables

d1 = double(im_monoch); % if we need operations over images, then make it double
d2 = im2double(im_monoch); % it also scales pixel values between 0 and 1

disp("Image in unint8")
disp(im_monoch(190:200, 320:330))

disp("double with double()")
disp(im_monoch(190:200, 320:330))

disp("double with im2double()")
disp(im_monoch(190:200, 320:330))
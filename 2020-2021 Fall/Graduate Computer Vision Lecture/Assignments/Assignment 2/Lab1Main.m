% Below four sections can be runned seperately by using the "Run Section" comment
% under "Editor" Tab 
%% Linear Scaling
clc;clear;close;

% Let's get the city image
Im = imread("city.png");
% Call the lab1linscale function
[~] = lab1linscale(Im); 
% In order to remove orange warning, replace Inew with ~ since we'll not use Inew.

%% Conditional Scaling 
clc;clear;close;

% Let's get the city and board images
% Im = imread("city.png");

Im = imread("B9 Dorm Clear Shot.jpg");
Iref = imread("blocks.png");
% Iref = imread("board.jpg");

% Call the lab1condscale function
[Jnew] = lab1condscale(Im,Iref);

%% Box Filter
clc;clear;close;

% Let's get the jump image
Im = imread("jump.png");
% Number for window(filter) size
k = 1;
[Inew] = lab1locbox(Im, k);

%% Local Min Max Filter
clc;clear;close;

% Let's get the current image
Im = imread("currentImage.png");
% Number for window(filter) size
k = 3;
[Imax, Imin] = lab1locmaxmin(Im, k);

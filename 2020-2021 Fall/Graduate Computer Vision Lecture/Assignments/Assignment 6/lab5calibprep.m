%% Start
clear; close all; clc;

% Read input calibration image
img = imread('calibrationObject.png');

% Check if it is RGB or not. Then, if it is RGB, transform it to 
% monochrome image.
[row, col, ch]=size(img);
if ch==3
    img_gray = rgb2gray(img);
end

% Apply canny edge detector
img_edge = edge(img_gray,'canny');
imshow(img_edge);


%% HOUGH TRANSFORM - Extract Lines
% Hough Transform
[H, theta, rho]=hough(img_edge);
% Hough Peaks
Thresh = ceil(0.5*max(H(:)));
P = houghpeaks(H, 60, "threshold", Thresh);
% Hough Lines with given parameters in lab sheet
line = houghlines(img_edge, theta,rho,P,"FillGap", 10, "MinLength", 35);
%% PLOT HOUGHLINES  
figure 
subplot(1,2,1), imshow(img), title ("Calibration Object")
subplot(1,2,2), imshow(img_gray), title ("Result of Hough line detection")
hold on
for k = 1:length(line)
    xy = [line(k).point1; line(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','green');
    plot(xy(1,1),xy(1,2),'x','MarkerSize',4,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','MarkerSize',4,'Color','red');
    len = norm(line(k).point1 - line(k).point2);
end
hold off
%% SELECT TWO INTERSECTING LINES MANUALLY

Lines_B = [39 130;80 112]; % Beginning points
Lines_E = [170 180;106 246]; % End points 

% Extract corresponding theta (T) and rho (R) values from the output of 'houghlines' function

Thetas =[];
Rhos =[];
for p = 1:length(Lines_B)
    for k=1:length(line)
        if ismember(line(k).point1, Lines_B(p,:), "rows") && ismember(line(k).point2, Lines_E(p,:),"rows") % use 1 cond for beg ismember ismember(A, B, "rows") 2nd cond for end
            Thetas = [Thetas; line(k).theta];
            Rhos = [Rhos; line(k).rho];
        end
    end
end

%% PLOT INTERSECTING LINES

x_v = 0:size(img,1);
x_h = 0:size(img,2);

figure
imshow(img)
hold on 

for i=1:length(Thetas)
    xPoint = 0:col;
    yPoint=(Rhos(i) -xPoint*cosd(Thetas(i)))/sind(Thetas(i));
    plot(xPoint,yPoint, "color", "magenta")
    
end
%%  Solving the 2 line equations to find intersection point (corner)

b = Rhos;
A = [cosd(Thetas(1)), sind(Thetas(1));cosd(Thetas(2)), sind(Thetas(2))];
C = A\b;

%% HARRIS CORNERS
corners = corner(img_gray);

%% PLOTTING CORNERS FOR COMPARISON
figure
imshow(img)
hold on

% plot houghlines intersection point as magenta circle
plot(C(1), C(2),"mo" )
hold on 

for i=1:length(Thetas)
    xPoint = 0:col;
    yPoint=(Rhos(i) -xPoint*cosd(Thetas(i)))/sind(Thetas(i));
    plot(xPoint,yPoint, "color", "magenta")
    
end
% plot harris corners as red circles
plot(corners(:,1),corners(:,2),'bo');

%% Calculate and display the distance between two corner points that 
% you obtained with two different methods.

% Select closest two corner points to the intersection of two lines:
% Note that they are already from corners struct variable
firstCorn = [85, 146];
secondCorn = [88, 150];
interPoint = [C(1), C(2)];

d1 = norm(firstCorn - interPoint);
d2 = norm(secondCorn - interPoint);
hold on

% Since there is a variable called line, we need to remove it before
% calling line function.
clear line 
line([firstCorn(1) interPoint(1)],[firstCorn(2) interPoint(2)],'Color','red','LineStyle','--');
str1 = sprintf('Euclidean distance is %.2f',d1);
text((firstCorn(1)+interPoint(1))/2, (firstCorn(2)+interPoint(2))/2, str1, 'Color','red')
line([secondCorn(1) interPoint(1)],[secondCorn(2) interPoint(2)],'Color','green','LineStyle','--');
str2 = sprintf('Euclidean distance is %.2f',d2);
text((secondCorn(1)+interPoint(1))/2, (secondCorn(2)+interPoint(2))/2, str2, 'Color','green')

%% For better visualization
figure
subplot(1,3,1)
imshow("2.jpg"), title("Calibration object image with corners by using two different methods")
subplot(1,3,2)
imshow("3.jpg"), title("Zoomed area of the intersection point")
subplot(1,3,3)
imshow("5.jpg"), title("Zoomed area of the intersection point with distances")
 

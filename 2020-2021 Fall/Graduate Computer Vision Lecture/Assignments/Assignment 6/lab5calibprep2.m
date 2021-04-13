%% Start
clear; close all; clc;

% Read input calibration image
im = imread('myCalObj7.jpg');

% Preprocess the input calibration image
img_resized = imresize(im, 0.1);
img = imrotate(img_resized, 270);

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
line = houghlines(img_edge, theta,rho,P,"FillGap", 80, "MinLength", 30); 
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

Lines_B = [
    2 461;
    230 4;
    23 296;
    403 3;
    23 296;
    230 4;
    23 296;
    315 277;
    8 379;
    315 277;
    8 379;
    403 3;
    8 379;
    230 4;
    8 379;
    473 7;
    ]; % Beginning points
Lines_E = [
    426 461;
    230 920;
    426 296;
    403 890;
    426 296;
    230 920;
    426 296;
    315 907;
    483 379;
    315 907;
    483 379;
    403 890;
    483 379;
    230 920;
    483 379;
    489 889; 
    ]; % End points 

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
imshow(img_gray)
hold on 

for i=1:length(Thetas)
    xPoint = 0:col;
    yPoint=(Rhos(i) -xPoint*cosd(Thetas(i)))/(sind(Thetas(i)+0.00001));
    plot(xPoint,yPoint, "color", "magenta")
    
end
%%  Solving the 2 line equations 8 times to find intersection points (corners)
for i = 1:length(Lines_B)/2
    b = Rhos(2*i-1:2*i);
    A = [cosd(Thetas(2*i-1)), sind(Thetas(2*i-1));cosd(Thetas(2*i)), sind(Thetas(2*i))];
    C(2*i-1:2*i, 1) = A\b; 
end


%% HARRIS CORNERS
corners = corner(img_gray, 300);

%% PLOTTING CORNERS FOR COMPARISON
figure
imshow(img)
hold on

% plot houghlines intersection point as magenta circle
for i = 1:length(Lines_B)/2
    plot(C(2*i-1), C(2*i),"mo" )
    hold on 
end


for i=1:length(Thetas)
    xPoint = 0:col;
    yPoint=(Rhos(i) -xPoint*cosd(Thetas(i)))/sind(Thetas(i)+0.00001);
    plot(xPoint,yPoint, "color", "magenta")
    
end
% plot harris corners as red circles
plot(corners(:,1),corners(:,2),'bo');

%% Calculate and display the distance between two corner points that 
% you obtained with two different methods.

% Since there is a variable called line, we need to remove it before
% calling line function.
clear line 

% Select closest two corner points to the intersection of two lines:
% Note that they are already from corners struct variable
firstCorn = [231, 460];
interPoint1 = [C(1), C(2)];
d1 = norm(firstCorn - interPoint1);
hold on
line([firstCorn(1) interPoint1(1)],[firstCorn(2) interPoint1(2)],'Color','red','LineStyle','--');
str1 = sprintf('Euclidean distance is %.2f',d1);
text((firstCorn(1)+interPoint1(1))/2, (firstCorn(2)+interPoint1(2))/2, str1, 'Color','red')

secCorn = [403, 295];
interPoint2 = [C(3), C(4)];
d2 = norm(secCorn - interPoint2);
hold on
line([secCorn(1) interPoint2(1)],[secCorn(2) interPoint2(2)],'Color','red','LineStyle','--');
str2 = sprintf('Euclidean distance is %.2f',d2);
text((secCorn(1)+interPoint2(1))/2, (secCorn(2)+interPoint2(2))/2, str2, 'Color','red')

thrCorn = [230, 295];
interPoint3 = [C(5), C(6)];
d3 = norm(thrCorn - interPoint3);
hold on
line([thrCorn(1) interPoint3(1)],[thrCorn(2) interPoint3(2)],'Color','red','LineStyle','--');
str3 = sprintf('Euclidean distance is %.2f',d3);
text((thrCorn(1)+interPoint3(1))/2, (thrCorn(2)+interPoint3(2))/2, str3, 'Color','red')

fortCorn = [314, 295];
interPoint4 = [C(7), C(8)];
d4 = norm(fortCorn - interPoint4);
hold on
line([fortCorn(1) interPoint4(1)],[fortCorn(2) interPoint4(2)],'Color','red','LineStyle','--');
str4 = sprintf('Euclidean distance is %.2f',d4);
text((fortCorn(1)+interPoint4(1))/2, (fortCorn(2)+interPoint4(2))/2, str4, 'Color','red')

fifCorn = [314, 379];
interPoint5 = [C(9), C(10)];
d5 = norm(fifCorn - interPoint5);
hold on
line([fifCorn(1) interPoint5(1)],[fifCorn(2) interPoint5(2)],'Color','red','LineStyle','--');
str5 = sprintf('Euclidean distance is %.2f',d5);
text((fifCorn(1)+interPoint5(1))/2, (fifCorn(2)+interPoint5(2))/2, str5, 'Color','red')

sixCorn = [403, 378];
interPoint6 = [C(11), C(12)];
d6 = norm(sixCorn - interPoint6);
hold on
line([sixCorn(1) interPoint6(1)],[sixCorn(2) interPoint6(2)],'Color','red','LineStyle','--');
str6 = sprintf('Euclidean distance is %.2f',d6);
text((sixCorn(1)+interPoint6(1))/2, (sixCorn(2)+interPoint6(2))/2, str6, 'Color','red')

sevCorn = [231, 378];
interPoint7 = [C(13), C(14)];
d7 = norm(sevCorn - interPoint7);
hold on
line([sevCorn(1) interPoint7(1)],[sevCorn(2) interPoint7(2)],'Color','red','LineStyle','--');
str7 = sprintf('Euclidean distance is %.2f',d7);
text((sevCorn(1)+interPoint7(1))/2, (sevCorn(2)+interPoint7(2))/2, str7, 'Color','red')

eigCorn = [479, 377];
interPoint8 = [C(15), C(16)];
d8 = norm(eigCorn - interPoint8);
hold on
line([eigCorn(1) interPoint8(1)],[eigCorn(2) interPoint8(2)],'Color','red','LineStyle','--');
str8 = sprintf('Euclidean distance is %.2f',d8);
text((eigCorn(1)+interPoint8(1))/2, (eigCorn(2)+interPoint8(2))/2, str8, 'Color','red')


% %% For better visualization
% figure
% subplot(1,2,1)
% imshow("1.jpg"), title("Zoomed area of the first intersection point")
% subplot(1,2,2)
% imshow("2.jpg"), title("Zoomed area of the second intersection point")
 

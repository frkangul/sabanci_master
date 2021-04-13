function [H, T, R] = lab4houghlines(img)
% Chech the original image if it is RGB or monocolor
[~, ~, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end
% If the input image has some noise
%img = imgaussfilt(img, 1.1);

% Edge Detection by Canny
edge_detector = "Canny";
img_edges = edge(img, edge_detector);

% Hough Transform
[H, T, R]=hough(img_edges);

% Display Part for Original Image, Canny Edge, and Hough Transform 
figure("Name", "Hough Transform", "NumberTitle", "off");
subplot(2,2,1)
imshow(img)
title("Original Image")

subplot(2,2,2)
imshow(img_edges)
title(sprintf("Edges using %s Edge Detector", edge_detector))

subplot(2,2,3)
imshow(H, [], "XData", T, "YData", R, "InitialMagnification", "fit");

title("Hough Transform")
xlabel('\theta');
ylabel("\rho");
axis on, axis normal, hold on;


% Hough Peaks
Thresh = ceil(0.5*max(H(:)));

P = houghpeaks(H, 5, "threshold", Thresh);
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,"s","color","white");

% Hough Lines with given parameters in lab sheet
lines = houghlines(img_edges, T,R,P,"FillGap", 10, "MinLength", 40);

% Plotting Hough Lines
subplot(2,2,4);
imshow(img), title(sprintf('Hough Lines Based on %s Edge detector, Threshold = %d', edge_detector, Thresh)), hold on

max_len = 40;
min_len = 2000;

for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow','Markersize',3);
       plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red','Markersize',3);

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
       
       if (len < min_len)
           min_len = len;
           xy_short = xy;
       end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',1,'Color','cyan');
plot(xy_short(:,1),xy_short(:,2),'LineWidth',1,'Color','red');
end


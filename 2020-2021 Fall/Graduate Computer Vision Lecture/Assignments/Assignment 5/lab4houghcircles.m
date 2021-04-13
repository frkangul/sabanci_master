function [centersBright, radiiBright,centersDark, radiiDark] = lab4houghcircles(I)
% Chech the original image if it is RGB or monocolor
[~,~,ch] = size(I);
    if (ch==3)
         I = rgb2gray(I);
    end

% Identify min and max radius ans sensitivity parameters
Rmin = 10;
Rmax = 60;
Sens = 0.7;

% Find circles in a given image using parameters above

% Find all the bright circles in the image within the radius range
[centersBright1, radiiBright1] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','bright');

% Find all the bright circles in the image within the radius range and
% sensitivity
[centersBright, radiiBright] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','bright','Sensitivity',Sens);
% Find all the dark circles in the image within the radius range and
% sensitivity
[centersDark, radiiDark] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',Sens);

% Plot circles
figure()
subplot(1,3,1)
imshow(I),title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d', Rmin, Rmax)), hold on
viscircles(centersBright1, radiiBright1,'EdgeColor','b');

subplot(1,3,2)
imshow(I),title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d & Sensitivity = %.2d', Rmin, Rmax, Sens)), hold on
viscircles(centersBright, radiiBright,'EdgeColor','r');

subplot(1,3,3)
imshow(I),title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d & Sensitivity = %.2d', Rmin, Rmax, Sens)), hold on
viscircles(centersBright, radiiBright,'Color','b');
viscircles(centersDark, radiiDark,'LineStyle','--');
end
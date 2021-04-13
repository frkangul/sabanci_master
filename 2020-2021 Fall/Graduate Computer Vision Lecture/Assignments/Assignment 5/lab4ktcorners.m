function [corners] = lab4ktcorners(img, T)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

% Transforming to double
img = double(img); % In order to have proper matrix operations, convert 
% datatype from uint8 to double

% Initializations of corners, threshold, and window size
corners = [];
k=1;

% Smooting
%Simg =  lab2gaussfilt(img);
Simg = imgaussfilt(img, 1.1);

% Compute gradient of Image
[Gx, Gy] = imgradientxy(Simg);

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.

% Finding H for each Pixel using windows
for i = k+1:h-k
    for j = k+1:w-k 
        % Find window sized gradient in x and y directions
        Ix = Gx(i-k:i+k, j-k:j+k);
        Iy = Gy(i-k:i+k, j-k:j+k);
        
        % Find elements of H matrix
        h11 = sum(sum(Ix.^2));
        h12 = sum(sum(Ix.*Iy));
        h21 = h12;
        h22 = sum(sum(Iy.^2)); 
        
        % Form H matrix
        H(1,1) = h11;
        H(1,2) = h12;
        H(2,1) = h21;
        H(2,2) = h22;
        
        % Finding eigenvalues and thresholding to get corner points
        [~, eigval] =eig(H);
        
        if min(eigval(1,1), eigval(2,2))>T
            corners = [corners;i j];
        end 
    end
end

% Change the datatype of the images from double to uint8 
% so that it can be displayed without any problem.
img = uint8(img);

% Plot corners with the original input images
% figure()
% 
% imshow(img);
% hold on;
% plot(corners(:,2), corners(:,1),"r*", "MarkerSize", 7, "Linewidth", 1);
% title("Kanade-Tomasi Corner Detection")
end


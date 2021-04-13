function [E] = lab3log(img, T1, T2)
% Chech the original image if it is RGB or monocolor
[h, w, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

% Blur the image, using Gaussian builtin function 
J = imgaussfilt(img, 1.1);

% datatype from uint8 to double


% Define laplace filter for x and y
laplac_Filter = [0 1 0;1 -4 1; 0 1 0];
G = conv2(J, laplac_Filter, "same");
    
% Find the zero crossing of the laplacian and compare the local change at
% this point to a threshold
E = zeros(h,w);

k = 1; % Since we have 3 by 3 LoG filter

% Go over center pixels. We have total 2k+1 parameters in every row & column of
% filter. Since we have a valid boundary, at the start, the center of the image 
% coincides the filter at (k+1, k+1) position. The filter (window) will slide 
% one by one until (h-k,w-k) position in the image.
for i = k+1:h-k
    for j = k+1:w-k
        % Apply thresholding at each pixel
        if abs(G(i,j)) >= T1
            % Check zero crossings occur at (i,j) pixel or not
            if (G(i,j)*G(i-1,j)<0 )|| (G(i,j)*G(i+1, j)<0)|| (G(i,j)*G(i, j-1)<0)...
                || (G(i,j)*G(i, j+1)<0)
                % Apply thresholding to slopes for finding strong edge
                % pixels
                if abs(G(i,j)-G(i-1,j))>= T2 || abs(G(i,j)-G(i+1,j))>= T2... 
                    || abs(G(i,j)-G(i, j-1))>= T2 || abs(G(i,j)-G(i, j+1))>= T2
                    % Make strong edge pixels white
                    E(i,j) = 255;
                end
            end
        else
            % Check zero crossings occur at (i,j) pixel or not
            if (G(i+1,j)*G(i-1,j)<0 )|| (G(i,j+1)*G(i, j-1)<0)
                % Apply thresholding to slopes for finding strong edge
                % pixels
                if abs(G(i, j+1) - G(i, j-1))>= T2 || abs(G(i+1, j) -G(i-1,j))>= T2
                    % Make strong edge pixels white
                    E(i,j) = 255;
                end                
            end
        end            
    end
end

% Change the datatype of the images from double to uint8 
% so that it can be displayed without any problem.
img = uint8(img);
G = uint8(G);
E = uint8(E);

% Plot the original image, laplacian of image and log edge images 
% via subplot function
figure()

subplot(1,3,1);
imshow(img);
title("Original Image", 'FontSize',18);

subplot(1,3,2);
imshow(G,[]);
title("Laplacian of an Image", 'FontSize',18);

subplot(1,3,3);
E= medfilt2(E); 
imshow(E);
title("LoG Edges", 'FontSize',18);
end


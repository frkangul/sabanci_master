function [Jnew] = lab1condscale(Im,Iref)
% Chech the original image if it is RGB or monocolor
[~, ~, c] = size(Im);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    Im = rgb2gray(Im);
end
% Chech the reference image if it is RGB or monocolor
[~, ~, c] = size(Iref);

% If the refrence image is RGB (colored), then convert it to grayscale image
if c == 3
    Iref = rgb2gray(Iref);
end

% To be able to make math operations on the monocolor images, change theirs' datatype
% to double
J = double(Im);
I = double(Iref);

%%Let's condition the mean and variance of the original image with the mean and
% variance of the reference image using below gradation function 
%(No need to make this line Section, think of it as a heading)

b = std(I(:))/std(J(:));
a = mean(I(:))/b - mean(J(:));

Jnew = b*(J+a);

% Let's check if the conditioned new image(Jnew) has the same mean and variance of the
% reference image(J) or not. 
%disp([mean(I(:)), mean(J(:)), mean(Jnew(:))]);
%disp([std(I(:)), std(J(:)), std(Jnew(:))]);

% Change the datatype of conditioned image matrix from double to uint8 so that 
% it can be displayed without any problem.
% Since I will use Im and Iref labels for the purpose of plotting, there is
% no need to convert their datatypes since they are already in uint8.

Jnew_uint = uint8(Jnew); % Make Jnew image 

% Plot the reference, current, and processed images via subplot function
figure()

subplot(2,2,[1, 2]);
imshow(Iref);
title("Reference Image", 'FontSize',18);
% Let's make xlabel as similar as it is in the pdf document
xlabel(["\mu = " + mean(I(:));"\sigma = " + std(I(:))], 'FontSize',18)

subplot(2,2,3);
imshow(Im);
title("Current Image", 'FontSize',18);
xlabel(["\mu = " + mean(J(:));"\sigma = " + std(J(:))], 'FontSize',18)

subplot(2,2,4);
imshow(Jnew_uint);
title("Processed Image", 'FontSize',18);
xlabel(["\mu = " + mean(Jnew(:));"\sigma = " + std(Jnew(:))], 'FontSize',18)
end

    
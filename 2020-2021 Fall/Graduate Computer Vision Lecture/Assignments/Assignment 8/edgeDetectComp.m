function [] = edgeDetectComp(img, T1, T2)
% Chech the original image if it is RGB or monocolor
[~, ~, c] = size(img);

% If the image is RGB (colored), then convert it to grayscale image
if c == 3
    img = rgb2gray(img); % It is overwritting. Not good in general.
end

img = imgaussfilt(img, 1.5);

prewitt = edge(img, "prewitt");
roberts = edge(img, "roberts");

if T1 == 0 && T2 == 0
    canny = edge(img, "canny");
    log = edge(img, "log");
    T1 = "Nothing";
    T2 = T1;
else
    canny = edge(img, "canny", T1);
    log = edge(img, "log", T2);
end


figure()
subplot(1,4,1)
imshow(prewitt)
title("Edgels with Prewitt Operator")

subplot(1,4,2)
imshow(roberts)
title("Edgels with Roberts Operator")

subplot(1,4,3)
imshow(canny)
title("Edgels with Canny Operator with Threshold of " + num2str(T1))

subplot(1,4,4)
imshow(log)
title("Edgels with LoG Operator with Threshold of " + num2str(T2))

end


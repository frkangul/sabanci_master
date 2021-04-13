function [med] = median(im)
%% Exp 8
[row, col, ch] = size(im);
card = row*col; % cardinality

if ch ==3
    im = rgb2gray(im);
end

im = double(im);
data = reshape(im, [1, card]);
data = sort(data);

if (mod(card, 2)==0)
    ind = card/2;
    med = (data(ind) + data(ind+1))/2;
else
    ind = (card+1)/2;
    med = Data(ind);
end
end


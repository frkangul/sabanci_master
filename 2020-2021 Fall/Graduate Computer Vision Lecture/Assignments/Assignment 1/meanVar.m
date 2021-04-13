function [mean,var] = meanVar(im)
%% Exp 7
[row, col, ch] = size(im);
card = row*col; % cardinality

if ch ==3
    im = rgb2gray(im);
end
im = double(im);% we cant do division on unsegined integer
data = reshape(im, [1, card]);

tot1 = 0;
tot2 = 0;

for i=1:1:card
    tot1 = tot1 + data(i);
    tot2 = tot2 + data(i)^2;
end

mean = tot1/card;
var = (tot2/card) - mean^2;

end


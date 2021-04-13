function lab6OF(ImPrev,ImCurr,k,Threshold)
% Turn them into double format to avoid algebraic errors
ImPrev = double(ImPrev);
ImCurr = double(ImCurr);
% Smooth the input images using a built in Box filter, size of 2 or 3
%ImPrev_smth = imboxfilt(ImPrev,3);
%ImCurr_smth = imboxfilt(ImCurr,3);

% Smooth the input images using a built in Gaussian filter, size of 2 or 3
ImPrev_smth = imgaussfilt(ImPrev,3);
ImCurr_smth = imgaussfilt(ImCurr,3);


% Calculate spatial gradients (Ix, Iy) using Prewitt filter and use conv2

% Define prewitt filters for x and y
x_Filter = [-1 0 1;-1 0 1; -1 0 1];
y_Filter = [-1 -1 -1; 0 0 0 ; 1 1 1];

Ix = conv2(ImPrev_smth, x_Filter, "same");
Iy = conv2(ImPrev_smth, y_Filter, "same");

% Calculate temporal (It) gradient
It=(ImPrev_smth -ImCurr_smth);

[ydim,xdim] = size(ImCurr);
% Velocities
Vx = zeros(ydim,xdim);
Vy = zeros(ydim,xdim);
G = zeros(2,2);
b = zeros(2,1);


for x=k+1:k:xdim-k-1
    for y=k+1:k:ydim-k-1
        % Calculate the elements of G and b
        % Find window sized gradient in x and y directions
     
        Ix_ = Ix(y-k:y+k, x-k:x+k);
        
        Iy_ = Iy(y-k:y+k, x-k:x+k);
        
        It_ = It(y-k:y+k, x-k:x+k);
        
        % Find elements of G matrix
        g11 = sum(sum(Ix_.^2));
        g12 = sum(sum(Ix_.*Iy_));
        g21 = g12;
        g22 = sum(sum(Iy_.^2)); 
        % Find elements _of b matrix
        b11 = sum(sum(Ix_.*It_));
        b21 = sum(sum(Iy_.*It_));
        % Form G matrix
        G(1,1) = g11;
        G(1,2) = g12;
        G(2,1) = g21;
        G(2,2) = g22;
        % Form b matrix
        b(1,1) = b11;
        b(2,1) = b21;
        % Finding eigenvalues and thresholding
        [~, eigval] =eig(G);
        if min(eigval(1,1), eigval(2,2))>Threshold 
            % Calculate u
            u = -inv(G)*b;
            Vx(y,x)=u(1,1); 
            Vy(y,x)=u(2,1);
        end
    end
end

% Displaying part using imagesc and meshgrid with scaled colors
cla reset;
imagesc(ImPrev); hold on;
[xramp,yramp] = meshgrid(1:1:xdim,1:1:ydim); 
quiver(xramp,yramp,Vx,Vy,10,"r");
colormap gray;
drawnow;
end

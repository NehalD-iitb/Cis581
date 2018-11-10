function E = edgeLink(M, Mag, Ori)
%%  Description
%       use hysteresis to link edges
%%  Input: 
%        M = (H, W), logic matrix, output from non-max suppression
%        Mag = (H, W), double matrix, the magnitude of gradient
%    		 Ori = (H, W), double matrix, the orientation of gradient
%
%%  Output:
%        E = (H, W), logic matrix, the edge detection result.
%
%% ****YOU CODE STARTS HERE**** 


edge = Mag.*M;
threshold = graythresh(edge); % otsu's method of thresholding
threshold = threshold*256;
threshold_high = 0.8;
threshold_low = threshold_high/2;
threshold_low = threshold_low * threshold;
threshold_high = threshold_high * threshold;
strong = M & Mag>threshold_high;
weak = M & Mag>threshold_low;
weak = weak-strong;
strong_neighbor = conv2(strong,[1,1,1;1,0,1;1,1,1],'same');
linkededges = weak & strong_neighbor;
E = logical(linkededges + strong);
end

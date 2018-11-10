% File name: feat_desc.m
% Author: Nehal Doiphode
% Date created: 01/11/2018

function [descs] = feat_desc(img, x, y)
% Input:
%    img = double (height)x(width) array (grayscale image) with values in the
%    range 0-255
%    x = nx1 vector representing the column coordinates of corners
%    y = nx1 vector representing the row coordinates of corners

% Output:
%   descs = 64xn matrix of double values with column i being the 64 dimensional
%   descriptor computed at location (xi, yi) in im

    cornerNum = size(x,1);
    descs = zeros(64, cornerNum);
    im = im2double(padarray(img,[20 20],'both'));
    spacing = 5;
    win = 40;
    filt = fspecial('gaussian'); 

    for i = 1:cornerNum
         patch = im(y(i):y(i)+win-1, x(i):x(i)+win-1);
         Filteredpatch = imfilter(patch, filt, 'same'); 
         Filteredpatch = Filteredpatch(1:spacing:win, 1:spacing:win);
         Filteredpatch = reshape(Filteredpatch, [64, 1]);
         Filteredpatch = (Filteredpatch - mean(Filteredpatch))./std(Filteredpatch,1); 
         descs(:,i) = Filteredpatch;
    end
   
end
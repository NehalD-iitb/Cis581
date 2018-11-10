% File name: corner_detector.m
% Author: Nehal Doiphode
% Date created: 01/11/2018

function [cimg] = corner_detector(img)
% Input:
% img is an image

% Output:
% cimg is a corner matrix
      HarrisPts = detectHarrisFeatures(img);
      cimg = zeros(size(img));
      points = (round(HarrisPts.Location));
      idx = sub2ind(size(cimg),points(:,2),points(:,1));
      cimg(idx) = HarrisPts.Metric;
     
end
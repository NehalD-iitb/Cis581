% File name: feat_match.m
% Author: Nehal Doiphode
% Date created: 01/11/2018

function [match] = feat_match(descs1, descs2)
% Input:
%   descs1 is a 64x(n1) matrix of double values
%   descs2 is a 64x(n2) matrix of double values

% Output:
%   match is n1x1 vector of integers where m(i) points to the index of the
%   descriptor in p2 that matches with the descriptor p1(:,i).
%   If no match is found, m(i) = -1

        thresh=0.7;
        [mIdx,mD] = knnsearch(descs2',descs1','K',2);
        ratio = mD(:,1)./mD(:,2);
        match = mIdx(:,1);
        match(ratio >= thresh) = -1;
    
    

end
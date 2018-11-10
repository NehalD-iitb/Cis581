% File name: ransac_est_homography.m
% Author: Nehal Doiphode
% Date created: 01/11/2018

function [H, inlier_ind] = ransac_est_homography(x1, y1, x2, y2, thresh)
% Input:
%    y1, x1, y2, x2 are the corresponding point coordinate vectors Nx1 such
%    that (y1i, x1i) matches (x2i, y2i) after a preliminary matching
%    thresh is the threshold on distance used to determine if transformed
%    points agree

% Output:
%    H is the 3x3 matrix computed in the final step of RANSAC
%    inlier_ind is the nx1 vector with indices of points in the arrays x1, y1,
%    x2, y2 that were found to be inliers

    mincount=-1;
    for i=1:1000
        idx =  randperm(size(x1,1), 4);
        H = est_homography(x1(idx),y1(idx),x2(idx),y2(idx));
        [H_x2, H_y2] = apply_homography(H,x2,y2);
        dist = (H_x2-x1).^2 + (H_y2-y1).^2;
        inlier_tmp = find(dist<=(thresh^2));
        inCount = size(inlier_tmp,1);
            if (inCount > mincount)
                mincount = inCount;
                inlier_ind = inlier_tmp;
            end
    end
    
    H=est_homography(x1(inlier_ind),y1(inlier_ind),x2(inlier_ind),y2(inlier_ind));
end


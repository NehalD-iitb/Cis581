% File name: anms.m
% Author: Nehal Doiphode
% Date created: 01/11/2018

function [y, x, rmax] = anms(cimg, max_pts)
% Input:
% cimg = corner strength map
% max_pts = number of corners desired

% Output:
% [x, y] = coordinates of corners
% rmax = suppression radius used to get max_pts corners


% [x,y,rmax]=anms(cimg,max_pts)
% – (INPUT) cimg: H x W matrix representing the corner-metric matrix.
% – (INPUT) max_pts: The desired number of corners
% – (OUTPUT) x: N x 1 matrix representing the column coordinates of the corners
% – (OUTPUT) y: N x 1 matrix representing the row coordinates of the corners
% – (OUTPUT) rmax: Supression radius used to obtain max_pts corners

    corners=find(cimg);
    [y x]=ind2sub(size(cimg),corners);
    cornerDist=inf*ones(size(y,1),1);
    thresh = 0.9;
    for i=1:size(corners,1)
        for j=1:size(corners,1)
            if (cimg(y(i),x(i))< cimg(y(j),x(j))*thresh)
                temp =(y(i)-y(j))^2 + (x(i)-x(j))^2;
                if (temp < cornerDist(i))
                    cornerDist(i)=temp;
                end
            end
        end
    end
    
    [d index]=sort(cornerDist,'descend');
    y=y(index);
    x=x(index);
    y=y(1:max_pts);
    x=x(1:max_pts);
    rmax=sqrt(d(max_pts));
end
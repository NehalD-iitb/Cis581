% File name: mymosaic.m
% File name: anms.m
% Author: Nehal Doiphode

function [img_mosaic] = mymosaic(img_input)
% Input:
%   img_input is a cell array of color images (HxWx3 uint8 values in the
%   range [0,255])
%
% Output:
% img_mosaic is the output mosaic

     Icell = img_input;
     I = Icell{1};
     grayImage = rgb2gray(I);
     max_pts = 200;

     cimg = corner_detector(grayImage);
     [y, x, rmax] = anms(cimg, max_pts);
     [descs] = feat_desc(grayImage, x, y);
    


     numImages = size(Icell,2);
     tforms(numImages) = projective2d(eye(3));

     % Initialize variable to hold image sizes.
     imageSize = zeros(numImages,2);

    % Iterate over remaining image pairs
    for n = 2:numImages

        % Read I(n).
        I1 = Icell{n};

        % Convert image to grayscale.
        grayImage1 = rgb2gray(I1);

        % Save image size.
        imageSize(n,:) = size(grayImage1);

        % Detect and extract SURF features for I(n).
        cimg1 = corner_detector(grayImage1);
        [y1, x1, rmax] = anms(cimg1, max_pts);
        [descs1] = feat_desc(grayImage1, x1, y1);


        [match] = feat_match(descs, descs1);
        m = match;
        thresh = 0.5;

        Y1 = y(m ~= -1);
        X1 = x(m ~= -1);
        Y2 = y1(m(m ~= -1));
        X2 = x1(m(m ~= -1));
        figure;
        showMatchedFeatures(I,I1,[X1 Y1],[X2 Y2],'montage');

        [H, inlier_ind] = ransac_est_homography(X1, Y1, X2, Y2, thresh);

        y = y1;
        x = x1;
        descs = descs1;
        I = I1;


        % Estimate the transformation between I(n) and I(n-1).
        tforms(n) = projective2d(H');
        % Compute T(n) * T(n-1) * ... * T(1)
        tforms(n).T = tforms(n).T * tforms(n-1).T;
    end


    % Compute the output limits  for each transform
    for i = 1:numel(tforms)
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
    end

    avgXLim = mean(xlim, 2);

    [~, idx] = sort(avgXLim);

    centerIdx = floor((numel(tforms)+1)/2);

    centerImageIdx = idx(centerIdx);


    Tinv = invert(tforms(centerImageIdx));

    for i = 1:numel(tforms)
        tforms(i).T = tforms(i).T * Tinv.T;
    end

    for i = 1:3
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
    end

    maxImageSize = max(imageSize);

    % Find the minimum and maximum output limits
    xMin = min([1; xlim(:)]);
    xMax = max([maxImageSize(2); xlim(:)]);

    yMin = min([1; ylim(:)]);
    yMax = max([maxImageSize(1); ylim(:)]);

    % Width and height of panorama.
    width  = round(xMax - xMin);
    height = round(yMax - yMin);

    % Initialize the "empty" panorama.
    panorama = zeros([height width 3], 'like', I);
    blender = vision.AlphaBlender('Operation', 'Binary mask', ...
        'MaskSource', 'Input port');

    % Create a 2-D spatial reference object defining the size of the panorama.
    xLimits = [xMin xMax];
    yLimits = [yMin yMax];
    panoramaView = imref2d([height width], xLimits, yLimits);

    % Create the panorama.
    for i = 1:numImages

        I = Icell{i};

        % Transform I into the panorama.
        warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);

        % Generate a binary mask.
        mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);

        % Overlay the warpedImage onto the panorama.
        panorama = step(blender, panorama, warpedImage, mask);
        img_mosaic{i} = panorama;
        figure
        imshow(panorama)

    end
end
    

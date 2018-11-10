function mask = maskImage(Img)
    
im = imshow(Img);    
title('Click and drag to draw mask');
outline = imfreehand(gca);
% wait(e);
mask = createMask(outline,im);
    
end


function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)


    targetMap_r = targetImg(:,:,1);
    targetMap_g = targetImg(:,:,2);
    targetMap_b = targetImg(:,:,3);
    sourceMap_r = sourceImg(:,:,1);
    sourceMap_g = sourceImg(:,:,2);
    sourceMap_b = sourceImg(:,:,3);
    [targetH,targetW,~]=size(targetImg);
    
    
    indexes=getIndexes(mask,targetH, targetW, offsetX, offsetY);

    coeffA = getCoefficientMatrix(indexes);
    
    
    b_R = getSolutionVect(indexes, sourceMap_r, targetMap_r, offsetX, offsetY);
    b_G = getSolutionVect(indexes, sourceMap_g, targetMap_g, offsetX, offsetY);
    b_B = getSolutionVect(indexes, sourceMap_b, targetMap_b, offsetX, offsetY);


    x_R = coeffA \ b_R';
    x_G = coeffA \ b_G';
    x_B = coeffA \ b_B';
    
    resultImg=reconstructImg(indexes, x_R', x_G', x_B', targetImg);
end
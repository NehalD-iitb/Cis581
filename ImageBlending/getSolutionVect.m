function solVectorb = getSolutionVect(indexes, source, target, offsetX, offsetY)



indexes_s = indexes(offsetY:offsetY+size(source,1)-1,offsetX:offsetX+size(source,2)-1);

laplacian_s = conv2(source,[0 -1 0;-1 4 -1;0 -1 0],'same');

laplacian_s(indexes_s==0)=0;

target(indexes>0)=0;

boundary_t = conv2(target,[0 1 0;1 0 1;0 1 0],'same');

boundary_t(indexes==0)=0;

boundary_t(offsetY:offsetY+ size(source,1) -1,offsetX:offsetX+size(source,2)-1) = ...
    boundary_t(offsetY:offsetY+size(source,1)-1,offsetX:offsetX+size(source,2)-1)+ laplacian_s;

boundary_t=boundary_t';

indexes=indexes';

solVectorb=boundary_t(indexes>0)';

end

function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
%initializing indexes to be of same size as target image
indexes = zeros(targetH, targetW);
%setting the replacement pixels as 1
indexes(offsetY:offsetY+size(mask,1)-1,offsetX:offsetX+size(mask,2)-1)=mask;
%finding total number of indices
n =nnz(indexes);
% transposing to obtain the right indexing order
indexes = indexes';
indexes(indexes==1)=1:n;
indexes = indexes';


end
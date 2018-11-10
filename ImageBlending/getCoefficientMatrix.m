function coeffA = getCoefficientMatrix(indexes)
%here indexes are of the replacement pixels on the target image

top = conv2(indexes,[1;0;0],'same');

bottom = conv2(indexes,[0;0;1],'same');

left = conv2(indexes,[1 0 0],'same');

right = conv2(indexes,[0 0 1],'same');

points = [indexes(indexes>0 & top>0),top(indexes>0 & top>0);
     indexes(indexes>0 & bottom>0),bottom(indexes>0 & bottom>0);
     indexes(indexes>0 & left>0),left(indexes>0 & left>0);
     indexes(indexes>0 & right>0),right(indexes>0 & right>0);];
 
n = max(indexes(:));

i = [points(:,1)',1:n];

j = [points(:,2)',1:n];

k = [ones(1,size(points,1))*-1,ones(1,n)*4];

coeffA = sparse(i,j,k);

end

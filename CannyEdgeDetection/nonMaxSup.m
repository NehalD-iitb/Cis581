function edge = nonMaxSup(Mag, Ori)
%%  Description
%       compute the local minimal along the gradient.
%%  Input: 
%         Mag = (H, W), double matrix, the magnitude of derivative 
%         Ori = (H, W), double matrix, the orientation of derivative
%%  Output:
%         M = (H, W), logic matrix, the edge map
%
%% ****YOU CODE STARTS HERE**** 
    angle = Ori;
    angle(angle<0) = pi+angle(angle<0);
    angle(angle>7*pi/8) = pi-angle(angle>7*pi/8);

    edge = zeros( size(Mag,1), size(Mag,2));
    
    %Interpolation code
    x1=cos(angle); 
    y1=sin(angle); 
    
    [X,Y]=meshgrid(1:size(angle,2),1:size(angle,1));

    Xq1=X; 
    Yq1=Y;
    Xq2=X;
    Yq2=Y;

    for i=2:size(angle,1)-1
        for j=2:size(angle,2)-1
            Xq1(i,j)=j+x1(i,j);
            Yq1(i,j)=i-y1(i,j);
            Xq2(i,j)=j-x1(i,j);
            Yq2(i,j)=i+y1(i,j);
        end
    end
    point1 = interp2(X,Y,Mag,Xq1, Yq1);
    point2 = interp2(X,Y,Mag,Xq2, Yq2);
    
    for i=2:size(angle,1)-1
        for j=2:size(angle,2)-1
            edge(i,j)=Mag(i,j)==max([Mag(i,j),point1(i,j),point2(i,j)]);
        end
     end

    edge=logical(edge);



end



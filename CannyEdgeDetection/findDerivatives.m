function [Mag, Magx, Magy, Ori] = findDerivatives(I_gray)
%%  Description
%       compute gradient from grayscale image 
%%  Input: 
%         I_gray = (H, W), double matrix, grayscale image matrix 
%
%%  Output:
%         Mag  = (H, W), double matrix, the magnitued of derivative%  
%         Magx = (H, W), double matrix, the magnitude of derivative in x-axis
%         Magx = (H, W), double matrix, the magnitude of derivative in y-axis
% 				Ori = (H, W), double matrix, the orientation of the derivative
%
%% ****YOU CODE STARTS HERE**** 

Iblur1 = imgaussfilt(I_gray,0.8); %sigma of filter is 1


f1 = [1 0 -1; 2 0 -2; 1 0 -1];
%f1 = [0 0 0; -1 2 -1; 0 0 0];

%% Convolve image with kernel f1 -> This highlights the vertical edges in the image

I=padarray(Iblur1,[1,1]);
I=double(I);
I3=zeros(size(I));
%Write code here to convolve img1 with f1for i=1:size(I,1)-2
for i=1:size(I,1)-2
    for j=1:size(I,2)-2
       
        I3(i,j)=sum(sum(f1.*I(i:i+2,j:j+2)));
       
    end
end

Magy =I3 ;

%% Y gradient - Sobel Operator
% Now if you want to highlight horizontal edges in the image, think about what the kernel should be. Store this kernel in the variable f2.
f2 = f1';
I4=zeros(size(I));
%Write code here to convolve img1 with f1for i=1:size(I,1)-2
for i=1:size(I,1)-2
    for j=1:size(I,2)-2
       
        I4(i,j)=sum(sum(f2.*I(i:i+2,j:j+2)));
       
    end
end

Magx =I4 ;

Mag=sqrt(Magx.^2+Magy.^2);%Compute magnitude of derivatives
Ori=atan2(Magy, Magx);%Compute orientation of derivatives
Magx = Magx(2:end-1,2:end-1);
Magy = Magy(2:end-1,2:end-1);
Mag = Mag(2:end-1,2:end-1);
Ori= Ori(2:end-1,2:end-1);





end
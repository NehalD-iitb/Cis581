
S = imread('SourceImage.png');
T = imread('TargetImage.png');
offsetX = 413;
offsetY = 300;

[mask] = maskImage(S);

[clonedImage] = seamlessCloningPoisson(S, T, mask, offsetX, offsetY);

imshow(clonedImage);
imwrite(clonedImage,'clonedImage.png');

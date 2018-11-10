% File name: test.m
% Author: Nehal Doiphode
% Date created: 01/11/2018
%Test file
clear;

img1 = imread('Input/test_img/1L.jpg');
img2 = imread('Input/test_img/1M.jpg');
img3 = imread('Input/test_img/1R.jpg');


Icell = {img1,img2,img3};
mosaic = mymosaic(Icell);

img1 = imread('Input/set2/yosemite1.jpg');
img2 = imread('Input/set2/yosemite2.jpg');
img3 = imread('Input/set2/yosemite3.jpg');

Icell = {img1,img2,img3};
mosaic = mymosaic(Icell);

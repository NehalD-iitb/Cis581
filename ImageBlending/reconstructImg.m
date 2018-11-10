function resultImg = reconstructImg(indexes, red, green, blue, targetImg)

indexes=indexes';

ChannelR=targetImg(:,:,1)';
ChannelG=targetImg(:,:,2)';
ChannelB=targetImg(:,:,3)';

ChannelR(indexes>0)=red;
ChannelG(indexes>0)=green;
ChannelB(indexes>0)=blue;

resultImg(:,:,1)=ChannelR';
resultImg(:,:,2)=ChannelG';
resultImg(:,:,3)=ChannelB';
 



end
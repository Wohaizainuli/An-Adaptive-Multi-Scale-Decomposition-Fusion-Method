clc;
clear all;
close all;
mimg=imread('../真实MS-PAN图片/re-1-m.jpg');
pimg=imread('../真实MS-PAN图片/re-1-p.jpg');
d=rgb2lab(mimg);
for i=1:size(d,3)
    na=sprintf("csc-%d.tif",i);
    img=mat2gray(d(:,:,i));
    imwrite(img,na);
end
lfm=d(:,:,1);
pan=gray_balance(pimg,lfm);
dfs=alfs(lfm,pan);
[le,sd]=getls_seven(dfs);
decp=mydec(pan,le,sd);
for i=1:length(decp)
    na=sprintf("amsd-%d.tif",i);
    img=mat2gray(decp{i});
    imwrite(img,na);
end
dimg = abs(lfm-decp{1});
dimg=mat2gray(dimg);
imwrite(dimg,'dimg.tif');
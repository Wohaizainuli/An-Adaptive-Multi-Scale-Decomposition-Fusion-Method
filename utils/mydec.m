function re = mydec(img, leve,  sd, os, is)
%利用高斯核函数实现非下采样金字塔分解
if nargin < 1 || nargin > 5
    error('wrong number of input ... ');
end
if nargin < 2
    leve=4;
end
if nargin < 3
    sd=1;
end
if nargin < 4
    os=3;
end
if nargin < 5
    is=2;
end
if size(img,3) ~= 1
    img=rgb2gray(img);
end
re=cell(1, leve+1);
temp=double(img);
for i=leve+1:-1:2
    re{i}=temp;
    si=os+is*(leve+1-i);
    kerk=fspecial('gaussian', [si, si], sd);
    temp = imfilter(temp, kerk, 'replicate','same');
    re{i} = re{i}-temp;
end
re{1}=temp;
end
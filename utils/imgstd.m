function re=imgstd(img, siz)
if nargin < 1 || nargin > 2
    error('The input is wrong...');
end
if nargin < 2
    siz=5;
end
if size(img,3) ~= 1
    img=rgb2gray(img);
end
img=im2double(img);
[c,r]=size(img);
sd=0;
for i=1:siz:c-siz+1
    for j=1:siz:r-siz+1
        temp=img(i:i+siz-1,j:j+siz-1);
        sd=sd+std2(temp);
    end
end
re=sd/(floor(i/siz)*floor(j/siz));
end
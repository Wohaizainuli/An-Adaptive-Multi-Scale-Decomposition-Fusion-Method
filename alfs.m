function re = alfs(img, ref, ws, ste, we)
if nargin < 2 || nargin > 5
    error('The number of input is wrong...');
end
if nargin < 3
    ws = [16, 16];
end
if nargin < 4
    ste = [ws(1),ws(2)];
end
if nargin < 5
    we=[1,1,1];
end
if size(img, 3) ~= 1
    img=rgb2gray(img);
end
if size(ref,3) ~= 1
    ref=rgb2gray(ref);
end
img=double(img);
ref=double(ref);
blimg=segment(img,ws,ste);
blref=segment(ref,ws,ste);
[ru,cu]=size(blimg);
temp=0;
for i=1:ru
    for j=1:cu
        temp=temp+lfs(blimg{i,j},blref{i,j},we);
    end
end
re=temp/(ru*cu);
end

function re = lfs(img, ref, w)
uimg=mean2(img);
uref=mean2(ref);
uif=(2*uimg*uref+10^-10)/(uimg^2+uref^2+10^-10);
simg=std2(img);
sref=std2(ref);
sif=(2*simg*sref+10^-10)/(simg^2+sref^2+10^-10);
rimg=SF(img);
rref=SF(ref);
rif=(2*rimg*rref+10^-10)/(rimg^2+rref^2+10^-10);
re=sif^w(1)*uif^w(2)*rif^w(3);
end

function re=SF(p)
[M,N]=size(p);
tempX=zeros(M,N);
tempY=zeros(M,N);
tempX(1:M, 1:(N-1))=p(1:M, 2:N);
tempY(1:(M-1), 1:N)=p(2:M, 1:N);
diffX=p-tempX;
diffY=p-tempY;
diffX(1:M,N)=0;
diffY(M,1:N)=0;
diffX=diffX.^2;
diffY=diffY.^2;
X=sum(sum(diffX));
Y=sum(sum(diffY));
re=sqrt((X+Y)/(M*N));
end

function re=segment(p,rc,step)
[r,c]=size(p);
ru=ceil((r-rc(1))/step(1)+1);
cu=ceil((c-rc(2))/step(2)+1);
re=cell(ru,cu);
for i=1:ru
    for j=1:cu
        if i == ru && j ~= cu
            re{i,j}=p(step(1)*(i-1)+1:end, step(2)*(j-1)+1:step(2)*(j-1)+rc(2));
        end
        if i ~= ru && j == cu
            re{i,j}=p(step(1)*(i-1)+1:step(2)*(i-1)+rc(1), step(2)*(j-1)+1:end);
        end
        if i ~= ru && j ~= cu
            re{i,j}=p(step(1)*(i-1)+1:step(2)*(i-1)+rc(1), step(2)*(j-1)+1:step(2)*(j-1)+rc(2));
        end
        if i == ru && j == cu
            re{i,j}=p(step(1)*(i-1)+1:end, step(2)*(j-1)+1:end);
        end
    end
end
end
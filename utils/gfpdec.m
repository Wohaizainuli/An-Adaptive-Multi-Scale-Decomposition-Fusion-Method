function re = svtdec(img, leve)
%利用高斯核函数实现非下采样金字塔分解
if nargin < 1 || nargin > 2
    error('wrong number of input ... ');
end
if nargin < 2
    leve=3;
end
if size(img,3) ~= 1
    img=rgb2gray(img);
end
re=cell(1,leve+1);
Ker=fspecial("average",[5,5]);
Ker=[-0.0158,-0.0136,-0.0102,-0.0136,-0.0158;
    -0.0136,-0.0130,-0.0602,-0.0130,-0.0136;
    -0.0102,-0.0602,0.5051,-0.0602,-0.0102;
    -0.0136,-0.0130,-0.0602,-0.0130,-0.0136;
    -0.0158,-0.0136,-0.0102,-0.0136,-0.0158];
kerk=cell(1,leve);
for i=1:leve
    kerk{i}=zeros(5+4*(i-1),5+4*(i-1));
    for x=1:5
        for y=1:5
            kerk{i}(x+(i-1)*(x-1),y+(i-1)*(y-1))=Ker(x,y);
        end
    end
end
temp=im2double(img);
for i=leve+1:-1:2
    re{i}=imfilter(temp,kerk{leve+2-i},'replicate','same','conv');
    temp=temp-re{i};
end
re{1}=temp;
end
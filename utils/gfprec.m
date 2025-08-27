function re = svtrec(dec)
%根据分解系数重建图像
if nargin ~= 1
    error('wrong number of input ... ');
end
leve=length(dec);
re=zeros(size(dec{1}));
for i=1:leve
    re=re+dec{i};
end
end


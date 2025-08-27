function re = svtrec(dec)
% 重构函数，通过累加多个图像层来合成一个图像
% 输入参数：
% dec - 包含多个图像层的单元数组

% 检查输入参数数量是否正确
if nargin ~= 1
    error('wrong number of input ... ');
end

% 获取解卷积层数量
leve = length(dec);

% 初始化结果图像为第一个图像层的大小，值为0
re = zeros(size(dec{1}));

% 遍历所有图像层，累加到结果图像
for i = 1:leve
    re = re + dec{i};
end
end

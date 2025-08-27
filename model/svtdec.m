function re = svtdec(img, leve)
% 图像分解函数，通过多级滤波分解图像
% 输入参数：
% img - 输入的单通道或彩色图像
% leve - 分解的层数，默认为3层

% 检查输入参数的数量是否正确
if nargin < 1 || nargin > 2
    error('wrong number of input ... ');
end

% 如果未指定层数，则默认为3层
if nargin < 2
    leve = 3;
end

% 如果图像是彩色的，则转换为灰度图像
if size(img, 3) ~= 1
    img = rgb2gray(img);
end

% 初始化用于存储每一层分解结果的单元数组
re = cell(1, leve + 1);

% 定义核心滤波器矩阵
Ker = [-0.0158, -0.0136, -0.0102, -0.0136, -0.0158;
       -0.0136, -0.0130, -0.0602, -0.0130, -0.0136;
       -0.0102, -0.0602,  0.5051, -0.0602, -0.0102;
       -0.0136, -0.0130, -0.0602, -0.0130, -0.0136;
       -0.0158, -0.0136, -0.0102, -0.0136, -0.0158];

% 初始化存储每一层使用的滤波器的单元数组
svtk = cell(1, leve);

% 生成每一层的滤波器
for i = 1:leve
    % 每层滤波器尺寸随层次递增
    svtk{i} = zeros(5 + 4 * (i - 1), 5 + 4 * (i - 1));
    for x = 1:5
        for y = 1:5
            svtk{i}(x + (i - 1) * (x - 1), y + (i - 1) * (y - 1)) = Ker(x, y);
        end
    end
end

% 将图像转换为双精度浮点数
temp = double(img);

% 逆向进行每一层的滤波分解
for i = leve + 1:-1:2
    re{i} = imfilter(temp, svtk{leve + 2 - i}, 'replicate', 'same', 'conv');
    temp = temp-re{i};
end

% 将最后的残差存储在第一层
re{1} = temp;
end

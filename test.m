ms = imread('仿真MS-PAN图片\1-m.jpg');  % 多光谱图像（RGB）
pan = imread('仿真MS-PAN图片\1-p.jpg');  % 全色图像（灰度图）

% 调用AMSD函数进行图像融合
fused_image = AMSD(ms, pan, 'hsi', 'av', 4, 1);

% 显示融合结果
imshow(fused_image);
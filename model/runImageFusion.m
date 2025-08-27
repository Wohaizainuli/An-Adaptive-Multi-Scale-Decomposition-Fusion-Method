function runImageFusion(panImagePath, msImagePath, colorSpace)
    % runImageFusion 调用AMSD函数来融合全色和多光谱图像
    % 输入:
    % panImagePath - 全色图像的路径
    % msImagePath - 多光谱图像的路径
    % colorSpace - 要使用的颜色空间 ('hsi', 'hsv', 'lab', 'yuv', 'hsl')

    % 读取全色和多光谱图像
    pan = imread(panImagePath);
    ms = imread(msImagePath);

    % 确保全色图像为灰度图
    if size(pan, 3) > 1
        pan = rgb2gray(pan);
    end

    % 调用AMSD函数进行图像融合
    fusedImage = AMSD(ms, pan, colorSpace, 'av', 4, 1);  % 使用默认融合规则和参数

    % 显示原始和融合后的图像
    figure;
    subplot(1, 3, 1);
    imshow(ms);
    title('Multi-Spectral Image');

    subplot(1, 3, 2);
    imshow(pan);
    title('Panchromatic Image');

    subplot(1, 3, 3);
    imshow(fusedImage);
    title(['Fused Image (' colorSpace ')']);
end

function fusedImage = display_fusion_results(panImagePath, msImagePath, csc, le)
    % 读取图像
    pan = imread(panImagePath);
    ms = imread(msImagePath);

    % 检查颜色空间和层数输入是否正确
    if ~ismember(csc, {'hsi', 'hsv', 'lab', 'yuv', 'hsl'})
        error('Unsupported color space. Please use ''hsi'', ''hsv'', ''lab'', ''yuv'', or ''hsl''.');
    end
    if ~isnumeric(le) || le < 1
        error('Layer (le) must be a positive integer.');
    end

    % 调用AMSD函数进行图像融合
    fusedImage = AMSD(ms, pan, csc, 'av', le, 1); % 我们假设融合规则始终为'平均值'，标准差为1
end

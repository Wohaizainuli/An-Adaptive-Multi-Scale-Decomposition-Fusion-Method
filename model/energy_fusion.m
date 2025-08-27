function re = energy_fusion(lfm, lfp, windowSize)
    % 根据区域能量进行图像融合，使用滑动窗口计算局部能量
    % 输入参数：
    % lfm, lfp - 两个图像层
    % windowSize - 窗口大小，默认为图像的1/20

    % 确保图像大小相同
    assert(all(size(lfm) == size(lfp)), 'Images must be of the same size.');

    % 如果未指定窗口大小，则根据图像大小动态设置
    if nargin < 3
        windowSize = max(5, round(min(size(lfm, 1), size(lfm, 2)) / 20));
    end

    % 初始化结果图像
    re = zeros(size(lfm), 'like', lfm);

    % 滑动窗口遍历图像
    for i = 1:size(lfm, 1) - windowSize + 1
        for j = 1:size(lfm, 2) - windowSize + 1
            % 提取当前窗口
            windowLFM = lfm(i:i+windowSize-1, j:j+windowSize-1);
            windowLFP = lfp(i:i+windowSize-1, j:j+windowSize-1);

            % 计算窗口内的能量
            energyLFM = sum(windowLFM(:).^2);
            energyLFP = sum(windowLFP(:).^2);

            % 根据能量大小选择像素
            if energyLFM > energyLFP
                re(i:i+windowSize-1, j:j+windowSize-1) = windowLFM;
            else
                re(i:i+windowSize-1, j:j+windowSize-1) = windowLFP;
            end
        end
    end
end

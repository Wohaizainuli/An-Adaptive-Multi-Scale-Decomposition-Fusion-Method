function flf = DWT_fusion(lfm, lfp)
    % 使用Haar小波对两幅图像进行融合
    waveletType = 'haar';

    % 对两幅图像进行二维小波分解
    [cA1, cH1, cV1, cD1] = dwt2(lfm, waveletType);
    [cA2, cH2, cV2, cD2] = dwt2(lfp, waveletType);

    % 融合低频部分（平均）
    cAfused = (cA1 + cA2) / 2;

    % 融合高频部分（选择最大值）
    cHfused = max(cH1, cH2);
    cVfused = max(cV1, cV2);
    cDfused = max(cD1, cD2);

    % 使用融合后的小波系数重构图像
    flf = idwt2(cAfused, cHfused, cVfused, cDfused, waveletType);
end

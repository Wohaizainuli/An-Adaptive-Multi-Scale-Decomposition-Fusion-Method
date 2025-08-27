function re = AMSD(ms, pan, csc, rul, le, sd)


    % 参数检查和默认值设置
    if nargin < 2 || nargin > 6
        error('Incorrect number of input parameters.');
    end
    if nargin < 3, csc = 'hsi'; end
    if nargin < 4, rul = 'av'; end
    if nargin < 5, le = 4; end
    if nargin < 6, sd = 1; end

    % 彩色图像转灰度处理
    if size(pan, 3) ~= 1
        pan = rgb2gray(pan);
    end

    % 颜色空间转换
    switch csc
        case 'hsi', csd = myrgb2hsi(ms);
        case 'hsv', csd = myrgb2hsv(ms);
        case 'lab', csd = myrgb2lab(ms);
        case 'yuv', csd = myrgb2yuv(ms);
        case 'hsl', csd = myrgb2hsl(ms);
        otherwise, error('Unsupported color space.');
    end

    % 将全色图像转换为双精度浮点型
    pan = im2double(pan);

    % 提取亮度或值分量
    if any(strcmp(csc, {'yuv', 'lab'}))
        lfm = csd(:,:,1);  % YUV或LAB的第一通道为亮度
    else
        lfm = csd(:,:,3);  % 其他的第三通道为亮度或值
    end

    % 亮度匹配
    pan = gray_balance(pan, lfm);

    % 开始计时
    tic;

    % 计算相似度并获取局部统计数据
    dfs = alfs(lfm, pan);
    [le, sd] = getls(dfs, le, sd);
    if length(le) > 1
        [le, idx] = max(le);
        sd = sd(idx);
    end

    % 局部统计处理
    if ~isempty(le) && ~isempty(sd)
        decp = mydec(pan, le, sd);
        lfp = decp{1};

        % 根据融合规则处理
        switch rul
            case 'av'
                flf = av(lfm, lfp);
            case 'max'
                flf = max_fusion(lfm, lfp);
            case 'min'
                flf = min_fusion(lfm, lfp);
            case 'energy'
                flf = energy_fusion(lfm, lfp);
            case 'PCA'
                flf = pca_fusion(lfm, lfp);
            case 'Similarity'
                flf = Similarity_fusion(lfm, lfp);
            case 'Contrast'
                flf = Contrast_fusion(lfm, lfp);
            otherwise
                error('Unsupported fusion rule.');
        end

        % 替换融合后的分量
        decp{1} = flf;
        switch csc
            case {'yuv', 'lab'}
                csd(:,:,1) = myrec(decp);
            otherwise
                csd(:,:,3) = myrec(decp);
        end

        % 转换回原始颜色空间
        switch csc
            case 'hsi', re = myhsi2rgb(csd);
            case 'hsv', re = myhsv2rgb(csd);
            case 'yuv', re = myyuv2rgb(csd);
            case 'lab', re = mylab2rgb(csd);
            case 'hsl', re = myhsl2rgb(csd);
            otherwise, re = [];
        end
        re = im2uint8(re);
    else
        re = [];
    end

    % 结束计时并打印所用时间
    elapsed_time = toc;
    fprintf('Total processing time: %.2f seconds.\n', elapsed_time);
end


function fusedImage = Similarity_fusion(img1, img2, blockSize)
      if nargin < 3
        % 如果没有指定块大小，设置默认大小为图像宽度的1/20
        blockSize = max(8, round(min(size(img1, 1), size(img2, 2)) / 20));
    end

    % 确保图像大小相同
    assert(all(size(img1) == size(img2)), 'Images must be of the same size.');
    
    % 转换图像为灰度，如果它们是彩色的
    if size(img1, 3) == 3
        img1 = rgb2gray(img1);
    end
    if size(img2, 3) == 3
        img2 = rgb2gray(img2);
    end

    % 初始化融合图像
    fusedImage = zeros(size(img1), 'like', img1);
    
    % 图像维度
    [rows, cols] = size(img1);
    
    % 遍历图像块，考虑边界
    for i = 1:blockSize:rows
        for j = 1:blockSize:cols
            % 确保区块不超过图像边界
            endRow = min(i + blockSize - 1, rows);
            endCol = min(j + blockSize - 1, cols);

            block1 = img1(i:endRow, j:endCol);
            block2 = img2(i:endRow, j:endCol);
            
            % 计算块的SSIM
            [ssimVal, ~] = ssim(block1, block2);
            
            % 选择SSIM较高的块进行融合
            if ssimVal > 0.5  % 使用0.5作为阈值，可以根据实际情况调整
                fusedImage(i:endRow, j:endCol) = (block1 + block2) / 2;
            else
                fusedImage(i:endRow, j:endCol) = block1;
            end
        end
    end
end
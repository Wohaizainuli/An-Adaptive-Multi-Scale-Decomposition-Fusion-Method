function re = gray_specify(img1, img2)
[row, col] = size(img1);
P = reshape(img1,[],1);
y1 = reshape(img2,[],1);
P = (P-min(P))/(max(P)-min(P));
P = P*(max(y1)-min(y1))+min(y1);
proportion = max(y1);
P = im2uint8(P/proportion);
y1 = im2uint8(y1/proportion);
P = im2double(histeq(P,imhist(y1)))*proportion;
re = reshape(P,[row, col]);
end
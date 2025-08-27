function re = gray_balance(img1,img2)
img1 = double(img1);
img2 = double(img2);
[row, col] = size(img1);
P = reshape(img1,[],1);
y1 = reshape(img2,[],1);
P = ((max(y1)-min(y1))*(P-min(P)))/(max(P)-min(P))+min(y1); 
re = reshape(P, [row, col]);
end
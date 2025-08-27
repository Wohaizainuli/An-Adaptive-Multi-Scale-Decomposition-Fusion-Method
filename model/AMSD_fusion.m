function re=AMSD_fusion(imgms, imgpan, csc, rul)
if nargin ~= 4
    error('The input is wrong...');
end
if size(imgpan,3) ~= 1
    imgpan=rgb2gray(imgpan);
end
% imgms=double(imgms);
% imgpan=double(imgpan);
switch csc
    case 'HSI'
        csd=myrgb2hsi(imgms);
        lfm=csd(:,:,3);
    case 'HSV'
        csd=myrgb2hsv(imgms);
        lfm=csd(:,:,3);
    case 'HSL'
        csd=myrgb2hsl(imgms);
        lfm=csd(:,:,3);
    case 'Lab'
        csd=rgb2lab(imgms);
        lfm=csd(:,:,1);
    case 'YUV'
        csd=myrgb2yuv(imgms);
        lfm=csd(:,:,1);
end
pan=gray_balance(imgpan,lfm);
dfs=alfs(lfm,pan);
[le,sd]=getls_seven(dfs);
decp=mydec(pan,le,sd);
lfp=decp{1};
switch rul
    case 'av'
        flf=0.5.*(lfm+lfp);
    case 'ldu'
        flf=ldu(lfm,lfp);
    case 'wsldu'
        flf = wsldu(lfm,lfp);
    case 'rp'
        flf = lfm;
    case 'nsp'
        flf = nsp_fusion(lfp, lfm);
end
decp{1}=flf;
switch csc
    case 'HSI'
        csd(:,:,3)=myrec(decp);
        re=myhsi2rgb(csd);
    case 'HSV'
        csd(:,:,3)=myrec(decp);
        re=myhsv2rgb(csd);
    case 'HSL'
        csd(:,:,3)=myrec(decp);
        re=myhsl2rgb(csd);
    case 'Lab'
        csd(:,:,1)=myrec(decp);
        re=lab2rgb(csd);
    case 'YUV'
        csd(:,:,1)=myrec(decp);
        re=myyuv2rgb(csd);
end
re=im2uint8(re);
end
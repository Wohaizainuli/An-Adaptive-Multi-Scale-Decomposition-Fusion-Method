clc;
clear all;
filep='仿真MS-PAN图片';
imgnum=[1:90];
imglong=length(imgnum);
data=[];
for le=1:7
    for sd=0.4:0.1:3.5
        tre=0;
        for num=1:imglong
            filename=sprintf('%s/%d-p.jpg',filep,imgnum(num));
            img=imread(filename);
            if size(img,3)~=1
                img=rgb2gray(img);
            end
            img=double(img);
            dec=mydec(img,le,sd);
            tre=tre+alfs(dec{1},img);
            inf=sprintf('(%d,%d,%.1f) finished...',imgnum(num),le,sd);
            disp(inf);
        end
        re=tre/num;
        temp=[le, sd, re];
        data=[data;temp];
    end
end
xlswrite('data2.xlsx', data);
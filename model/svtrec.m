function re = svtrec(dec)
% �ع�������ͨ���ۼӶ��ͼ������ϳ�һ��ͼ��
% ���������
% dec - �������ͼ���ĵ�Ԫ����

% ���������������Ƿ���ȷ
if nargin ~= 1
    error('wrong number of input ... ');
end

% ��ȡ����������
leve = length(dec);

% ��ʼ�����ͼ��Ϊ��һ��ͼ���Ĵ�С��ֵΪ0
re = zeros(size(dec{1}));

% ��������ͼ��㣬�ۼӵ����ͼ��
for i = 1:leve
    re = re + dec{i};
end
end

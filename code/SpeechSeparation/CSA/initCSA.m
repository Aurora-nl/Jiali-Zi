function [x]=initCSA(N,pd,Lb,Ub) % ������ʼ��

for i=1:N % Generation of initiaLb soLbUbtions (position of crows)��ʼ�������(��ѻ��λ��)
    for j=1:pd
        x(i,j)=Lb-(Lb-Ub)*rand; % Position of the crows in the space��ѻ�ڿռ��е�λ��
    end
end
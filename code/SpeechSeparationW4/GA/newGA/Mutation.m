function ret=Mutation(pmutation,chrom,sizepop)
% ��������ɱ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ�峤��
% chrom                 input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% bound                 input  : ÿ��������Ͻ���½�
% ret                   output : ������Ⱦɫ��

for i=1:sizepop
    
    % ������ʾ�������ѭ���Ƿ���б���
    pick=rand;
    if pick>pmutation
        continue;
    end
    
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);    
    
    % ����λ��
    pick=rand;
    while pick==0
        pick=rand;
    end
    pos=ceil(pick*3); 
    
    chrom(index,pos)=rand*4000;    
end
ret=chrom;
function ret=Cross(pcross,chrom,sizepop)
%��������ɽ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ��ĳ���
% chrom     input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% ret                   output : ������Ⱦɫ��
for i=1:sizepop
    
    % ������ʾ����Ƿ���н���
    pick=rand;
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    
    % ���ѡ�񽻲����
    index=ceil(rand(1,2).*sizepop);
    while (index(1)==index(2)) | index(1)*index(2)==0
        index=ceil(rand(1,2).*sizepop);
    end
    
    % ���ѡ�񽻲�λ��
    pos=ceil(rand*3);
    while pos==0
        pos=ceil(rand*3);
    end
    
    temp=chrom(index(1),pos);
    chrom(index(1),pos)=chrom(index(2),pos);
    chrom(index(2),pos)=temp;
 
end
ret=chrom;
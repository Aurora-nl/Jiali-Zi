function ret=Select(individuals,sizepop)
% ��������ÿһ����Ⱥ�е�Ⱦɫ�����ѡ���Խ��к���Ľ���ͱ���
% individuals input  : ��Ⱥ��Ϣ
% sizepop     input  : ��Ⱥ��ģ
% ret         output : ����ѡ������Ⱥ



sumfitness=sum(individuals.fitness);
sumf=(individuals.fitness)./sumfitness;
index=[];

for i=1:sizepop   %תsizepop������
    pick=rand;
    while pick==0    
        pick=rand;        
    end
    for i=1:sizepop    
        pick=pick-sumf(i);        
        if pick<0        
            index=[index i];            
            break;  
        end
    end
end
individuals.chrom=individuals.chrom(index,:);
individuals.fitness=individuals.fitness(index);
ret=individuals;
 
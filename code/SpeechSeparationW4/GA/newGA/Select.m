function ret=Select(individuals,sizepop)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异
% individuals input  : 种群信息
% sizepop     input  : 种群规模
% ret         output : 经过选择后的种群



sumfitness=sum(individuals.fitness);
sumf=(individuals.fitness)./sumfitness;
index=[];

for i=1:sizepop   %转sizepop次轮盘
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
 
function ret=Mutation(pmutation,chrom,sizepop)
% 本函数完成变异操作
% pcorss                input  : 变异概率
% lenchrom              input  : 染色体长度
% chrom                 input  : 染色体群
% sizepop               input  : 种群规模
% bound                 input  : 每个个体的上届和下届
% ret                   output : 变异后的染色体

for i=1:sizepop
    
    % 变异概率决定该轮循环是否进行变异
    pick=rand;
    if pick>pmutation
        continue;
    end
    
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);    
    
    % 变异位置
    pick=rand;
    while pick==0
        pick=rand;
    end
    pos=ceil(pick*3); 
    
    chrom(index,pos)=rand*4000;    
end
ret=chrom;
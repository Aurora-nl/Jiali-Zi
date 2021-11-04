function ret=Cross(pcross,chrom,sizepop)
%本函数完成交叉操作
% pcorss                input  : 交叉概率
% lenchrom              input  : 染色体的长度
% chrom     input  : 染色体群
% sizepop               input  : 种群规模
% ret                   output : 交叉后的染色体
for i=1:sizepop
    
    % 交叉概率决定是否进行交叉
    pick=rand;
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    
    % 随机选择交叉个体
    index=ceil(rand(1,2).*sizepop);
    while (index(1)==index(2)) | index(1)*index(2)==0
        index=ceil(rand(1,2).*sizepop);
    end
    
    % 随机选择交叉位置
    pos=ceil(rand*3);
    while pos==0
        pos=ceil(rand*3);
    end
    
    temp=chrom(index(1),pos);
    chrom(index(1),pos)=chrom(index(2),pos);
    chrom(index(2),pos)=temp;
 
end
ret=chrom;
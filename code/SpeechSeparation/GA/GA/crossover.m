%% 子函数
%
%题  目：Crossover
%
%%
%输   入：
%           parentsPop       上一代种群
%           NUMPOP           种群大小
%           CROSSOVERRATE    交叉率
%输   出：
%           kidsPop          下一代种群
%
%% 
% function kidsPop = Crossover(parentsPop,NUMPOP,CROSSOVERRATE)
% kidsPop = {[]};n = 1;
% while size(kidsPop,2)< NUMPOP-size(parentsPop,2)
%     %选择出交叉的父代和母代
%     father = parentsPop{1,ceil((size(parentsPop,2)-1)*rand)+1};
%     mother = parentsPop{1,ceil((size(parentsPop,2)-1)*rand)+1};
%     %随机产生交叉位置
%     crossLocation = ceil((length(father)-1)*rand)+1;
%     %如果随即数比交叉率低，就杂交
%     if rand<CROSSOVERRATE
%         father(1,crossLocation:end) = mother(1,crossLocation:end);
%         kidsPop{n} = father;
%         n = n+1;
%     end
% end
% end

function kidsPop = crossover(parentsPop,NUMPOP,CROSSOVERRATE)
kidsPop = {[]};n = 1;
    while size(kidsPop,1) < NUMPOP-size(parentsPop,1)
        for i = 1:2
            %选择出交叉的父代和母代
            father = parentsPop{ceil((size(parentsPop,1)-1)*rand)+1,i};
            mother = parentsPop{ceil((size(parentsPop,1)-1)*rand)+1,i};
            %随机产生交叉位置
            crossLocation = ceil((length(father)-1)*rand)+1;
            %如果随即数比交叉率低，就杂交
            if rand < CROSSOVERRATE
                father(1,crossLocation:end) = mother(1,crossLocation:end);
                kidsPop{n,i} = father;
            else
                kidsPop{n,i} =  parentsPop{n,i};
            end
        end
        n = n+1;
     end
end

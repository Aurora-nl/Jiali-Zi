%% �Ӻ���
%
%��  Ŀ��Crossover
%
%%
%��   �룺
%           parentsPop       ��һ����Ⱥ
%           NUMPOP           ��Ⱥ��С
%           CROSSOVERRATE    ������
%��   ����
%           kidsPop          ��һ����Ⱥ
%
%% 
% function kidsPop = Crossover(parentsPop,NUMPOP,CROSSOVERRATE)
% kidsPop = {[]};n = 1;
% while size(kidsPop,2)< NUMPOP-size(parentsPop,2)
%     %ѡ�������ĸ�����ĸ��
%     father = parentsPop{1,ceil((size(parentsPop,2)-1)*rand)+1};
%     mother = parentsPop{1,ceil((size(parentsPop,2)-1)*rand)+1};
%     %�����������λ��
%     crossLocation = ceil((length(father)-1)*rand)+1;
%     %����漴���Ƚ����ʵͣ����ӽ�
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
            %ѡ�������ĸ�����ĸ��
            father = parentsPop{ceil((size(parentsPop,1)-1)*rand)+1,i};
            mother = parentsPop{ceil((size(parentsPop,1)-1)*rand)+1,i};
            %�����������λ��
            crossLocation = ceil((length(father)-1)*rand)+1;
            %����漴���Ƚ����ʵͣ����ӽ�
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

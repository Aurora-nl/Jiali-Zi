function fitness = PsoFitness(S)
    fitness=0;
    j = size(S,1);
     %ȡS�ĵ�j�з���
    for i = 1:j
       si = S(i,:);
       f=(1/48*(mean(si.^4)/(mean(si.^2).^2 -3)));
       fitness = fitness+f;
    end
end


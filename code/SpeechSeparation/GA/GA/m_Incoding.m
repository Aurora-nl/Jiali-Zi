function pop=m_Incoding(binPop,irange_l)
%% ����
popNum = 4;%Ⱦɫ������Ĳ�������
for n=1:size(binPop,1)
    for j = 1:size(binPop,2)
        Matrix = binPop{n,j};
        pop(n,j) = bin2dec(Matrix);
    end
end
pop = pop./10^6+irange_l;
end
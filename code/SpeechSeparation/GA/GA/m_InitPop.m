function pop=m_InitPop(numpop,D,irange_l,irange_r)
%% ��ʼ����Ⱥ
%  ���룺numpop--��Ⱥ��С��
%       [irange_l,irange_r]--��ʼ��Ⱥ���ڵ�����
pop=[];
for i=1:numpop
    for j = 1:D
        pop(i,j)=irange_l+(irange_r-irange_l)*rand;
    end
end
end
    
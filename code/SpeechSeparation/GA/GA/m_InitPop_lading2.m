function pop=m_InitPop_lading2(P,D,irange_l,irange_r)
    %% ��ʼ����Ⱥ
    %  ���룺numpop--��Ⱥ��С��
    %       [irange_l,irange_r]--��ʼ��Ⱥ���ڵ�����
    pop=[];
    Q = lhsdesigncon(P,D,[irange_l irange_l irange_l irange_l],[irange_r irange_r irange_r irange_r]);
    pop = Q;  
end
    
function pop=m_InitPop_lading1(P,D,irange_l,irange_r)
    %% ��ʼ����Ⱥ
    %  ���룺numpop--��Ⱥ��С��
    %       [irange_l,irange_r]--��ʼ��Ⱥ���ڵ�����
    pop=[];
    Q = lading( P,D,irange_l,irange_r );
    pop = Q;  
end
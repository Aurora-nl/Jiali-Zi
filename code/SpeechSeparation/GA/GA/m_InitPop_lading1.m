function pop=m_InitPop_lading1(P,D,irange_l,irange_r)
    %% 初始化种群
    %  输入：numpop--种群大小；
    %       [irange_l,irange_r]--初始种群所在的区间
    pop=[];
    Q = lading( P,D,irange_l,irange_r );
    pop = Q;  
end
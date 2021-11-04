function [W1,Emax,max_fitness,Fit,Yfinal,sepresults,YYY] = GA_mainfunctionW4(s,X,rt,upload)
%%遗传参数设置
P=200;%初始种群大小
irange_l=-1; %问题解区间
irange_r=1;
LENGTH=22; %二进制编码长度
ITERATION = 50;%迭代次数
CROSSOVERRATE = 0.7;%杂交率
SELECTRATE = 0.5;%选择率
VARIATIONRATE = 0.001;%变异率
D = 4 ; %空间维数

%初始化种群
pop=m_InitPop(P,D,irange_l,irange_r);
pop_save = pop;
max_fitness = inf;
Emax = 0;
plotOpt=1;

fprintf('s: %g For %g time:\n ',s,rt);
%开始迭代
for time=1:ITERATION  
     if mod(time,30)
       fprintf('%g ',time);
    else 
       fprintf('%g \n',time);
    end
    if time==ITERATION  
        fprintf('\n');
    end
    
    [fitness,W]= m_Fitness(pop,P,X);
    time_max_fitness = max(fitness);
    
    if time_max_fitness < max_fitness
        max_fitness = time_max_fitness;
        W1 = W;
        Emax = time;
    end
    Fit(rt,time) = max_fitness;
    record(time) = max_fitness;%最大值记录
    %计算初始种群的适应度
    %选择
    pop=m_Select(fitness,pop,SELECTRATE);
    
    %编码
    binpop=m_Coding(pop,LENGTH,irange_l);
    
    %交叉
    kidsPop = crossover(binpop,P,CROSSOVERRATE);
  
    %变异
    kidsPop = Variation(kidsPop,VARIATIONRATE);
    
    %解码
    kidsPop=m_Incoding(kidsPop,irange_l);
    
    %更新种群 
    pop = [pop;kidsPop];  
    mybestresult(1).fitness(time,:)=max_fitness;
    mybestresult(1).postion(time,:)=reshape(W1,1,4);
end
 figure(7);plot(record,'LineWidth',2);title('GA收敛过程');
  xlabel('e','fontname','Times New Roman','fontsize',9);
  ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on
 
 fig7 = sprintf( '7shoulian%d',rt);
 exportgraphics(gcf,[upload,'\4GA\',fig7,'.jpg'],'Resolution',600);
%    saveas(gcf,[upload,'\4GA\',fig7,'.jpg']);
   upload1 = [upload,'4GA\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,mybestresult,X,plotOpt,upload1);
   
    save([upload,'4GA\GA02']);
end
    
    



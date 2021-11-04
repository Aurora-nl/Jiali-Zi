function [W1,Emax] = myself(X)

%%遗传参数设置
P=100;%初始种群大小
irange_l=-1; %问题解区间
irange_r=2;
LENGTH=22; %二进制编码长度
ITERATION = 100;%迭代次数
CROSSOVERRATE = 0.7;%杂交率
SELECTRATE = 0.5;%选择率
VARIATIONRATE = 0.001;%变异率

%初始化种群
pop=m_InitPop(P,irange_l,irange_r);
pop_save = pop;
max_fitness = 0;
W1 = rand(2);
Emax = 0;
% hold on
% for i=1:size(pop,2)
%     plot(pop(i),m_Fx(pop(i)),'ro');
% end
% hold off
% title('初始种群');

%开始迭代
for time=1:ITERATION    
     if time > 1
       for o = 2:P
           W = rand(2);
           Data{o} = W;
       end
    else
       for o = 1:P
            W=rand(2);
            Data{o}= W; %将矩阵存储进元胞数组中
       end  
     end
    fs = 0 ;   %总适应度
   
   % 共有P个W，所以提取P次 
   for o = 1:P
       W = Data{o};
       Y = W*X;
       j = size(Y,1);
       %取Y的第j列分量
       for i = 1:j
           yi = Y(i,:);
           %f = f(yi);
           %f=(1/48*(mean(yi.^4)/(mean(yi.^2).^2 -3)));
           %f =(0.001*(1/48)*((mean(yi.^4)/(mean(yi.^2)^2))-3));   
           f = abs((mean(yi.^4)-3*mean(yi.^2).^2));
           %fs = abs(fs+f);
           fs = fs+f;
       end
        if fs > max_fitness
            max_fitness = fs;
            W1 = W;
            Emax = time;
            Data{1} = W1;
        end
   end
    record(time) = max_fitness;%最大值记录
    pause(0.001)
    figure(8)
    plot(time,max_fitness,'ro');
    title('fitness');xlabel('time','fontname','Times New Roman','fontsize',9);
    ylabel('fitness','fontname','Times New Roman','fontsize',9);
    
    %计算初始种群的适应度
    fitness=fs;
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
    pop = [pop kidsPop];
end
 figure(10);plot(record);title('收敛过程') 
% figure
% x=linspace(-1,2,1000);
% y=m_Fx(x);
% plot(x,y);
% hold on
%画图
% for i=1:size(pop,2)
%     plot(pop(i),m_Fx(pop(i)),'ro');
% end
hold off
end
    
    



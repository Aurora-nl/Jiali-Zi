function [W1,Emax,max_fitness,Fit,Yfinal,sepresults,YYY] = GA_mainfunctionW4(s,X,rt,upload)
%%�Ŵ���������
P=200;%��ʼ��Ⱥ��С
irange_l=-1; %���������
irange_r=1;
LENGTH=22; %�����Ʊ��볤��
ITERATION = 50;%��������
CROSSOVERRATE = 0.7;%�ӽ���
SELECTRATE = 0.5;%ѡ����
VARIATIONRATE = 0.001;%������
D = 4 ; %�ռ�ά��

%��ʼ����Ⱥ
pop=m_InitPop(P,D,irange_l,irange_r);
pop_save = pop;
max_fitness = inf;
Emax = 0;
plotOpt=1;

fprintf('s: %g For %g time:\n ',s,rt);
%��ʼ����
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
    record(time) = max_fitness;%���ֵ��¼
    %�����ʼ��Ⱥ����Ӧ��
    %ѡ��
    pop=m_Select(fitness,pop,SELECTRATE);
    
    %����
    binpop=m_Coding(pop,LENGTH,irange_l);
    
    %����
    kidsPop = crossover(binpop,P,CROSSOVERRATE);
  
    %����
    kidsPop = Variation(kidsPop,VARIATIONRATE);
    
    %����
    kidsPop=m_Incoding(kidsPop,irange_l);
    
    %������Ⱥ 
    pop = [pop;kidsPop];  
    mybestresult(1).fitness(time,:)=max_fitness;
    mybestresult(1).postion(time,:)=reshape(W1,1,4);
end
 figure(7);plot(record,'LineWidth',2);title('GA��������');
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
    
    



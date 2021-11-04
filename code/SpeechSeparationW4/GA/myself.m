function [W1,Emax] = myself(X)

%%�Ŵ���������
P=100;%��ʼ��Ⱥ��С
irange_l=-1; %���������
irange_r=2;
LENGTH=22; %�����Ʊ��볤��
ITERATION = 100;%��������
CROSSOVERRATE = 0.7;%�ӽ���
SELECTRATE = 0.5;%ѡ����
VARIATIONRATE = 0.001;%������

%��ʼ����Ⱥ
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
% title('��ʼ��Ⱥ');

%��ʼ����
for time=1:ITERATION    
     if time > 1
       for o = 2:P
           W = rand(2);
           Data{o} = W;
       end
    else
       for o = 1:P
            W=rand(2);
            Data{o}= W; %������洢��Ԫ��������
       end  
     end
    fs = 0 ;   %����Ӧ��
   
   % ����P��W��������ȡP�� 
   for o = 1:P
       W = Data{o};
       Y = W*X;
       j = size(Y,1);
       %ȡY�ĵ�j�з���
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
    record(time) = max_fitness;%���ֵ��¼
    pause(0.001)
    figure(8)
    plot(time,max_fitness,'ro');
    title('fitness');xlabel('time','fontname','Times New Roman','fontsize',9);
    ylabel('fitness','fontname','Times New Roman','fontsize',9);
    
    %�����ʼ��Ⱥ����Ӧ��
    fitness=fs;
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
    pop = [pop kidsPop];
end
 figure(10);plot(record);title('��������') 
% figure
% x=linspace(-1,2,1000);
% y=m_Fx(x);
% plot(x,y);
% hold on
%��ͼ
% for i=1:size(pop,2)
%     plot(pop(i),m_Fx(pop(i)),'ro');
% end
hold off
end
    
    



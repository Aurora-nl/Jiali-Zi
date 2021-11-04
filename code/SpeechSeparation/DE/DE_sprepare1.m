function [W1,Emax,fitness_max,Fit,Yfinal,sepresults,YYY] = DE_sprepare1(s,X,rt,upload)  
% t0 = cputime;  
%��ֽ����㷨����  
%F0�Ǳ����� %Gm ����������  
Gm = 50;  
F0 = 0.5;  
Np = 200;  
CR = 0.9;  %�������  
G = 1; %��ʼ������  
D = 2; %���������ά��  
Gmax = zeros(1,Gm); %����������ֵ  
best_x = zeros(Gm,D); %���������Ž�  
value = zeros(1,Np);  
fitness_max = inf;
xmin = -1;  
xmax =1; 
plotOpt=1;

X0 = (xmax-xmin)*rand(Np,D) + xmin;  %����Np��Dά����  
XG = X0; 
%%%%%%%%%%%%%----����δ�����ۣ����ж���ֹ����----%%%%%%%%%%%%%%%%%%%%%%%%  
  
XG_next_1= zeros(Np,D); %��ʼ��  
XG_next_2 = zeros(Np,D);  
XG_next = zeros(Np,D);  
  
fprintf('s: %g For %g time:\n ',s,rt);
for G =1:Gm  
    if mod(G,30)
       fprintf('%g ',G);
    else 
       fprintf('%g \n',G);
    end
    if G==Gm  
        fprintf('\n');
    end
%%%%%%%%%%%%%%%%%%%%%%%%----�������----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i = 1:Np  
        %����j,k,p������ͬ����  
        a = 1;  
        b = Np;  
        dx = randperm(b-a+1) + a- 1;  
        j = dx(1);  
        k = dx(2);  
        p = dx(3);  
        %Ҫ��֤��i��ͬ  
        if j == i  
            j  = dx(4);  
            else if k == i  
                 k = dx(4);  
                else if p == i  
                    p = dx(4);  
                    end  
                end  
         end  
          
        %��������  
        suanzi = exp(1-Gm/(Gm + 1-G));  
        F = F0*2.^suanzi;  
        %����ĸ������������������  
         
        son = XG(p,:) + F*(XG(j,:) - XG(k,:));         
        for j = 1: D  
            if son(1,j) >xmin  & son(1,j) < xmax %��ֹ���쳬���߽�  
                XG_next_1(i,j) = son(1,j);  
            else  
                XG_next_1(i,j) = (xmax - xmin)*rand(1) + xmin;  
            end  
        end  
    end  
   %%%%%%%%%%%%%%%%%%%%%%%---�������----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
      
      
    for i = 1: Np  
        randx = randperm(D);% [1,2,3,...D]���������     
        for j = 1: D  
              
            if rand > CR & randx(1) ~= j % CR = 0.9   
                XG_next_2(i,j) = XG(i,j);  
            else  
                XG_next_2(i,j) = XG_next_1(i,j);  
            end  
        end  
    end  
      
    %%%%%%%%%%%%%%%%%%----ѡ�����---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  

    for o = 1:Np  
        W22 = XG_next_2(o,:);
%         W2 = reshape(W22,2,2);
        W2=[W22;fliplr(W22)];
%         f_XG_next_2 =  FitnessFunNew(W2,X);
          f_XG_next_2 =  FitnessFun(W2,X);
        fXGNext2(o) = f_XG_next_2; 

       WW = XG(o,:);
%        W = reshape(WW,2,2);
        W1=[WW;fliplr(WW)];
%         f_XG =  FitnessFunNew(W1,X);
        f_XG =  FitnessFun(W1,X);
        fXG(o) = f_XG;
        
        if f_XG_next_2 < f_XG     
            XG_next(o,:) = XG_next_2(o,:);  
        else  
            XG_next(o,:) = XG(o,:);  
        end  
    end  
      
    %�ҳ����ֵ

    for o = 1:Np 
       Ww = XG_next(o,:);
%        Ww = reshape(Ww,2,2);
       W=[Ww;fliplr(Ww)];
%        f_XG_next =  FitnessFunNew(W,X);
       f_XG_next =  FitnessFun(W,X);
       value(o) = f_XG_next;
        
    end  
    [value_max,pos_max] = min(value);  
    
    
    %��G���е�Ŀ�꺯�������ֵ  
    Gmax(G) = value_max;
   
    if value_max < fitness_max
        fitness_max = value_max;
        Emax = G;
    end
    
    record(G) = fitness_max;%���ֵ��¼
    Fit(rt,G) = fitness_max;
    mybestresult(1).fitness(G,:)=fitness_max;
    mybestresult(1).postion(G,:)= XG_next(pos_max,:);

    %�������ŵĸ���  
    best_x(G,:) = XG_next(pos_max,:);     
      
    XG = XG_next;      
    trace(G,1) = G;  
    trace(G,2) = value_max;  
    
end  

  [value_max,pos_max] = min(Gmax);  
  best_value = value_max  ;
  best_vector =  best_x(pos_max,:);    
%   W1 = reshape(best_vector,2,2);
    W1=[best_vector;fliplr(best_vector)];
%   fprintf('DE���ĵ�ʱ��Ϊ��%f \n',cputime - t0);  
%   %�������������ź���ֵ֮��Ĺ�ϵͼ    
%   plot(trace(:,1),trace(:,2));  
  figure(7);plot(record,'LineWidth',2);title('DE��������');
  xlabel('e','fontname','Times New Roman','fontsize',9);
  ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on
  
 fig7 = sprintf( '7shoulian%d',rt);
 exportgraphics(gcf,[upload,'\4GA\',fig7,'.jpg'],'Resolution',600);
%  saveas(gcf,[upload,'\7DE\',fig7,'.jpg']);

   upload1 = [upload,'7DE\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,mybestresult,X,plotOpt,upload1);
   save([upload,'7DE\DE02']);
%    saveFileName=strcat(upload1,'GA0701_Seper_Dim2_AMat10_round10_vs_',num2str(rt),'.mat');
%    save(saveFileName,'mybestresult','rt','sepresults');
%  hold off
end
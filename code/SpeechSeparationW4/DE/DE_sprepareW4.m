function [W1,Emax,fitness_max,Fit,Yfinal,sepresults,YYY] = DE_sprepareW4(s,X,rt,upload)   
%��ֽ����㷨����  
%F0�Ǳ����� %Gm ����������  
Gm = 50;  
F0 = 0.5;  
Np = 200;  
CR = 0.9;  %�������  
G= 1; %��ʼ������  
D = 4; %���������ά��  
Gmax = zeros(1,Gm); %����������ֵ  
best_x = zeros(Gm,D); %���������Ž�  
value = zeros(1,Np);  
fitness_max = inf;

%������ʼ��Ⱥ  
%xmin = -10; xmax = 100;%���������½�  
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
    f_XG_next_2 = 0;
    f_XG = 0;
    for o = 1:Np  
        W22 = XG_next_2(o,:);
        W2 = reshape(W22,2,2);
        f_XG_next_2 =  FitnessFunW4(W2,X);
%         f_XG_next_2 =  FitnessFunW4NOXcorr(W2,X);
        fXGNext2(o) = f_XG_next_2; 
        
       WW = XG(o,:);
       W1 = reshape(WW,2,2);
       f_XG =  FitnessFunW4(W1,X);
%        f_XG =  FitnessFunW4NOXcorr(W1,X);
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
       W = reshape(Ww,2,2);
       f_XG_next =  FitnessFunW4(W,X);
%        f_XG_next =  FitnessFunW4NOXcorr(W,X);
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
  W1 = reshape(best_vector,2,2);
  figure(7);plot(record,'LineWidth',2);title('DE��������');
  xlabel('e','fontname','Times New Roman','fontsize',9);
  ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on
  
 fig7 = sprintf( '7shoulian%d',rt);
 exportgraphics(gcf,[upload,'\4GA\',fig7,'.jpg'],'Resolution',600);

   upload1 = [upload,'7DE\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,mybestresult,X,plotOpt,upload1);
   save([upload,'7DE\DE02']);
end
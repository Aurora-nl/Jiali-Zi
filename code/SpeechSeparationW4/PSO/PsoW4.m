function [W1,Emax,fym,Fit,Yfinal,sepresults,YYY] = PsoW4(s,X,rt,upload)
%close all;               %清图 
 %粒子群算法
P = 200 ; %初始种群的个数
d = 4 ; %空间维数
e = 1; %迭代次数
xlimit_min = -50*ones(d,1); %设置位置参数限制
xlimit_max = 50*ones(d,1);
vlimit_min = -1*ones(d,1);%设置速度限制
vlimit_max = 1*ones(d,1);
% limit = [0,20;0,20;0,20;0,20]; %设置位置参数限制
% vlimit = [-1,1;-1,1;-1,1;-1,1]; %设置速度限制
r = 0.9; %惯性权重
c1 = 2; %自我学习因子
c2 = 2;%群体学习因子
iger = 50; %迭代次数
Emax = 0;
plotOpt=1;
Wb = zeros(iger,4);  

%初始种群的位置
for i = 1:d
    for j = 1:P
        x(i,j) = xlimit_min(i) + (xlimit_max(i) - xlimit_min(i)) * rand;%初始种群的位置
        v(i,j) = vlimit_min(i) + (vlimit_max(i) - vlimit_min(i)) * rand;
    end  
end
   
%粒子群算法
% v = rand(d,P); %初始化种群速度
xm = x ; %定义每个个体历史最佳位置
ym = x(:,1) ; %定义种群历史最佳位置

fxm = zeros(P,1); %定义每个个体历史最佳适应度
for p = 1:P
    fxm(p) = inf;
end
fym = inf; %定义种群历史最佳适应度
wxm = zeros(2); %定义每个个体最佳W
wym = zeros(2); %定义种群最佳W
W1 = zeros(2);

for o = 1:P
    W =rand(1,d);
    Wc(o,:) = W;
%     Data{o}= W; %将矩阵存储进元胞数组中
end 

fprintf('s: %g For %g time:\n ',s,rt);

for e = 1:iger
   if mod(e,30)
       fprintf('%g ',e);
    else 
       fprintf('%g \n',e);
    end
    if e==iger  
        fprintf('\n');
    end
    
%    fs = 0 ;   %总适应度
   % 共有P个W，所以提取P次 
   for o = 1:P
       W = Data{o};
%        Fs = FitnessFunW4(W,X);
       Fs = FitnessFunW4NOXcorr(W,X);
       Fs1(o) = Fs;
       
       if Fs < fxm(o)
          fxm(o) = Fs;
          xm(:,o) = x(:,o);  
          wxm = W;
       end 
       
       if  fxm(o) < fym
          fym = fxm(o);
          ym = xm(o);
          Data{1} = W;
          W1 = W;
          Emax = e;
       end            
   end
   v = v * r + c1 * rand * (xm - x) + c2 * rand * (repmat(ym,1,P) - x);% 速度更新
  
%     V1 = v(:,o);
%     V2 = [V1(1,1),V1(1,2);V()]
        %边界速度处理
        for o = 2:P
            v(:,o) = v(:,o) * r + c1 * rand * (xm(:,o) - x(:,o)) + c2 * rand * (ym - x(:,o));% 速度更新 
            V = reshape(v(:,o),2,2);
            W2 = W+V;
            W3 = W2/max(max(abs(W2))); %将矩阵归一化处理
            Data{o}= W3; %将新的矩阵存储进元胞数组中
        end
        for i = 1:d
            for j  = 1:P
                if v(i,j) > vlimit_max(i)
                    v(i,j) = vlimit_max(i);
                end
                if v(i,j)<vlimit_min(i)
                    v(i,j)=vlimit_min(i);
                end
            end
        end

        x = x + v;% 位置更新
        % 边界位置处理 
        for i=1:d
            for j=1:P
                if x(i,j) > xlimit_max(i)
                    x(i,j) = xlimit_max(i);
                end
                if x(i,j)<xlimit_max(i)
                    x(i,j) = xlimit_min(i);
                end
            end
        end
        Fit(rt,e) = fym;
        record(e) = fym;%最大值记录
        Wf=reshape(W1,1,4);
        
        mybestresult(1).fitness(e,:)=fym;
        mybestresult(1).postion(e,:)=Wf;

end
 figure(7);plot(record,'LineWidth',2);title('PSO收敛过程');
 xlabel('e','fontname','Times New Roman','fontsize',9);
 ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on   
   fig7 = sprintf( '7shoulian%d',rt);
   exportgraphics(gcf,[upload,'1PSO\',fig7,'.jpg'],'Resolution',600);
%    saveas(gcf,[upload,'1PSO\',fig7,'.jpg']);
   upload1 = [upload,'1PSO\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,mybestresult,X,plotOpt,upload1);
   
   save([upload,'\1PSO\Pso02']);
%  hold off
end

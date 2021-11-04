function [Wf,Emax,fym,Fit,Yfinal,sepresults,YYY] = Pso(s,X,rt,upload)
%close all;               %��ͼ 
 %����Ⱥ�㷨
P = 200 ; %��ʼ��Ⱥ�ĸ���
d = 2 ; %�ռ�ά��
% e = 1; %��������
xlimit_min = -50*ones(d,1); %����λ�ò�������
xlimit_max = 50*ones(d,1);
vlimit_min = -1*ones(d,1);%�����ٶ�����
vlimit_max = 1*ones(d,1);
% limit = [0,20;0,20;0,20;0,20]; %����λ�ò�������
% vlimit = [-1,1;-1,1;-1,1;-1,1]; %�����ٶ�����
r = 0.9; %����Ȩ��
c1 = 2; %����ѧϰ����
c2 = 2;%Ⱥ��ѧϰ����
iger = 50; %��������
Emax = 0;  
plotOpt=1;
Wb = zeros(iger,2);  

%��ʼ��Ⱥ��λ��
for i = 1:d
    for j = 1:P
        x(i,j) = xlimit_min(i) + (xlimit_max(i) - xlimit_min(i)) * rand;%��ʼ��Ⱥ��λ��
        v(i,j) = vlimit_min(i) + (vlimit_max(i) - vlimit_min(i)) * rand;
    end  
end
   
%����Ⱥ�㷨
% v = rand(d,P); %��ʼ����Ⱥ�ٶ�
xm = x ; %����ÿ��������ʷ���λ��
ym = x(:,1) ; %������Ⱥ��ʷ���λ��

fxm = zeros(P,1); %����ÿ��������ʷ�����Ӧ��
for p = 1:P
    fxm(p) = inf;
end
fym = inf; %������Ⱥ��ʷ�����Ӧ��
wxm = zeros(2); %����ÿ���������W
wym = zeros(2); %������Ⱥ���W
Wf = zeros(2);

for o = 1:P
    W =rand(1,2);
    Wc(o,:) = W;
%     Data{o}= W; %������洢��Ԫ��������
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
    
%    fs = 0 ;   %����Ӧ��
   % ����P��W��������ȡP�� 
   for o = 1:P
       W1 = Wc(o,:);
       W2=[W1;fliplr(W1)];
%        fs = FitnessFunNew(W2,X);
       Fs = FitnessFun(W2,X);
       Fs1(o) = Fs;
       
       if Fs < fxm(o)
          fxm(o) = Fs;
          xm(:,o) = x(:,o);  
%           wxm = W1;
          wxm = W2;
       end 
       
       if  fxm(o) < fym
          fym = fxm(o);
          ym = xm(o);
%           Wc(1,:) = W1;
%           Wf = W1;
            Wf = W2;
          Emax = e;
       end 
   end
   v = v * r + c1 * rand * (xm - x) + c2 * rand * (repmat(ym,1,P) - x);% �ٶȸ���
  
%     V1 = v(:,o);
%     V2 = [V1(1,1),V1(1,2);V()]
        %�߽��ٶȴ���
        for o = 2:P
            v(:,o) = v(:,o) * r + c1 * rand * (xm(:,o) - x(:,o)) + c2 * rand * (ym - x(:,o));% �ٶȸ��� 
            V = reshape(v(:,o),1,2);
            W = W1+V;
            W = W/max(max(abs(W))); %�������һ������
            Wc(o,:)= W; %���µľ���洢��Ԫ��������
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

        x = x + v;% λ�ø���
        % �߽�λ�ô��� 
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
        record(e) = fym;%���ֵ��¼
        mybestresult(1).fitness(e,:)=fym;
        mybestresult(1).postion(e,:)=Wf(1,:);

      Wb(e,:) = Wf(1,:);
end
  figure(7);plot(record,'LineWidth',2);title('PSO��������');
  xlabel('e','fontname','Times New Roman','fontsize',9);
  ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on   
   fig7 = sprintf( '7shoulian%d',rt);
%    exportgraphics(gcf,[upload,'1PSO\',fig7,'.jpg'],'Resolution',600);
   saveas(gcf,[upload,'1PSO\',fig7,'.jpg']);
   upload1 = [upload,'1PSO\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,mybestresult,X,plotOpt,upload1);
   
   save([upload,'\1PSO\Pso02']);
%    saveFileName=strcat(upload1,'PSO0701_Seper_Dim2_AMat10_round10_vs_',num2str(rt),'.mat');
%    save(saveFileName,'mybestresult','rt','sepresults');

%  hold off
end

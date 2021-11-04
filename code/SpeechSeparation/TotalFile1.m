clear
clc
t0=cputime;
Count = 50;
for s =1:Count
close all;
fn1 =  'E:\ZJL\20210822\ZjlSeparation\pepleAudio\fsew0_v1\fsew0_0';
fn2 =  'E:\ZJL\20210822\ZjlSeparation\pepleAudio\maps0\maps0_0';

filename1 = strcat(fn1,num2str(s),'.wav');%Ů
filename2 = strcat(fn2,num2str(s),'.wav');  %��
upload = ['E:\ZJL\result1011001\',num2str(s),'\'];

% ��ȡ��Ƶ,��ȡ��Ƶ
[SS1,Fs1] = audioread(filename1);
[SS2,Fs2] = audioread(filename2);

S1 = SS1(:,1);
S2 = SS2(:,1);

S1 = S1(1:15000,:)';
S2 = S2(10001:25000,:)';

%���ݳ��ȴ���
[m1,n1] = size(S1);
[m2,n2] = size(S2);

S(1,:) = S1;
S(2,:) = S2;

K = 2;
N = n1;
%����Դ�ź�ͼ
figure(1)
subplot(2,1,1);
plot(S(1,:),'r');
set(gca,'fontname','Times New Roman','fontsize',9);
title('Singal 1');
xlabel('time/ms','fontname','Times New Roman','fontsize',9);
ylabel('amplitude','fontname','Times New Roman','fontsize',9);
hold on;

subplot(2,1,2);
plot(S(2,:),'b');
set(gca,'fontname','Times New Roman','fontsize',9);
title('Singal 2');xlabel('time/ms','fontname','Times New Roman','fontsize',9);
ylabel('amplitude','fontname','Times New Roman','fontsize',9);
hold on;

exportgraphics(gcf,[upload,'signal1.jpg'],'Resolution',600);
% saveas(gcf,[upload,'signal1.jpg']);

%���ݻ�ϣ����ɹ۲��ź�
A = (rand(2)-0.5)*2;  
X=A*S;

audiowrite([upload,'X1.wav'],X(1,:),Fs2);
audiowrite([upload,'X2.wav'],X(2,:),Fs2);
% %�������ݣ���������
% Xmax=max(max(abs(X)));
% X = X/Xmax;

%���ƹ۲��ź�ͼ
figure(2);
subplot(2,1,1);
plot(X(1,:),'r');
set(gca,'fontname','Times New Roman','fontsize',9);
title('MixSignal 1','fontname','����','fontsize',9);xlabel('time/ms','fontname','Times New Roman','fontsize',9);
ylabel('amplitude','fontname','Times New Roman','fontsize',9);

subplot(2,1,2);
plot(X(2,:),'b');
set(gca,'fontname','Times New Roman','fontsize',9);
title('MixSignal 2','fontname','����','fontsize',9);xlabel('time/ms','fontname','Times New Roman','fontsize',9);
ylabel('amplitude','fontname','Times New Roman','fontsize',9);
hold on
exportgraphics(gcf,[upload,'MixSignal.jpg'],'Resolution',600);
% saveas(gcf,[upload,'MixSignal.jpg']);


% X �������Ļ�
m=mean(X,2);
% for i=1:N
%     X(:,i)= X(:,i)-m;
% end
X=X-m;
% X ���ݰ׻�
covMat=cov(X');
[E,D]=eig(covMat);
V=E*D^(-0.5)*E';
Z=V*X;
% X=V*X;
% 
Pso = lzqSprepare(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tPSO =cputime-t0;

GA = SprepareGA(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tGA =cputime-t0;

DE = SprepareDE(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tDE =cputime-t0;

SCA = SprepareSCA(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tSCA =cputime-t0;

BOA = SprepareBOA(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tBOA =cputime-t0;

CSA = SprepareCSA(s,Z,S,S1,S2,Fs1,Fs2,filename1,filename2,upload);
tCSA =cputime-t0;
save([upload,'Total01'])
end
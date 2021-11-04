clc
tic
%%������ʼ��
maxgen=99; %������������������������ʼԤ��ֵѡΪ100
sizepop=100; %��Ⱥ��ģ����ʼԤ��ֵѡΪ100
pcross=0.9; %�������ѡ��0��1֮�䣬һ��ȡ0.9
pmutation=0.01; %�������ѡ��0��1֮�䣬һ��ȡ0.01
individuals=struct('fitness',zeros(1,sizepop),'chrom',[]);
individuals
%��Ⱥ����Ⱥ��sizepop��Ⱦɫ��(chrom)��ÿ��Ⱦɫ�����Ӧ��(fitness)���
avgfitness=[];
avgfitness
%��¼ÿһ����Ⱥ��ƽ����Ӧ�ȣ����ȸ���һ��������
bestfitness=[];
bestfitness
%��¼ÿһ����Ⱥ�������Ӧ�ȣ����ȸ���һ��������
bestchrom=[];
bestchrom
%��¼��Ӧ����õ�Ⱦɫ�壬���ȸ���һ��������
%��ʼ����Ⱥ
for i=1:sizepop
%�������һ����Ⱥ
individuals.chrom(i,:)=4000*rand(1,12);
%��12��0~4000�������������Ⱥ�е�һ��Ⱦɫ�壬����K=4����������
x=individuals.chrom(i,:);
%����ÿ��Ⱦɫ�����Ӧ��
individuals.fitness(i)=fitness(x);
end
%%����õ�Ⱦɫ��
[bestfitness bestindex]=max(individuals.fitness);
%�ҳ���Ӧ������Ⱦɫ�壬����¼����Ӧ�ȵ�ֵ(bestfitness)��Ⱦɫ�����ڵ�λ��(bestindex)
bestchrom=individuals.chrom(bestindex,:);
%����õ�Ⱦɫ�帳������bestchrom
avgfitness=sum(individuals.fitness)/sizepop;
%����Ⱥ����Ⱦɫ���ƽ����Ӧ��

trace=[avgfitness bestfitness];
%��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��

for i=1:maxgen
i
%�����������
individuals=Select(individuals,sizepop);
aa='individuals:'
aa
individuals
avgfitness=sum(individuals.fitness)/sizepop;
bb='avgfitness:'
avgfitness
%����Ⱥ����ѡ����������������Ⱥ��ƽ����Ӧ��
individuals.chrom=Cross(pcross,individuals.chrom,sizepop);
individuals.chrom
%����Ⱥ�е�Ⱦɫ����н������
individuals.chrom=Mutation(pmutation,individuals.chrom,sizepop);
cc='individuals.chrom:'
individuals.chrom
%����Ⱥ�е�Ⱦɫ����б������
for j=1:sizepop
x=individuals.chrom(j,:);%����
[individuals.fitness(j)]=fitness(x);
end
%���������Ⱥ��ÿ��Ⱦɫ�����Ӧ��
[newbestfitness,newbestindex]=max(individuals.fitness);
[worestfitness,worestindex]=min(individuals.fitness);
%�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
if bestfitness<newbestfitness
bestfitness=newbestfitness;
bestchrom=individuals.chrom(newbestindex,:);
end
%������һ�ν�������õ�Ⱦɫ��
individuals.chrom(worestindex,:)=bestchrom;
individuals.fitness(worestindex)=bestfitness;
%��̭��Ӧ�����ĸ���
avgfitness=sum(individuals.fitness)/sizepop;
trace=[trace;avgfitness bestfitness];
%��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
figure(1)
plot(trace(:,1),'-*r');
title('��Ӧ�Ⱥ�������(100*100)')
hold on
plot(trace(:,2),'-ob');
legend('ƽ����Ӧ������','�����Ӧ������','location','southeast')
%%������Ӧ�ȱ仯����
clc
%%���������
data1=load('aa.txt');
%�����������
kernal=[bestchrom(1:3);bestchrom(4:6);bestchrom(7:9);bestchrom(10:12)];
%�������Ѿ�������
[n,m]=size(data1);
%������������ݵ�����������
index=cell(4,1);
%��������������
dist=0;
%��������׼����
for i=1:n
dis(1)=norm(kernal(1,:)-data1(i,:));
dis(2)=norm(kernal(2,:)-data1(i,:));
dis(3)=norm(kernal(3,:)-data1(i,:));
dis(4)=norm(kernal(4,:)-data1(i,:));
%����������������е�һ�㵽�����������ĵľ���
[value,index1]=min(dis);
%�ҳ���̾������������ĵ�����
cid(i)=index1;
%������¼���ݱ����ֵ������
index{index1,1}=[index{index1,1} i];
dist=dist+value;
%����׼����
end
cid;
dist;
%%��ͼ
figure(2)
plot3(bestchrom(1),bestchrom(2),bestchrom(3),'ro');
title('result100*100') 
hold on
%������һ��ľ�������
index1=index{1,1};
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'r*')
hold on
end
hold on
%���������ֵ���һ���еĸ���
index1=index{2,1};
plot3(bestchrom(4),bestchrom(5),bestchrom(6),'bo');
hold on
%�����ڶ���ľ�������
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'b*');
grid on;
hold on
end
%���������ֵ��ڶ����еĸ���
index1=index{3,1};
plot3(bestchrom(7),bestchrom(8),bestchrom(9),'go');
hold on
%����������ľ�������
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'g*');
hold on
end
%���������ֵ��������еĸ���
index1=index{4,1};
plot3(bestchrom(10),bestchrom(11),bestchrom(12),'ko');
hold on
%����������ľ�������
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'k*');
hold on
end
%���������ֵ��������еĸ���
toc
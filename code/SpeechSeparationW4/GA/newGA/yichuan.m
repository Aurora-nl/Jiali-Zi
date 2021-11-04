clc
tic
%%参数初始化
maxgen=99; %进化代数，即迭代次数，初始预定值选为100
sizepop=100; %种群规模，初始预定值选为100
pcross=0.9; %交叉概率选择，0和1之间，一般取0.9
pmutation=0.01; %变异概率选择，0和1之间，一般取0.01
individuals=struct('fitness',zeros(1,sizepop),'chrom',[]);
individuals
%种群，种群由sizepop条染色体(chrom)及每条染色体的适应度(fitness)组成
avgfitness=[];
avgfitness
%记录每一代种群的平均适应度，首先赋给一个空数组
bestfitness=[];
bestfitness
%记录每一代种群的最佳适应度，首先赋给一个空数组
bestchrom=[];
bestchrom
%记录适应度最好的染色体，首先赋给一个空数组
%初始化种群
for i=1:sizepop
%随机产生一个种群
individuals.chrom(i,:)=4000*rand(1,12);
%把12个0~4000的随机数赋给种群中的一条染色体，代表K=4个聚类中心
x=individuals.chrom(i,:);
%计算每条染色体的适应度
individuals.fitness(i)=fitness(x);
end
%%找最好的染色体
[bestfitness bestindex]=max(individuals.fitness);
%找出适应度最大的染色体，并记录其适应度的值(bestfitness)和染色体所在的位置(bestindex)
bestchrom=individuals.chrom(bestindex,:);
%把最好的染色体赋给变量bestchrom
avgfitness=sum(individuals.fitness)/sizepop;
%计算群体中染色体的平均适应度

trace=[avgfitness bestfitness];
%记录每一代进化中最好的适应度和平均适应度

for i=1:maxgen
i
%输出进化代数
individuals=Select(individuals,sizepop);
aa='individuals:'
aa
individuals
avgfitness=sum(individuals.fitness)/sizepop;
bb='avgfitness:'
avgfitness
%对种群进行选择操作，并计算出种群的平均适应度
individuals.chrom=Cross(pcross,individuals.chrom,sizepop);
individuals.chrom
%对种群中的染色体进行交叉操作
individuals.chrom=Mutation(pmutation,individuals.chrom,sizepop);
cc='individuals.chrom:'
individuals.chrom
%对种群中的染色体进行变异操作
for j=1:sizepop
x=individuals.chrom(j,:);%解码
[individuals.fitness(j)]=fitness(x);
end
%计算进化种群中每条染色体的适应度
[newbestfitness,newbestindex]=max(individuals.fitness);
[worestfitness,worestindex]=min(individuals.fitness);
%找到最小和最大适应度的染色体及它们在种群中的位置
if bestfitness<newbestfitness
bestfitness=newbestfitness;
bestchrom=individuals.chrom(newbestindex,:);
end
%代替上一次进化中最好的染色体
individuals.chrom(worestindex,:)=bestchrom;
individuals.fitness(worestindex)=bestfitness;
%淘汰适应度最差的个体
avgfitness=sum(individuals.fitness)/sizepop;
trace=[trace;avgfitness bestfitness];
%记录每一代进化中最好的适应度和平均适应度
end
figure(1)
plot(trace(:,1),'-*r');
title('适应度函数曲线(100*100)')
hold on
plot(trace(:,2),'-ob');
legend('平均适应度曲线','最佳适应度曲线','location','southeast')
%%画出适应度变化曲线
clc
%%画出聚类点
data1=load('aa.txt');
%待分类的数据
kernal=[bestchrom(1:3);bestchrom(4:6);bestchrom(7:9);bestchrom(10:12)];
%解码出最佳聚类中心
[n,m]=size(data1);
%求出待聚类数据的行数和列数
index=cell(4,1);
%用来保存聚类类别
dist=0;
%用来计算准则函数
for i=1:n
dis(1)=norm(kernal(1,:)-data1(i,:));
dis(2)=norm(kernal(2,:)-data1(i,:));
dis(3)=norm(kernal(3,:)-data1(i,:));
dis(4)=norm(kernal(4,:)-data1(i,:));
%计算出待聚类数据中的一点到各个聚类中心的距离
[value,index1]=min(dis);
%找出最短距离和其聚类中心的种类
cid(i)=index1;
%用来记录数据被划分到的类别
index{index1,1}=[index{index1,1} i];
dist=dist+value;
%计算准则函数
end
cid;
dist;
%%作图
figure(2)
plot3(bestchrom(1),bestchrom(2),bestchrom(3),'ro');
title('result100*100') 
hold on
%画出第一类的聚类中心
index1=index{1,1};
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'r*')
hold on
end
hold on
%画出被划分到第一类中的各点
index1=index{2,1};
plot3(bestchrom(4),bestchrom(5),bestchrom(6),'bo');
hold on
%画出第二类的聚类中心
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'b*');
grid on;
hold on
end
%画出被划分到第二类中的各点
index1=index{3,1};
plot3(bestchrom(7),bestchrom(8),bestchrom(9),'go');
hold on
%画出第三类的聚类中心
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'g*');
hold on
end
%画出被划分到第三类中的各点
index1=index{4,1};
plot3(bestchrom(10),bestchrom(11),bestchrom(12),'ko');
hold on
%画出第四类的聚类中心
for i=1:length(index1)
plot3(data1(index1(i),1),data1(index1(i),2),data1(index1(i),3),'k*');
hold on
end
%画出被划分到第四类中的各点
toc

function [fitness,W1]=m_Fitness(pop,P,X)
%% Fitness Function
%y=xsin(3x)��[-1,2]�ϣ����ֵҲ���ᳬ��2
%���Լ��㺯��ֵ��2�ľ��룬������Сʱ����Ϊ���Ž�
%��Ӧ�Ⱥ���Ϊ1/����
max_fitness = inf;
W1 = zeros(2);
  for o = 1:P
       W2 = pop(o,:);
       W = reshape(W2,2,2);
       %W = Data{o};
       Y = W*X;
       j = size(Y,1);
       fs = 0;
       %ȡY�ĵ�j�з���
       for i = 1:j
           yi = Y(i,:);
           f = (1/48* ((mean(yi.^4)/(mean(yi.^2).^2))-3));
           fs = fs+f;
       end
        Fs = 1/fs;
       fitness(o) = Fs;
       
       if Fs < max_fitness
            W1 = W;
            max_fitness = Fs;
        end
  end
end

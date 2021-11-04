
function [W1,Emax,fitness_min,Fit,Yfinal,sepresults,YYY] = CSAoptimumW4(Ss,XX,rt,upload)
display('CSA');
dim = 4; % Problem dimension (number of decision variables)
N=200; % Flock (population) size
AP=0.1; % Awareness probability
fl=2; % Flight length (fl)
Lb = -1;
Ub = 1;
plotOpt=1;
Emax = 1;
Max_iteration = 50;

% if(max(size(lb)) == 1 || max(size(ub)) == 1)
%     Lb = lb*ones(1,dim);
%     Ub = ub*ones(1,dim);
% else
%     Lb = lb;
%     Ub = ub;
% end
    
[x]=initCSA(N,dim,Lb,Ub); % Function for initialization

xn=x;
for i = 1:N
     ft(i)=FitnessFunW4(xn(i,:),XX); % Function for fitness evaluation
%      ft(i)=FitnessFunW4NOXcorr(xn(i,:),XX); % Function for fitness evaluation
end

[fitness_min,ii] = min(ft);
W1(1,:) = xn(ii,:);
mem=x; % Memory initialization
fit_mem=ft; % Fitness of memory positions

fprintf('s: %g For %g time:\n ',Ss,rt);

for t=1:Max_iteration
    if mod(t,30)
       fprintf('%g ',t);
    else 
       fprintf('%g \n',t);
    end
    if t==Max_iteration  
        fprintf('\n');
    end
    
    num=ceil(N*rand(1,N)); % Generation of random candidate crows for following (chasing)
    for i=1:N
        if rand>AP
            xnew(i,:)= x(i,:)+fl*rand*(mem(num(i),:)-x(i,:)); % Generation of a new position for crow i (state 1)
        else
            for j=1:dim
                xnew(i,j)=Lb-(Lb-Ub)*rand; % Generation of a new position for crow i (state 2)
            end
        end
    end

    xn=xnew;
    for i = 1:N

        ft(i)=FitnessFunW4(xn(i,:),XX);  % Function for fitness evaluation of new solutions
%         ft(i)=FitnessFunW4NOXcorr(xn(i,:),XX);  % Function for fitness evaluation of new solutions
    end
    for i=1:N % Udimate position and memory
        if xnew(i,:)>=Lb & xnew(i,:)<=Ub
            x(i,:)=xnew(i,:); % Udimate position
            if ft(i)<fit_mem(i)
                mem(i,:)=xnew(i,:); % Udimate memory
                fit_mem(i)=ft(i);
            end
        end
    end
   
    [fitness_mem,mm] = min(fit_mem);
    ffit(t) = min(fit_mem); % Best found value until iteration t
    
    if  fitness_mem < fitness_min
        W1 = mem(mm,:);
        fitness_min = fitness_mem;
        Emax = t;
    end
    
    Fit(rt,t) = fitness_min;
    record(t) = fitness_min;%最MIN值记录
    sepresults(1).fitness(t,:)=fitness_min;
    sepresults(1).postion(t,:)=W1;
end
curve = ffit; %iteration curve
ngbest=find(fit_mem == min(fit_mem));
g_best=mem(ngbest(1),:); % Solutin of the problem
Best_pos = g_best; %best solution
Best_score = ffit(end);%best fitness score


figure(7);plot(record,'LineWidth',2);title('CSA收敛过程');
xlabel('e','fontname','Times New Roman','fontsize',9);
ylabel('fitness','fontname','Times New Roman','fontsize',9);
box off
hold on
 
fig7 = sprintf( '7shoulian%d',rt);
exportgraphics(gcf,[upload,'\13CSA\',fig7,'.jpg'],'Resolution',600); 
% saveas(gcf,[upload,'\13CSA\',fig7,'.jpg']);
upload1 = [upload,'13CSA\'];
[sepresults,Yfinal,YYY] = SepChoose2(rt,sepresults,XX,plotOpt,upload1);
save([upload,'13CSA\CSA02']);

end


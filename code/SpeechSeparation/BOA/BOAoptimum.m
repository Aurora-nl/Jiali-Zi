function [best_pos,Emax,fmin,Fit,Yfinal,sepresults,YYY] = BOAoptimum(Ss,XX,rt,upload)
display('BOA');
p=0.8;                       % probabibility switch
power_exponent=0.1;
sensory_modality=0.01;
n=200; % n is the population size
N_iter=50; % N_iter represnets total number of iterations
Lb = -1;
Ub = 1;
dim = 2;
plotOpt=1;
Emax = 1;

%Initialize the positions of search agents
Sol=initialization(n,dim,Ub,Lb);

for i=1:n
%     Fitness(i)=FitnessFunNew(Sol(i,:),XX);
    Fitness(i)=FitnessFun(Sol(i,:),XX);
end

% Find the current best_pos
[fmin,I]=min(Fitness);
best_pos=Sol(I,:);
S=Sol; 

fprintf('s: %g For %g time:\n ',Ss,rt);
% Start the iterations -- Butterfly Optimization Algorithm 
for t=1:N_iter
  
    if mod(t,30)
       fprintf('%g ',t);
    else 
       fprintf('%g \n',t);
    end
    if t==N_iter  
        fprintf('\n');
    end
    
        for i=1:n % Loop over all butterflies/solutions
         
          %Calculate fragrance of each butterfly which is correlated with objective function
          Fnew(i)=FitnessFun(S(i,:),XX);
          FP=(sensory_modality*(Fnew(i)^power_exponent));   
    
          %Global or local search
          if rand<p  
            dis = rand * rand * best_pos - Sol(i,:);        %Eq. (2) in paper
            S(i,:)=Sol(i,:)+dis*FP;
           else
              % Find random butterflies in the neighbourhood
              epsilon=rand;
              JK=randperm(n);
              dis=epsilon*epsilon*Sol(JK(1),:)-Sol(JK(2),:);
              S(i,:)=Sol(i,:)+dis*FP;                         %Eq. (3) in paper
          end
           
            % Check if the simple limits/bounds are OK
            S(i,:)=simplebounds(S(i,:),Lb,Ub);
          
            % Evaluate new solutions
            Fnew1(i)=FitnessFun(S(i,:),XX);  %Fnew represents new fitness values
            
            % If fitness improves (better solutions found), update then
            if (Fnew1(i)<=Fitness(i))
                Sol(i,:)=S(i,:);
                Fitness(i) = Fnew1(i);
            end
           
           % Update the current global best_pos
           if Fnew1(i) <= fmin
                best_pos=S(i,:);
                fmin=Fnew1(i);
                Emax = t;
           end
           
         end
            
         Convergence_curve(t,1)=fmin;
         
         %Update sensory_modality
          sensory_modality=sensory_modality_NEW(sensory_modality, N_iter);
          
    Fit(rt,t) = fmin;
    record(t) = fmin;%最大值记录
    sepresults(1).fitness(t,:)=fmin;
    sepresults(1).postion(t,:)=best_pos;
end

% Boundary constraints
function s=simplebounds(s,Lb,Ub)
  % Apply the lower bound
  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb;
  
  % Apply the upper bounds 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub;
  % Update this new move 
  s=ns_tmp;
end

  
function y=sensory_modality_NEW(x,Ngen)
y=x+(0.025/(x*Ngen));
end


figure(7);plot(record,'LineWidth',2);title('BOA收敛过程');
xlabel('e','fontname','Times New Roman','fontsize',9);
ylabel('fitness','fontname','Times New Roman','fontsize',9);
box off
hold on
 
fig7 = sprintf( '7shoulian%d',rt);
exportgraphics(gcf,[upload,'\12BOA\',fig7,'.jpg'],'Resolution',600);
% saveas(gcf,[upload,'\12BOA\',fig7,'.jpg']);
upload1 = [upload,'12BOA\'];
[sepresults,Yfinal,YYY] = SepChoose2(rt,sepresults,XX,plotOpt,upload1);
save([upload,'12BOA\BOA02']);

end

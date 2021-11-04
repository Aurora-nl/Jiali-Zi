
function [Destination_position,Emax,Destination_fitness,Fit,Yfinal,sepresults,YYY]=SCAoptimumW4(s,XX,rt,upload)

display('SCA');
N =200; % Number of search agents
Max_iteration=50; % Maximum numbef of iterations
lb = -1;
ub = 1;
dim = 4;
plotOpt=1;

X=initialization(N,dim,ub,lb);

Destination_position=zeros(1,dim);
Destination_fitness=inf;

Convergence_curve=zeros(1,Max_iteration);
Objective_values = zeros(1,N);

fprintf('s: %g For %g time:\n ',s,rt);
% Calculate the fitness of the first set and find the best one
for i=1:size(X,1)
    Objective_values(1,i)=FitnessFunW4(X(i,:),XX);
%     Objective_values(1,i)=FitnessFunW4NOXcorr(X(i,:),XX);
    if i==1
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    
    All_objective_values(1,i)=Objective_values(1,i);
end
    Emax = 1;
    Fit(rt,1) = Destination_fitness;
    record(1) = Destination_fitness;%最大值记录

%Main loop
t=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness
while t<=Max_iteration
    if mod(t,30)
       fprintf('%g ',t);
    else 
       fprintf('%g \n',t);
    end
    if t==Max_iteration  
        fprintf('\n');
    end
    
    % Eq. (3.4)
    a = 2;
    Max_iteration = Max_iteration;
    r1=a-t*((a)/Max_iteration); % r1 decreases linearly from a to 0
    
    % Update the position of solutions with respect to destination
    for i=1:size(X,1) % in i-th solution
        for j=1:size(X,2) % in j-th dimension
            
            % Update r2, r3, and r4 for Eq. (3.3)
            r2=(2*pi)*rand();
            r3=2*rand;
            r4=rand();
            
            % Eq. (3.3)
            if r4<0.5
                % Eq. (3.1)
                X(i,j)= X(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-X(i,j)));
            else
                % Eq. (3.2)
                X(i,j)= X(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-X(i,j)));
            end
            
        end
    end
    
    for i=1:size(X,1)
         
        % Check if solutions go outside the search spaceand bring them back
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        Objective_values(1,i)=FitnessFunW4(X(i,:),XX);
%         Objective_values(1,i)=FitnessFunW4NOXcorr(X(i,:),XX);
        
        % Update the destination if there is a better solution
        if Objective_values(1,i) < Destination_fitness
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
            Emax = t;
        end
    end
    
%     Convergence_curve(t)=Destination_fitness;
    
    % Display the iteration and best optimum obtained so far
    if mod(t,50)==0
        display(['At iteration ', num2str(t), ' the optimum is ', num2str(Destination_fitness)]);
    end
    Fit(rt,t) = Destination_fitness;
    record(t) = Destination_fitness;%最大值记录
    sepresults(1).fitness(t,:)=Destination_fitness;
    sepresults(1).postion(t,:)=Destination_position;
    
    % Increase the iteration counter
    t=t+1;
    
end
  figure(7);plot(record,'LineWidth',2);title('SCA收敛过程');
  xlabel('e','fontname','Times New Roman','fontsize',9);
  ylabel('fitness','fontname','Times New Roman','fontsize',9);
  box off
  hold on
 
 fig7 = sprintf( '7shoulian%d',rt);
    
   exportgraphics(gcf,[upload,'\11SCA\',fig7,'.jpg'],'Resolution',600);
%    saveas(gcf,[upload,'\11SCA\',fig7,'.jpg']);
   upload1 = [upload,'11SCA\'];
   [sepresults,Yfinal,YYY] = SepChoose2(rt,sepresults,XX,plotOpt,upload1);
   save([upload,'11SCA\SCA02']);

end
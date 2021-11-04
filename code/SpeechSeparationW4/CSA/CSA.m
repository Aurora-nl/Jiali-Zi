

% -------------------------------------------------
% Citation details:
% Alireza Askarzadeh, Anovel metaheuristic method for solving constrained
% engineering optimization problems: Crow search algorithm, Computers &
% Structures, Vol. 169, 1-12, 2016.

% Programmed by Alireza Askarzadeh at Kerman Graduate %
% University of Advanced Technology (KGUT) %
% Date of programming: September 2015 %
% -------------------------------------------------
% This demo only implements a standard version of CSA for minimization of
% a standard test function (Sphere) on MATLAB 7.6.0 (R2008a).
% -------------------------------------------------
% Note:
% Due to the stochastic nature of meta-heuristc algorithms, different runs
% may lead to slightly different results.
% -------------------------------------------------

function [Best_pos,Best_score,curve] = CSA(fobj,lb,ub,dim,nPop,Max_iteration)
pd=dim; % Problem dimension (number of decision variables)
N=nPop; % Flock (population) size
AP=0.1; % Awareness probability
fl=2; % Flight length (fl)
if(max(size(lb)) == 1 || max(size(ub)) == 1)
    Lb = lb*ones(1,pd);
    Ub = ub*ones(1,pd);
else
    Lb = lb;
    Ub = ub;
end
    
[x]=init(N,pd,Lb,Ub); % Function for initialization

xn=x;
for i = 1:N
ft(i)=fobj(xn(i,:)); % Function for fitness evaluation
end
mem=x; % Memory initialization
fit_mem=ft; % Fitness of memory positions

for t=1:Max_iteration

    num=ceil(N*rand(1,N)); % Generation of random candidate crows for following (chasing)
    for i=1:N
        if rand>AP
            xnew(i,:)= x(i,:)+fl*rand*(mem(num(i),:)-x(i,:)); % Generation of a new position for crow i (state 1)
        else
            for j=1:pd
                xnew(i,j)=Lb(j)-(Lb(j)-Ub(j))*rand; % Generation of a new position for crow i (state 2)
            end
        end
    end

    xn=xnew;
    for i = 1:N
    ft(i)=fobj(xn(i,:));  % Function for fitness evaluation of new solutions
    end
    for i=1:N % Update position and memory
        if xnew(i,:)>=Lb & xnew(i,:)<=Ub
            x(i,:)=xnew(i,:); % Update position
            if ft(i)<fit_mem(i)
                mem(i,:)=xnew(i,:); % Update memory
                fit_mem(i)=ft(i);
            end
        end
    end

    ffit(t)=min(fit_mem); % Best found value until iteration t
    min(fit_mem);
end
curve = ffit; %iteration curve
ngbest=find(fit_mem== min(fit_mem));
g_best=mem(ngbest(1),:); % Solutin of the problem
Best_pos = g_best; %best solution
Best_score = ffit(end);%best fitness score
end


function lhsdesigncontest( )
%LHSDESIGNCONTEST Test for LHSDESIGNCON function.
%
%   Requires LHSDESIGNCON.
%
%   See also LHSDESIGNCON.


%A = [1, 1; 1, -1]; b = [2; -2]; % A x <= b
x = lhsdesigncon(300,4,[-1 -1 -1 -1],[1 1 1 1]);
% Show samples are well distributed within constraints.
figure;
x
semilogy(x(:,1),x(:,2),'.');
a = size(x);
a 
end


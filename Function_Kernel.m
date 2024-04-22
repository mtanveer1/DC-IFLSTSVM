function Matrix_Ker = Function_Kernel(A, B, Kernel)

%  A:  The input data whose samples lie in the row of A
%  B:  Another input data whose samples lies in the row of B with the same size of the sample in A 
% Kernel: it main inclues two part: Kernel's type and Kernel's parameters

% Linear kernel:  Kernel.Type='Linear'
% RBF kernel:  Kernel.Type='RBF', Kernel.gamma=
% Sigmoid kernel:  K0ernel.Type='Sigmoid', Kernel.gamma= , Kernel.c
% Polynomial kernel:  Kernel.Type='Polynomial', Kernel.gamma= , Kernel.c ,Kernel.n 


%% Main procedure
    M = size(A, 1);
    N = size(B, 1);
    
   switch Kernel.type
       case 'Linear'
           Matrix_Ker = A*B';
       case 'rbf'
           gamma = Kernel.pars;
           A2 = kron(sum(A'.^2)', ones(1, N));
           B2 = kron(ones(M, 1), sum(B'.^2));
           Cross = 2*A*B';
           Matrix_Ker = exp(-gamma*(A2+B2-Cross));
       case 'Sigmoid'
           gamma = Kernel.pars;
           c = Kernel.c;
           Matrix_Ker = tanh(gamma*A*B'+c);
       case 'Polynomial'
           gamma = Kernel.pars;
           c = Kernel.c;
           n = Kernel.n;
           Matrix_Ker = (gamma*A*B'+c).^n;
       otherwise
           Index = 'Wrong input is provided, and we use FBF kenel instead.'; 
           gamma = Kernel.pars;
           A2 = kron(sum(A'.^2)', ones(1, N));
           B2 = kron(ones(M, 1), sum(B'.^2));
           Cross = 2*A*B';
           Matrix_Ker = exp(-gamma*(A2+B2-Cross));
   end

end


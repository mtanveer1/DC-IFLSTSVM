function[x_optimal]=conjugate_gradient(x0,A,b,max_iter,tol)
% initialize residual r
r0=b-A*x0;
p0=r0; %initialize direction
r_prod_old=r0'*r0;
for i=1:max_iter
    deno0=p0'*(A*p0);
    alpha=(r_prod_old)/deno0;
    x_new=x0+alpha*p0;
    r_new=r0-alpha*A*p0;

    if norm(r_new)<tol
        break;
    end
    r_prod_new=r_new'*r_new;
    beta=(r_prod_new)/(r_prod_old);
    p_new=r_new+beta*p0;
    p0=p_new;
    r0=r_new;
    x0=x_new;
    r_prod_old=r_prod_new;
end
x_optimal=x0;
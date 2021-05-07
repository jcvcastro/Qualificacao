function [y] = MR2aO(u,a,d)
    alpha = 1-a+a*log(a);
    beta = a^2-a-a*log(a);
    n = length(u);
    y = zeros(1,n);
    for k=d+3:n    %% analisar estes limites
       y(k) = 2*a*y(k-1) - a^2*y(k-2) + alpha*u(k-d-1) + beta*u(k-d-2);
    end
end

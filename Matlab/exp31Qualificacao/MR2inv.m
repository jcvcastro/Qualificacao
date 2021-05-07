function [e, u] = MR2inv(u,y,a,d)
    alpha = 1-a+a*log(a);
    beta = a^2-a-a*log(a);
    n = length(y);
    r = zeros(n-d-1,1);
    e = zeros(n-d-1,1);
    for k=2:n-d-1    %% analisar estes limites
       r(k) = ( y(k+d+1) - 2*a*y(k+d) + a^2*y(k+d-1) - beta*r(k-1) )/alpha;
    end
    r = r(2:end);
    e = r-y(2:n-d-1);
    u = u(2:n-d-1);
end

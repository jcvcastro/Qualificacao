function [y] = sis1aO(u,A,d,G)
    N = length(u);
    y = zeros(1,N);
    for k=1+d:N    %% analisar estes limites
       y(k) = A*y(k-1) + (1-A)*G*u(k-d);
    end
end
